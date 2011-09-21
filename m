From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: link between HDMI ELD and PCM devices
Date: Wed, 21 Sep 2011 12:30:43 -0500
Message-ID: <1316626243.16197.7.camel@pbossart-Dell-N7010>
References: <1316560363.3872.14.camel@pbossart-Dell-N7010>
	<74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>
	<1316566711.3872.24.camel@pbossart-Dell-N7010>
	<4E7987BF.8000206@canonical.com>
	<000001cc7861$2d7895e0$8869c1a0$@bossart@linux.intel.com>
	<4E79ECBA.3060705@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF1738180031@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TOAARVHGJMGbcf5NX2ZN"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 23EDE2441C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 19:31:02 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1738180031@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 'Wu Fengguang' <fengguang.wu@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--=-TOAARVHGJMGbcf5NX2ZN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


> Just as an FYI, this is a little HW-dependent.
> 
> For GPUs that have multiple codecs, everything David said is true.
> 
> Very recent NVIDIA GPUs such as GeForce 520, and at least some Intel GPUs
> which Pierre-Louis may be testing with (e.g. my wife's Ibex Peak) have
> just one codec, which supports multiple PCMs, and then are numbered like:
> 
> card 1: NVidia_1 [HDA NVidia], device 3: HDMI 0 [HDMI 0]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 1: NVidia_1 [HDA NVidia], device 7: HDMI 1 [HDMI 1]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0

Good feedback. Looks like the device number is the only reliable piece
of information here. 
I simplified my initial patch based on David's suggestions, can you guys
let me know how it behaves with multiple codecs/multiple PCMs?
On my laptop, I get this result

$ amixer -c0 controls
numid=22,iface=PCM,name='ELD',device=3
$ amixer -c0 cget numid=22
numid=22,iface=PCM,name='ELD',device=3
  ; type=BYTES,access=rw------,values=84
  : values=0x10,0x00,0x0d,0x00,0x68,0x82,0x00,0x0f,<snip>
Thanks!


--=-TOAARVHGJMGbcf5NX2ZN
Content-Disposition: attachment; filename="0001-ALSA-hdmi-expose-ELD-control.patch"
Content-Type: text/x-patch; name="0001-ALSA-hdmi-expose-ELD-control.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 01320aa954c7968db0d026c0643a0238df590804 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 20 Sep 2011 20:15:48 -0500
Subject: [PATCH] ALSA: hdmi: expose ELD control

Applications may want to read ELD information to
understand what codecs are supported on the HDMI
receiver and handle the a-v delay for better lip-sync.

ELD information is exposed in a device-specific
IFACE_PCM kcontrol.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_eld.c    |    9 ++---
 sound/pci/hda/hda_local.h  |    2 +
 sound/pci/hda/patch_hdmi.c |   85 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 28ce17d..8f16b20 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -335,21 +335,20 @@ int snd_hdmi_get_eld(struct hdmi_eld *eld,
 		snd_printd(KERN_INFO "HDMI: ELD buf size is 0, force 128\n");
 		size = 128;
 	}
-	if (size < ELD_FIXED_BYTES || size > PAGE_SIZE) {
+	if (size < ELD_FIXED_BYTES || size > ELD_MAX_SIZE || size > PAGE_SIZE) {
 		snd_printd(KERN_INFO "HDMI: invalid ELD buf size %d\n", size);
 		return -ERANGE;
 	}
 
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	/* update info */
+	eld->eld_size = size;
+	buf = eld->eld_buffer;
 
 	for (i = 0; i < size; i++)
 		buf[i] = hdmi_get_eld_byte(codec, nid, i);
 
 	ret = hdmi_update_eld(eld, buf, size);
 
-	kfree(buf);
 	return ret;
 }
 
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 9ed4b0d..cd579a6 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -609,6 +609,7 @@ struct cea_sad {
 };
 
 #define ELD_FIXED_BYTES	20
+#define ELD_MAX_SIZE    256
 #define ELD_MAX_MNL	16
 #define ELD_MAX_SAD	16
 
@@ -633,6 +634,7 @@ struct hdmi_eld {
 	int	spk_alloc;
 	int	sad_count;
 	struct cea_sad sad[ELD_MAX_SAD];
+	char    eld_buffer[ELD_MAX_SIZE];
 #ifdef CONFIG_PROC_FS
 	struct snd_info_entry *proc_entry;
 #endif
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 19cb72d..5ea9b55 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -324,6 +324,83 @@ static int cvt_nid_to_cvt_index(struct hdmi_spec *spec, hda_nid_t cvt_nid)
 	return -EINVAL;
 }
 
+static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hdmi_spec *spec;
+	struct hdmi_spec_per_pin *per_pin;
+	struct hdmi_eld *eld;
+	int pin_idx;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	pin_idx = kcontrol->private_value;
+	spec = codec->spec;
+
+	if (pin_idx < 0) {
+		uinfo->count = 0;
+	} else {
+		per_pin = &spec->pins[pin_idx];
+		eld = &per_pin->sink_eld;
+		uinfo->count = eld->eld_size;
+	}
+	return 0;
+}
+
+static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hdmi_spec *spec;
+	struct hdmi_spec_per_pin *per_pin;
+	struct hdmi_eld *eld;
+	int pin_idx;
+
+	spec = codec->spec;
+	pin_idx = kcontrol->private_value;
+
+	if (pin_idx < 0) {
+		memset(ucontrol->value.bytes.data, 0, ELD_MAX_SIZE);
+	} else {
+		per_pin = &spec->pins[pin_idx];
+		eld = &per_pin->sink_eld;
+		memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
+			(eld->eld_size > ELD_MAX_SIZE) ?
+			ELD_MAX_SIZE : eld->eld_size);
+	}
+	return 0;
+}
+
+static struct snd_kcontrol_new eld_bytes_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.name = "ELD",
+	.info = hdmi_eld_ctl_info,
+	.get = hdmi_eld_ctl_get,
+};
+
+static int hdmi_create_eld_ctl(struct hda_codec *codec, int pin_idx,
+			int device)
+{
+	struct snd_kcontrol *kctl;
+	struct hdmi_spec *spec = codec->spec;
+	int err;
+
+	if (pin_idx < 0)
+		return -EINVAL;
+
+	kctl = snd_ctl_new1(&eld_bytes_ctl, codec);
+	if (!kctl)
+		return -ENOMEM;
+	kctl->private_value = pin_idx;
+	kctl->id.device = device;
+
+	err = snd_hda_ctl_add(codec, spec->pins[pin_idx].pin_nid, kctl);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 #ifdef BE_PARANOID
 static void hdmi_get_dip_index(struct hda_codec *codec, hda_nid_t pin_nid,
 				int *packet_index, int *byte_index)
@@ -1176,6 +1253,14 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 		snd_hda_spdif_ctls_unassign(codec, pin_idx);
+
+		/* add control for ELD Bytes */
+		err = hdmi_create_eld_ctl(codec,
+					pin_idx,
+					spec->pcm_rec[pin_idx].device);
+
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
-- 
1.7.6.2


--=-TOAARVHGJMGbcf5NX2ZN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-TOAARVHGJMGbcf5NX2ZN--
