From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Use the local variable to get
	the data from SPI device
Date: Fri, 21 Jul 2017 16:00:47 +0800
Message-ID: <1500624047-21492-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 287CB266C39
 for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2017 10:00:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch uses the local variable to get the data from SPI device to
prevent to get all zero data.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 950d1ff..e693204 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -289,7 +289,7 @@ int rt5514_spi_burst_read(unsigned int addr, u8 *rxbuf, size_t len)
 {
 	u8 spi_cmd = RT5514_SPI_CMD_BURST_READ;
 	int status;
-	u8 write_buf[8];
+	u8 write_buf[8], read_buf[RT5514_SPI_BUF_LEN];
 	unsigned int i, end, offset = 0;
 
 	struct spi_message message;
@@ -319,7 +319,7 @@ int rt5514_spi_burst_read(unsigned int addr, u8 *rxbuf, size_t len)
 		spi_message_add_tail(&x[1], &message);
 
 		x[2].len = end;
-		x[2].rx_buf = rxbuf + offset;
+		x[2].rx_buf = read_buf;
 		spi_message_add_tail(&x[2], &message);
 
 		status = spi_sync(rt5514_spi, &message);
@@ -327,6 +327,8 @@ int rt5514_spi_burst_read(unsigned int addr, u8 *rxbuf, size_t len)
 		if (status)
 			return false;
 
+		memcpy(rxbuf + offset, read_buf, end);
+
 		offset += RT5514_SPI_BUF_LEN;
 	}
 
@@ -365,14 +367,9 @@ int rt5514_spi_burst_read(unsigned int addr, u8 *rxbuf, size_t len)
 int rt5514_spi_burst_write(u32 addr, const u8 *txbuf, size_t len)
 {
 	u8 spi_cmd = RT5514_SPI_CMD_BURST_WRITE;
-	u8 *write_buf;
+	u8 write_buf[RT5514_SPI_BUF_LEN + 6];
 	unsigned int i, end, offset = 0;
 
-	write_buf = kmalloc(RT5514_SPI_BUF_LEN + 6, GFP_KERNEL);
-
-	if (write_buf == NULL)
-		return -ENOMEM;
-
 	while (offset < len) {
 		if (offset + RT5514_SPI_BUF_LEN <= len)
 			end = RT5514_SPI_BUF_LEN;
@@ -403,8 +400,6 @@ int rt5514_spi_burst_write(u32 addr, const u8 *txbuf, size_t len)
 		offset += RT5514_SPI_BUF_LEN;
 	}
 
-	kfree(write_buf);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rt5514_spi_burst_write);
-- 
2.7.4
