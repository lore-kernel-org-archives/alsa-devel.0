From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uda1380: Remove unused DAI ID defines"
	to the asoc tree
Date: Wed, 23 Nov 2016 12:38:17 +0000
Message-ID: <E1c9Wob-0007Ck-8Q@debutante>
References: <1479893411-32011-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CF8B2666AC
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 13:38:31 +0100 (CET)
In-Reply-To: <1479893411-32011-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uda1380: Remove unused DAI ID defines

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

>From 4185d4be22a3fbf8e065437883ced195e692642b Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 23 Nov 2016 10:30:10 +0100
Subject: [PATCH] ASoC: uda1380: Remove unused DAI ID defines

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used for matching instead and the
defines are unused. The last user of these defines was removed in commit
f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support"). So
remove the defines as well.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/uda1380.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/uda1380.h b/sound/soc/codecs/uda1380.h
index 942e3927c72b..69a326ac3c1a 100644
--- a/sound/soc/codecs/uda1380.h
+++ b/sound/soc/codecs/uda1380.h
@@ -72,8 +72,4 @@
 #define R22_SKIP_DCFIL	0x0002
 #define R23_AGC_EN	0x0001
 
-#define UDA1380_DAI_DUPLEX	0 /* playback and capture on single DAI */
-#define UDA1380_DAI_PLAYBACK	1 /* playback DAI */
-#define UDA1380_DAI_CAPTURE	2 /* capture DAI */
-
 #endif /* _UDA1380_H */
-- 
2.10.2
