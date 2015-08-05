From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8741: Simplify wm8741_set_dai_sysclk
	implementation" to the asoc tree
Date: Wed, 05 Aug 2015 13:30:43 +0100
Message-ID: <E1ZMxqF-0005lD-4u@finisterre>
References: <1438223043.17273.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 37ACF265DA7
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:00 +0200 (CEST)
In-Reply-To: <1438223043.17273.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8741: Simplify wm8741_set_dai_sysclk implementation

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

>From 6f55a041378f8688ab4afd2702416cd5318fa73d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 30 Jul 2015 10:24:03 +0800
Subject: [PATCH] ASoC: wm8741: Simplify wm8741_set_dai_sysclk implementation

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8741.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index b346237..506792b 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -278,51 +278,38 @@ static int wm8741_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	switch (freq) {
 	case 0:
 		wm8741->sysclk_constraints = NULL;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 11289600:
 		wm8741->sysclk_constraints = &constraints_11289;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 12288000:
 		wm8741->sysclk_constraints = &constraints_12288;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 16384000:
 		wm8741->sysclk_constraints = &constraints_16384;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 16934400:
 		wm8741->sysclk_constraints = &constraints_16934;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 18432000:
 		wm8741->sysclk_constraints = &constraints_18432;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 22579200:
 	case 33868800:
 		wm8741->sysclk_constraints = &constraints_22579;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 24576000:
 		wm8741->sysclk_constraints = &constraints_24576;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 36864000:
 		wm8741->sysclk_constraints = &constraints_36864;
-		wm8741->sysclk = freq;
-		return 0;
+		break;
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
+
+	wm8741->sysclk = freq;
+	return 0;
 }
 
 static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
-- 
2.1.4
