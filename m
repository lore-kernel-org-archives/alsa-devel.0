From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: add Mono ADC Capture Switch
	control" to the asoc tree
Date: Fri, 28 Oct 2016 19:47:46 +0100
Message-ID: <E1c0CBu-0005u4-UO@finisterre>
References: <1477446044-15127-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F64E265D93
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 20:48:20 +0200 (CEST)
In-Reply-To: <1477446044-15127-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: add Mono ADC Capture Switch control

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

>From ca5f17c59b63c3e52f8fad887c27c6eaa5ced81f Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 26 Oct 2016 09:40:44 +0800
Subject: [PATCH] ASoC: rt5640: add Mono ADC Capture Switch control

Mono ADC Capture Switch control is missing in the driver. So, add it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 2 ++
 sound/soc/codecs/rt5640.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0a7378f81acb..e29a6defefa0 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -423,6 +423,8 @@ static const struct snd_kcontrol_new rt5640_snd_controls[] = {
 	SOC_DOUBLE_TLV("ADC Capture Volume", RT5640_ADC_DIG_VOL,
 			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
 			127, 0, adc_vol_tlv),
+	SOC_DOUBLE("Mono ADC Capture Switch", RT5640_DUMMY1,
+		RT5640_M_MONO_ADC_L_SFT, RT5640_M_MONO_ADC_R_SFT, 1, 1),
 	SOC_DOUBLE_TLV("Mono ADC Capture Volume", RT5640_ADC_DATA,
 			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
 			127, 0, adc_vol_tlv),
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 22c017c58d5b..b8a811732a52 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -1971,6 +1971,10 @@
 #define RT5640_ZCD_HP_EN			(0x1 << 15)
 
 /* General Control 1 (0xfa) */
+#define RT5640_M_MONO_ADC_L			(0x1 << 13)
+#define RT5640_M_MONO_ADC_L_SFT			13
+#define RT5640_M_MONO_ADC_R			(0x1 << 12)
+#define RT5640_M_MONO_ADC_R_SFT			12
 #define RT5640_MCLK_DET				(0x1 << 11)
 
 /* Codec Private Register definition */
-- 
2.10.1
