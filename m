From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCHv2] ASoC: Fix to avoid compile error
Date: Mon,  4 Apr 2011 13:43:42 +0900
Message-ID: <1301892222-9152-1-git-send-email-sw.youn@samsung.com>
References: <20110404045556.GA12690@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FF7224392
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 07:13:50 +0200 (CEST)
In-Reply-To: <20110404045556.GA12690@opensource.wolfsonmicro.com>
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
 sound/soc/soc-cache.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 22b0990..8418b1f 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -414,12 +414,16 @@ static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int r
 		return -EINVAL;
 
 	switch (codec->control_type) {
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 	case SND_SOC_I2C:
 		ret = i2c_master_send(codec->control_data, data, len);
 		break;
+#endif
+#if defined(CONFIG_SPI_MASTER)
 	case SND_SOC_SPI:
 		ret = do_spi_write(codec->control_data, data, len);
 		break;
+#endif
 	default:
 		BUG();
 	}
-- 
1.7.1
