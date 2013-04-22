From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH,
	for-next 1/2] ALSA: pcm_format_to_bits strong-typed conversion
Date: Tue, 23 Apr 2013 01:00:41 +0200
Message-ID: <1366671642-30423-1-git-send-email-eldad@fogrefinery.com>
References: <s5hk3nu4wfa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id F25C126171F
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2013 01:00:58 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id jk13so687bkc.31
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 16:00:58 -0700 (PDT)
In-Reply-To: <s5hk3nu4wfa.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Eldad Zack <eldad@fogrefinery.com>, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Add a function to handle conversion from snd_pcm_format_t
to bitwise with proper typing.

Change such conversions to use this function and silence sparse
warnings.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 include/sound/pcm.h             | 6 ++++++
 sound/aoa/soundbus/i2sbus/pcm.c | 2 +-
 sound/atmel/ac97c.c             | 4 ++--
 sound/drivers/aloop.c           | 2 +-
 sound/pci/asihpi/asihpi.c       | 4 ++--
 sound/usb/format.c              | 5 +++--
 sound/usb/pcm.c                 | 4 ++--
 sound/usb/proc.c                | 2 +-
 8 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1b0c648..5357ecb 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1133,4 +1133,10 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 			   unsigned long private_value,
 			   struct snd_pcm_chmap **info_ret);
 
+/* Strong-typed conversion of pcm_format to bitwise */
+static inline u64 pcm_format_to_bits(snd_pcm_format_t pcm_format)
+{
+	return 1ULL << (__force int) pcm_format;
+}
+
 #endif /* __SOUND_PCM_H */
diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 19491ed..7b74a4b 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -179,7 +179,7 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	 */
 	if (other->active) {
 		/* FIXME: is this guaranteed by the alsa api? */
-		hw->formats &= (1ULL << i2sdev->format);
+		hw->formats &= pcm_format_to_bits(i2sdev->format);
 		/* see above, restrict rates to the one we already have */
 		hw->rate_min = i2sdev->rate;
 		hw->rate_max = i2sdev->rate;
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 79d6bda..6b7e2b5 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -182,7 +182,7 @@ static int atmel_ac97c_playback_open(struct snd_pcm_substream *substream)
 		runtime->hw.rate_max = chip->cur_rate;
 	}
 	if (chip->cur_format)
-		runtime->hw.formats = (1ULL << chip->cur_format);
+		runtime->hw.formats = pcm_format_to_bits(chip->cur_format);
 	mutex_unlock(&opened_mutex);
 	chip->playback_substream = substream;
 	return 0;
@@ -201,7 +201,7 @@ static int atmel_ac97c_capture_open(struct snd_pcm_substream *substream)
 		runtime->hw.rate_max = chip->cur_rate;
 	}
 	if (chip->cur_format)
-		runtime->hw.formats = (1ULL << chip->cur_format);
+		runtime->hw.formats = pcm_format_to_bits(chip->cur_format);
 	mutex_unlock(&opened_mutex);
 	chip->capture_substream = substream;
 	return 0;
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 64d5347..6f78de9 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -325,7 +325,7 @@ static void params_change(struct snd_pcm_substream *substream)
 	struct loopback_pcm *dpcm = runtime->private_data;
 	struct loopback_cable *cable = dpcm->cable;
 
-	cable->hw.formats = (1ULL << runtime->format);
+	cable->hw.formats = pcm_format_to_bits(runtime->format);
 	cable->hw.rate_min = runtime->rate;
 	cable->hw.rate_max = runtime->rate;
 	cable->hw.channels_min = runtime->channels;
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 0aabfed..160cf83 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -966,7 +966,7 @@ static u64 snd_card_asihpi_playback_formats(struct snd_card_asihpi *asihpi,
 		if (!err)
 			err = hpi_outstream_query_format(h_stream, &hpi_format);
 		if (!err && (hpi_to_alsa_formats[format] != -1))
-			formats |= (1ULL << hpi_to_alsa_formats[format]);
+			formats |= pcm_format_to_bits(hpi_to_alsa_formats[format]);
 	}
 	return formats;
 }
@@ -1142,7 +1142,7 @@ static u64 snd_card_asihpi_capture_formats(struct snd_card_asihpi *asihpi,
 		if (!err)
 			err = hpi_instream_query_format(h_stream, &hpi_format);
 		if (!err)
-			formats |= (1ULL << hpi_to_alsa_formats[format]);
+			formats |= pcm_format_to_bits(hpi_to_alsa_formats[format]);
 	}
 	return formats;
 }
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 020ede0..99299ff 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -365,7 +365,8 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 {
 	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
 	int protocol = altsd->bInterfaceProtocol;
-	int pcm_format, ret;
+	snd_pcm_format_t pcm_format;
+	int ret;
 
 	if (fmt->bFormatType == UAC_FORMAT_TYPE_III) {
 		/* FIXME: the format type is really IECxxx
@@ -384,7 +385,7 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 		default:
 			pcm_format = SNDRV_PCM_FORMAT_S16_LE;
 		}
-		fp->formats = 1uLL << pcm_format;
+		fp->formats = pcm_format_to_bits(pcm_format);
 	} else {
 		fp->formats = parse_audio_format_i_type(chip, fp, format,
 							fmt, protocol);
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 9723f3c..93b6e32 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -100,7 +100,7 @@ static struct audioformat *find_format(struct snd_usb_substream *subs)
 	int cur_attr = 0, attr;
 
 	list_for_each_entry(fp, &subs->fmt_list, list) {
-		if (!(fp->formats & (1uLL << subs->pcm_format)))
+		if (!(fp->formats & pcm_format_to_bits(subs->pcm_format)))
 			continue;
 		if (fp->channels != subs->channels)
 			continue;
@@ -478,7 +478,7 @@ static int match_endpoint_audioformats(struct audioformat *fp,
 		return 0;
 	}
 
-	if (!(fp->formats & (1ULL << pcm_format))) {
+	if (!(fp->formats & pcm_format_to_bits(pcm_format))) {
 		snd_printdd("%s: (fmt @%p) no match for format %d\n", __func__,
 			fp, pcm_format);
 		return 0;
diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index 0182ef6..135c768 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -85,7 +85,7 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 		snd_iprintf(buffer, "    Altset %d\n", fp->altsetting);
 		snd_iprintf(buffer, "    Format:");
 		for (fmt = 0; fmt <= SNDRV_PCM_FORMAT_LAST; ++fmt)
-			if (fp->formats & (1uLL << fmt))
+			if (fp->formats & pcm_format_to_bits(fmt))
 				snd_iprintf(buffer, " %s",
 					    snd_pcm_format_name(fmt));
 		snd_iprintf(buffer, "\n");
-- 
1.8.1.5
