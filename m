From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH] ASoC: rt5677: Allow arbitrary block read/write
	via SPI
Date: Fri, 21 Aug 2015 21:17:00 -0700
Message-ID: <1440217020-24365-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CD39260536
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2015 06:17:37 +0200 (CEST)
Received: by padfo6 with SMTP id fo6so20055038pad.1
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 21:17:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Added rt5677_spi_read() and refactored rt5677_spi_write() so that
an arbitrary block in the DSP address space can be read/written
via SPI. For example, this allows us to load an ELF DSP firmware
with sparse sections, and stream audio samples from DSP ring buffer.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/rt5677-spi.c | 233 +++++++++++++++++++++++++++++++-----------
 sound/soc/codecs/rt5677-spi.h |   8 +-
 sound/soc/codecs/rt5677.c     |   4 +-
 3 files changed, 178 insertions(+), 67 deletions(-)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index ef6348c..3505aaf 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -31,84 +31,197 @@
 
 #include "rt5677-spi.h"
 
+#define RT5677_SPI_BURST_LEN	240
+#define RT5677_SPI_HEADER	5
+#define RT5677_SPI_FREQ		6000000
+
+/* The AddressPhase and DataPhase of SPI commands are MSB first on the wire.
+ * DataPhase word size of 16-bit commands is 2 bytes.
+ * DataPhase word size of 32-bit commands is 4 bytes.
+ * DataPhase word size of burst commands is 8 bytes.
+ * The DSP CPU is little-endian.
+ */
+#define RT5677_SPI_WRITE_BURST	0x5
+#define RT5677_SPI_READ_BURST	0x4
+#define RT5677_SPI_WRITE_32	0x3
+#define RT5677_SPI_READ_32	0x2
+#define RT5677_SPI_WRITE_16	0x1
+#define RT5677_SPI_READ_16	0x0
+
 static struct spi_device *g_spi;
+static DEFINE_MUTEX(spi_mutex);
 
-/**
- * rt5677_spi_write - Write data to SPI.
- * @txbuf: Data Buffer for writing.
- * @len: Data length.
+/* Select a suitable transfer command for the next transfer to ensure
+ * the transfer address is always naturally aligned while minimizing
+ * the total number of transfers required.
+ *
+ * 3 transfer commands are available:
+ * RT5677_SPI_READ/WRITE_16:	Transfer 2 bytes
+ * RT5677_SPI_READ/WRITE_32:	Transfer 4 bytes
+ * RT5677_SPI_READ/WRITE_BURST:	Transfer any multiples of 8 bytes
+ *
+ * For example, reading 260 bytes at 0x60030002 uses the following commands:
+ * 0x60030002 RT5677_SPI_READ_16	2 bytes
+ * 0x60030004 RT5677_SPI_READ_32	4 bytes
+ * 0x60030008 RT5677_SPI_READ_BURST	240 bytes
+ * 0x600300F8 RT5677_SPI_READ_BURST	8 bytes
+ * 0x60030100 RT5677_SPI_READ_32	4 bytes
+ * 0x60030104 RT5677_SPI_READ_16	2 bytes
  *
+ * Input:
+ * @read: true for read commands; false for write commands
+ * @align: alignment of the next transfer address
+ * @remain: number of bytes remaining to transfer
  *
- * Returns true for success.
+ * Output:
+ * @len: number of bytes to transfer with the selected command
+ * Returns the selected command
  */
-int rt5677_spi_write(u8 *txbuf, size_t len)
+static u8 rt5677_spi_select_cmd(bool read, u32 align, u32 remain, u32 *len)
 {
-	int status;
-
-	status = spi_write(g_spi, txbuf, len);
-
-	if (status)
-		dev_err(&g_spi->dev, "rt5677_spi_write error %d\n", status);
-
-	return status;
+	u8 cmd;
+
+	if (align == 2 || align == 6 || remain == 2) {
+		cmd = RT5677_SPI_READ_16;
+		*len = 2;
+	} else if (align == 4 || remain <= 6) {
+		cmd = RT5677_SPI_READ_32;
+		*len = 4;
+	} else {
+		cmd = RT5677_SPI_READ_BURST;
+		*len = min_t(u32, remain & ~7, RT5677_SPI_BURST_LEN);
+	}
+	return read ? cmd : cmd + 1;
 }
-EXPORT_SYMBOL_GPL(rt5677_spi_write);
 
-/**
- * rt5677_spi_burst_write - Write data to SPI by rt5677 dsp memory address.
- * @addr: Start address.
- * @txbuf: Data Buffer for writng.
- * @len: Data length, it must be a multiple of 8.
- *
- *
- * Returns true for success.
+/* Copy dstlen bytes from src to dst, while reversing byte order for each word.
+ * If srclen < dstlen, zeros are padded.
  */
