From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH v2 1/1] ALSA: usb-audio: Add custom mixer
	status quirks for RME CC devices
Date: Thu,  4 Oct 2018 22:17:43 +0300
Message-ID: <20181004191743.20100-2-jussi@sonarnerd.net>
References: <20181004191743.20100-1-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id C0C762678D9
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 21:18:17 +0200 (CEST)
In-Reply-To: <20181004191743.20100-1-jussi@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

Adds several vendor specific mixer quirks for RME's Class Compliant
USB devices. These provide extra status information from the device
otherwise not available.

These include AES/SPDIF rate and status information, current system
sampling rate and measured frequency. This information is especially
useful in cases where device's clock is slaved to external clock
source.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/mixer_quirks.c | 349 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 349 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index cbfb48bdea51..d75e1f025b3b 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -27,6 +27,8 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <asm/div64.h>
+
 #include <linux/hid.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -1817,6 +1819,347 @@ static int dell_dock_mixer_init(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/* RME Class Compliant device quirks */
+
+static const u32 snd_rme_rate_table[] = {
+	32000, 44100, 48000, 50000,
+	64000, 88200, 96000, 100000,
+	128000, 176400, 192000, 200000,
+	256000,	352800, 384000, 400000,
+	512000, 705600, 768000, 800000
+};
+
+static int snd_rme_get_status1(struct snd_kcontrol *kcontrol,
+			       u32 *status1)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	struct usb_device *dev = chip->dev;
+	int err;
+
+	err = snd_usb_lock_shutdown(chip);
+	if (err < 0)
+		return err;
+
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      23,  /* GET_STATUS1 */
+			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      0, 0,
+			      status1, sizeof(*status1));
+	if (err < 0) {
+		dev_err(&dev->dev,
+			"unable to issue vendor read request (ret = %d)", err);
+		goto end;
+	}
+
+end:
+	snd_usb_unlock_shutdown(chip);
+	return err;
+}
+
+static int snd_rme_rate_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	u32 rate = 0;
+	int idx;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+
+	switch (kcontrol->private_value)
+	{
+	case 0:  /* System */
+		idx = (status1 >> 16) & 0x1f;
+		if (idx < ARRAY_SIZE(snd_rme_rate_table))
+			rate = snd_rme_rate_table[idx];
+		break;
+	case 1:  /* AES */
+		idx = (status1 >> 8) & 0xf;
+		if (idx < 12)
+			rate = snd_rme_rate_table[idx];
+		break;
+	case 2:  /* SPDIF */
+		idx = (status1 >> 12) & 0xf;
+		if (idx < 12)
+			rate = snd_rme_rate_table[idx];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ucontrol->value.integer.value[0] = rate;
+	return 0;
+}
+
+static int snd_rme_sync_state_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	int idx = 0;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+
+	switch (kcontrol->private_value)
+	{
+	case 1:  /* AES */
+		if (status1 & 0x4)
+			idx = 2;
+		else if (status1 & 0x1)
+			idx = 1;
+		break;
+	case 2:  /* SPDIF */
+		if (status1 & 0x8)
+			idx = 2;
+		else if (status1 & 0x2)
+			idx = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ucontrol->value.enumerated.item[0] = idx;
+	return 0;
+}
+
+static int snd_rme_spdif_if_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+
+	ucontrol->value.enumerated.item[0] = (status1 >> 4) & 0x1;
+	return 0;
+}
+
+static int snd_rme_spdif_format_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+
+	ucontrol->value.enumerated.item[0] = (status1 >> 5) & 0x1;
+	return 0;
+}
+
+static int snd_rme_sync_source_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+
+	ucontrol->value.enumerated.item[0] = (status1 >> 6) & 0x3;
+	return 0;
+}
+
+static int snd_rme_current_freq_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	struct usb_device *dev = chip->dev;
+	u32 status1;
+	const u64 num = 104857600000000;
+	u32 den;
+	unsigned int freq;
+	int err;
+
+	err = snd_usb_lock_shutdown(chip);
+	if (err < 0)
+		return err;
+
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      23,  /* GET_STATUS1 */
+			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      0, 0,
+			      &status1, sizeof(status1));
+	if (err < 0) {
+		dev_err(&dev->dev,
+			"unable to issue vendor read request (ret = %d)", err);
+		goto end;
+	}
+
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      17,  /* GET_CURRENT_FREQ */
+			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      0, 0,
+			      &den, sizeof(den));
+	if (err < 0) {
+		dev_err(&dev->dev,
+			"unable to issue vendor read request (ret = %d)", err);
+		goto end;
+	}
+	freq = (den == 0) ? 0 : div64_u64(num, den);
+
+	freq <<= ((status1 >> 18) & 0x7);
+	ucontrol->value.integer.value[0] = freq;
+
+end:
+	snd_usb_unlock_shutdown(chip);
+	return err;
+}
+
+static int snd_rme_rate_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min =
+		(kcontrol->private_value > 0) ? 0 : 32000;
+	uinfo->value.integer.max =
+		(kcontrol->private_value > 0) ? 200000 : 800000;
+	uinfo->value.integer.step = 0;
+	return 0;
+}
+
+static int snd_rme_sync_state_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const sync_states[] = {
+		"No Lock", "Lock", "Sync"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(sync_states), sync_states);
+}
+
+static int snd_rme_spdif_if_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const spdif_if[] = {
+		"Coaxial", "Optical"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(spdif_if), spdif_if);
+}
+
+static int snd_rme_spdif_format_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const optical_type[] = {
+		"Consumer", "Professional"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(optical_type), optical_type);
+}
+
+static int snd_rme_sync_source_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const sync_sources[] = {
+		"Internal", "AES", "SPDIF", "Internal"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(sync_sources), sync_sources);
+}
+
+static struct snd_kcontrol_new snd_rme_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "AES Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_rate_get,
+		.private_value = 1
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "AES Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_sync_state_get,
+		.private_value = 1
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "SPDIF Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_rate_get,
+		.private_value = 2
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "SPDIF Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_sync_state_get,
+		.private_value = 2
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "SPDIF Interface",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_spdif_if_info,
+		.get = snd_rme_spdif_if_get,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "SPDIF Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_spdif_format_info,
+		.get = snd_rme_spdif_format_get,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Sync Source",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_source_info,
+		.get = snd_rme_sync_source_get
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "System Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_rate_get,
+		.private_value = 0
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Current Frequency",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_current_freq_get
+	}
+};
+
+static int snd_rme_controls_create(struct usb_mixer_interface *mixer)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(snd_rme_controls); ++i) {
+		err = add_single_ctl_with_resume(mixer, 0,
+						 NULL,
+						 &snd_rme_controls[i],
+						 NULL);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err = 0;
@@ -1904,6 +2247,12 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x0bda, 0x4014): /* Dell WD15 dock */
 		err = dell_dock_mixer_init(mixer);
 		break;
+
+	case USB_ID(0x2a39, 0x3fd2): /* RME ADI-2 Pro */
+	case USB_ID(0x2a39, 0x3fd3): /* RME ADI-2 DAC */
+	case USB_ID(0x2a39, 0x3fd4): /* RME */
+		err = snd_rme_controls_create(mixer);
+		break;
 	}
 
 	return err;
-- 
2.17.1
