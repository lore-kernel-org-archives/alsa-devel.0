From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm0010: Remove redundant spi driver bus
	initialization" to the asoc tree
Date: Fri, 03 Jul 2015 15:10:47 +0100
Message-ID: <E1ZB1fz-00025e-Oc@finisterre>
References: <1435071132-24409-1-git-send-email-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D00D265065
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 16:11:02 +0200 (CEST)
In-Reply-To: <1435071132-24409-1-git-send-email-borneo.antonio@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Borneo <borneo.antonio@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm0010: Remove redundant spi driver bus initialization

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

>From 7a28db9906a993ec43226fb6927f35b8af6cc83c Mon Sep 17 00:00:00 2001
From: Antonio Borneo <borneo.antonio@gmail.com>
Date: Tue, 23 Jun 2015 22:52:12 +0800
Subject: [PATCH] ASoC: wm0010: Remove redundant spi driver bus initialization

In ancient times it was necessary to manually initialize the bus
field of an spi_driver to spi_bus_type. These days this is done in
spi_register_driver(), so we can drop the manual assignment.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm0010.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index f37989e..61bfff4 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -1005,7 +1005,6 @@ static int wm0010_spi_remove(struct spi_device *spi)
 static struct spi_driver wm0010_spi_driver = {
 	.driver = {
 		.name	= "wm0010",
-		.bus 	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm0010_spi_probe,
-- 
2.1.4
