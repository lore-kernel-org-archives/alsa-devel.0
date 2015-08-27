From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bcm2835-i2s: Fix module autoload for OF
	platform drivers" to the asoc tree
Date: Thu, 27 Aug 2015 20:24:00 +0100
Message-ID: <E1ZV2mG-0004KG-Is@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E020A260592
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 21:24:07 +0200 (CEST)
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
To: Luis de Bethencourt <luis@debethencourt.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bcm2835-i2s: Fix module autoload for OF platform drivers

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

>From 054bc835d27b558393541c32a209c01d89cda75a Mon Sep 17 00:00:00 2001
From: Luis de Bethencourt <luis@debethencourt.com>
Date: Thu, 27 Aug 2015 17:04:01 +0200
Subject: [PATCH] ASoC: bcm2835-i2s: Fix module autoload for OF platform
 drivers

These platform drivers have a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 03fa1cbf8ec1..8c435beb263d 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -862,6 +862,8 @@ static const struct of_device_id bcm2835_i2s_of_match[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(of, bcm2835_i2s_of_match);
+
 static struct platform_driver bcm2835_i2s_driver = {
 	.probe		= bcm2835_i2s_probe,
 	.driver		= {
-- 
2.5.0
