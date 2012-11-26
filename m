From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: usb-audio: add channel map support
Date: Mon, 26 Nov 2012 16:36:33 +0100
Message-ID: <1353944193-16190-3-git-send-email-tiwai@suse.de>
References: <1353944193-16190-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 030ED265180
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 16:36:45 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id C33B1A3EBF
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 16:36:45 +0100 (CET)
In-Reply-To: <1353944193-16190-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add the support for channel maps of the PCM streams on USB audio
devices.  The channel map information is already found in
ChannelConfig descriptor entries, which haven't been referred until
now.

Each chmap entry is added to audioformat list entry and copied to TLV
dynamically instead of creating a whole chmap array.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.h   |   2 +
 sound/usb/stream.c | 230 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 227 insertions(+), 5 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 814cb35..8a751b4 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -27,6 +27,7 @@ struct audioformat {
 	unsigned int nr_rates;		/* number of rate table entries */
 	unsigned int *rate_table;	/* rate table */
 	unsigned char clock;		/* associated clock */
+	struct snd_pcm_chmap_elem *chmap; /* (optional) channel map */
 };
 
 struct snd_usb_substream;
@@ -109,6 +110,7 @@ struct snd_usb_substream {
 	struct audioformat *cur_audiofmt;	/* current audioformat pointer (for hw_params callback) */
 	snd_pcm_format_t pcm_format;	/* current audio format (for hw_params callback) */
 	unsigned int channels;		/* current number of channels (for hw_params callback) */
+	unsigned int channels_max;	/* max channels in the all audiofmts */
 	unsigned int cur_rate;		/* current rate (for hw_params callback) */
 	unsigned int period_bytes;	/* current period bytes (for hw_params callback) */
 	unsigned int altset_idx;     /* USB data format: index of alternate setting */
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 1de0c8c..ad181d5 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -23,6 +23,8 @@
 
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/control.h>
+#include <sound/tlv.h>
 
 #include "usbaudio.h"
 #include "card.h"
@@ -47,6 +49,7 @@ static void free_substream(struct snd_usb_substream *subs)
 	list_for_each_safe(p, n, &subs->fmt_list) {
 		struct audioformat *fp = list_entry(p, struct audioformat, list);
 		kfree(fp->rate_table);
+		kfree(fp->chmap);
 		kfree(fp);
 	}
 	kfree(subs->rate_list.list);
@@ -99,6 +102,206 @@ static void snd_usb_init_substream(struct snd_usb_stream *as,
 	subs->num_formats++;
 	subs->fmt_type = fp->fmt_type;
 	subs->ep_num = fp->endpoint;
+	if (fp->channels > subs->channels_max)
+		subs->channels_max = fp->channels;
+}
+
+/* kctl callbacks for usb-audio channel maps */
+static int usb_chmap_ctl_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_substream *subs = info->private_data;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = subs->channels_max;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = SNDRV_CHMAP_LAST;
+	return 0;
+}
+
+/* check whether a duplicated entry exists in the audiofmt list */
+static bool have_dup_chmap(struct snd_usb_substream *subs,
+			   struct audioformat *fp)
+{
+	struct list_head *p;
+
+	for (p = fp->list.prev; p != &subs->fmt_list; p = p->prev) {
+		struct audioformat *prev;
+		prev = list_entry(p, struct audioformat, list);
+		if (prev->chmap &&
+		    !memcmp(prev->chmap, fp->chmap, sizeof(*fp->chmap)))
+			return true;
+	}
+	return false;
+}
+
+static int usb_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
+			     unsigned int size, unsigned int __user *tlv)
+{
+	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_substream *subs = info->private_data;
+	struct audioformat *fp;
+	unsigned int __user *dst;
+	int count = 0;
+
+	if (size < 8)
+		return -ENOMEM;
+	if (put_user(SNDRV_CTL_TLVT_CONTAINER, tlv))
+		return -EFAULT;
+	size -= 8;
+	dst = tlv + 2;
+	list_for_each_entry(fp, &subs->fmt_list, list) {
+		int i, ch_bytes;
+
+		if (!fp->chmap)
+			continue;
+		if (have_dup_chmap(subs, fp))
+			continue;
+		/* copy the entry */
+		ch_bytes = fp->chmap->channels * 4;
+		if (size < 8 + ch_bytes)
+			return -ENOMEM;
+		if (put_user(SNDRV_CTL_TLVT_CHMAP_FIXED, dst) ||
+		    put_user(ch_bytes, dst + 1))
+			return -EFAULT;
+		dst += 2;
+		for (i = 0; i < fp->chmap->channels; i++, dst++) {
+			if (put_user(fp->chmap->map[i], dst))
+				return -EFAULT;
+		}
+
+		count += 8 + ch_bytes;
+		size -= 8 + ch_bytes;
+	}
+	if (put_user(count, tlv + 1))
+		return -EFAULT;
+	return 0;
+}
+
+static int usb_chmap_ctl_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_substream *subs = info->private_data;
+	struct snd_pcm_chmap_elem *chmap = NULL;
+	int i;
+
+	memset(ucontrol->value.integer.value, 0,
+	       sizeof(ucontrol->value.integer.value));
+	if (subs->cur_audiofmt)
+		chmap = subs->cur_audiofmt->chmap;
+	if (chmap) {
+		for (i = 0; i < chmap->channels; i++)
+			ucontrol->value.integer.value[i] = chmap->map[i];
+	}
+	return 0;
+}
+
+/* create a chmap kctl assigned to the given USB substream */
+static int add_chmap(struct snd_pcm *pcm, int stream,
+		     struct snd_usb_substream *subs)
+{
+	struct audioformat *fp;
+	struct snd_pcm_chmap *chmap;
+	struct snd_kcontrol *kctl;
+	int err;
+
+	list_for_each_entry(fp, &subs->fmt_list, list)
+		if (fp->chmap)
+			goto ok;
+	/* no chmap is found */
+	return 0;
+
+ ok:
+	err = snd_pcm_add_chmap_ctls(pcm, stream, NULL, 0, 0, &chmap);
+	if (err < 0)
+		return err;
+
+	/* override handlers */
+	chmap->private_data = subs;
+	kctl = chmap->kctl;
+	kctl->info = usb_chmap_ctl_info;
+	kctl->get = usb_chmap_ctl_get;
+	kctl->tlv.c = usb_chmap_ctl_tlv;
+
+	return 0;
+}
+
+/* convert from USB ChannelConfig bits to ALSA chmap element */
+static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
+						int protocol)
+{
+	static unsigned int uac1_maps[] = {
+		SNDRV_CHMAP_FL,		/* left front */
+		SNDRV_CHMAP_FR,		/* right front */
+		SNDRV_CHMAP_FC,		/* center front */
+		SNDRV_CHMAP_LFE,	/* LFE */
+		SNDRV_CHMAP_SL,		/* left surround */
+		SNDRV_CHMAP_SR,		/* right surround */
+		SNDRV_CHMAP_FLC,	/* left of center */
+		SNDRV_CHMAP_FRC,	/* right of center */
+		SNDRV_CHMAP_RC,		/* surround */
+		SNDRV_CHMAP_SL,		/* side left */
+		SNDRV_CHMAP_SR,		/* side right */
+		SNDRV_CHMAP_TC,		/* top */
+		0 /* terminator */
+	};
+	static unsigned int uac2_maps[] = {
+		SNDRV_CHMAP_FL,		/* front left */
+		SNDRV_CHMAP_FR,		/* front right */
+		SNDRV_CHMAP_FC,		/* front center */
+		SNDRV_CHMAP_LFE,	/* LFE */
+		SNDRV_CHMAP_RL,		/* back left */
+		SNDRV_CHMAP_RR,		/* back right */
+		SNDRV_CHMAP_FLC,	/* front left of center */
+		SNDRV_CHMAP_FRC,	/* front right of center */
+		SNDRV_CHMAP_RC,		/* back center */
+		SNDRV_CHMAP_SL,		/* side left */
+		SNDRV_CHMAP_SR,		/* side right */
+		SNDRV_CHMAP_TC,		/* top center */
+		SNDRV_CHMAP_TFL,	/* top front left */
+		SNDRV_CHMAP_TFC,	/* top front center */
+		SNDRV_CHMAP_TFR,	/* top front right */
+		SNDRV_CHMAP_TRL,	/* top back left */
+		SNDRV_CHMAP_TRC,	/* top back center */
+		SNDRV_CHMAP_TRR,	/* top back right */
+		SNDRV_CHMAP_TFLC,	/* top front left of center */
+		SNDRV_CHMAP_TFRC,	/* top front right of center */
+		SNDRV_CHMAP_LLFE,	/* left LFE */
+		SNDRV_CHMAP_RLFE,	/* right LFE */
+		SNDRV_CHMAP_TSL,	/* top side left */
+		SNDRV_CHMAP_TSR,	/* top side right */
+		SNDRV_CHMAP_BC,		/* bottom center */
+		SNDRV_CHMAP_BLC,	/* bottom left center */
+		SNDRV_CHMAP_BRC,	/* bottom right center */
+		0 /* terminator */
+	};
+	struct snd_pcm_chmap_elem *chmap;
+	const unsigned int *maps;
+	int c;
+
+	if (!bits)
+		return NULL;
+	if (channels > ARRAY_SIZE(chmap->map))
+		return NULL;
+
+	chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
+	if (!chmap)
+		return NULL;
+
+	maps = protocol == UAC_VERSION_2 ? uac2_maps : uac1_maps;
+	chmap->channels = channels;
+	c = 0;
+	for (; bits && *maps; maps++, bits >>= 1) {
+		if (bits & 1)
+			chmap->map[c++] = *maps;
+	}
+
+	for (; c < channels; c++)
+		chmap->map[c] = SNDRV_CHMAP_UNKNOWN;
+
+	return chmap;
 }
 
 /*
@@ -140,7 +343,7 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 		if (err < 0)
 			return err;
 		snd_usb_init_substream(as, stream, fp);
-		return 0;
+		return add_chmap(as->pcm, stream, subs);
 	}
 
 	/* create a new pcm */
