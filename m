From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ics43432: Fix build errors" to the asoc
	tree
Date: Fri, 28 Aug 2015 17:25:08 +0100
Message-ID: <E1ZVMSi-0004Rt-Iu@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D1A92658DC
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 18:25:31 +0200 (CEST)
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
To: Ricard Wanderlof <ricardw@axis.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ics43432: Fix build errors

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

>From b37bfdaac914f4886b8be803703b12177eb873f6 Mon Sep 17 00:00:00 2001
From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Date: Fri, 28 Aug 2015 12:11:48 +0200
Subject: [PATCH] ASoC: ics43432: Fix build errors

Fix build errors

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ics43432.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ics43432.c b/sound/soc/codecs/ics43432.c
index 7c35c98..dd850b9 100644
--- a/sound/soc/codecs/ics43432.c
+++ b/sound/soc/codecs/ics43432.c
@@ -57,7 +57,7 @@ static const struct of_device_id ics43432_ids[] = {
 	{ .compatible = "invensense,ics43432", },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, ics43432_dt_ids);
+MODULE_DEVICE_TABLE(of, ics43432_ids);
 #endif
 
 static struct platform_driver ics43432_driver = {
-- 
2.5.0
