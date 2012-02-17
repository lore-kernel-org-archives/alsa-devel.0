From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: ak4104: Convert to
	module_spi_driver()
Date: Fri, 17 Feb 2012 12:23:09 -0800
Message-ID: <1329510192-4442-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120217202240.GA2784@opensource.wolfsonmicro.com>
	<1329510192-4442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 99839103FE1
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 21:23:19 +0100 (CET)
In-Reply-To: <1329510192-4442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4104.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 6f93892..f12c115 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -289,17 +289,7 @@ static struct spi_driver ak4104_spi_driver = {
 	.remove = __devexit_p(ak4104_spi_remove),
 };
 
-static int __init ak4104_init(void)
-{
-	return spi_register_driver(&ak4104_spi_driver);
-}
-module_init(ak4104_init);
-
-static void __exit ak4104_exit(void)
-{
-	spi_unregister_driver(&ak4104_spi_driver);
-}
-module_exit(ak4104_exit);
+module_spi_driver(ak4104_spi_driver);
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
 MODULE_DESCRIPTION("Asahi Kasei AK4104 ALSA SoC driver");
-- 
1.7.9
