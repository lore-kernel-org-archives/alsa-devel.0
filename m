From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH] ASoC: xlnx: parse AES audio parameters
Date: Thu, 10 Jan 2019 18:44:43 +0530
Message-ID: <1547126083-44466-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700044.outbound.protection.outlook.com [40.107.70.44])
 by alsa0.perex.cz (Postfix) with ESMTP id E7BCD26712B
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 14:14:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

AES channel status carries various audio parameters. If channel status is
detected, current patch extracts sample rate and bit depth parameters of
the incoming stream during capture.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 143 ++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index d2194da..97177d3 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -13,6 +13,7 @@
 #include <linux/of_irq.h>
 #include <linux/sizes.h>
 
+#include <sound/asoundef.h>
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
@@ -63,6 +64,7 @@
 #define PERIODS_MAX		6
 #define PERIOD_BYTES_MIN	192
 #define PERIOD_BYTES_MAX	(50 * 1024)
+#define XLNX_PARAM_UNKNOWN	0
 
 enum bit_depth {
 	BIT_DEPTH_8,
@@ -117,6 +119,129 @@ static const struct snd_pcm_hardware xlnx_pcm_hardware = {
 	.periods_max = PERIODS_MAX,
 };
 
+enum {
+	AES_TO_AES,
+	AES_TO_PCM,
+	PCM_TO_PCM,
+	PCM_TO_AES
+};
+
+static void xlnx_parse_aes_params(u32 chsts_reg1_val, u32 chsts_reg2_val,
+				  struct device *dev)
+{
+	u32 padded, srate, bit_depth, status[2];
+
+	if (chsts_reg1_val & IEC958_AES0_PROFESSIONAL) {
+		status[0] = chsts_reg1_val & 0xff;
+		status[1] = (chsts_reg1_val >> 16) & 0xff;
+
+		switch (status[0] & IEC958_AES0_PRO_FS) {
+		case IEC958_AES0_PRO_FS_44100:
+			srate = 44100;
+			break;
+		case IEC958_AES0_PRO_FS_48000:
+			srate = 48000;
+			break;
+		case IEC958_AES0_PRO_FS_32000:
+			srate = 32000;
+			break;
+		case IEC958_AES0_PRO_FS_NOTID:
+		default:
+			srate = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+
+		switch (status[1] & IEC958_AES2_PRO_SBITS) {
+		case IEC958_AES2_PRO_WORDLEN_NOTID:
+		case IEC958_AES2_PRO_SBITS_20:
+			padded = 0;
+			break;
+		case IEC958_AES2_PRO_SBITS_24:
+			padded = 4;
+			break;
+		default:
+			bit_depth = XLNX_PARAM_UNKNOWN;
+			goto log_params;
+		}
+
+		switch (status[1] & IEC958_AES2_PRO_WORDLEN) {
+		case IEC958_AES2_PRO_WORDLEN_20_16:
+			bit_depth = 16 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_22_18:
+			bit_depth = 18 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_23_19:
+			bit_depth = 19 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_24_20:
+			bit_depth = 20 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_NOTID:
+		default:
+			bit_depth = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+
+	} else {
+		status[0] = (chsts_reg1_val >> 24) & 0xff;
+		status[1] = chsts_reg2_val & 0xff;
+
+		switch (status[0] & IEC958_AES3_CON_FS) {
+		case IEC958_AES3_CON_FS_44100:
+			srate = 44100;
+			break;
+		case IEC958_AES3_CON_FS_48000:
+			srate = 48000;
+			break;
+		case IEC958_AES3_CON_FS_32000:
+			srate = 32000;
+			break;
+		default:
+			srate = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+
+		if (status[1] & IEC958_AES4_CON_MAX_WORDLEN_24)
+			padded = 4;
+		else
+			padded = 0;
+
+		switch (status[1] & IEC958_AES4_CON_WORDLEN) {
+		case IEC958_AES4_CON_WORDLEN_20_16:
+			bit_depth = 16 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_22_18:
+			bit_depth = 18 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_23_19:
+			bit_depth = 19 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_24_20:
+			bit_depth = 20 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_21_17:
+			bit_depth = 17 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_NOTID:
+		default:
+			bit_depth = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+	}
+
+log_params:
+	if (srate != XLNX_PARAM_UNKNOWN)
+		dev_info(dev, "sample rate = %d\n", srate);
+	else
+		dev_info(dev, "sample rate = unknown\n");
+
+	if (bit_depth != XLNX_PARAM_UNKNOWN)
+		dev_info(dev, "bit_depth = %d\n", bit_depth);
+	else
+		dev_info(dev, "bit_depth = unknown\n");
+}
+
 static int xlnx_formatter_pcm_reset(void __iomem *mmio_base)
 {
 	u32 val, retries = 0;
@@ -302,8 +427,12 @@ static int xlnx_formatter_pcm_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
 	u32 low, high, active_ch, val, bytes_per_ch, bits_per_sample;
+	u32 aes_reg1_val, aes_reg2_val;
 	int status;
 	u64 size;
+	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
 
@@ -311,6 +440,20 @@ static int xlnx_formatter_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (active_ch > stream_data->ch_limit)
 		return -EINVAL;
 
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	    stream_data->xfer_mode == AES_TO_PCM) {
+		val = readl(stream_data->mmio + XLNX_AUD_STS);
+		if (val & AUD_STS_CH_STS_MASK) {
+			aes_reg1_val = readl(stream_data->mmio +
+					     XLNX_AUD_CH_STS_START);
+			aes_reg2_val = readl(stream_data->mmio +
+					     XLNX_AUD_CH_STS_START + 0x4);
+
+			xlnx_parse_aes_params(aes_reg1_val, aes_reg2_val,
+					      component->dev);
+		}
+	}
+
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
-- 
2.7.4
