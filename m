From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Support download of WM8958 MBC
	firmware
Date: Tue, 22 Mar 2011 17:51:55 +0000
Message-ID: <1300816318-1859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 195A224414
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 18:52:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow userspace to supply an update to the ROM firmware. The firmware
request is non-blocking so userspace can load the firmware at its
leisure without delaying startup, the driver will begin using the
firmware the next time MBC is started after it has been supplied.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8958-dsp2.c |  223 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8994.c      |    4 +
 sound/soc/codecs/wm8994.h      |    4 +
 3 files changed, 231 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index c4e4baa..88fd4a9 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -30,10 +30,212 @@
 
 #include "wm8994.h"
 
+#define WM_FW_BLOCK_INFO 0xff
+#define WM_FW_BLOCK_PM   0x00
+#define WM_FW_BLOCK_X    0x01
+#define WM_FW_BLOCK_Y    0x02
+#define WM_FW_BLOCK_Z    0x03
+#define WM_FW_BLOCK_I    0x06
+#define WM_FW_BLOCK_A    0x08
+#define WM_FW_BLOCK_C    0x0c
+
+static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
+			  const struct firmware *fw, bool check)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	u64 data64;
+	u32 data32;
+	const u8 *data;
+	char *str;
+	size_t block_len, len;
+	int ret = 0;
+
+	/* Suppress unneeded downloads */
+	if (wm8994->cur_fw == fw)
+		return 0;
+
+	if (fw->size < 32) {
+		dev_err(codec->dev, "%s: firmware too short\n", name);
+		goto err;
+	}
+
+	if (memcmp(fw->data, "WMFW", 4) != 0) {
+		dev_err(codec->dev, "%s: firmware has bad file magic %08x\n",
+			name, data32);
+		goto err;
+	}
+
+	memcpy(&data32, fw->data + 4, sizeof(data32));
+	len = be32_to_cpu(data32);
+
+	memcpy(&data32, fw->data + 8, sizeof(data32));
+	data32 = be32_to_cpu(data32);
+	if ((data32 >> 24) & 0xff) {
+		dev_err(codec->dev, "%s: unsupported firmware version %d\n",
+			name, (data32 >> 24) & 0xff);
+		goto err;
+	}
+	if ((data32 & 0xffff) != 8958) {
+		dev_err(codec->dev, "%s: unsupported target device %d\n",
+			name, data32 & 0xffff);
+		goto err;
+	}
+	if (((data32 >> 16) & 0xff) != 0xc) {
+		dev_err(codec->dev, "%s: unsupported target core %d\n",
+			name, (data32 >> 16) & 0xff);
+		goto err;
+	}
+
+	if (check) {
+		memcpy(&data64, fw->data + 24, sizeof(u64));
+		dev_info(codec->dev, "%s timestamp %llx\n",
+			 name, be64_to_cpu(data64));
+	} else {
+		snd_soc_write(codec, 0x102, 0x2);
+		snd_soc_write(codec, 0x900, 0x2);
+	}
+
+	data = fw->data + len;
+	len = fw->size - len;
+	while (len) {
+		if (len < 12) {
+			dev_err(codec->dev, "%s short data block of %d\n",
+				name, len);
+			goto err;
+		}
+
+		memcpy(&data32, data + 4, sizeof(data32));
+		block_len = be32_to_cpu(data32);
+		if (block_len + 8 > len) {
+			dev_err(codec->dev, "%d byte block longer than file\n",
+				block_len);
+			goto err;
+		}
+		if (block_len == 0) {
+			dev_err(codec->dev, "Zero length block\n");
+			goto err;
+		}
+
+		memcpy(&data32, data, sizeof(data32));
+		data32 = be32_to_cpu(data32);
+
+		switch ((data32 >> 24) & 0xff) {
+		case WM_FW_BLOCK_INFO:
+			/* Informational text */
+			if (!check)
+				break;
+
+			str = kzalloc(block_len + 1, GFP_KERNEL);
+			if (str) {
+				memcpy(str, data + 8, block_len);
+				dev_info(codec->dev, "%s: %s\n", name, str);
+				kfree(str);
+			} else {
+				dev_err(codec->dev, "Out of memory\n");
+			}
+			break;
+		case WM_FW_BLOCK_PM:
+		case WM_FW_BLOCK_X:
+		case WM_FW_BLOCK_Y:
+		case WM_FW_BLOCK_Z:
+		case WM_FW_BLOCK_I:
+		case WM_FW_BLOCK_A:
+		case WM_FW_BLOCK_C:
+			dev_dbg(codec->dev, "%s: %d bytes of %x@%x\n", name,
+				block_len, (data32 >> 24) & 0xff,
+				data32 & 0xffffff);
+
+			if (check)
+				break;
+
+			data32 &= 0xffffff;
+
+			wm8994_bulk_write(codec->control_data,
+					  data32 & 0xffffff,
+					  block_len / 2,
+					  (void *)(data + 8));
+
+			break;
+		default:
+			dev_warn(codec->dev, "%s: unknown block type %d\n",
+				 name, (data32 >> 24) & 0xff);
+			break;
+		}
+
+		/* Round up to the next 32 bit word */
+		block_len += block_len % 4;
+
+		data += block_len + 8;
+		len -= block_len + 8;
+	}
+
+	if (!check) {
+		dev_dbg(codec->dev, "%s: download done\n", name);
+		wm8994->cur_fw = fw;
+	} else {
+		dev_info(codec->dev, "%s: got firmware\n", name);
+	}
+
+	goto ok;
+
+err:
+	ret = -EINVAL;
+ok:
+	if (!check) {
+		snd_soc_write(codec, 0x900, 0x0);
+		snd_soc_write(codec, 0x102, 0x0);
+	}
+
+	return ret;
+}
+
 static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994_pdata *pdata = wm8994->pdata;
