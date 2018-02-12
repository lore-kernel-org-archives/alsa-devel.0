From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm0010: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:51:54 +0000
Message-ID: <E1elDaM-0006T3-0F@debutante>
References: <87efm95q46.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 37698267B3A
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:51:58 +0100 (CET)
In-Reply-To: <87efm95q46.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm0010: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b5311eede823588b9c33774a1c4dc51843a42a41 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:58:43 +0000
Subject: [PATCH] ASoC: wm0010: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 1	->	.idle_bias_on = 0
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm0010.c | 181 +++++++++++++++++++++++-----------------------
 1 file changed, 89 insertions(+), 92 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 0147d2fb7b0a..abd2defe7530 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -90,7 +90,7 @@ enum wm0010_state {
 };
 
 struct wm0010_priv {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 
 	struct mutex lock;
 	struct device *dev;
@@ -157,9 +157,9 @@ static const char *wm0010_state_to_str(enum wm0010_state state)
 }
 
 /* Called with wm0010->lock held */
-static void wm0010_halt(struct snd_soc_codec *codec)
+static void wm0010_halt(struct snd_soc_component *component)
 {
-	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
+	struct wm0010_priv *wm0010 = snd_soc_component_get_drvdata(component);
 	unsigned long flags;
 	enum wm0010_state state;
 
@@ -193,7 +193,7 @@ static void wm0010_halt(struct snd_soc_codec *codec)
 
 struct wm0010_boot_xfer {
 	struct list_head list;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct completion *done;
 	struct spi_message m;
 	struct spi_transfer t;
@@ -218,13 +218,13 @@ static void wm0010_mark_boot_failure(struct wm0010_priv *wm0010)
 static void wm0010_boot_xfer_complete(void *data)
 {
 	struct wm0010_boot_xfer *xfer = data;
-	struct snd_soc_codec *codec = xfer->codec;
-	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = xfer->component;
+	struct wm0010_priv *wm0010 = snd_soc_component_get_drvdata(component);
 	u32 *out32 = xfer->t.rx_buf;
 	int i;
 
 	if (xfer->m.status != 0) {
-		dev_err(codec->dev, "SPI transfer failed: %d\n",
+		dev_err(component->dev, "SPI transfer failed: %d\n",
 			xfer->m.status);
 		wm0010_mark_boot_failure(wm0010);
 		if (xfer->done)
@@ -233,11 +233,11 @@ static void wm0010_boot_xfer_complete(void *data)
 	}
 
 	for (i = 0; i < xfer->t.len / 4; i++) {
-		dev_dbg(codec->dev, "%d: %04x\n", i, out32[i]);
+		dev_dbg(component->dev, "%d: %04x\n", i, out32[i]);
 
 		switch (be32_to_cpu(out32[i])) {
 		case 0xe0e0e0e0:
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"%d: ROM error reported in stage 2\n", i);
 			wm0010_mark_boot_failure(wm0010);
 			break;
@@ -245,82 +245,82 @@ static void wm0010_boot_xfer_complete(void *data)
 		case 0x55555555:
 			if (wm0010->state < WM0010_STAGE2)
 				break;
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"%d: ROM bootloader running in stage 2\n", i);
 			wm0010_mark_boot_failure(wm0010);
 			break;
 
 		case 0x0fed0000:
-			dev_dbg(codec->dev, "Stage2 loader running\n");
+			dev_dbg(component->dev, "Stage2 loader running\n");
 			break;
 
 		case 0x0fed0007:
-			dev_dbg(codec->dev, "CODE_HDR packet received\n");
+			dev_dbg(component->dev, "CODE_HDR packet received\n");
 			break;
 
 		case 0x0fed0008:
-			dev_dbg(codec->dev, "CODE_DATA packet received\n");
+			dev_dbg(component->dev, "CODE_DATA packet received\n");
 			break;
 
 		case 0x0fed0009:
-			dev_dbg(codec->dev, "Download complete\n");
+			dev_dbg(component->dev, "Download complete\n");
 			break;
 
 		case 0x0fed000c:
-			dev_dbg(codec->dev, "Application start\n");
+			dev_dbg(component->dev, "Application start\n");
 			break;
 
 		case 0x0fed000e:
-			dev_dbg(codec->dev, "PLL packet received\n");
+			dev_dbg(component->dev, "PLL packet received\n");
 			wm0010->pll_running = true;
 			break;
 
 		case 0x0fed0025:
-			dev_err(codec->dev, "Device reports image too long\n");
+			dev_err(component->dev, "Device reports image too long\n");
 			wm0010_mark_boot_failure(wm0010);
 			break;
 
 		case 0x0fed002c:
-			dev_err(codec->dev, "Device reports bad SPI packet\n");
+			dev_err(component->dev, "Device reports bad SPI packet\n");
 			wm0010_mark_boot_failure(wm0010);
 			break;
 
 		case 0x0fed0031:
-			dev_err(codec->dev, "Device reports SPI read overflow\n");
+			dev_err(component->dev, "Device reports SPI read overflow\n");
 			wm0010_mark_boot_failure(wm0010);
 			break;
 
 		case 0x0fed0032:
-			dev_err(codec->dev, "Device reports SPI underclock\n");
+			dev_err(component->dev, "Device reports SPI underclock\n");
 			wm0010_mark_boot_failure(wm0010);
 			break;
 
 		case 0x0fed0033:
-			dev_err(codec->dev, "Device reports bad header packet\n");
+			dev_err(component->dev, "Device reports bad header packet\n");
 			wm0010_mark_boot_failure(wm0010);
 			break;
 
 		case 0x0fed0034:
-			dev_err(codec->dev, "Device reports invalid packet type\n");
+			dev_err(component->dev, "Device reports invalid packet type\n");
 			wm0010_mark_boot_failure(wm0010);
 			break;
 
 		case 0x0fed0035:
-			dev_err(codec->dev, "Device reports data before header error\n");
+			dev_err(component->dev, "Device reports data before header error\n");
 			wm0010_mark_boot_failure(wm0010);
 			break;
 
 		case 0x0fed0038:
-			dev_err(codec->dev, "Device reports invalid PLL packet\n");
+			dev_err(component->dev, "Device reports invalid PLL packet\n");
 			break;
 
 		case 0x0fed003a:
-			dev_err(codec->dev, "Device reports packet alignment error\n");
+			dev_err(component->dev, "Device reports packet alignment error\n");
 			wm0010_mark_boot_failure(wm0010);
 			break;
 
 		default:
-			dev_err(codec->dev, "Unrecognised return 0x%x\n",
+			dev_err(component->dev, "Unrecognised return 0x%x\n",
 			    be32_to_cpu(out32[i]));
 			wm0010_mark_boot_failure(wm0010);
 			break;
@@ -342,10 +342,10 @@ static void byte_swap_64(u64 *data_in, u64 *data_out, u32 len)
 		data_out[i] = cpu_to_be64(le64_to_cpu(data_in[i]));
 }
 
-static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
+static int wm0010_firmware_load(const char *name, struct snd_soc_component *component)
 {
-	struct spi_device *spi = to_spi_device(codec->dev);
-	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
+	struct spi_device *spi = to_spi_device(component->dev);
+	struct wm0010_priv *wm0010 = snd_soc_component_get_drvdata(component);
 	struct list_head xfer_list;
 	struct wm0010_boot_xfer *xfer;
 	int ret;
@@ -359,9 +359,9 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 
 	INIT_LIST_HEAD(&xfer_list);
 
-	ret = request_firmware(&fw, name, codec->dev);
+	ret = request_firmware(&fw, name, component->dev);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request application(%s): %d\n",
+		dev_err(component->dev, "Failed to request application(%s): %d\n",
 			name, ret);
 		return ret;
 	}
@@ -377,25 +377,25 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 
 	/* First record should be INFO */
 	if (rec->command != DFW_CMD_INFO) {
-		dev_err(codec->dev, "First record not INFO\r\n");
+		dev_err(component->dev, "First record not INFO\r\n");
 		ret = -EINVAL;
 		goto abort;
 	}
 
 	if (inforec->info_version != INFO_VERSION) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"Unsupported version (%02d) of INFO record\r\n",
 			inforec->info_version);
 		ret = -EINVAL;
 		goto abort;
 	}
 
-	dev_dbg(codec->dev, "Version v%02d INFO record found\r\n",
+	dev_dbg(component->dev, "Version v%02d INFO record found\r\n",
 		inforec->info_version);
 
 	/* Check it's a DSP file */
 	if (dsp != DEVICE_ID_WM0010) {
-		dev_err(codec->dev, "Not a WM0010 firmware file.\r\n");
+		dev_err(component->dev, "Not a WM0010 firmware file.\r\n");
 		ret = -EINVAL;
 		goto abort;
 	}
@@ -405,7 +405,7 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 	rec = (void *)&rec->data[rec->length];
 
 	while (offset < fw->size) {
-		dev_dbg(codec->dev,
+		dev_dbg(component->dev,
 			"Packet: command %d, data length = 0x%x\r\n",
 			rec->command, rec->length);
 		len = rec->length + 8;
@@ -416,7 +416,7 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 			goto abort;
 		}
 
-		xfer->codec = codec;
+		xfer->component = component;
 		list_add_tail(&xfer->list, &xfer_list);
 
 		out = kzalloc(len, GFP_KERNEL | GFP_DMA);
@@ -460,18 +460,18 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 		rec = (void *)&rec->data[rec->length];
 
 		if (offset >= fw->size) {
-			dev_dbg(codec->dev, "All transfers scheduled\n");
+			dev_dbg(component->dev, "All transfers scheduled\n");
 			xfer->done = &done;
 		}
 
 		ret = spi_async(spi, &xfer->m);
 		if (ret != 0) {
-			dev_err(codec->dev, "Write failed: %d\n", ret);
+			dev_err(component->dev, "Write failed: %d\n", ret);
 			goto abort1;
 		}
 
 		if (wm0010->boot_failed) {
-			dev_dbg(codec->dev, "Boot fail!\n");
+			dev_dbg(component->dev, "Boot fail!\n");
 			ret = -EINVAL;
 			goto abort1;
 		}
@@ -496,10 +496,10 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 	return ret;
 }
 
-static int wm0010_stage2_load(struct snd_soc_codec *codec)
+static int wm0010_stage2_load(struct snd_soc_component *component)
 {
-	struct spi_device *spi = to_spi_device(codec->dev);
-	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
+	struct spi_device *spi = to_spi_device(component->dev);
+	struct wm0010_priv *wm0010 = snd_soc_component_get_drvdata(component);
 	const struct firmware *fw;
 	struct spi_message m;
 	struct spi_transfer t;
@@ -508,14 +508,14 @@ static int wm0010_stage2_load(struct snd_soc_codec *codec)
 	int i;
 	int ret = 0;
 
-	ret = request_firmware(&fw, "wm0010_stage2.bin", codec->dev);
+	ret = request_firmware(&fw, "wm0010_stage2.bin", component->dev);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request stage2 loader: %d\n",
+		dev_err(component->dev, "Failed to request stage2 loader: %d\n",
 			ret);
 		return ret;
 	}
 
-	dev_dbg(codec->dev, "Downloading %zu byte stage 2 loader\n", fw->size);
+	dev_dbg(component->dev, "Downloading %zu byte stage 2 loader\n", fw->size);
 
 	/* Copy to local buffer first as vmalloc causes problems for dma */
 	img = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
@@ -541,19 +541,19 @@ static int wm0010_stage2_load(struct snd_soc_codec *codec)
 	t.speed_hz = wm0010->sysclk / 10;
 	spi_message_add_tail(&t, &m);
 
-	dev_dbg(codec->dev, "Starting initial download at %dHz\n",
+	dev_dbg(component->dev, "Starting initial download at %dHz\n",
 		t.speed_hz);
 
 	ret = spi_sync(spi, &m);
 	if (ret != 0) {
-		dev_err(codec->dev, "Initial download failed: %d\n", ret);
+		dev_err(component->dev, "Initial download failed: %d\n", ret);
 		goto abort;
 	}
 
 	/* Look for errors from the boot ROM */
 	for (i = 0; i < fw->size; i++) {
 		if (out[i] != 0x55) {
-			dev_err(codec->dev, "Boot ROM error: %x in %d\n",
+			dev_err(component->dev, "Boot ROM error: %x in %d\n",
 				out[i], i);
 			wm0010_mark_boot_failure(wm0010);
 			ret = -EBUSY;
@@ -570,10 +570,10 @@ static int wm0010_stage2_load(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static int wm0010_boot(struct snd_soc_codec *codec)
+static int wm0010_boot(struct snd_soc_component *component)
 {
-	struct spi_device *spi = to_spi_device(codec->dev);
-	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
+	struct spi_device *spi = to_spi_device(component->dev);
+	struct wm0010_priv *wm0010 = snd_soc_component_get_drvdata(component);
 	unsigned long flags;
 	int ret;
 	struct spi_message m;
@@ -590,7 +590,7 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	spin_unlock_irqrestore(&wm0010->irq_lock, flags);
 
 	if (wm0010->sysclk > 26000000) {
-		dev_err(codec->dev, "Max DSP clock frequency is 26MHz\n");
+		dev_err(component->dev, "Max DSP clock frequency is 26MHz\n");
 		ret = -ECANCELED;
 		goto err;
 	}
@@ -598,7 +598,7 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	mutex_lock(&wm0010->lock);
 	wm0010->pll_running = false;
 
-	dev_dbg(codec->dev, "max_spi_freq: %d\n", wm0010->max_spi_freq);
+	dev_dbg(component->dev, "max_spi_freq: %d\n", wm0010->max_spi_freq);
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm0010->core_supplies),
 				    wm0010->core_supplies);
@@ -623,19 +623,19 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 
 	if (!wait_for_completion_timeout(&wm0010->boot_completion,
 					 msecs_to_jiffies(20)))
-		dev_err(codec->dev, "Failed to get interrupt from DSP\n");
+		dev_err(component->dev, "Failed to get interrupt from DSP\n");
 
 	spin_lock_irqsave(&wm0010->irq_lock, flags);
 	wm0010->state = WM0010_BOOTROM;
 	spin_unlock_irqrestore(&wm0010->irq_lock, flags);
 
-	ret = wm0010_stage2_load(codec);
+	ret = wm0010_stage2_load(component);
 	if (ret)
 		goto abort;
 
 	if (!wait_for_completion_timeout(&wm0010->boot_completion,
 					 msecs_to_jiffies(20)))
-		dev_err(codec->dev, "Failed to get interrupt from DSP loader.\n");
+		dev_err(component->dev, "Failed to get interrupt from DSP loader.\n");
 
 	spin_lock_irqsave(&wm0010->irq_lock, flags);
 	wm0010->state = WM0010_STAGE2;
@@ -676,14 +676,14 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 
 		ret = spi_sync(spi, &m);
 		if (ret) {
-			dev_err(codec->dev, "First PLL write failed: %d\n", ret);
+			dev_err(component->dev, "First PLL write failed: %d\n", ret);
 			goto abort_swap;
 		}
 
 		/* Use a second send of the message to get the return status */
 		ret = spi_sync(spi, &m);
 		if (ret) {
-			dev_err(codec->dev, "Second PLL write failed: %d\n", ret);
+			dev_err(component->dev, "Second PLL write failed: %d\n", ret);
 			goto abort_swap;
 		}
 
@@ -692,7 +692,7 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		/* Look for PLL active code from the DSP */
 		for (i = 0; i < len / 4; i++) {
 			if (*p == 0x0e00ed0f) {
-				dev_dbg(codec->dev, "PLL packet received\n");
+				dev_dbg(component->dev, "PLL packet received\n");
 				wm0010->pll_running = true;
 				break;
 			}
@@ -702,9 +702,9 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		kfree(img_swap);
 		kfree(out);
 	} else
-		dev_dbg(codec->dev, "Not enabling DSP PLL.");
+		dev_dbg(component->dev, "Not enabling DSP PLL.");
 
-	ret = wm0010_firmware_load("wm0010.dfw", codec);
+	ret = wm0010_firmware_load("wm0010.dfw", component);
 
 	if (ret != 0)
 		goto abort;
@@ -723,7 +723,7 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	kfree(out);
 abort:
 	/* Put the chip back into reset */
-	wm0010_halt(codec);
+	wm0010_halt(component);
 	mutex_unlock(&wm0010->lock);
 	return ret;
 
@@ -735,22 +735,22 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static int wm0010_set_bias_level(struct snd_soc_codec *codec,
+static int wm0010_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
+	struct wm0010_priv *wm0010 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE)
-			wm0010_boot(codec);
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_PREPARE)
+			wm0010_boot(component);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_PREPARE) {
 			mutex_lock(&wm0010->lock);
-			wm0010_halt(codec);
+			wm0010_halt(component);
 			mutex_unlock(&wm0010->lock);
 		}
 		break;
@@ -761,10 +761,10 @@ static int wm0010_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm0010_set_sysclk(struct snd_soc_codec *codec, int source,
+static int wm0010_set_sysclk(struct snd_soc_component *component, int source,
 			     int clk_id, unsigned int freq, int dir)
 {
-	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
+	struct wm0010_priv *wm0010 = snd_soc_component_get_drvdata(component);
 	unsigned int i;
 
 	wm0010->sysclk = freq;
@@ -783,20 +783,19 @@ static int wm0010_set_sysclk(struct snd_soc_codec *codec, int source,
 	return 0;
 }
 
-static int wm0010_probe(struct snd_soc_codec *codec);
-
-static const struct snd_soc_codec_driver soc_codec_dev_wm0010 = {
-	.probe = wm0010_probe,
-	.set_bias_level = wm0010_set_bias_level,
-	.set_sysclk = wm0010_set_sysclk,
-	.idle_bias_off = true,
-
-	.component_driver = {
-		.dapm_widgets		= wm0010_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm0010_dapm_widgets),
-		.dapm_routes		= wm0010_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm0010_dapm_routes),
-	},
+static int wm0010_probe(struct snd_soc_component *component);
+
+static const struct snd_soc_component_driver soc_component_dev_wm0010 = {
+	.probe			= wm0010_probe,
+	.set_bias_level		= wm0010_set_bias_level,
+	.set_sysclk		= wm0010_set_sysclk,
+	.dapm_widgets		= wm0010_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm0010_dapm_widgets),
+	.dapm_routes		= wm0010_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm0010_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 #define WM0010_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
@@ -860,11 +859,11 @@ static irqreturn_t wm0010_irq(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static int wm0010_probe(struct snd_soc_codec *codec)
+static int wm0010_probe(struct snd_soc_component *component)
 {
-	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
+	struct wm0010_priv *wm0010 = snd_soc_component_get_drvdata(component);
 
-	wm0010->codec = codec;
+	wm0010->component = component;
 
 	return 0;
 }
@@ -967,8 +966,8 @@ static int wm0010_spi_probe(struct spi_device *spi)
 	else
 		wm0010->board_max_spi_speed = 0;
 
-	ret = snd_soc_register_codec(&spi->dev,
-				     &soc_codec_dev_wm0010, wm0010_dai,
+	ret = devm_snd_soc_register_component(&spi->dev,
+				     &soc_component_dev_wm0010, wm0010_dai,
 				     ARRAY_SIZE(wm0010_dai));
 	if (ret < 0)
 		return ret;
@@ -980,8 +979,6 @@ static int wm0010_spi_remove(struct spi_device *spi)
 {
 	struct wm0010_priv *wm0010 = spi_get_drvdata(spi);
 
-	snd_soc_unregister_codec(&spi->dev);
-
 	gpio_set_value_cansleep(wm0010->gpio_reset,
 				wm0010->gpio_reset_value);
 
-- 
2.16.1
