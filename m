From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: MAX9877: separate callback functions
Date: Wed, 22 Jul 2009 14:09:08 +0900
Message-ID: <4A669EF4.2070504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 30A831038A7
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 07:09:12 +0200 (CEST)
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KN600FHC3N828@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 22 Jul 2009 14:09:09 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KN600GHZ3N8R4@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 22 Jul 2009 14:09:08 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The callback function to control register was used by whole controls in
MAX9877 driver, but this causes using many if statement for double
register control or invert.
So, the callback function for double register control is separate
differently, and the code for invert is added in the callback function.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/codecs/max9877.c |   96 +++++++++++++++++++++++++++++---------------
 1 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index 7df9a7c..a1f1119 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -34,16 +34,16 @@ static int max9877_get_reg(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int reg = mc->reg;
-	int reg2 = mc->rreg;
-	int shift = mc->shift;
-	int mask = mc->max;
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int mask = mc->max;
+	unsigned int invert = mc->invert;
 
 	ucontrol->value.integer.value[0] = (max9877_regs[reg] >> shift) & mask;
 
-	if (reg2)
-		ucontrol->value.integer.value[1] =
-			(max9877_regs[reg2] >> shift) & mask;
+	if (invert)
+		ucontrol->value.integer.value[0] =
+			mask - ucontrol->value.integer.value[0];
 
 	return 0;
 }
@@ -53,39 +53,69 @@ static int max9877_set_reg(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int reg = mc->reg;
-	int reg2 = mc->rreg;
-	int shift = mc->shift;
-	int mask = mc->max;
-	int change = 1;
-	int change2 = 1;
-	int ret = 0;
-
-	if (((max9877_regs[reg] >> shift) & mask) ==
-			ucontrol->value.integer.value[0])
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int mask = mc->max;
+	unsigned int invert = mc->invert;
+	unsigned int val = (ucontrol->value.integer.value[0] & mask);
+
+	if (invert)
+		val = mask - val;
+
+	if (((max9877_regs[reg] >> shift) & mask) == val)
+		return 0;
+
+	max9877_regs[reg] &= ~(mask << shift);
+	max9877_regs[reg] |= val << shift;
+	max9877_write_regs();
+
+	return 1;
+}
+
+static int max9877_get_2reg(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
+	unsigned int mask = mc->max;
+
+	ucontrol->value.integer.value[0] = (max9877_regs[reg] >> shift) & mask;
+	ucontrol->value.integer.value[1] = (max9877_regs[reg2] >> shift) & mask;
+
+	return 0;
+}
+
+static int max9877_set_2reg(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
+	unsigned int mask = mc->max;
+	unsigned int val = (ucontrol->value.integer.value[0] & mask);
+	unsigned int val2 = (ucontrol->value.integer.value[1] & mask);
+	unsigned int change = 1;
+
+	if (((max9877_regs[reg] >> shift) & mask) == val)
 		change = 0;
 
-	if (reg2)
-		if (((max9877_regs[reg2] >> shift) & mask) ==
-				ucontrol->value.integer.value[1])
-			change2 = 0;
+	if (((max9877_regs[reg2] >> shift) & mask) == val2)
+		change = 0;
 
 	if (change) {
 		max9877_regs[reg] &= ~(mask << shift);
-		max9877_regs[reg] |= ucontrol->value.integer.value[0] << shift;
-		ret = change;
-	}
-
-	if (reg2 && change2) {
+		max9877_regs[reg] |= val << shift;
 		max9877_regs[reg2] &= ~(mask << shift);
-		max9877_regs[reg2] |= ucontrol->value.integer.value[1] << shift;
-		ret = change2;
-	}
-
-	if (ret)
+		max9877_regs[reg2] |= val2 << shift;
 		max9877_write_regs();
+	}
 
-	return ret;
+	return change;
 }
 
 static int max9877_get_out_mode(struct snd_kcontrol *kcontrol,
@@ -190,7 +220,7 @@ static const struct snd_kcontrol_new max9877_controls[] = {
 			max9877_get_reg, max9877_set_reg, max9877_output_tlv),
 	SOC_DOUBLE_R_EXT_TLV("MAX9877 Amp HP Playback Volume",
 			MAX9877_HPL_VOLUME, MAX9877_HPR_VOLUME, 0, 31, 0,
-			max9877_get_reg, max9877_set_reg, max9877_output_tlv),
+			max9877_get_2reg, max9877_set_2reg, max9877_output_tlv),
 	SOC_SINGLE_EXT("MAX9877 INB Stereo Switch",
 			MAX9877_INPUT_MODE, 4, 1, 1,
 			max9877_get_reg, max9877_set_reg),
-- 
1.6.0.4
