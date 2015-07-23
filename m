From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas2552: Fix off-by-one for
	max_register setting" to the asoc tree
Date: Thu, 23 Jul 2015 16:47:28 +0100
Message-ID: <E1ZIIiW-0008Bu-EE@debutante>
References: <1437663364.20606.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A9FC2610B1
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:47:37 +0200 (CEST)
In-Reply-To: <1437663364.20606.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Dan Murphy <dmurphy@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas2552: Fix off-by-one for max_register setting

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

>From 95f1044f5674b53f67e0933abff228c594792f4c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 23 Jul 2015 22:56:04 +0800
Subject: [PATCH] ASoC: tas2552: Fix off-by-one for max_register setting

The latest valid register is TAS2552_VBAT_DATA.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Dan Murphy<dmurphy@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2552.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index 5746f8fd0afd..e34752b8a299 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -42,7 +42,7 @@
 #define TAS2552_BOOST_APT_CTRL		0x14
 #define TAS2552_VER_NUM			0x16
 #define TAS2552_VBAT_DATA		0x19
-#define TAS2552_MAX_REG			0x20
+#define TAS2552_MAX_REG			TAS2552_VBAT_DATA
 
 /* CFG1 Register Masks */
 #define TAS2552_DEV_RESET		(1 << 0)
-- 
2.1.4
