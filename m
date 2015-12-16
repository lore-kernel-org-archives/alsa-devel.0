From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: In arizona_calc_fratio make
	new codecs the default case" to the asoc tree
Date: Wed, 16 Dec 2015 19:24:24 +0000
Message-ID: <E1a9HgW-0006Qz-E3@debutante>
References: <1450285584-14472-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5D082657BA
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 20:24:32 +0100 (CET)
In-Reply-To: <1450285584-14472-1-git-send-email-rf@opensource.wolfsonmicro.com>
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

   ASoC: arizona: In arizona_calc_fratio make new codecs the default case

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

>From 3451eb485aee78f31a8dd127e3385f89946c813b Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 16 Dec 2015 17:06:24 +0000
Subject: [PATCH] ASoC: arizona: In arizona_calc_fratio make new codecs the
 default case

This patch rearranges the switch statement in arizona_calc_fratio so
that older codecs are the special cases, with the default case
applying to newer codecs (WM8998 and later). This is preferable
because it avoids having to patch new cases in every time a new
codec is added.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index d90b3c51019a..38a73e3da508 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2020,18 +2020,18 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 	}
 
 	switch (fll->arizona->type) {
+	case WM5102:
+	case WM8997:
+		return init_ratio;
 	case WM5110:
 	case WM8280:
 		if (fll->arizona->rev < 3 || sync)
 			return init_ratio;
 		break;
-	case WM8998:
-	case WM1814:
+	default:
 		if (sync)
 			return init_ratio;
 		break;
-	default:
-		return init_ratio;
 	}
 
 	cfg->fratio = init_ratio - 1;
-- 
2.6.2
