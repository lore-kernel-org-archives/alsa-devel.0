From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: add button detection mode
	control" to the asoc tree
Date: Tue, 03 Jul 2018 16:34:30 +0100
Message-ID: <E1faNK2-0003tN-8x@debutante>
References: <1530594445-30007-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DE83D26776A
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 17:34:53 +0200 (CEST)
In-Reply-To: <1530594445-30007-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, naveen.m@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: add button detection mode control

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2daf3d9962c5a11fb79fe17bae03125df5d60236 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 3 Jul 2018 13:07:25 +0800
Subject: [PATCH] ASoC: rt5682: add button detection mode control

We are currently using power saving mode for button detection.
However, it will impact the headset recording performance.
This patch will switch button detection to normal mode in capture
and switch to power saving mode in the end of capture.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index baad177908ab..640d400ca013 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -857,6 +857,8 @@ static int rt5682_button_detect(struct snd_soc_component *component)
 	btn_type = val & 0xfff0;
 	snd_soc_component_write(component, RT5682_4BTN_IL_CMD_1, val);
 	pr_debug("%s btn_type=%x\n", __func__, btn_type);
+	snd_soc_component_update_bits(component,
+		RT5682_SAR_IL_CMD_2, 0x10, 0x10);
 
 	return btn_type;
 }
@@ -1645,6 +1647,8 @@ static const struct snd_soc_dapm_widget rt5682_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Stereo1 ADC MIXR", RT5682_STO1_ADC_DIG_VOL,
 		RT5682_R_MUTE_SFT, 1, rt5682_sto1_adc_r_mix,
 		ARRAY_SIZE(rt5682_sto1_adc_r_mix)),
+	SND_SOC_DAPM_SUPPLY("BTN Detection Mode", RT5682_SAR_IL_CMD_1,
+		14, 1, NULL, 0),
 
 	/* ADC PGA */
 	SND_SOC_DAPM_PGA("Stereo1 ADC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -1807,6 +1811,8 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 	{"Stereo1 ADC MIXR", "ADC2 Switch", "Stereo1 ADC R2 Mux"},
 	{"Stereo1 ADC MIXR", NULL, "ADC Stereo1 Filter"},
 
+	{"ADC Stereo1 Filter", NULL, "BTN Detection Mode"},
+
 	{"Stereo1 ADC MIX", NULL, "Stereo1 ADC MIXL"},
 	{"Stereo1 ADC MIX", NULL, "Stereo1 ADC MIXR"},
 
-- 
2.18.0.rc2
