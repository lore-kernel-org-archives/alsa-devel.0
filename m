From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: fix range of OPCLK_REF" to the
	asoc tree
Date: Tue, 03 Nov 2015 19:09:41 +0000
Message-ID: <E1Ztgxh-0007OC-Lh@debutante>
References: <1446560652-3144-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89B8F2604D1
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 20:09:51 +0100 (CET)
In-Reply-To: <1446560652-3144-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: fix range of OPCLK_REF

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

>From 341604ad839d10314af51669fd454dc0aa2ef288 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 3 Nov 2015 14:24:12 +0000
Subject: [PATCH] ASoC: arizona: fix range of OPCLK_REF

The code was able to generate illegal OPCLK_REF values because the
reference frequency tables listed all values of SYSCLK instead of
valid values for OPCLK_REF clock. The maximum OPCLK_REF clock is
49.152MHz or 45.1584MHz.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 8a2221ab3d10..586789597ecd 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -979,24 +979,18 @@ void arizona_init_dvfs(struct arizona_priv *priv)
 }
 EXPORT_SYMBOL_GPL(arizona_init_dvfs);
 
-static unsigned int arizona_sysclk_48k_rates[] = {
+static unsigned int arizona_opclk_ref_48k_rates[] = {
 	6144000,
 	12288000,
 	24576000,
 	49152000,
-	73728000,
-	98304000,
-	147456000,
 };
 
-static unsigned int arizona_sysclk_44k1_rates[] = {
+static unsigned int arizona_opclk_ref_44k1_rates[] = {
 	5644800,
 	11289600,
 	22579200,
 	45158400,
-	67737600,
-	90316800,
-	135475200,
 };
 
 static int arizona_set_opclk(struct snd_soc_codec *codec, unsigned int clk,
@@ -1021,11 +1015,11 @@ static int arizona_set_opclk(struct snd_soc_codec *codec, unsigned int clk,
 	}
 
 	if (refclk % 8000)
-		rates = arizona_sysclk_44k1_rates;
+		rates = arizona_opclk_ref_44k1_rates;
 	else
-		rates = arizona_sysclk_48k_rates;
+		rates = arizona_opclk_ref_48k_rates;
 
-	for (ref = 0; ref < ARRAY_SIZE(arizona_sysclk_48k_rates) &&
+	for (ref = 0; ref < ARRAY_SIZE(arizona_opclk_ref_48k_rates) &&
 		     rates[ref] <= refclk; ref++) {
 		div = 1;
 		while (rates[ref] / div >= freq && div < 32) {
-- 
2.6.2
