From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH v2 5/5] ASoC: ad193x: remove cache support
Date: Fri, 12 Aug 2011 18:04:14 -0400
Message-ID: <1313186654-22520-5-git-send-email-scott.jiang.linux@gmail.com>
References: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id C26EE1039B9
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 10:57:58 +0200 (CEST)
In-Reply-To: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

asoc cache layer can't support this kind of spi registers well.
remove cache support and read/write registers directly

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/codecs/ad193x.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index f1a8be5..eedb6f5 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -27,11 +27,6 @@ struct ad193x_priv {
 	int sysclk;
 };
 
-/* ad193x register cache & default register settings */
-static const u8 ad193x_reg[AD193X_NUM_REGS] = {
-	0, 0, 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0, 0, 0,
-};
-
 /*
  * AD193X volume/mute/de-emphasis etc. controls
  */
@@ -390,9 +385,6 @@ static int ad193x_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_dev_ad193x = {
 	.probe = 	ad193x_probe,
-	.reg_cache_default = ad193x_reg,
-	.reg_cache_size = AD193X_NUM_REGS,
-	.reg_word_size = sizeof(u16),
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.7.0.4
