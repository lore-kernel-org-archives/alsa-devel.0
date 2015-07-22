From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Fix up define for
	SGTL5000_SMALL_POP" to the asoc tree
Date: Wed, 22 Jul 2015 10:57:31 +0100
Message-ID: <E1ZHqmJ-00078w-Ky@debutante>
References: <1437535665.17780.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C57C32606A7
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 11:57:38 +0200 (CEST)
In-Reply-To: <1437535665.17780.1.camel@ingics.com>
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

   ASoC: sgtl5000: Fix up define for SGTL5000_SMALL_POP

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

>From b101acfabc9377469af3abfb7cb63112da367284 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 22 Jul 2015 11:27:45 +0800
Subject: [PATCH] ASoC: sgtl5000: Fix up define for SGTL5000_SMALL_POP

Currently, below code actually does not update any bit because
SGTL5000_SMALL_POP is 0.

snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL, SGTL5000_SMALL_POP, 1);

The SGTL5000_SMALL_POP should be BIT(0) rather than 0, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-By: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index bd7a344bf8c5..1c317de26176 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -275,7 +275,7 @@
 #define SGTL5000_BIAS_CTRL_MASK			0x000e
 #define SGTL5000_BIAS_CTRL_SHIFT		1
 #define SGTL5000_BIAS_CTRL_WIDTH		3
-#define SGTL5000_SMALL_POP			0
+#define SGTL5000_SMALL_POP			1
 
 /*
  * SGTL5000_CHIP_MIC_CTRL
-- 
2.1.4
