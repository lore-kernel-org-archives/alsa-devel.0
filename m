From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH] ASoC: Fix to avoid compile error
Date: Mon,  4 Apr 2011 13:15:04 +0900
Message-ID: <1301890504-14423-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id B3DBE2434C
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 06:48:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch fixes to avoid compile error when ASoC codec doesn't use I2C
nor SPI on snd_soc_hw_bulk_write_raw().

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/soc-cache.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 22b0990..6ba1714 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -402,7 +402,7 @@ static int snd_soc_16_16_spi_write(void *control_data, const char *data,
 static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int reg,
 				     const void *data, size_t len)
 {
-	int ret;
+	int ret = 0;
 
 	/* Ensure that the base register is volatile.  Subsequently
 	 * any other register that is touched by this routine should be
@@ -415,10 +415,14 @@ static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int r
 
 	switch (codec->control_type) {
 	case SND_SOC_I2C:
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 		ret = i2c_master_send(codec->control_data, data, len);
+#endif
 		break;
 	case SND_SOC_SPI:
+#if defined(CONFIG_SPI_MASTER)
 		ret = do_spi_write(codec->control_data, data, len);
+#endif
 		break;
 	default:
 		BUG();
-- 
1.7.1
