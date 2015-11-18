From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: wm5102: Move driver to use
	SND_SOC_BYTES_TLV
Date: Wed, 18 Nov 2015 19:09:11 +0530
Message-ID: <1447853952-6414-3-git-send-email-vinod.koul@intel.com>
References: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 83BC92654B0
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:36:01 +0100 (CET)
In-Reply-To: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, patches@opensource.wolfsonmicro.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

WM5102 driver was using SND_SOC_BYTES_EXT. Since we want to
remove this, convert it to use SND_SOC_BYTES_TLV

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com
---
 sound/soc/codecs/wm5102.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 64637d1cf4e5..ac96e7e32fa7 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -657,33 +657,50 @@ static int wm5102_adsp_power_ev(struct snd_soc_dapm_widget *w,
 	return wm_adsp2_early_event(w, kcontrol, event);
 }
 
+#define WM5102_OUT_COMP_SZ 2
+
 static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
+			unsigned int __user *data, unsigned int size)
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	u16 buff;
+	int ret = 0;
+
+	if (size > WM5102_OUT_COMP_SZ)
+		return -EINVAL;
 
 	mutex_lock(&arizona->dac_comp_lock);
-	put_unaligned_be16(arizona->dac_comp_coeff,
-			   ucontrol->value.bytes.data);
+	put_unaligned_be16(arizona->dac_comp_coeff, &buff);
+	if (copy_to_user(data, &buff, sizeof(buff)))
+		ret = -EFAULT;
+
 	mutex_unlock(&arizona->dac_comp_lock);
 
-	return 0;
+	return ret;
 }
 
 static int wm5102_out_comp_coeff_put(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
+			const unsigned int __user *data, unsigned int size)
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	int ret = 0;
+
+	if (size > WM5102_OUT_COMP_SZ)
+		return -EINVAL;
 
 	mutex_lock(&arizona->dac_comp_lock);
-	memcpy(&arizona->dac_comp_coeff, ucontrol->value.bytes.data,
-	       sizeof(arizona->dac_comp_coeff));
+	if (copy_from_user(&arizona->dac_comp_coeff, data, size)) {
+		ret = -EFAULT;
+		goto exit;
+	}
 	arizona->dac_comp_coeff = be16_to_cpu(arizona->dac_comp_coeff);
+
+exit:
 	mutex_unlock(&arizona->dac_comp_lock);
 
-	return 0;
+	return ret;
 }
 
 static int wm5102_out_comp_switch_get(struct snd_kcontrol *kcontrol,
@@ -939,7 +956,7 @@ SOC_SINGLE_TLV("Noise Gate Threshold Volume", ARIZONA_NOISE_GATE_CONTROL,
 	       ARIZONA_NGATE_THR_SHIFT, 7, 1, ng_tlv),
 SOC_ENUM("Noise Gate Hold", arizona_ng_hold),
 
-SND_SOC_BYTES_EXT("Output Compensation Coefficient", 2,
+SND_SOC_BYTES_TLV("Output Compensation Coefficient", WM5102_OUT_COMP_SZ,
 		  wm5102_out_comp_coeff_get, wm5102_out_comp_coeff_put),
 
 SOC_SINGLE_EXT("Output Compensation Switch", 0, 0, 1, 0,
-- 
1.9.1
