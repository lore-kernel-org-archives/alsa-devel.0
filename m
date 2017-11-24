From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Make sure the DMIC delay will
	be happened after normal SUPPLY widgets power on" to the asoc tree
Date: Fri, 24 Nov 2017 13:03:43 +0000 (GMT)
Message-ID: <20171124130343.CCBB444005B@finisterre.ee.mobilebroadband>
References: <1511504597-2948-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BAFC4267962
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 14:03:45 +0100 (CET)
In-Reply-To: <1511504597-2948-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Make sure the DMIC delay will be happened after normal SUPPLY widgets power on

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

>From 254beff97b4714bac4ec8add5a6888c1adc1ad8f Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Fri, 24 Nov 2017 16:11:22 +0800
Subject: [PATCH] ASoC: rt5514: Make sure the DMIC delay will be happened after
 normal SUPPLY widgets power on

The patch makes sure the DMIC delay will be happened after normal SUPPLY
widgets power on. If there are some platforms that provide the MCLK using
the SUPPLY widget, it will make sure the delay time is helpful.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 2a5b5d74e697..2dd6e9f990a4 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -496,7 +496,7 @@ static const struct snd_soc_dapm_widget rt5514_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("DMIC1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("DMIC2", SND_SOC_NOPM, 0, 0, NULL, 0),
 
-	SND_SOC_DAPM_SUPPLY("DMIC CLK", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SUPPLY_S("DMIC CLK", 1, SND_SOC_NOPM, 0, 0,
 		rt5514_set_dmic_clk, SND_SOC_DAPM_PRE_PMU),
 
 	SND_SOC_DAPM_SUPPLY("ADC CLK", RT5514_CLK_CTRL1,
-- 
2.14.1