-int rt5677_spi_burst_write(u32 addr, const struct firmware *fw)
+static void rt5677_spi_reverse(u8 *dst, u32 dstlen, const u8 *src, u32 srclen)
 {
-	u8 spi_cmd = RT5677_SPI_CMD_BURST_WRITE;
-	u8 *write_buf;
-	unsigned int i, end, offset = 0;
-
-	write_buf = kmalloc(RT5677_SPI_BUF_LEN + 6, GFP_KERNEL);
-
-	if (write_buf == NULL)
-		return -ENOMEM;
-
-	while (offset < fw->size) {
-		if (offset + RT5677_SPI_BUF_LEN <= fw->size)
-			end = RT5677_SPI_BUF_LEN;
-		else
-			end = fw->size % RT5677_SPI_BUF_LEN;
-
-		write_buf[0] = spi_cmd;
-		write_buf[1] = ((addr + offset) & 0xff000000) >> 24;
-		write_buf[2] = ((addr + offset) & 0x00ff0000) >> 16;
-		write_buf[3] = ((addr + offset) & 0x0000ff00) >> 8;
-		write_buf[4] = ((addr + offset) & 0x000000ff) >> 0;
-
-		for (i = 0; i < end; i += 8) {
-			write_buf[i + 12] = fw->data[offset + i + 0];
-			write_buf[i + 11] = fw->data[offset + i + 1];
-			write_buf[i + 10] = fw->data[offset + i + 2];
-			write_buf[i +  9] = fw->data[offset + i + 3];
-			write_buf[i +  8] = fw->data[offset + i + 4];
-			write_buf[i +  7] = fw->data[offset + i + 5];
-			write_buf[i +  6] = fw->data[offset + i + 6];
-			write_buf[i +  5] = fw->data[offset + i + 7];
+	u32 w, i, si;
+	u32 word_size = min_t(u32, dstlen, 8);
+
+	for (w = 0; w < dstlen; w += word_size) {
+		for (i = 0; i < word_size; i++) {
+			si = w + word_size - i - 1;
+			dst[w + i] = si < srclen ? src[si] : 0;
 		}
+	}
+}
 
-		write_buf[end + 5] = spi_cmd;
+/* Read DSP address space using SPI. addr and len have to be 2-byte aligned. */
+int rt5677_spi_read(u32 addr, void *rxbuf, size_t len)
+{
+	u32 offset;
+	int status = 0;
+	struct spi_transfer t[2];
+	struct spi_message m;
+	/* +4 bytes is for the DummyPhase following the AddressPhase */
+	u8 header[RT5677_SPI_HEADER + 4];
+	u8 body[RT5677_SPI_BURST_LEN];
+	u8 spi_cmd;
+	u8 *cb = rxbuf;
+
+	if (!g_spi)
+		return -ENODEV;
+
+	if ((addr & 1) || (len & 1)) {
+		dev_err(&g_spi->dev, "Bad read align 0x%x(%zu)\n", addr, len);
+		return -EACCES;
+	}
 
-		rt5677_spi_write(write_buf, end + 6);
+	memset(t, 0, sizeof(t));
+	t[0].tx_buf = header;
+	t[0].len = sizeof(header);
+	t[0].speed_hz = RT5677_SPI_FREQ;
+	t[1].rx_buf = body;
+	t[1].speed_hz = RT5677_SPI_FREQ;
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
+
+	for (offset = 0; offset < len; offset += t[1].len) {
+		spi_cmd = rt5677_spi_select_cmd(true, (addr + offset) & 7,
+				len - offset, &t[1].len);
+
+		/* Construct SPI message header */
+		header[0] = spi_cmd;
+		header[1] = ((addr + offset) & 0xff000000) >> 24;
+		header[2] = ((addr + offset) & 0x00ff0000) >> 16;
+		header[3] = ((addr + offset) & 0x0000ff00) >> 8;
+		header[4] = ((addr + offset) & 0x000000ff) >> 0;
+
+		mutex_lock(&spi_mutex);
+		status |= spi_sync(g_spi, &m);
+		mutex_unlock(&spi_mutex);
+
+		/* Copy data back to caller buffer */
+		rt5677_spi_reverse(cb + offset, t[1].len, body, t[1].len);
+	}
+	return status;
+}
+EXPORT_SYMBOL_GPL(rt5677_spi_read);
 
-		offset += RT5677_SPI_BUF_LEN;
+/* Write DSP address space using SPI. addr has to be 2-byte aligned.
+ * If len is not 2-byte aligned, an extra byte of zero is written at the end
+ * as padding.
+ */
+int rt5677_spi_write(u32 addr, const void *txbuf, size_t len)
+{
+	u32 offset, len_with_pad = len;
+	int status = 0;
+	struct spi_transfer t;
+	struct spi_message m;
+	/* +1 byte is for the DummyPhase following the DataPhase */
+	u8 buf[RT5677_SPI_HEADER + RT5677_SPI_BURST_LEN + 1];
+	u8 *body = buf + RT5677_SPI_HEADER;
+	u8 spi_cmd;
+	const u8 *cb = txbuf;
+
+	if (!g_spi)
+		return -ENODEV;
+
+	if (addr & 1) {
+		dev_err(&g_spi->dev, "Bad write align 0x%x(%zu)\n", addr, len);
+		return -EACCES;
 	}
 
-	kfree(write_buf);
+	if (len & 1)
+		len_with_pad = len + 1;
+
+	memset(&t, 0, sizeof(t));
+	t.tx_buf = buf;
+	t.speed_hz = RT5677_SPI_FREQ;
+	spi_message_init_with_transfers(&m, &t, 1);
+
+	for (offset = 0; offset < len_with_pad;) {
+		spi_cmd = rt5677_spi_select_cmd(false, (addr + offset) & 7,
+				len_with_pad - offset, &t.len);
+
+		/* Construct SPI message header */
+		buf[0] = spi_cmd;
+		buf[1] = ((addr + offset) & 0xff000000) >> 24;
+		buf[2] = ((addr + offset) & 0x00ff0000) >> 16;
+		buf[3] = ((addr + offset) & 0x0000ff00) >> 8;
+		buf[4] = ((addr + offset) & 0x000000ff) >> 0;
+
+		/* Fetch data from caller buffer */
+		rt5677_spi_reverse(body, t.len, cb + offset, len - offset);
+		offset += t.len;
+		t.len += RT5677_SPI_HEADER + 1;
+
+		mutex_lock(&spi_mutex);
+		status |= spi_sync(g_spi, &m);
+		mutex_unlock(&spi_mutex);
+	}
+	return status;
+}
+EXPORT_SYMBOL_GPL(rt5677_spi_write);
 
-	return 0;
+int rt5677_spi_write_firmware(u32 addr, const struct firmware *fw)
+{
+	return rt5677_spi_write(addr, fw->data, fw->size);
 }
-EXPORT_SYMBOL_GPL(rt5677_spi_burst_write);
+EXPORT_SYMBOL_GPL(rt5677_spi_write_firmware);
 
 static int rt5677_spi_probe(struct spi_device *spi)
 {
diff --git a/sound/soc/codecs/rt5677-spi.h b/sound/soc/codecs/rt5677-spi.h
index ec41b2b..662db16 100644
--- a/sound/soc/codecs/rt5677-spi.h
+++ b/sound/soc/codecs/rt5677-spi.h
@@ -12,10 +12,8 @@
 #ifndef __RT5677_SPI_H__
 #define __RT5677_SPI_H__
 
-#define RT5677_SPI_BUF_LEN 240
-#define RT5677_SPI_CMD_BURST_WRITE 0x05
-
-int rt5677_spi_write(u8 *txbuf, size_t len);
-int rt5677_spi_burst_write(u32 addr, const struct firmware *fw);
+int rt5677_spi_read(u32 addr, void *rxbuf, size_t len);
+int rt5677_spi_write(u32 addr, const void *txbuf, size_t len);
+int rt5677_spi_write_firmware(u32 addr, const struct firmware *fw);
 
 #endif /* __RT5677_SPI_H__ */
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 3f890a6..d916d0c 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -745,14 +745,14 @@ static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
 		ret = request_firmware(&rt5677->fw1, RT5677_FIRMWARE1,
 			codec->dev);
 		if (ret == 0) {
-			rt5677_spi_burst_write(0x50000000, rt5677->fw1);
+			rt5677_spi_write_firmware(0x50000000, rt5677->fw1);
 			release_firmware(rt5677->fw1);
 		}
 
 		ret = request_firmware(&rt5677->fw2, RT5677_FIRMWARE2,
 			codec->dev);
 		if (ret == 0) {
-			rt5677_spi_burst_write(0x60000000, rt5677->fw2);
+			rt5677_spi_write_firmware(0x60000000, rt5677->fw2);
 			release_firmware(rt5677->fw2);
 		}
 
-- 
2.5.0.457.gab17608
