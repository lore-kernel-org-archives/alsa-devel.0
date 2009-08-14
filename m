From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] delete -spi suffix in name and free private
	data while registers fail
Date: Fri, 14 Aug 2009 12:06:38 +0800
Message-ID: <1250222798-19507-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E63F24633
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Aug 2009 06:04:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/codecs/ad1938.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad1938.c b/sound/soc/codecs/ad1938.c
index 051f68c..e62b277 100644
--- a/sound/soc/codecs/ad1938.c
+++ b/sound/soc/codecs/ad1938.c
@@ -456,7 +456,7 @@ static int __devexit ad1938_spi_remove(struct spi_device *spi)
 
 static struct spi_driver ad1938_spi_driver = {
 	.driver = {
-		.name	= "ad1938-spi",
+		.name	= "ad1938",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
@@ -543,6 +543,7 @@ static int ad1938_register(struct ad1938_priv *ad1938)
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		kfree(ad1938);
 		return ret;
 	}
 
@@ -550,6 +551,7 @@ static int ad1938_register(struct ad1938_priv *ad1938)
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
 		snd_soc_unregister_codec(codec);
+		kfree(ad1938);
 		return ret;
 	}
 
-- 
1.5.6.3
