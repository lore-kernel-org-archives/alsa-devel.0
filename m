From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Tests of the hda-jack branch
Date: Wed, 30 Nov 2011 07:38:37 +0100
Message-ID: <4ED5CF6D.7050804@ladisch.de>
References: <4ED535CA.1080108@canonical.com> <4ED545E1.3040409@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C7313103A4D
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 07:38:56 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B26882228A
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 01:38:55 -0500 (EST)
In-Reply-To: <4ED545E1.3040409@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> David Henningsson wrote:
>> ... two patches - one adds a "device index" for mapping against pcm
>> devices on HDMI,
>
>> +	kctl->id.device = device;
>
> In the general case, there is not always a 1:1 mapping between jacks and
> PCM devices, so I fear that a jack belonging to device 0 cannot be
> distinguished from a jack that has no specific device.
>
> There is a convention that id.device is a valid PCM device number if and
> only if id.iface is IFACE_PCM.  However, it might be useful to map
> controls with IFACE_MIXER to PCM devices, so I'd propose a new TLV,

Er, the point was for the TLV to be optional; please ignore the previous
patch.  :)


--8<---------------------------------------------------------------->8--
ALSA: hda/jack: add PCM device TLV for jack controls

Allow to add a new TLV to jack kcontrols so that HDMI jacks can be
associated with the correct PCM devices.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/tlv.h        |    6 ++++++
 sound/pci/hda/hda_jack.c   |   12 ++++++++++--
 sound/pci/hda/hda_jack.h   |    3 ++-
 sound/pci/hda/patch_hdmi.c |    3 ++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/sound/tlv.h b/include/sound/tlv.h
index 7067e2d..809b077 100644
--- a/include/sound/tlv.h
+++ b/include/sound/tlv.h
@@ -37,6 +37,7 @@
 #define SNDRV_CTL_TLVT_DB_RANGE 3	/* dB range container */
 #define SNDRV_CTL_TLVT_DB_MINMAX 4	/* dB scale with min/max */
 #define SNDRV_CTL_TLVT_DB_MINMAX_MUTE 5	/* dB scale with min/max with mute */
+#define SNDRV_CTL_TLVT_PCM_DEVICE 6	/* (jack) control maps to this device */

 #define TLV_DB_SCALE_MASK	0xffff
 #define TLV_DB_SCALE_MUTE	0x10000
@@ -73,4 +74,9 @@

 #define TLV_DB_GAIN_MUTE	-9999999

+#define TLV_PCM_DEVICE_NUMBER_ITEM(devno) \
+	SNDRV_CTL_TLVT_PCM_DEVICE, 1 * sizeof(unsigned int), (devno)
+#define DECLARE_TLV_PCM_DEVICE_NUMBER(name, devno) \
+	unsigned int name[] = { TLV_PCM_DEVICE_NUMBER_ITEM(devno) }
+
 #endif /* __SOUND_TLV_H */
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 3949015..848dd03 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -15,6 +15,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/jack.h>
+#include <sound/tlv.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_jack.h"
@@ -210,7 +211,7 @@ EXPORT_SYMBOL_HDA(snd_hda_jack_report_sync);
  * will have the given name and index.
  */
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx)
+			  const char *name, int idx, int device)
 {
 	struct hda_jack_tbl *jack;
 	struct snd_kcontrol *kctl;
@@ -223,6 +224,13 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	kctl = snd_kctl_jack_new(name, idx, codec);
 	if (!kctl)
 		return -ENOMEM;
+	if (device >= 0) {
+		jack->tlv[0] = SNDRV_CTL_TLVT_PCM_DEVICE;
+		jack->tlv[1] = 1 * sizeof(unsigned int);
+		jack->tlv[2] = device;
+		kctl->tlv.p = jack->tlv;
+		kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+	}
 	if (snd_hda_ctl_add(codec, nid, kctl) < 0)
 		return -ENOMEM;
 	jack->kctl = kctl;
@@ -249,7 +257,7 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 		return 0;

 	snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), &idx);
-	err = snd_hda_jack_add_kctl(codec, nid, name, idx);
+	err = snd_hda_jack_add_kctl(codec, nid, name, idx, -1);
 	if (err < 0)
 		return err;
 	return snd_hda_jack_detect_enable(codec, nid, 0);
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index f8f97c7..a2e69c5 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -22,6 +22,7 @@ struct hda_jack_tbl {
 	unsigned int jack_detect:1;	/* capable of jack-detection? */
 	unsigned int jack_dirty:1;	/* needs to update? */
 	struct snd_kcontrol *kctl;	/* assigned kctl for jack-detection */
+	unsigned int tlv[3];
 #ifdef CONFIG_SND_HDA_INPUT_JACK
 	int type;
 	struct snd_jack *jack;
@@ -76,7 +77,7 @@ static inline bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid)
 }

 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx);
+			  const char *name, int idx, int device);
 int snd_hda_jack_add_kctls(struct hda_codec *codec,
 			   const struct auto_pin_cfg *cfg);

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index bb8cfc6..9689c8d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1277,7 +1277,8 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 		err = snd_hda_jack_add_kctl(codec, per_pin->pin_nid,
-					    "HDMI", pin_idx);
+					    "HDMI", pin_idx,
+					    spec->pcm_rec[pin_idx].device);
 		if (err < 0)
 			return err;
 	}
