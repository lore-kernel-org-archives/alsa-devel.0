From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Support acknowledged controls" to the asoc tree
Date: Fri, 11 Nov 2016 16:00:38 +0000
Message-ID: <E1c5EFq-0003gL-J8@finisterre>
References: <1478711658-23696-5-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478711658-23696-5-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Support acknowledged controls

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a23ebba845fee07cce00659c06844845b24da290 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 9 Nov 2016 17:14:18 +0000
Subject: [PATCH] ASoC: wm_adsp: Support acknowledged controls

This patch handles publishing acknowledged controls through ALSA.
These controls allow user-side to send events to the firmware and
wait for the firmware to acknowledge it.

Note that although acked controls only operate in the direction
host->firmware, and therefore they are write-only as seen from user-
side code, we have to make them readable to account for all the code
out there that assumes that ALSA controls are always readable (amixer
for example.)

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 89 +++++++++++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/wmfw.h    |  1 +
 2 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d13dd9a9c817..0f705bfd76b4 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -164,6 +164,8 @@
 
 #define WM_ADSP_ACKED_CTL_TIMEOUT_MS         100
 #define WM_ADSP_ACKED_CTL_N_QUICKPOLLS       10
+#define WM_ADSP_ACKED_CTL_MIN_VALUE          0
+#define WM_ADSP_ACKED_CTL_MAX_VALUE          0xFFFFFF
 
 /*
  * Event control messages
@@ -761,8 +763,20 @@ static int wm_coeff_info(struct snd_kcontrol *kctl,
 		(struct soc_bytes_ext *)kctl->private_value;
 	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
-	uinfo->count = ctl->len;
+	switch (ctl->type) {
+	case WMFW_CTL_TYPE_ACKED:
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+		uinfo->value.integer.min = WM_ADSP_ACKED_CTL_MIN_VALUE;
+		uinfo->value.integer.max = WM_ADSP_ACKED_CTL_MAX_VALUE;
+		uinfo->value.integer.step = 1;
+		uinfo->count = 1;
+		break;
+	default:
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+		uinfo->count = ctl->len;
+		break;
+	}
+
 	return 0;
 }
 
@@ -910,6 +924,30 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 	return ret;
 }
 
+static int wm_coeff_put_acked(struct snd_kcontrol *kctl,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
+	unsigned int val = ucontrol->value.integer.value[0];
+	int ret;
+
+	if (val == 0)
+		return 0;	/* 0 means no event */
+
+	mutex_lock(&ctl->dsp->pwr_lock);
+
+	if (ctl->enabled)
+		ret = wm_coeff_write_acked_control(ctl, val);
+	else
+		ret = -EPERM;
+
+	mutex_unlock(&ctl->dsp->pwr_lock);
+
+	return ret;
+}
+
 static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 				 void *buf, size_t len)
 {
@@ -1005,6 +1043,21 @@ static int wm_coeff_tlv_get(struct snd_kcontrol *kctl,
 	return ret;
 }
 
+static int wm_coeff_get_acked(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	/*
+	 * Although it's not useful to read an acked control, we must satisfy
+	 * user-side assumptions that all controls are readable and that a
+	 * write of the same value should be filtered out (it's valid to send
+	 * the same event number again to the firmware). We therefore return 0,
+	 * meaning "no event" so valid event numbers will always be a change
+	 */
+	ucontrol->value.integer.value[0] = 0;
+
+	return 0;
+}
+
 struct wmfw_ctl_work {
 	struct wm_adsp *dsp;
 	struct wm_coeff_ctl *ctl;
@@ -1057,17 +1110,25 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 
 	kcontrol->name = ctl->name;
 	kcontrol->info = wm_coeff_info;
-	kcontrol->get = wm_coeff_get;
-	kcontrol->put = wm_coeff_put;
 	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	kcontrol->tlv.c = snd_soc_bytes_tlv_callback;
 	kcontrol->private_value = (unsigned long)&ctl->bytes_ext;
+	kcontrol->access = wmfw_convert_flags(ctl->flags, ctl->len);
 
-	ctl->bytes_ext.max = ctl->len;
-	ctl->bytes_ext.get = wm_coeff_tlv_get;
-	ctl->bytes_ext.put = wm_coeff_tlv_put;
+	switch (ctl->type) {
+	case WMFW_CTL_TYPE_ACKED:
+		kcontrol->get = wm_coeff_get_acked;
+		kcontrol->put = wm_coeff_put_acked;
+		break;
+	default:
+		kcontrol->get = wm_coeff_get;
+		kcontrol->put = wm_coeff_put;
 
-	kcontrol->access = wmfw_convert_flags(ctl->flags, ctl->len);
+		ctl->bytes_ext.max = ctl->len;
+		ctl->bytes_ext.get = wm_coeff_tlv_get;
+		ctl->bytes_ext.put = wm_coeff_tlv_put;
+		break;
+	}
 
 	ret = snd_soc_add_card_controls(dsp->card, kcontrol, 1);
 	if (ret < 0)
@@ -1429,6 +1490,18 @@ static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 		switch (coeff_blk.ctl_type) {
 		case SNDRV_CTL_ELEM_TYPE_BYTES:
 			break;
+		case WMFW_CTL_TYPE_ACKED:
+			if (coeff_blk.flags & WMFW_CTL_FLAG_SYS)
+				continue;	/* ignore */
+
+			ret = wm_adsp_check_coeff_flags(dsp, &coeff_blk,
+						WMFW_CTL_FLAG_VOLATILE |
+						WMFW_CTL_FLAG_WRITEABLE |
+						WMFW_CTL_FLAG_READABLE,
+						0);
+			if (ret)
+				return -EINVAL;
+			break;
 		case WMFW_CTL_TYPE_HOSTEVENT:
 			ret = wm_adsp_check_coeff_flags(dsp, &coeff_blk,
 						WMFW_CTL_FLAG_SYS |
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index 892fc7490f3b..ec78b9da020f 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -27,6 +27,7 @@
 #define WMFW_CTL_FLAG_READABLE    0x0001
 
 /* Non-ALSA coefficient types start at 0x1000 */
+#define WMFW_CTL_TYPE_ACKED       0x1000 /* acked control */
 #define WMFW_CTL_TYPE_HOSTEVENT   0x1001 /* event control */
 
 struct wmfw_header {
-- 
2.10.2
