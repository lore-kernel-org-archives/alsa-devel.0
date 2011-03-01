From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove module probe announcements from
	CODEC drivers
Date: Tue,  1 Mar 2011 20:14:15 +0000
Message-ID: <1299010455-31934-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08770103854
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 21:13:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4104.c |    1 -
 sound/soc/codecs/cs4270.c |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index c27f8f5..cbf0b6d 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -294,7 +294,6 @@ static struct spi_driver ak4104_spi_driver = {
 
 static int __init ak4104_init(void)
 {
-	pr_info("Asahi Kasei AK4104 ALSA SoC Codec Driver\n");
 	return spi_register_driver(&ak4104_spi_driver);
 }
 module_init(ak4104_init);
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index c0fccad..65f578f 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -743,8 +743,6 @@ static struct i2c_driver cs4270_i2c_driver = {
 
 static int __init cs4270_init(void)
 {
-	pr_info("Cirrus Logic CS4270 ALSA SoC Codec Driver\n");
-
 	return i2c_add_driver(&cs4270_i2c_driver);
 }
 module_init(cs4270_init);
-- 
1.7.2.3