+	int i;
+
+	/* If the DSP is already running then noop */
+	if (snd_soc_read(codec, WM8958_DSP2_PROGRAM) & WM8958_DSP2_ENA)
+		return;
+
+	/* If we have MBC firmware download it */
+	if (wm8994->mbc)
+		wm8958_dsp2_fw(codec, "MBC", wm8994->mbc, false);
+
+	snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+			    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
+
+	/* If we've got user supplied MBC settings use them */
+	if (pdata && pdata->num_mbc_cfgs) {
+		struct wm8958_mbc_cfg *cfg
+			= &pdata->mbc_cfgs[wm8994->mbc_cfg];
+
+		for (i = 0; i < ARRAY_SIZE(cfg->coeff_regs); i++)
+			snd_soc_write(codec, i + WM8958_MBC_BAND_1_K_1,
+				      cfg->coeff_regs[i]);
+
+		for (i = 0; i < ARRAY_SIZE(cfg->cutoff_regs); i++)
+			snd_soc_write(codec,
+				      i + WM8958_MBC_BAND_2_LOWER_CUTOFF_C1_1,
+				      cfg->cutoff_regs[i]);
+	}
+
+	/* Run the DSP */
+	snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+		      WM8958_DSP2_RUNR);
+
+	/* And we're off! */
+	snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+			    WM8958_MBC_ENA |
+			    WM8958_MBC_SEL_MASK,
+			    path << WM8958_MBC_SEL_SHIFT |
+			    WM8958_MBC_ENA);
+}
+
+static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int pwr_reg = snd_soc_read(codec, WM8994_POWER_MANAGEMENT_5);
 	int ena, reg, aif, i;
 
@@ -76,6 +278,10 @@ static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
 		      & WM8994_AIF2CLK_ENA_MASK))
 			return;
 
+		/* If we have MBC firmware download it */
+		if (wm8994->mbc && wm8994->mbc_ena[mbc])
+			wm8958_dsp2_fw(codec, "MBC", wm8994->mbc, false);
+
 		/* Switch the clock over to the appropriate AIF */
 		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
 				    WM8958_DSP2CLK_SRC | WM8958_DSP2CLK_ENA,
@@ -242,6 +448,18 @@ WM8958_MBC_SWITCH("AIF1DAC2 MBC Switch", 1),
 WM8958_MBC_SWITCH("AIF2DAC MBC Switch", 2),
 };
 
+static void wm8958_mbc_loaded(const struct firmware *fw, void *context)
+{
+	struct snd_soc_codec *codec = context;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (fw && wm8958_dsp2_fw(codec, "MBC", fw, true) != 0) {
+		mutex_lock(&codec->mutex);
+		wm8994->mbc = fw;
+		mutex_unlock(&codec->mutex);
+	}
+}
+
 void wm8958_dsp2_init(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -251,6 +469,11 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 	snd_soc_add_controls(codec, wm8958_mbc_snd_controls,
 			     ARRAY_SIZE(wm8958_mbc_snd_controls));
 
+	/* We don't require firmware and don't want to delay boot */
+	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+				"wm8958_mbc.wfw", codec->dev, GFP_KERNEL,
+				codec, wm8958_mbc_loaded);
+
 	if (!pdata)
 		return;
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index bdd1ac7..f622ff6 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1922,6 +1922,8 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 					    WM8994_VMID_BUF_ENA |
 					    WM8994_VMID_RAMP_MASK, 0);
 
+			wm8994->cur_fw = NULL;
+
 			pm_runtime_put(codec->dev);
 		}
 		break;
@@ -3136,6 +3138,8 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 			free_irq(wm8994->micdet_irq, wm8994);
 		break;
 	}
+	if (wm8994->mbc)
+		release_firmware(wm8994->mbc);
 	kfree(wm8994->retune_mobile_texts);
 	kfree(wm8994->drc_texts);
 	kfree(wm8994);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 93a6cf1..1aa365b 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -10,6 +10,7 @@
 #define _WM8994_H
 
 #include <sound/soc.h>
+#include <linux/firmware.h>
 
 #include "wm_hubs.h"
 
@@ -114,6 +115,9 @@ struct wm8994_priv {
 
 	unsigned int aif1clk_disable:1;
 	unsigned int aif2clk_disable:1;
+
+	const struct firmware *cur_fw;
+	const struct firmware *mbc;
 };
 
 #endif
-- 
1.7.4.1
