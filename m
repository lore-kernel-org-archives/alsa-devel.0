From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l32: Fix define for
	CS35L32_SDOUT_3ST" to the asoc tree
Date: Thu, 23 Jul 2015 16:04:30 +0100
Message-ID: <E1ZII2w-0006k4-12@debutante>
References: <1437611330.6620.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D111426070C
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:04:38 +0200 (CEST)
In-Reply-To: <1437611330.6620.4.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l32: Fix define for CS35L32_SDOUT_3ST

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

>From 4c38b9c30f78d44c576ca3049577fbd4d5c2acc6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 23 Jul 2015 08:28:50 +0800
Subject: [PATCH] ASoC: cs35l32: Fix define for CS35L32_SDOUT_3ST

According to the datasheet, the CS35L32_SDOUT_3ST is BIT(3).

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l32.h b/sound/soc/codecs/cs35l32.h
index 31ab804a22bc..1d6c2508cd41 100644
--- a/sound/soc/codecs/cs35l32.h
+++ b/sound/soc/codecs/cs35l32.h
@@ -80,7 +80,7 @@ struct cs35l32_platform_data {
 #define CS35L32_GAIN_MGR_MASK		0x08
 #define CS35L32_ADSP_SHARE_MASK		0x08
 #define CS35L32_ADSP_DATACFG_MASK	0x30
-#define CS35L32_SDOUT_3ST		0x80
+#define CS35L32_SDOUT_3ST		0x08
 #define CS35L32_BATT_REC_MASK		0x0E
 #define CS35L32_BATT_THRESH_MASK	0x30
 
-- 
2.1.4
