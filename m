From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stac9766: Remove unused DAI ID defines"
	to the asoc tree
Date: Fri, 04 Nov 2016 12:16:24 -0600
Message-ID: <E1c2j2O-000871-D0@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 46E582674D5
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 19:16:36 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stac9766: Remove unused DAI ID defines

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

>From 355602eb5af91ff8ddda435f0f9e910f3b18c438 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 4 Nov 2016 18:26:53 +0100
Subject: [PATCH] ASoC: stac9766: Remove unused DAI ID defines

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used instead and the defines are
unused.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/stac9766.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/stac9766.h b/sound/soc/codecs/stac9766.h
index c726f907e2c0..cb0d5505d571 100644
--- a/sound/soc/codecs/stac9766.h
+++ b/sound/soc/codecs/stac9766.h
@@ -10,8 +10,4 @@
 #define AC97_STAC_ANALOG_SPECIAL (AC97_STAC_PAGE0 | 0x6E)
 #define AC97_STAC_STEREO_MIC 0x78
 
-/* STAC9766 DAI ID's */
-#define STAC9766_DAI_AC97_ANALOG		0
-#define STAC9766_DAI_AC97_DIGITAL		1
-
 #endif
-- 
2.10.1