@@ -174,7 +377,7 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 
 	snd_usb_proc_pcm_format_add(as);
 
-	return 0;
+	return add_chmap(pcm, stream, &as->substream[stream]);
 }
 
 static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
@@ -218,8 +421,11 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 	return attributes;
 }
 
-static struct uac2_input_terminal_descriptor *
-	snd_usb_find_input_terminal_descriptor(struct usb_host_interface *ctrl_iface,
+/* find an input terminal descriptor (either UAC1 or UAC2) with the given
+ * terminal id
+ */
+static void *
+snd_usb_find_input_terminal_descriptor(struct usb_host_interface *ctrl_iface,
 					       int terminal_id)
 {
 	struct uac2_input_terminal_descriptor *term = NULL;
@@ -261,6 +467,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 	struct audioformat *fp = NULL;
 	int num, protocol, clock = 0;
 	struct uac_format_type_i_continuous_descriptor *fmt;
+	unsigned int chconfig;
 
 	dev = chip->dev;
 
@@ -300,6 +507,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		if (snd_usb_apply_interface_quirk(chip, iface_no, altno))
 			continue;
 
+		chconfig = 0;
 		/* get audio formats */
 		switch (protocol) {
 		default:
@@ -311,6 +519,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		case UAC_VERSION_1: {
 			struct uac1_as_header_descriptor *as =
 				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
+			struct uac_input_terminal_descriptor *iterm;
 
 			if (!as) {
 				snd_printk(KERN_ERR "%d:%u:%d : UAC_AS_GENERAL descriptor not found\n",
@@ -325,6 +534,14 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 			}
 
 			format = le16_to_cpu(as->wFormatTag); /* remember the format value */
+
+			iterm = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+								       as->bTerminalLink);
+			if (iterm) {
+				num_channels = iterm->bNrChannels;
+				chconfig = le16_to_cpu(iterm->wChannelConfig);
+			}
+
 			break;
 		}
 
@@ -355,6 +572,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 									    as->bTerminalLink);
 			if (input_term) {
 				clock = input_term->bCSourceID;
+				chconfig = le32_to_cpu(input_term->bmChannelConfig);
 				break;
 			}
 
@@ -413,13 +631,13 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
 		fp->datainterval = snd_usb_parse_datainterval(chip, alts);
 		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
-		/* num_channels is only set for v2 interfaces */
 		fp->channels = num_channels;
 		if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
 			fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
 					* (fp->maxpacksize & 0x7ff);
 		fp->attributes = parse_uac_endpoint_attributes(chip, alts, protocol, iface_no);
 		fp->clock = clock;
+		fp->chmap = convert_chmap(num_channels, chconfig, protocol);
 
 		/* some quirks for attributes here */
 
@@ -455,6 +673,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		/* ok, let's parse further... */
 		if (snd_usb_parse_audio_format(chip, fp, format, fmt, stream, alts) < 0) {
 			kfree(fp->rate_table);
+			kfree(fp->chmap);
 			kfree(fp);
 			fp = NULL;
 			continue;
@@ -464,6 +683,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		err = snd_usb_add_audio_stream(chip, stream, fp);
 		if (err < 0) {
 			kfree(fp->rate_table);
+			kfree(fp->chmap);
 			kfree(fp);
 			return err;
 		}
-- 
1.8.0
