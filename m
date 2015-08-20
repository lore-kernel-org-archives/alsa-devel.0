From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8994: fix add dynamic path error" to
	the asoc tree
Date: Thu, 20 Aug 2015 11:34:06 -0700
Message-ID: <E1ZSUf8-0008PM-Bu@finisterre>
References: <898610f35e157ce9d5b1e53a85f5a6ed822eadae.1439522138.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 65CEC265366
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2015 20:34:22 +0200 (CEST)
In-Reply-To: <898610f35e157ce9d5b1e53a85f5a6ed822eadae.1439522138.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8994: fix add dynamic path error

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

>From e134cb2041359c927b735b81568373624ea26baf Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 14 Aug 2015 11:22:16 +0800
Subject: [PATCH] ASoC: wm8994: fix add dynamic path error

If there don't exist dynamic sink or source widget, it will failed to
add dynamic path.

"AIF3ADCDAT" is snd_soc_dapm_aif_out, can't be dynamic sink widget. So
change the audio route to fix this issue.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8994.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 962e1d3..2ccbb32 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1942,14 +1942,16 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "AIF2ADCDAT", NULL, "AIF2ADC Mux" },
 
 	/* AIF3 output */
-	{ "AIF3ADCDAT", "AIF1ADCDAT", "AIF1ADC1L" },
-	{ "AIF3ADCDAT", "AIF1ADCDAT", "AIF1ADC1R" },
-	{ "AIF3ADCDAT", "AIF1ADCDAT", "AIF1ADC2L" },
-	{ "AIF3ADCDAT", "AIF1ADCDAT", "AIF1ADC2R" },
-	{ "AIF3ADCDAT", "AIF2ADCDAT", "AIF2ADCL" },
-	{ "AIF3ADCDAT", "AIF2ADCDAT", "AIF2ADCR" },
-	{ "AIF3ADCDAT", "AIF2DACDAT", "AIF2DACL" },
-	{ "AIF3ADCDAT", "AIF2DACDAT", "AIF2DACR" },
+	{ "AIF3ADC Mux", "AIF1ADCDAT", "AIF1ADC1L" },
+	{ "AIF3ADC Mux", "AIF1ADCDAT", "AIF1ADC1R" },
+	{ "AIF3ADC Mux", "AIF1ADCDAT", "AIF1ADC2L" },
+	{ "AIF3ADC Mux", "AIF1ADCDAT", "AIF1ADC2R" },
+	{ "AIF3ADC Mux", "AIF2ADCDAT", "AIF2ADCL" },
+	{ "AIF3ADC Mux", "AIF2ADCDAT", "AIF2ADCR" },
+	{ "AIF3ADC Mux", "AIF2DACDAT", "AIF2DACL" },
+	{ "AIF3ADC Mux", "AIF2DACDAT", "AIF2DACR" },
+
+	{ "AIF3ADCDAT", NULL, "AIF3ADC Mux" },
 
 	/* Loopback */
 	{ "AIF1 Loopback", "ADCDAT", "AIF1ADCDAT" },
-- 
2.5.0
