From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ALSA: hda: hdmi: Hint matching between input
 devices and pcm devices
Date: Mon, 29 Aug 2011 17:14:23 -0500
Message-ID: <1314656063.27660.9.camel@plb-Dell>
References: <4E53C32E.9020801@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3823@HQMAIL01.nvidia.com>
	<4E5483CD.6070808@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3C9E@HQMAIL01.nvidia.com>
	<4E55F634.9070601@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3E7D@HQMAIL01.nvidia.com>
	<4E56C088.6080402@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nXZBGyAuxF6FtGxPD8Xf"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 12A44245C6
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 00:14:31 +0200 (CEST)
In-Reply-To: <4E56C088.6080402@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-nXZBGyAuxF6FtGxPD8Xf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


> Since modern HDMI cards often have more than one output pin and thus
> input device, we need to know which one has actually been plugged in.
> This patch adds a name hint that indicates which PCM device is connected
> to which pin.

I've been thinking about this, and there's some additional work needed
for the jack-detection to be useful.
User-space code will need at some point to rely on the ELD information
to know what the HDMI receiver supports, eg to enable/disable
passthrough. I hacked a while ago a small patch to make the ELD bytes
available in a control (see attached). It seems to work but I wasn't too
sure how to expose it. 
Should we define a convention for the name of this control as well? Or
is there a way to link a control to a specify PCM device?
Thanks for your feedback,
-Pierre

--=-nXZBGyAuxF6FtGxPD8Xf
Content-Disposition: attachment; filename="eld.patch"
Content-Type: text/x-patch; name="eld.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 28ce17d..01d5226 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -24,6 +24,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <sound/core.h>
+#include <sound/control.h>
+#include <sound/asoundef.h>
 #include <asm/unaligned.h>
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -318,6 +320,14 @@ int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid)
 						 AC_DIPSIZE_ELD_BUF);
 }
 
+
+static struct snd_kcontrol_new eld_bytes_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "ELD Bytes",
+	.info = snd_hdmi_eld_ctl_info,
+	.get = snd_hdmi_eld_ctl_get
+};
+
 int snd_hdmi_get_eld(struct hdmi_eld *eld,
 		     struct hda_codec *codec, hda_nid_t nid)
 {
@@ -325,6 +335,8 @@ int snd_hdmi_get_eld(struct hdmi_eld *eld,
 	int ret;
 	int size;
 	unsigned char *buf;
+	struct snd_kcontrol *kctl;
+	int err;
 
 	if (!eld->eld_valid)
 		return -ENOENT;
@@ -335,21 +347,30 @@ int snd_hdmi_get_eld(struct hdmi_eld *eld,
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
+	/* add control for ELD Bytes */
+	kctl = snd_ctl_new1(&eld_bytes_ctl, codec);
+	if (!kctl)
 		return -ENOMEM;
+	err = snd_hda_ctl_add(codec, nid, kctl);
+	if (err < 0)
+		return err;
+	kctl->private_value = nid;
+	printk(KERN_ERR "plb: added control \n");
+
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
index 9ed4b0d..1f237ef 100644
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
@@ -643,6 +645,10 @@ int snd_hdmi_get_eld(struct hdmi_eld *, struct hda_codec *, hda_nid_t);
 void snd_hdmi_show_eld(struct hdmi_eld *eld);
 void snd_hdmi_eld_update_pcm_info(struct hdmi_eld *eld,
 			      struct hda_pcm_stream *hinfo);
+int snd_hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo);
+int snd_hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol);
 
 #ifdef CONFIG_PROC_FS
 int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld,
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 19cb72d..4a11e93 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -324,6 +324,62 @@ static int cvt_nid_to_cvt_index(struct hdmi_spec *spec, hda_nid_t cvt_nid)
 	return -EINVAL;
 }
 
+int snd_hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hdmi_spec *spec;
+	struct hdmi_spec_per_pin *per_pin;
+	struct hdmi_eld *eld;
+	int pin_nid;
+	int pin_idx;
+
+	printk(KERN_ERR "plb: in ctl_info routine\n");
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+
+	pin_nid = kcontrol->private_value;
+	spec = codec->spec;
+
+	pin_idx = pin_nid_to_pin_index(spec, pin_nid);
+	if (pin_idx<0) {
+		uinfo->count = 0;
+	} else {
+		per_pin = &spec->pins[pin_idx];
+		eld = &per_pin->sink_eld;
+		uinfo->count = eld->eld_size;
+	}
+	return 0;
+}
+
+int snd_hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hdmi_spec *spec;
+	struct hdmi_spec_per_pin *per_pin;
+	struct hdmi_eld *eld;
+	int pin_nid;
+	int pin_idx;
+
+	printk(KERN_ERR "plb: in ctl_get routine\n");
+	pin_nid = kcontrol->private_value;
+
+	spec = codec->spec;
+	pin_nid = kcontrol->private_value;
+
+	pin_idx = pin_nid_to_pin_index(spec, pin_nid);
+	if (pin_idx<0) {
+		memset(ucontrol->value.bytes.data, 0, ELD_MAX_SIZE);
+		printk(KERN_ERR "eld_get: no info found\n");
+	} else {
+		per_pin = &spec->pins[pin_idx];
+		eld = &per_pin->sink_eld;
+		printk(KERN_ERR "eld_get: copying %d bytes\n", eld->eld_size);
+		memcpy(ucontrol->value.bytes.data, eld->eld_buffer, eld->eld_size);
+	}
+	return 0;
+}
+
 #ifdef BE_PARANOID
 static void hdmi_get_dip_index(struct hda_codec *codec, hda_nid_t pin_nid,
 				int *packet_index, int *byte_index)

--=-nXZBGyAuxF6FtGxPD8Xf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-nXZBGyAuxF6FtGxPD8Xf--
