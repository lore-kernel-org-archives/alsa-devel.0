From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] soc-cache: add i2c read entry for
	8_8 mode
Date: Thu, 18 Mar 2010 16:17:00 +0800
Message-ID: <1268900221-6833-4-git-send-email-21cnbao@gmail.com>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1268900221-6833-3-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 sound/soc/soc-cache.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index bf593a8..91db7af 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -226,6 +226,40 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 }
 
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
+static unsigned int snd_soc_8_8_read_i2c(struct snd_soc_codec *codec,
+					  unsigned int r)
+{
+	struct i2c_msg xfer[2];
+	u8 reg = r;
+	u8 data;
+	int ret;
+	struct i2c_client *client = codec->control_data;
+
+	/* Write register */
+	xfer[0].addr = client->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = 1;
+	xfer[0].buf = &reg;
+
+	/* Read data */
+	xfer[1].addr = client->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = 1;
+	xfer[1].buf = &data;
+
+	ret = i2c_transfer(client->adapter, xfer, 2);
+	if (ret != 2) {
+		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
+		return 0;
+	}
+
+	return data;
+}
+#else
+#define snd_soc_8_8_read_i2c NULL
+#endif
+
+#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 static unsigned int snd_soc_8_16_read_i2c(struct snd_soc_codec *codec,
 					  unsigned int r)
 {
@@ -466,6 +500,7 @@ static struct {
 	{
 		.addr_bits = 8, .data_bits = 8,
 		.write = snd_soc_8_8_write, .read = snd_soc_8_8_read,
+		.i2c_read = snd_soc_8_8_read_i2c,
 	},
 	{
 		.addr_bits = 8, .data_bits = 16,
-- 
1.5.6.3
