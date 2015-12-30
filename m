From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: add sys clk detection" to the
	asoc tree
Date: Wed, 30 Dec 2015 18:05:19 +0000
Message-ID: <E1aEL7f-0007Mp-OF@debutante>
References: <1451460801-24252-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D9C5265A13
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 19:05:25 +0100 (CET)
In-Reply-To: <1451460801-24252-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: add sys clk detection

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

>From ca8457bb02d8ecddf7f49ab874127dd4df782b16 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 30 Dec 2015 15:33:21 +0800
Subject: [PATCH] ASoC: rt5645: add sys clk detection

Add system clock detection to prevent output DC from SPO.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 4 ++++
 sound/soc/codecs/rt5645.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 28132375e427..61bbeac0c117 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1646,9 +1646,13 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
 			RT5645_PWR_CLS_D_L,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
 			RT5645_PWR_CLS_D_L);
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL3,
+			RT5645_DET_CLK_MASK, RT5645_DET_CLK_MODE1);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL3,
+			RT5645_DET_CLK_MASK, RT5645_DET_CLK_DIS);
 		snd_soc_write(codec, RT5645_EQ_CTRL2, 0);
 		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 093e46d559fb..205e0715c99a 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2122,6 +2122,10 @@ enum {
 /* General Control3 (0xfc) */
 #define RT5645_JD_PSV_MODE			(0x1 << 12)
 #define RT5645_IRQ_CLK_GATE_CTRL		(0x1 << 11)
+#define RT5645_DET_CLK_MASK			(0x3 << 9)
+#define RT5645_DET_CLK_DIS			(0x0 << 9)
+#define RT5645_DET_CLK_MODE1			(0x1 << 9)
+#define RT5645_DET_CLK_MODE2			(0x2 << 9)
 #define RT5645_MICINDET_MANU			(0x1 << 7)
 #define RT5645_RING2_SLEEVE_GND			(0x1 << 5)
 
-- 
2.6.2
