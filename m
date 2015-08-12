From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/4] ASoC: cs42l56: Use case range at
	appropriate place
Date: Wed, 12 Aug 2015 11:09:39 +0800
Message-ID: <1439348979.3594.4.camel@ingics.com>
References: <1439348866.3594.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AD8426062B
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 05:09:44 +0200 (CEST)
Received: by pdbfa8 with SMTP id fa8so2153598pdb.1
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 20:09:43 -0700 (PDT)
In-Reply-To: <1439348866.3594.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The readable registers are in continuous range: 0x01 ~ 0x2e.
Use case range syntax makes the code shorter with better readability when
we have a large number of continuous switch cases.
No functional change with this patch.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l56.c | 47 +---------------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 39f51fb..7cd5f76 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -115,52 +115,7 @@ static const struct reg_default cs42l56_reg_defaults[] = {
 static bool cs42l56_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS42L56_CHIP_ID_1:
-	case CS42L56_CHIP_ID_2:
-	case CS42L56_PWRCTL_1:
-	case CS42L56_PWRCTL_2:
-	case CS42L56_CLKCTL_1:
-	case CS42L56_CLKCTL_2:
-	case CS42L56_SERIAL_FMT:
-	case CS42L56_CLASSH_CTL:
-	case CS42L56_MISC_CTL:
-	case CS42L56_INT_STATUS:
-	case CS42L56_PLAYBACK_CTL:
-	case CS42L56_DSP_MUTE_CTL:
-	case CS42L56_ADCA_MIX_VOLUME:
-	case CS42L56_ADCB_MIX_VOLUME:
-	case CS42L56_PCMA_MIX_VOLUME:
-	case CS42L56_PCMB_MIX_VOLUME:
-	case CS42L56_ANAINPUT_ADV_VOLUME:
-	case CS42L56_DIGINPUT_ADV_VOLUME:
-	case CS42L56_MASTER_A_VOLUME:
-	case CS42L56_MASTER_B_VOLUME:
-	case CS42L56_BEEP_FREQ_ONTIME:
-	case CS42L56_BEEP_FREQ_OFFTIME:
-	case CS42L56_BEEP_TONE_CFG:
-	case CS42L56_TONE_CTL:
-	case CS42L56_CHAN_MIX_SWAP:
-	case CS42L56_AIN_REFCFG_ADC_MUX:
-	case CS42L56_HPF_CTL:
-	case CS42L56_MISC_ADC_CTL:
-	case CS42L56_GAIN_BIAS_CTL:
-	case CS42L56_PGAA_MUX_VOLUME:
-	case CS42L56_PGAB_MUX_VOLUME:
-	case CS42L56_ADCA_ATTENUATOR:
-	case CS42L56_ADCB_ATTENUATOR:
-	case CS42L56_ALC_EN_ATTACK_RATE:
-	case CS42L56_ALC_RELEASE_RATE:
-	case CS42L56_ALC_THRESHOLD:
-	case CS42L56_NOISE_GATE_CTL:
-	case CS42L56_ALC_LIM_SFT_ZC:
-	case CS42L56_AMUTE_HPLO_MUX:
-	case CS42L56_HPA_VOLUME:
-	case CS42L56_HPB_VOLUME:
-	case CS42L56_LOA_VOLUME:
-	case CS42L56_LOB_VOLUME:
-	case CS42L56_LIM_THRESHOLD_CTL:
-	case CS42L56_LIM_CTL_RELEASE_RATE:
-	case CS42L56_LIM_ATTACK_RATE:
+	case CS42L56_CHIP_ID_1 ... CS42L56_LIM_ATTACK_RATE:
 		return true;
 	default:
 		return false;
-- 
2.1.0
