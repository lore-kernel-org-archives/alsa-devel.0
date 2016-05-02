From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add support for TLV based
	binary controls" to the asoc tree
Date: Mon, 02 May 2016 16:47:09 +0100
Message-ID: <E1axG3x-0005FL-3V@debutante>
References: <1462193856-4360-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34FDB260421
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 17:47:18 +0200 (CEST)
In-Reply-To: <1462193856-4360-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add support for TLV based binary controls

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

>From 9ee78757d5dae51decc881b293a39a605c9a6df2 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 2 May 2016 13:57:36 +0100
Subject: [PATCH] ASoC: wm_adsp: Add support for TLV based binary controls

This patch adds support for the arbitrary length TLV based binary
controls. This allows users to properly access controls that are
more than 512 bytes in length.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 128 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 108 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3ac2e1f06ad3..f835277901d4 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -160,6 +160,8 @@
 #define ADSP2_RAM_RDY_SHIFT                    0
 #define ADSP2_RAM_RDY_WIDTH                    1
 
+#define ADSP_MAX_STD_CTRL_SIZE               512
+
 struct wm_adsp_buf {
 	struct list_head list;
 	void *buf;
@@ -435,6 +437,7 @@ struct wm_coeff_ctl {
 	size_t len;
 	unsigned int set:1;
 	struct snd_kcontrol *kcontrol;
+	struct soc_bytes_ext bytes_ext;
 	unsigned int flags;
 };
 
@@ -711,10 +714,17 @@ static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
 		 be16_to_cpu(scratch[3]));
 }
 
+static inline struct wm_coeff_ctl *bytes_ext_to_ctl(struct soc_bytes_ext *ext)
+{
+	return container_of(ext, struct wm_coeff_ctl, bytes_ext);
+}
+
 static int wm_coeff_info(struct snd_kcontrol *kctl,
 			 struct snd_ctl_elem_info *uinfo)
 {
-	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
 	uinfo->count = ctl->len;
@@ -763,7 +773,9 @@ static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 static int wm_coeff_put(struct snd_kcontrol *kctl,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
 	char *p = ucontrol->value.bytes.data;
 	int ret = 0;
 
@@ -780,6 +792,29 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 	return ret;
 }
 
+static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
+			    const unsigned int __user *bytes, unsigned int size)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
+	int ret = 0;
+
+	mutex_lock(&ctl->dsp->pwr_lock);
+
+	if (copy_from_user(ctl->cache, bytes, size)) {
+		ret = -EFAULT;
+	} else {
+		ctl->set = 1;
+		if (ctl->enabled)
+			ret = wm_coeff_write_control(ctl, ctl->cache, size);
+	}
+
+	mutex_unlock(&ctl->dsp->pwr_lock);
+
+	return ret;
+}
+
 static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 				 void *buf, size_t len)
 {
@@ -822,7 +857,9 @@ static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 static int wm_coeff_get(struct snd_kcontrol *kctl,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
 	char *p = ucontrol->value.bytes.data;
 	int ret = 0;
 
@@ -845,12 +882,72 @@ static int wm_coeff_get(struct snd_kcontrol *kctl,
 	return ret;
 }
 
+static int wm_coeff_tlv_get(struct snd_kcontrol *kctl,
+			    unsigned int __user *bytes, unsigned int size)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
+	int ret = 0;
+
+	mutex_lock(&ctl->dsp->pwr_lock);
+
+	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
+		if (ctl->enabled)
+			ret = wm_coeff_read_control(ctl, ctl->cache, size);
+		else
+			ret = -EPERM;
+	} else {
+		if (!ctl->flags && ctl->enabled)
+			ret = wm_coeff_read_control(ctl, ctl->cache, size);
+	}
+
+	if (!ret && copy_to_user(bytes, ctl->cache, size))
+		ret = -EFAULT;
+
+	mutex_unlock(&ctl->dsp->pwr_lock);
+
+	return ret;
+}
+
 struct wmfw_ctl_work {
 	struct wm_adsp *dsp;
 	struct wm_coeff_ctl *ctl;
 	struct work_struct work;
 };
 
+static unsigned int wmfw_convert_flags(unsigned int in, unsigned int len)
+{
+	unsigned int out, rd, wr, vol;
+
+	if (len > ADSP_MAX_STD_CTRL_SIZE) {
+		rd = SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+		wr = SNDRV_CTL_ELEM_ACCESS_TLV_WRITE;
+		vol = SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+
+		out = SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+	} else {
+		rd = SNDRV_CTL_ELEM_ACCESS_READ;
+		wr = SNDRV_CTL_ELEM_ACCESS_WRITE;
+		vol = SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+
+		out = 0;
+	}
+
+	if (in) {
+		if (in & WMFW_CTL_FLAG_READABLE)
+			out |= rd;
+		if (in & WMFW_CTL_FLAG_WRITEABLE)
+			out |= wr;
+		if (in & WMFW_CTL_FLAG_VOLATILE)
+			out |= vol;
+	} else {
+		out |= rd | wr | vol;
+	}
+
+	return out;
+}
+
 static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 {
 	struct snd_kcontrol_new *kcontrol;
@@ -868,19 +965,15 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 	kcontrol->info = wm_coeff_info;
 	kcontrol->get = wm_coeff_get;
 	kcontrol->put = wm_coeff_put;
-	kcontrol->private_value = (unsigned long)ctl;
+	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	kcontrol->tlv.c = snd_soc_bytes_tlv_callback;
+	kcontrol->private_value = (unsigned long)&ctl->bytes_ext;
 
-	if (ctl->flags) {
-		if (ctl->flags & WMFW_CTL_FLAG_WRITEABLE)
-			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_WRITE;
-		if (ctl->flags & WMFW_CTL_FLAG_READABLE)
-			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_READ;
-		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
-			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
-	} else {
-		kcontrol->access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
-		kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
-	}
+	ctl->bytes_ext.max = ctl->len;
+	ctl->bytes_ext.get = wm_coeff_tlv_get;
+	ctl->bytes_ext.put = wm_coeff_tlv_put;
+
+	kcontrol->access = wmfw_convert_flags(ctl->flags, ctl->len);
 
 	ret = snd_soc_add_card_controls(dsp->card, kcontrol, 1);
 	if (ret < 0)
@@ -1032,11 +1125,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 
 	ctl->flags = flags;
 	ctl->offset = offset;
-	if (len > 512) {
-		adsp_warn(dsp, "Truncating control %s from %d\n",
-			  ctl->name, len);
-		len = 512;
-	}
 	ctl->len = len;
 	ctl->cache = kzalloc(ctl->len, GFP_KERNEL);
 	if (!ctl->cache) {
-- 
2.8.1
