From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8993/wm8994/wm8958: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:32:58 +0000
Message-ID: <E1elDI2-0003VH-GY@debutante>
References: <87inbl2wci.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 88EF4267922
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:33:01 +0100 (CET)
In-Reply-To: <87inbl2wci.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8993/wm8994/wm8958: replace codec to component

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

>From 00a6941c841205fbdade825219a828c81008149b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:12:21 +0000
Subject: [PATCH] ASoC: wm8993/wm8994/wm8958: replace codec to component

Now we can replace Codec to Component. Let's do it.

Becase wm8993/wm8994/wm8958 are using wm_hubs feature,
we need to update these all related drivers in same time.
Otherwise compile error/warning happen

wm8993:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

wm8994:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8958-dsp2.c | 278 +++++++-------
 sound/soc/codecs/wm8993.c      | 237 ++++++------
 sound/soc/codecs/wm8994.c      | 810 +++++++++++++++++++++--------------------
 sound/soc/codecs/wm8994.h      |   8 +-
 sound/soc/codecs/wm_hubs.c     | 254 ++++++-------
 sound/soc/codecs/wm_hubs.h     |  18 +-
 sound/soc/samsung/littlemill.c |   8 +-
 7 files changed, 809 insertions(+), 804 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 6b864c0fc2b6..8d495220fa25 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -39,10 +39,10 @@
 #define WM_FW_BLOCK_A    0x08
 #define WM_FW_BLOCK_C    0x0c
 
-static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
+static int wm8958_dsp2_fw(struct snd_soc_component *component, const char *name,
 			  const struct firmware *fw, bool check)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	u64 data64;
 	u32 data32;
 	const u8 *data;
@@ -55,7 +55,7 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 		return 0;
 
 	if (fw->size < 32) {
-		dev_err(codec->dev, "%s: firmware too short (%zd bytes)\n",
+		dev_err(component->dev, "%s: firmware too short (%zd bytes)\n",
 			name, fw->size);
 		goto err;
 	}
@@ -63,7 +63,7 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 	if (memcmp(fw->data, "WMFW", 4) != 0) {
 		memcpy(&data32, fw->data, sizeof(data32));
 		data32 = be32_to_cpu(data32);
-		dev_err(codec->dev, "%s: firmware has bad file magic %08x\n",
+		dev_err(component->dev, "%s: firmware has bad file magic %08x\n",
 			name, data32);
 		goto err;
 	}
@@ -74,35 +74,35 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 	memcpy(&data32, fw->data + 8, sizeof(data32));
 	data32 = be32_to_cpu(data32);
 	if ((data32 >> 24) & 0xff) {
-		dev_err(codec->dev, "%s: unsupported firmware version %d\n",
+		dev_err(component->dev, "%s: unsupported firmware version %d\n",
 			name, (data32 >> 24) & 0xff);
 		goto err;
 	}
 	if ((data32 & 0xffff) != 8958) {
-		dev_err(codec->dev, "%s: unsupported target device %d\n",
+		dev_err(component->dev, "%s: unsupported target device %d\n",
 			name, data32 & 0xffff);
 		goto err;
 	}
 	if (((data32 >> 16) & 0xff) != 0xc) {
-		dev_err(codec->dev, "%s: unsupported target core %d\n",
+		dev_err(component->dev, "%s: unsupported target core %d\n",
 			name, (data32 >> 16) & 0xff);
 		goto err;
 	}
 
 	if (check) {
 		memcpy(&data64, fw->data + 24, sizeof(u64));
-		dev_info(codec->dev, "%s timestamp %llx\n",
+		dev_info(component->dev, "%s timestamp %llx\n",
 			 name, be64_to_cpu(data64));
 	} else {
-		snd_soc_write(codec, 0x102, 0x2);
-		snd_soc_write(codec, 0x900, 0x2);
+		snd_soc_component_write(component, 0x102, 0x2);
+		snd_soc_component_write(component, 0x900, 0x2);
 	}
 
 	data = fw->data + len;
 	len = fw->size - len;
 	while (len) {
 		if (len < 12) {
-			dev_err(codec->dev, "%s short data block of %zd\n",
+			dev_err(component->dev, "%s short data block of %zd\n",
 				name, len);
 			goto err;
 		}
@@ -110,12 +110,12 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 		memcpy(&data32, data + 4, sizeof(data32));
 		block_len = be32_to_cpu(data32);
 		if (block_len + 8 > len) {
-			dev_err(codec->dev, "%zd byte block longer than file\n",
+			dev_err(component->dev, "%zd byte block longer than file\n",
 				block_len);
 			goto err;
 		}
 		if (block_len == 0) {
-			dev_err(codec->dev, "Zero length block\n");
+			dev_err(component->dev, "Zero length block\n");
 			goto err;
 		}
 
@@ -131,10 +131,10 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 			str = kzalloc(block_len + 1, GFP_KERNEL);
 			if (str) {
 				memcpy(str, data + 8, block_len);
-				dev_info(codec->dev, "%s: %s\n", name, str);
+				dev_info(component->dev, "%s: %s\n", name, str);
 				kfree(str);
 			} else {
-				dev_err(codec->dev, "Out of memory\n");
+				dev_err(component->dev, "Out of memory\n");
 			}
 			break;
 		case WM_FW_BLOCK_PM:
@@ -144,7 +144,7 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 		case WM_FW_BLOCK_I:
 		case WM_FW_BLOCK_A:
 		case WM_FW_BLOCK_C:
-			dev_dbg(codec->dev, "%s: %zd bytes of %x@%x\n", name,
+			dev_dbg(component->dev, "%s: %zd bytes of %x@%x\n", name,
 				block_len, (data32 >> 24) & 0xff,
 				data32 & 0xffffff);
 
@@ -160,7 +160,7 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 
 			break;
 		default:
-			dev_warn(codec->dev, "%s: unknown block type %d\n",
+			dev_warn(component->dev, "%s: unknown block type %d\n",
 				 name, (data32 >> 24) & 0xff);
 			break;
 		}
@@ -173,10 +173,10 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 	}
 
 	if (!check) {
-		dev_dbg(codec->dev, "%s: download done\n", name);
+		dev_dbg(component->dev, "%s: download done\n", name);
 		wm8994->cur_fw = fw;
 	} else {
-		dev_info(codec->dev, "%s: got firmware\n", name);
+		dev_info(component->dev, "%s: got firmware\n", name);
 	}
 
 	goto ok;
@@ -185,28 +185,28 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 	ret = -EINVAL;
 ok:
 	if (!check) {
-		snd_soc_write(codec, 0x900, 0x0);
-		snd_soc_write(codec, 0x102, 0x0);
+		snd_soc_component_write(component, 0x900, 0x0);
+		snd_soc_component_write(component, 0x102, 0x0);
 	}
 
 	return ret;
 }
 
-static void wm8958_dsp_start_mbc(struct snd_soc_codec *codec, int path)
+static void wm8958_dsp_start_mbc(struct snd_soc_component *component, int path)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int i;
 
 	/* If the DSP is already running then noop */
-	if (snd_soc_read(codec, WM8958_DSP2_PROGRAM) & WM8958_DSP2_ENA)
+	if (snd_soc_component_read32(component, WM8958_DSP2_PROGRAM) & WM8958_DSP2_ENA)
 		return;
 
 	/* If we have MBC firmware download it */
 	if (wm8994->mbc)
-		wm8958_dsp2_fw(codec, "MBC", wm8994->mbc, false);
+		wm8958_dsp2_fw(component, "MBC", wm8994->mbc, false);
 
-	snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+	snd_soc_component_update_bits(component, WM8958_DSP2_PROGRAM,
 			    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
 
 	/* If we've got user supplied MBC settings use them */
@@ -215,37 +215,37 @@ static void wm8958_dsp_start_mbc(struct snd_soc_codec *codec, int path)
 			= &control->pdata.mbc_cfgs[wm8994->mbc_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->coeff_regs); i++)
-			snd_soc_write(codec, i + WM8958_MBC_BAND_1_K_1,
+			snd_soc_component_write(component, i + WM8958_MBC_BAND_1_K_1,
 				      cfg->coeff_regs[i]);
 
 		for (i = 0; i < ARRAY_SIZE(cfg->cutoff_regs); i++)
-			snd_soc_write(codec,
+			snd_soc_component_write(component,
 				      i + WM8958_MBC_BAND_2_LOWER_CUTOFF_C1_1,
 				      cfg->cutoff_regs[i]);
 	}
 
 	/* Run the DSP */
-	snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+	snd_soc_component_write(component, WM8958_DSP2_EXECCONTROL,
 		      WM8958_DSP2_RUNR);
 
 	/* And we're off! */
-	snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+	snd_soc_component_update_bits(component, WM8958_DSP2_CONFIG,
 			    WM8958_MBC_ENA |
 			    WM8958_MBC_SEL_MASK,
 			    path << WM8958_MBC_SEL_SHIFT |
 			    WM8958_MBC_ENA);
 }
 
-static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
+static void wm8958_dsp_start_vss(struct snd_soc_component *component, int path)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int i, ena;
 
 	if (wm8994->mbc_vss)
-		wm8958_dsp2_fw(codec, "MBC+VSS", wm8994->mbc_vss, false);
+		wm8958_dsp2_fw(component, "MBC+VSS", wm8994->mbc_vss, false);
 
-	snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+	snd_soc_component_update_bits(component, WM8958_DSP2_PROGRAM,
 			    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
 
 	/* If we've got user supplied settings use them */
@@ -254,7 +254,7 @@ static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
 			= &control->pdata.mbc_cfgs[wm8994->mbc_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->combined_regs); i++)
-			snd_soc_write(codec, i + 0x2800,
+			snd_soc_component_write(component, i + 0x2800,
 				      cfg->combined_regs[i]);
 	}
 
@@ -263,7 +263,7 @@ static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
 			= &control->pdata.vss_cfgs[wm8994->vss_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->regs); i++)
-			snd_soc_write(codec, i + 0x2600, cfg->regs[i]);
+			snd_soc_component_write(component, i + 0x2600, cfg->regs[i]);
 	}
 
 	if (control->pdata.num_vss_hpf_cfgs) {
@@ -271,11 +271,11 @@ static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
 			= &control->pdata.vss_hpf_cfgs[wm8994->vss_hpf_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->regs); i++)
-			snd_soc_write(codec, i + 0x2400, cfg->regs[i]);
+			snd_soc_component_write(component, i + 0x2400, cfg->regs[i]);
 	}
 
 	/* Run the DSP */
-	snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+	snd_soc_component_write(component, WM8958_DSP2_EXECCONTROL,
 		      WM8958_DSP2_RUNR);
 
 	/* Enable the algorithms we've selected */
@@ -289,23 +289,23 @@ static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
 	if (wm8994->vss_ena[path])
 		ena |= 0x1;
 
-	snd_soc_write(codec, 0x2201, ena);
+	snd_soc_component_write(component, 0x2201, ena);
 
 	/* Switch the DSP into the data path */
-	snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+	snd_soc_component_update_bits(component, WM8958_DSP2_CONFIG,
 			    WM8958_MBC_SEL_MASK | WM8958_MBC_ENA,
 			    path << WM8958_MBC_SEL_SHIFT | WM8958_MBC_ENA);
 }
 
-static void wm8958_dsp_start_enh_eq(struct snd_soc_codec *codec, int path)
+static void wm8958_dsp_start_enh_eq(struct snd_soc_component *component, int path)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int i;
 
-	wm8958_dsp2_fw(codec, "ENH_EQ", wm8994->enh_eq, false);
+	wm8958_dsp2_fw(component, "ENH_EQ", wm8994->enh_eq, false);
 
-	snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+	snd_soc_component_update_bits(component, WM8958_DSP2_PROGRAM,
 			    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
 
 	/* If we've got user supplied settings use them */
@@ -314,24 +314,24 @@ static void wm8958_dsp_start_enh_eq(struct snd_soc_codec *codec, int path)
 			= &control->pdata.enh_eq_cfgs[wm8994->enh_eq_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->regs); i++)
-			snd_soc_write(codec, i + 0x2200,
+			snd_soc_component_write(component, i + 0x2200,
 				      cfg->regs[i]);
 	}
 
 	/* Run the DSP */
-	snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+	snd_soc_component_write(component, WM8958_DSP2_EXECCONTROL,
 		      WM8958_DSP2_RUNR);
 
 	/* Switch the DSP into the data path */
-	snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+	snd_soc_component_update_bits(component, WM8958_DSP2_CONFIG,
 			    WM8958_MBC_SEL_MASK | WM8958_MBC_ENA,
 			    path << WM8958_MBC_SEL_SHIFT | WM8958_MBC_ENA);
 }
 
-static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
+static void wm8958_dsp_apply(struct snd_soc_component *component, int path, int start)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	int pwr_reg = snd_soc_read(codec, WM8994_POWER_MANAGEMENT_5);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
+	int pwr_reg = snd_soc_component_read32(component, WM8994_POWER_MANAGEMENT_5);
 	int ena, reg, aif;
 
 	switch (path) {
@@ -359,9 +359,9 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 	if (!pwr_reg)
 		ena = 0;
 
-	reg = snd_soc_read(codec, WM8958_DSP2_PROGRAM);
+	reg = snd_soc_component_read32(component, WM8958_DSP2_PROGRAM);
 
-	dev_dbg(codec->dev, "DSP path %d %d startup: %d, power: %x, DSP: %x\n",
+	dev_dbg(component->dev, "DSP path %d %d startup: %d, power: %x, DSP: %x\n",
 		path, wm8994->dsp_active, start, pwr_reg, reg);
 
 	if (start && ena) {
@@ -370,29 +370,29 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 			return;
 
 		/* If either AIFnCLK is not yet enabled postpone */
-		if (!(snd_soc_read(codec, WM8994_AIF1_CLOCKING_1)
+		if (!(snd_soc_component_read32(component, WM8994_AIF1_CLOCKING_1)
 		      & WM8994_AIF1CLK_ENA_MASK) &&
-		    !(snd_soc_read(codec, WM8994_AIF2_CLOCKING_1)
+		    !(snd_soc_component_read32(component, WM8994_AIF2_CLOCKING_1)
 		      & WM8994_AIF2CLK_ENA_MASK))
 			return;
 
 		/* Switch the clock over to the appropriate AIF */
-		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+		snd_soc_component_update_bits(component, WM8994_CLOCKING_1,
 				    WM8958_DSP2CLK_SRC | WM8958_DSP2CLK_ENA,
 				    aif << WM8958_DSP2CLK_SRC_SHIFT |
 				    WM8958_DSP2CLK_ENA);
 
 		if (wm8994->enh_eq_ena[path])
-			wm8958_dsp_start_enh_eq(codec, path);
+			wm8958_dsp_start_enh_eq(component, path);
 		else if (wm8994->vss_ena[path] || wm8994->hpf1_ena[path] ||
 		    wm8994->hpf2_ena[path])
-			wm8958_dsp_start_vss(codec, path);
+			wm8958_dsp_start_vss(component, path);
 		else if (wm8994->mbc_ena[path])
-			wm8958_dsp_start_mbc(codec, path);
+			wm8958_dsp_start_mbc(component, path);
 
 		wm8994->dsp_active = path;
 
-		dev_dbg(codec->dev, "DSP running in path %d\n", path);
+		dev_dbg(component->dev, "DSP running in path %d\n", path);
 	}
 
 	if (!start && wm8994->dsp_active == path) {
@@ -400,37 +400,37 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 		if (!(reg & WM8958_DSP2_ENA))
 			return;
 
-		snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+		snd_soc_component_update_bits(component, WM8958_DSP2_CONFIG,
 				    WM8958_MBC_ENA, 0);	
-		snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+		snd_soc_component_write(component, WM8958_DSP2_EXECCONTROL,
 			      WM8958_DSP2_STOP);
-		snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+		snd_soc_component_update_bits(component, WM8958_DSP2_PROGRAM,
 				    WM8958_DSP2_ENA, 0);
-		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+		snd_soc_component_update_bits(component, WM8994_CLOCKING_1,
 				    WM8958_DSP2CLK_ENA, 0);
 
 		wm8994->dsp_active = -1;
 
-		dev_dbg(codec->dev, "DSP stopped\n");
+		dev_dbg(component->dev, "DSP stopped\n");
 	}
 }
 
 int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	int i;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 	case SND_SOC_DAPM_PRE_PMU:
 		for (i = 0; i < 3; i++)
-			wm8958_dsp_apply(codec, i, 1);
+			wm8958_dsp_apply(component, i, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 	case SND_SOC_DAPM_PRE_PMD:
 		for (i = 0; i < 3; i++)
-			wm8958_dsp_apply(codec, i, 0);
+			wm8958_dsp_apply(component, i, 0);
 		break;
 	}
 
@@ -456,14 +456,14 @@ static int wm8958_dsp2_busy(struct wm8994_priv *wm8994, int aif)
 static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.enumerated.item[0];
 	int reg;
 
 	/* Don't allow on the fly reconfiguration */
-	reg = snd_soc_read(codec, WM8994_CLOCKING_1);
+	reg = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
 		return -EBUSY;
 
@@ -478,8 +478,8 @@ static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_get_mbc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = wm8994->mbc_cfg;
 
@@ -500,8 +500,8 @@ static int wm8958_mbc_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int mbc = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = wm8994->mbc_ena[mbc];
 
@@ -512,8 +512,8 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int mbc = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	if (wm8994->mbc_ena[mbc] == ucontrol->value.integer.value[0])
 		return 0;
@@ -522,7 +522,7 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 
 	if (wm8958_dsp2_busy(wm8994, mbc)) {
-		dev_dbg(codec->dev, "DSP2 active on %d already\n", mbc);
+		dev_dbg(component->dev, "DSP2 active on %d already\n", mbc);
 		return -EBUSY;
 	}
 
@@ -531,7 +531,7 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 
 	wm8994->mbc_ena[mbc] = ucontrol->value.integer.value[0];
 
-	wm8958_dsp_apply(codec, mbc, wm8994->mbc_ena[mbc]);
+	wm8958_dsp_apply(component, mbc, wm8994->mbc_ena[mbc]);
 
 	return 0;
 }
@@ -546,14 +546,14 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 static int wm8958_put_vss_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.enumerated.item[0];
 	int reg;
 
 	/* Don't allow on the fly reconfiguration */
-	reg = snd_soc_read(codec, WM8994_CLOCKING_1);
+	reg = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
 		return -EBUSY;
 
@@ -568,8 +568,8 @@ static int wm8958_put_vss_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_get_vss_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = wm8994->vss_cfg;
 
@@ -579,14 +579,14 @@ static int wm8958_get_vss_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_put_vss_hpf_enum(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.enumerated.item[0];
 	int reg;
 
 	/* Don't allow on the fly reconfiguration */
-	reg = snd_soc_read(codec, WM8994_CLOCKING_1);
+	reg = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
 		return -EBUSY;
 
@@ -601,8 +601,8 @@ static int wm8958_put_vss_hpf_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_get_vss_hpf_enum(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = wm8994->vss_hpf_cfg;
 
@@ -623,8 +623,8 @@ static int wm8958_vss_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int vss = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = wm8994->vss_ena[vss];
 
@@ -635,8 +635,8 @@ static int wm8958_vss_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int vss = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	if (wm8994->vss_ena[vss] == ucontrol->value.integer.value[0])
 		return 0;
@@ -648,7 +648,7 @@ static int wm8958_vss_put(struct snd_kcontrol *kcontrol,
 		return -ENODEV;
 
 	if (wm8958_dsp2_busy(wm8994, vss)) {
-		dev_dbg(codec->dev, "DSP2 active on %d already\n", vss);
+		dev_dbg(component->dev, "DSP2 active on %d already\n", vss);
 		return -EBUSY;
 	}
 
@@ -657,7 +657,7 @@ static int wm8958_vss_put(struct snd_kcontrol *kcontrol,
 
 	wm8994->vss_ena[vss] = ucontrol->value.integer.value[0];
 
-	wm8958_dsp_apply(codec, vss, wm8994->vss_ena[vss]);
+	wm8958_dsp_apply(component, vss, wm8994->vss_ena[vss]);
 
 	return 0;
 }
@@ -684,8 +684,8 @@ static int wm8958_hpf_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int hpf = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	if (hpf < 3)
 		ucontrol->value.integer.value[0] = wm8994->hpf1_ena[hpf % 3];
@@ -699,8 +699,8 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int hpf = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	if (hpf < 3) {
 		if (wm8994->hpf1_ena[hpf % 3] ==
@@ -719,7 +719,7 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 		return -ENODEV;
 
 	if (wm8958_dsp2_busy(wm8994, hpf % 3)) {
-		dev_dbg(codec->dev, "DSP2 active on %d already\n", hpf);
+		dev_dbg(component->dev, "DSP2 active on %d already\n", hpf);
 		return -EBUSY;
 	}
 
@@ -731,7 +731,7 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 	else
 		wm8994->hpf2_ena[hpf % 3] = ucontrol->value.integer.value[0];
 
-	wm8958_dsp_apply(codec, hpf % 3, ucontrol->value.integer.value[0]);
+	wm8958_dsp_apply(component, hpf % 3, ucontrol->value.integer.value[0]);
 
 	return 0;
 }
@@ -746,14 +746,14 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 static int wm8958_put_enh_eq_enum(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.enumerated.item[0];
 	int reg;
 
 	/* Don't allow on the fly reconfiguration */
-	reg = snd_soc_read(codec, WM8994_CLOCKING_1);
+	reg = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
 		return -EBUSY;
 
@@ -768,8 +768,8 @@ static int wm8958_put_enh_eq_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_get_enh_eq_enum(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = wm8994->enh_eq_cfg;
 
@@ -790,8 +790,8 @@ static int wm8958_enh_eq_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int eq = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = wm8994->enh_eq_ena[eq];
 
@@ -802,8 +802,8 @@ static int wm8958_enh_eq_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int eq = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	if (wm8994->enh_eq_ena[eq] == ucontrol->value.integer.value[0])
 		return 0;
@@ -815,7 +815,7 @@ static int wm8958_enh_eq_put(struct snd_kcontrol *kcontrol,
 		return -ENODEV;
 
 	if (wm8958_dsp2_busy(wm8994, eq)) {
-		dev_dbg(codec->dev, "DSP2 active on %d already\n", eq);
+		dev_dbg(component->dev, "DSP2 active on %d already\n", eq);
 		return -EBUSY;
 	}
 
@@ -825,7 +825,7 @@ static int wm8958_enh_eq_put(struct snd_kcontrol *kcontrol,
 
 	wm8994->enh_eq_ena[eq] = ucontrol->value.integer.value[0];
 
-	wm8958_dsp_apply(codec, eq, ucontrol->value.integer.value[0]);
+	wm8958_dsp_apply(component, eq, ucontrol->value.integer.value[0]);
 
 	return 0;
 }
@@ -863,10 +863,10 @@ WM8958_ENH_EQ_SWITCH("AIF2DAC Enhanced EQ Switch", 2),
 
 static void wm8958_enh_eq_loaded(const struct firmware *fw, void *context)
 {
-	struct snd_soc_codec *codec = context;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = context;
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
-	if (fw && (wm8958_dsp2_fw(codec, "ENH_EQ", fw, true) == 0)) {
+	if (fw && (wm8958_dsp2_fw(component, "ENH_EQ", fw, true) == 0)) {
 		mutex_lock(&wm8994->fw_lock);
 		wm8994->enh_eq = fw;
 		mutex_unlock(&wm8994->fw_lock);
@@ -875,10 +875,10 @@ static void wm8958_enh_eq_loaded(const struct firmware *fw, void *context)
 
 static void wm8958_mbc_vss_loaded(const struct firmware *fw, void *context)
 {
-	struct snd_soc_codec *codec = context;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = context;
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
-	if (fw && (wm8958_dsp2_fw(codec, "MBC+VSS", fw, true) == 0)) {
+	if (fw && (wm8958_dsp2_fw(component, "MBC+VSS", fw, true) == 0)) {
 		mutex_lock(&wm8994->fw_lock);
 		wm8994->mbc_vss = fw;
 		mutex_unlock(&wm8994->fw_lock);
@@ -887,43 +887,43 @@ static void wm8958_mbc_vss_loaded(const struct firmware *fw, void *context)
 
 static void wm8958_mbc_loaded(const struct firmware *fw, void *context)
 {
-	struct snd_soc_codec *codec = context;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = context;
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
-	if (fw && (wm8958_dsp2_fw(codec, "MBC", fw, true) == 0)) {
+	if (fw && (wm8958_dsp2_fw(component, "MBC", fw, true) == 0)) {
 		mutex_lock(&wm8994->fw_lock);
 		wm8994->mbc = fw;
 		mutex_unlock(&wm8994->fw_lock);
 	}
 }
 
-void wm8958_dsp2_init(struct snd_soc_codec *codec)
+void wm8958_dsp2_init(struct snd_soc_component *component)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int ret, i;
 
 	wm8994->dsp_active = -1;
 
-	snd_soc_add_codec_controls(codec, wm8958_mbc_snd_controls,
+	snd_soc_add_component_controls(component, wm8958_mbc_snd_controls,
 			     ARRAY_SIZE(wm8958_mbc_snd_controls));
-	snd_soc_add_codec_controls(codec, wm8958_vss_snd_controls,
+	snd_soc_add_component_controls(component, wm8958_vss_snd_controls,
 			     ARRAY_SIZE(wm8958_vss_snd_controls));
-	snd_soc_add_codec_controls(codec, wm8958_enh_eq_snd_controls,
+	snd_soc_add_component_controls(component, wm8958_enh_eq_snd_controls,
 			     ARRAY_SIZE(wm8958_enh_eq_snd_controls));
 
 
 	/* We don't *require* firmware and don't want to delay boot */
 	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
-				"wm8958_mbc.wfw", codec->dev, GFP_KERNEL,
-				codec, wm8958_mbc_loaded);
+				"wm8958_mbc.wfw", component->dev, GFP_KERNEL,
+				component, wm8958_mbc_loaded);
 	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
-				"wm8958_mbc_vss.wfw", codec->dev, GFP_KERNEL,
-				codec, wm8958_mbc_vss_loaded);
+				"wm8958_mbc_vss.wfw", component->dev, GFP_KERNEL,
+				component, wm8958_mbc_vss_loaded);
 	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
-				"wm8958_enh_eq.wfw", codec->dev, GFP_KERNEL,
-				codec, wm8958_enh_eq_loaded);
+				"wm8958_enh_eq.wfw", component->dev, GFP_KERNEL,
+				component, wm8958_enh_eq_loaded);
 
 	if (pdata->num_mbc_cfgs) {
 		struct snd_kcontrol_new control[] = {
@@ -943,10 +943,10 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->mbc_enum.items = pdata->num_mbc_cfgs;
 		wm8994->mbc_enum.texts = wm8994->mbc_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+		ret = snd_soc_add_component_controls(wm8994->hubs.component,
 						 control, 1);
 		if (ret != 0)
-			dev_err(wm8994->hubs.codec->dev,
+			dev_err(wm8994->hubs.component->dev,
 				"Failed to add MBC mode controls: %d\n", ret);
 	}
 
@@ -968,10 +968,10 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->vss_enum.items = pdata->num_vss_cfgs;
 		wm8994->vss_enum.texts = wm8994->vss_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+		ret = snd_soc_add_component_controls(wm8994->hubs.component,
 						 control, 1);
 		if (ret != 0)
-			dev_err(wm8994->hubs.codec->dev,
+			dev_err(wm8994->hubs.component->dev,
 				"Failed to add VSS mode controls: %d\n", ret);
 	}
 
@@ -994,10 +994,10 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->vss_hpf_enum.items = pdata->num_vss_hpf_cfgs;
 		wm8994->vss_hpf_enum.texts = wm8994->vss_hpf_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+		ret = snd_soc_add_component_controls(wm8994->hubs.component,
 						 control, 1);
 		if (ret != 0)
-			dev_err(wm8994->hubs.codec->dev,
+			dev_err(wm8994->hubs.component->dev,
 				"Failed to add VSS HPFmode controls: %d\n",
 				ret);
 	}
@@ -1021,10 +1021,10 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 		wm8994->enh_eq_enum.items = pdata->num_enh_eq_cfgs;
 		wm8994->enh_eq_enum.texts = wm8994->enh_eq_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+		ret = snd_soc_add_component_controls(wm8994->hubs.component,
 						 control, 1);
 		if (ret != 0)
-			dev_err(wm8994->hubs.codec->dev,
+			dev_err(wm8994->hubs.component->dev,
 				"Failed to add enhanced EQ controls: %d\n",
 				ret);
 	}
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 830ffd80de4a..2c61655c44ea 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -466,11 +466,11 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	return 0;
 }
 
-static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
+static int _wm8993_set_fll(struct snd_soc_component *component, int fll_id, int source,
 			  unsigned int Fref, unsigned int Fout)
 {
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = to_i2c_client(codec->dev);
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
 	u16 reg1, reg4, reg5;
 	struct _fll_div fll_div;
 	unsigned int timeout;
@@ -482,13 +482,13 @@ static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	/* Disable the FLL */
 	if (Fout == 0) {
-		dev_dbg(codec->dev, "FLL disabled\n");
+		dev_dbg(component->dev, "FLL disabled\n");
 		wm8993->fll_fref = 0;
 		wm8993->fll_fout = 0;
 
-		reg1 = snd_soc_read(codec, WM8993_FLL_CONTROL_1);
+		reg1 = snd_soc_component_read32(component, WM8993_FLL_CONTROL_1);
 		reg1 &= ~WM8993_FLL_ENA;
-		snd_soc_write(codec, WM8993_FLL_CONTROL_1, reg1);
+		snd_soc_component_write(component, WM8993_FLL_CONTROL_1, reg1);
 
 		return 0;
 	}
@@ -497,7 +497,7 @@ static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	if (ret != 0)
 		return ret;
 
-	reg5 = snd_soc_read(codec, WM8993_FLL_CONTROL_5);
+	reg5 = snd_soc_component_read32(component, WM8993_FLL_CONTROL_5);
 	reg5 &= ~WM8993_FLL_CLK_SRC_MASK;
 
 	switch (fll_id) {
@@ -513,36 +513,36 @@ static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 		break;
 
 	default:
-		dev_err(codec->dev, "Unknown FLL ID %d\n", fll_id);
+		dev_err(component->dev, "Unknown FLL ID %d\n", fll_id);
 		return -EINVAL;
 	}
 
 	/* Any FLL configuration change requires that the FLL be
 	 * disabled first. */
-	reg1 = snd_soc_read(codec, WM8993_FLL_CONTROL_1);
+	reg1 = snd_soc_component_read32(component, WM8993_FLL_CONTROL_1);
 	reg1 &= ~WM8993_FLL_ENA;
-	snd_soc_write(codec, WM8993_FLL_CONTROL_1, reg1);
+	snd_soc_component_write(component, WM8993_FLL_CONTROL_1, reg1);
 
 	/* Apply the configuration */
 	if (fll_div.k)
 		reg1 |= WM8993_FLL_FRAC_MASK;
 	else
 		reg1 &= ~WM8993_FLL_FRAC_MASK;
-	snd_soc_write(codec, WM8993_FLL_CONTROL_1, reg1);
+	snd_soc_component_write(component, WM8993_FLL_CONTROL_1, reg1);
 
-	snd_soc_write(codec, WM8993_FLL_CONTROL_2,
+	snd_soc_component_write(component, WM8993_FLL_CONTROL_2,
 		      (fll_div.fll_outdiv << WM8993_FLL_OUTDIV_SHIFT) |
 		      (fll_div.fll_fratio << WM8993_FLL_FRATIO_SHIFT));
-	snd_soc_write(codec, WM8993_FLL_CONTROL_3, fll_div.k);
+	snd_soc_component_write(component, WM8993_FLL_CONTROL_3, fll_div.k);
 
-	reg4 = snd_soc_read(codec, WM8993_FLL_CONTROL_4);
+	reg4 = snd_soc_component_read32(component, WM8993_FLL_CONTROL_4);
 	reg4 &= ~WM8993_FLL_N_MASK;
 	reg4 |= fll_div.n << WM8993_FLL_N_SHIFT;
-	snd_soc_write(codec, WM8993_FLL_CONTROL_4, reg4);
+	snd_soc_component_write(component, WM8993_FLL_CONTROL_4, reg4);
 
 	reg5 &= ~WM8993_FLL_CLK_REF_DIV_MASK;
 	reg5 |= fll_div.fll_clk_ref_div << WM8993_FLL_CLK_REF_DIV_SHIFT;
-	snd_soc_write(codec, WM8993_FLL_CONTROL_5, reg5);
+	snd_soc_component_write(component, WM8993_FLL_CONTROL_5, reg5);
 
 	/* If we've got an interrupt wired up make sure we get it */
 	if (i2c->irq)
@@ -555,13 +555,13 @@ static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	try_wait_for_completion(&wm8993->fll_lock);
 
 	/* Enable the FLL */
-	snd_soc_write(codec, WM8993_FLL_CONTROL_1, reg1 | WM8993_FLL_ENA);
+	snd_soc_component_write(component, WM8993_FLL_CONTROL_1, reg1 | WM8993_FLL_ENA);
 
 	timeout = wait_for_completion_timeout(&wm8993->fll_lock, timeout);
 	if (i2c->irq && !timeout)
-		dev_warn(codec->dev, "Timed out waiting for FLL\n");
+		dev_warn(component->dev, "Timed out waiting for FLL\n");
 
-	dev_dbg(codec->dev, "FLL enabled at %dHz->%dHz\n", Fref, Fout);
+	dev_dbg(component->dev, "FLL enabled at %dHz->%dHz\n", Fref, Fout);
 
 	wm8993->fll_fref = Fref;
 	wm8993->fll_fout = Fout;
@@ -573,20 +573,20 @@ static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 static int wm8993_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 			  unsigned int Fref, unsigned int Fout)
 {
-	return _wm8993_set_fll(dai->codec, fll_id, source, Fref, Fout);
+	return _wm8993_set_fll(dai->component, fll_id, source, Fref, Fout);
 }
 
-static int configure_clock(struct snd_soc_codec *codec)
+static int configure_clock(struct snd_soc_component *component)
 {
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
 	unsigned int reg;
 
 	/* This should be done on init() for bypass paths */
 	switch (wm8993->sysclk_source) {
 	case WM8993_SYSCLK_MCLK:
-		dev_dbg(codec->dev, "Using %dHz MCLK\n", wm8993->mclk_rate);
+		dev_dbg(component->dev, "Using %dHz MCLK\n", wm8993->mclk_rate);
 
-		reg = snd_soc_read(codec, WM8993_CLOCKING_2);
+		reg = snd_soc_component_read32(component, WM8993_CLOCKING_2);
 		reg &= ~(WM8993_MCLK_DIV | WM8993_SYSCLK_SRC);
 		if (wm8993->mclk_rate > 13500000) {
 			reg |= WM8993_MCLK_DIV;
@@ -595,14 +595,14 @@ static int configure_clock(struct snd_soc_codec *codec)
 			reg &= ~WM8993_MCLK_DIV;
 			wm8993->sysclk_rate = wm8993->mclk_rate;
 		}
-		snd_soc_write(codec, WM8993_CLOCKING_2, reg);
+		snd_soc_component_write(component, WM8993_CLOCKING_2, reg);
 		break;
 
 	case WM8993_SYSCLK_FLL:
-		dev_dbg(codec->dev, "Using %dHz FLL clock\n",
+		dev_dbg(component->dev, "Using %dHz FLL clock\n",
 			wm8993->fll_fout);
 
-		reg = snd_soc_read(codec, WM8993_CLOCKING_2);
+		reg = snd_soc_component_read32(component, WM8993_CLOCKING_2);
 		reg |= WM8993_SYSCLK_SRC;
 		if (wm8993->fll_fout > 13500000) {
 			reg |= WM8993_MCLK_DIV;
@@ -611,15 +611,15 @@ static int configure_clock(struct snd_soc_codec *codec)
 			reg &= ~WM8993_MCLK_DIV;
 			wm8993->sysclk_rate = wm8993->fll_fout;
 		}
-		snd_soc_write(codec, WM8993_CLOCKING_2, reg);
+		snd_soc_component_write(component, WM8993_CLOCKING_2, reg);
 		break;
 
 	default:
-		dev_err(codec->dev, "System clock not configured\n");
+		dev_err(component->dev, "System clock not configured\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(codec->dev, "CLK_SYS is %dHz\n", wm8993->sysclk_rate);
+	dev_dbg(component->dev, "CLK_SYS is %dHz\n", wm8993->sysclk_rate);
 
 	return 0;
 }
@@ -809,11 +809,11 @@ SOC_SINGLE_TLV("EQ5 Volume", WM8993_EQ6, 0, 24, 0, eq_tlv),
 static int clk_sys_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		return configure_clock(codec);
+		return configure_clock(component);
 
 	case SND_SOC_DAPM_POST_PMD:
 		break;
@@ -972,26 +972,26 @@ static const struct snd_soc_dapm_route routes[] = {
 	{ "Right Headphone Mux", "DAC", "DACR" },
 };
 
-static int wm8993_set_bias_level(struct snd_soc_codec *codec,
+static int wm8993_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	wm_hubs_set_bias_level(codec, level);
+	wm_hubs_set_bias_level(component, level);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID=2*40k */
-		snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_1,
 				    WM8993_VMID_SEL_MASK, 0x2);
-		snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_2,
+		snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_2,
 				    WM8993_TSHUT_ENA, WM8993_TSHUT_ENA);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8993->supplies),
 						    wm8993->supplies);
 			if (ret != 0)
@@ -1000,10 +1000,10 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 			regcache_cache_only(wm8993->regmap, false);
 			regcache_sync(wm8993->regmap);
 
-			wm_hubs_vmid_ena(codec);
+			wm_hubs_vmid_ena(component);
 
 			/* Bring up VMID with fast soft start */
-			snd_soc_update_bits(codec, WM8993_ANTIPOP2,
+			snd_soc_component_update_bits(component, WM8993_ANTIPOP2,
 					    WM8993_STARTUP_BIAS_ENA |
 					    WM8993_VMID_BUF_ENA |
 					    WM8993_VMID_RAMP_MASK |
@@ -1017,40 +1017,40 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 			 * need the VMID buffer */
 			if (!wm8993->pdata.lineout1_diff ||
 			    !wm8993->pdata.lineout2_diff)
-				snd_soc_update_bits(codec, WM8993_ANTIPOP1,
+				snd_soc_component_update_bits(component, WM8993_ANTIPOP1,
 						 WM8993_LINEOUT_VMID_BUF_ENA,
 						 WM8993_LINEOUT_VMID_BUF_ENA);
 
 			/* VMID=2*40k */
-			snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_1,
+			snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_1,
 					    WM8993_VMID_SEL_MASK |
 					    WM8993_BIAS_ENA,
 					    WM8993_BIAS_ENA | 0x2);
 			msleep(32);
 
 			/* Switch to normal bias */
-			snd_soc_update_bits(codec, WM8993_ANTIPOP2,
+			snd_soc_component_update_bits(component, WM8993_ANTIPOP2,
 					    WM8993_BIAS_SRC |
 					    WM8993_STARTUP_BIAS_ENA, 0);
 		}
 
 		/* VMID=2*240k */
-		snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_1,
 				    WM8993_VMID_SEL_MASK, 0x4);
 
-		snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_2,
+		snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_2,
 				    WM8993_TSHUT_ENA, 0);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, WM8993_ANTIPOP1,
+		snd_soc_component_update_bits(component, WM8993_ANTIPOP1,
 				    WM8993_LINEOUT_VMID_BUF_ENA, 0);
 
-		snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_1,
 				    WM8993_VMID_SEL_MASK | WM8993_BIAS_ENA,
 				    0);
 
-		snd_soc_update_bits(codec, WM8993_ANTIPOP2,
+		snd_soc_component_update_bits(component, WM8993_ANTIPOP2,
 				    WM8993_STARTUP_BIAS_ENA |
 				    WM8993_VMID_BUF_ENA |
 				    WM8993_VMID_RAMP_MASK |
@@ -1070,8 +1070,8 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 static int wm8993_set_sysclk(struct snd_soc_dai *codec_dai,
 			     int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case WM8993_SYSCLK_MCLK:
@@ -1091,10 +1091,10 @@ static int wm8993_set_sysclk(struct snd_soc_dai *codec_dai,
 static int wm8993_set_dai_fmt(struct snd_soc_dai *dai,
 			      unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
-	unsigned int aif1 = snd_soc_read(codec, WM8993_AUDIO_INTERFACE_1);
-	unsigned int aif4 = snd_soc_read(codec, WM8993_AUDIO_INTERFACE_4);
+	struct snd_soc_component *component = dai->component;
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
+	unsigned int aif1 = snd_soc_component_read32(component, WM8993_AUDIO_INTERFACE_1);
+	unsigned int aif4 = snd_soc_component_read32(component, WM8993_AUDIO_INTERFACE_4);
 
 	aif1 &= ~(WM8993_BCLK_DIR | WM8993_AIF_BCLK_INV |
 		  WM8993_AIF_LRCLK_INV | WM8993_AIF_FMT_MASK);
@@ -1178,8 +1178,8 @@ static int wm8993_set_dai_fmt(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8993_AUDIO_INTERFACE_1, aif1);
-	snd_soc_write(codec, WM8993_AUDIO_INTERFACE_4, aif4);
+	snd_soc_component_write(component, WM8993_AUDIO_INTERFACE_1, aif1);
+	snd_soc_component_write(component, WM8993_AUDIO_INTERFACE_4, aif4);
 
 	return 0;
 }
@@ -1188,28 +1188,28 @@ static int wm8993_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
 	int ret, i, best, best_val, cur_val;
 	unsigned int clocking1, clocking3, aif1, aif4;
 
-	clocking1 = snd_soc_read(codec, WM8993_CLOCKING_1);
+	clocking1 = snd_soc_component_read32(component, WM8993_CLOCKING_1);
 	clocking1 &= ~WM8993_BCLK_DIV_MASK;
 
-	clocking3 = snd_soc_read(codec, WM8993_CLOCKING_3);
+	clocking3 = snd_soc_component_read32(component, WM8993_CLOCKING_3);
 	clocking3 &= ~(WM8993_CLK_SYS_RATE_MASK | WM8993_SAMPLE_RATE_MASK);
 
-	aif1 = snd_soc_read(codec, WM8993_AUDIO_INTERFACE_1);
+	aif1 = snd_soc_component_read32(component, WM8993_AUDIO_INTERFACE_1);
 	aif1 &= ~WM8993_AIF_WL_MASK;
 
-	aif4 = snd_soc_read(codec, WM8993_AUDIO_INTERFACE_4);
+	aif4 = snd_soc_component_read32(component, WM8993_AUDIO_INTERFACE_4);
 	aif4 &= ~WM8993_LRCLK_RATE_MASK;
 
 	/* What BCLK do we need? */
 	wm8993->fs = params_rate(params);
 	wm8993->bclk = 2 * wm8993->fs;
 	if (wm8993->tdm_slots) {
-		dev_dbg(codec->dev, "Configuring for %d %d bit TDM slots\n",
+		dev_dbg(component->dev, "Configuring for %d %d bit TDM slots\n",
 			wm8993->tdm_slots, wm8993->tdm_width);
 		wm8993->bclk *= wm8993->tdm_width * wm8993->tdm_slots;
 	} else {
@@ -1234,9 +1234,9 @@ static int wm8993_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	dev_dbg(codec->dev, "Target BCLK is %dHz\n", wm8993->bclk);
+	dev_dbg(component->dev, "Target BCLK is %dHz\n", wm8993->bclk);
 
-	ret = configure_clock(codec);
+	ret = configure_clock(component);
 	if (ret != 0)
 		return ret;
 
@@ -1252,7 +1252,7 @@ static int wm8993_hw_params(struct snd_pcm_substream *substream,
 			best_val = cur_val;
 		}
 	}
-	dev_dbg(codec->dev, "Selected CLK_SYS_RATIO of %d\n",
+	dev_dbg(component->dev, "Selected CLK_SYS_RATIO of %d\n",
 		clk_sys_rates[best].ratio);
 	clocking3 |= (clk_sys_rates[best].clk_sys_rate
 		      << WM8993_CLK_SYS_RATE_SHIFT);
@@ -1268,7 +1268,7 @@ static int wm8993_hw_params(struct snd_pcm_substream *substream,
 			best_val = cur_val;
 		}
 	}
-	dev_dbg(codec->dev, "Selected SAMPLE_RATE of %dHz\n",
+	dev_dbg(component->dev, "Selected SAMPLE_RATE of %dHz\n",
 		sample_rates[best].rate);
 	clocking3 |= (sample_rates[best].sample_rate
 		      << WM8993_SAMPLE_RATE_SHIFT);
@@ -1287,22 +1287,22 @@ static int wm8993_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 	wm8993->bclk = (wm8993->sysclk_rate * 10) / bclk_divs[best].div;
-	dev_dbg(codec->dev, "Selected BCLK_DIV of %d for %dHz BCLK\n",
+	dev_dbg(component->dev, "Selected BCLK_DIV of %d for %dHz BCLK\n",
 		bclk_divs[best].div, wm8993->bclk);
 	clocking1 |= bclk_divs[best].bclk_div << WM8993_BCLK_DIV_SHIFT;
 
 	/* LRCLK is a simple fraction of BCLK */
-	dev_dbg(codec->dev, "LRCLK_RATE is %d\n", wm8993->bclk / wm8993->fs);
+	dev_dbg(component->dev, "LRCLK_RATE is %d\n", wm8993->bclk / wm8993->fs);
 	aif4 |= wm8993->bclk / wm8993->fs;
 
-	snd_soc_write(codec, WM8993_CLOCKING_1, clocking1);
-	snd_soc_write(codec, WM8993_CLOCKING_3, clocking3);
-	snd_soc_write(codec, WM8993_AUDIO_INTERFACE_1, aif1);
-	snd_soc_write(codec, WM8993_AUDIO_INTERFACE_4, aif4);
+	snd_soc_component_write(component, WM8993_CLOCKING_1, clocking1);
+	snd_soc_component_write(component, WM8993_CLOCKING_3, clocking3);
+	snd_soc_component_write(component, WM8993_AUDIO_INTERFACE_1, aif1);
+	snd_soc_component_write(component, WM8993_AUDIO_INTERFACE_4, aif4);
 
 	/* ReTune Mobile? */
 	if (wm8993->pdata.num_retune_configs) {
-		u16 eq1 = snd_soc_read(codec, WM8993_EQ1);
+		u16 eq1 = snd_soc_component_read32(component, WM8993_EQ1);
 		struct wm8993_retune_mobile_setting *s;
 
 		best = 0;
@@ -1318,16 +1318,16 @@ static int wm8993_hw_params(struct snd_pcm_substream *substream,
 		}
 		s = &wm8993->pdata.retune_configs[best];
 
-		dev_dbg(codec->dev, "ReTune Mobile %s tuned for %dHz\n",
+		dev_dbg(component->dev, "ReTune Mobile %s tuned for %dHz\n",
 			s->name, s->rate);
 
 		/* Disable EQ while we reconfigure */
-		snd_soc_update_bits(codec, WM8993_EQ1, WM8993_EQ_ENA, 0);
+		snd_soc_component_update_bits(component, WM8993_EQ1, WM8993_EQ_ENA, 0);
 
 		for (i = 1; i < ARRAY_SIZE(s->config); i++)
-			snd_soc_write(codec, WM8993_EQ1 + i, s->config[i]);
+			snd_soc_component_write(component, WM8993_EQ1 + i, s->config[i]);
 
-		snd_soc_update_bits(codec, WM8993_EQ1, WM8993_EQ_ENA, eq1);
+		snd_soc_component_update_bits(component, WM8993_EQ1, WM8993_EQ_ENA, eq1);
 	}
 
 	return 0;
@@ -1335,17 +1335,17 @@ static int wm8993_hw_params(struct snd_pcm_substream *substream,
 
 static int wm8993_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, WM8993_DAC_CTRL);
+	reg = snd_soc_component_read32(component, WM8993_DAC_CTRL);
 
 	if (mute)
 		reg |= WM8993_DAC_MUTE;
 	else
 		reg &= ~WM8993_DAC_MUTE;
 
-	snd_soc_write(codec, WM8993_DAC_CTRL, reg);
+	snd_soc_component_write(component, WM8993_DAC_CTRL, reg);
 
 	return 0;
 }
@@ -1353,8 +1353,8 @@ static int wm8993_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 static int wm8993_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots, int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
 	int aif1 = 0;
 	int aif2 = 0;
 
@@ -1396,9 +1396,9 @@ static int wm8993_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	wm8993->tdm_width = slot_width;
 	wm8993->tdm_slots = slots / 2;
 
-	snd_soc_update_bits(codec, WM8993_AUDIO_INTERFACE_1,
+	snd_soc_component_update_bits(component, WM8993_AUDIO_INTERFACE_1,
 			    WM8993_AIFADC_TDM | WM8993_AIFADC_TDM_CHAN, aif1);
-	snd_soc_update_bits(codec, WM8993_AUDIO_INTERFACE_2,
+	snd_soc_component_update_bits(component, WM8993_AUDIO_INTERFACE_2,
 			    WM8993_AIFDAC_TDM | WM8993_AIFDAC_TDM_CHAN, aif2);
 
 	return 0;
@@ -1481,10 +1481,10 @@ static struct snd_soc_dai_driver wm8993_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8993_probe(struct snd_soc_codec *codec)
+static int wm8993_probe(struct snd_soc_component *component)
 {
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	wm8993->hubs_data.hp_startup_mode = 1;
 	wm8993->hubs_data.dcs_codes_l = -2;
@@ -1492,20 +1492,20 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 	wm8993->hubs_data.series_startup = 1;
 
 	/* Latch volume update bits and default ZC on */
-	snd_soc_update_bits(codec, WM8993_RIGHT_DAC_DIGITAL_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_RIGHT_DAC_DIGITAL_VOLUME,
 			    WM8993_DAC_VU, WM8993_DAC_VU);
-	snd_soc_update_bits(codec, WM8993_RIGHT_ADC_DIGITAL_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_RIGHT_ADC_DIGITAL_VOLUME,
 			    WM8993_ADC_VU, WM8993_ADC_VU);
 
 	/* Manualy manage the HPOUT sequencing for independent stereo
 	 * control. */
-	snd_soc_update_bits(codec, WM8993_ANALOGUE_HP_0,
+	snd_soc_component_update_bits(component, WM8993_ANALOGUE_HP_0,
 			    WM8993_HPOUT1_AUTO_PU, 0);
 
 	/* Use automatic clock configuration */
-	snd_soc_update_bits(codec, WM8993_CLOCKING_4, WM8993_SR_MODE, 0);
+	snd_soc_component_update_bits(component, WM8993_CLOCKING_4, WM8993_SR_MODE, 0);
 
-	wm_hubs_handle_analogue_pdata(codec, wm8993->pdata.lineout1_diff,
+	wm_hubs_handle_analogue_pdata(component, wm8993->pdata.lineout1_diff,
 				      wm8993->pdata.lineout2_diff,
 				      wm8993->pdata.lineout1fb,
 				      wm8993->pdata.lineout2fb,
@@ -1516,22 +1516,22 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 				      wm8993->pdata.micbias1_lvl,
 				      wm8993->pdata.micbias2_lvl);
 
-	snd_soc_add_codec_controls(codec, wm8993_snd_controls,
+	snd_soc_add_component_controls(component, wm8993_snd_controls,
 			     ARRAY_SIZE(wm8993_snd_controls));
 	if (wm8993->pdata.num_retune_configs != 0) {
-		dev_dbg(codec->dev, "Using ReTune Mobile\n");
+		dev_dbg(component->dev, "Using ReTune Mobile\n");
 	} else {
-		dev_dbg(codec->dev, "No ReTune Mobile, using normal EQ\n");
-		snd_soc_add_codec_controls(codec, wm8993_eq_controls,
+		dev_dbg(component->dev, "No ReTune Mobile, using normal EQ\n");
+		snd_soc_add_component_controls(component, wm8993_eq_controls,
 				     ARRAY_SIZE(wm8993_eq_controls));
 	}
 
 	snd_soc_dapm_new_controls(dapm, wm8993_dapm_widgets,
 				  ARRAY_SIZE(wm8993_dapm_widgets));
-	wm_hubs_add_analogue_controls(codec);
+	wm_hubs_add_analogue_controls(component);
 
 	snd_soc_dapm_add_routes(dapm, routes, ARRAY_SIZE(routes));
-	wm_hubs_add_analogue_routes(codec, wm8993->pdata.lineout1_diff,
+	wm_hubs_add_analogue_routes(component, wm8993->pdata.lineout1_diff,
 				    wm8993->pdata.lineout2_diff);
 
 	/* If the line outputs are differential then we aren't presenting
@@ -1545,34 +1545,34 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int wm8993_suspend(struct snd_soc_codec *codec)
+static int wm8993_suspend(struct snd_soc_component *component)
 {
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
 	int fll_fout = wm8993->fll_fout;
 	int fll_fref  = wm8993->fll_fref;
 	int ret;
 
 	/* Stop the FLL in an orderly fashion */
-	ret = _wm8993_set_fll(codec, 0, 0, 0, 0);
+	ret = _wm8993_set_fll(component, 0, 0, 0, 0);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to stop FLL\n");
+		dev_err(component->dev, "Failed to stop FLL\n");
 		return ret;
 	}
 
 	wm8993->fll_fout = fll_fout;
 	wm8993->fll_fref = fll_fref;
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8993_resume(struct snd_soc_codec *codec)
+static int wm8993_resume(struct snd_soc_component *component)
 {
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	struct wm8993_priv *wm8993 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 
 	/* Restart the FLL? */
 	if (wm8993->fll_fout) {
@@ -1582,10 +1582,10 @@ static int wm8993_resume(struct snd_soc_codec *codec)
 		wm8993->fll_fref = 0;
 		wm8993->fll_fout = 0;
 
-		ret = _wm8993_set_fll(codec, 0, wm8993->fll_src,
+		ret = _wm8993_set_fll(component, 0, wm8993->fll_src,
 				     fll_fref, fll_fout);
 		if (ret != 0)
-			dev_err(codec->dev, "Failed to restart FLL\n");
+			dev_err(component->dev, "Failed to restart FLL\n");
 	}
 
 	return 0;
@@ -1615,11 +1615,15 @@ static const struct regmap_config wm8993_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8993_reg_defaults),
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8993 = {
-	.probe = 	wm8993_probe,
-	.suspend =	wm8993_suspend,
-	.resume =	wm8993_resume,
-	.set_bias_level = wm8993_set_bias_level,
+static const struct snd_soc_component_driver soc_component_dev_wm8993 = {
+	.probe			= wm8993_probe,
+	.suspend		= wm8993_suspend,
+	.resume			= wm8993_resume,
+	.set_bias_level		= wm8993_set_bias_level,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm8993_i2c_probe(struct i2c_client *i2c,
@@ -1705,8 +1709,8 @@ static int wm8993_i2c_probe(struct i2c_client *i2c,
 
 	regcache_cache_only(wm8993->regmap, true);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8993, &wm8993_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8993, &wm8993_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
 		goto err_irq;
@@ -1726,7 +1730,6 @@ static int wm8993_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm8993_priv *wm8993 = i2c_get_clientdata(i2c);
 
-	snd_soc_unregister_codec(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm8993);
 	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 21ffd6403173..6e9e32a07259 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -106,9 +106,9 @@ static const struct wm8958_micd_rate jackdet_rates[] = {
 	{ 44100 * 256, false, 7, 8 },
 };
 
-static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
+static void wm8958_micd_set_rate(struct snd_soc_component *component)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int best, i, sysclk, val;
 	bool idle;
@@ -117,7 +117,7 @@ static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
 
 	idle = !wm8994->jack_mic;
 
-	sysclk = snd_soc_read(codec, WM8994_CLOCKING_1);
+	sysclk = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 	if (sysclk & WM8994_SYSCLK_SRC)
 		sysclk = wm8994->aifclk[1];
 	else
@@ -148,18 +148,18 @@ static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
 	val = rates[best].start << WM8958_MICD_BIAS_STARTTIME_SHIFT
 		| rates[best].rate << WM8958_MICD_RATE_SHIFT;
 
-	dev_dbg(codec->dev, "MICD rate %d,%d for %dHz %s\n",
+	dev_dbg(component->dev, "MICD rate %d,%d for %dHz %s\n",
 		rates[best].start, rates[best].rate, sysclk,
 		idle ? "idle" : "active");
 
-	snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+	snd_soc_component_update_bits(component, WM8958_MIC_DETECT_1,
 			    WM8958_MICD_BIAS_STARTTIME_MASK |
 			    WM8958_MICD_RATE_MASK, val);
 }
 
-static int configure_aif_clock(struct snd_soc_codec *codec, int aif)
+static int configure_aif_clock(struct snd_soc_component *component, int aif)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	int rate;
 	int reg1 = 0;
 	int offset;
@@ -197,28 +197,28 @@ static int configure_aif_clock(struct snd_soc_codec *codec, int aif)
 		rate /= 2;
 		reg1 |= WM8994_AIF1CLK_DIV;
 
-		dev_dbg(codec->dev, "Dividing AIF%d clock to %dHz\n",
+		dev_dbg(component->dev, "Dividing AIF%d clock to %dHz\n",
 			aif + 1, rate);
 	}
 
 	wm8994->aifclk[aif] = rate;
 
-	snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1 + offset,
+	snd_soc_component_update_bits(component, WM8994_AIF1_CLOCKING_1 + offset,
 			    WM8994_AIF1CLK_SRC_MASK | WM8994_AIF1CLK_DIV,
 			    reg1);
 
 	return 0;
 }
 
-static int configure_clock(struct snd_soc_codec *codec)
+static int configure_clock(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	int change, new;
 
 	/* Bring up the AIF clocks first */
-	configure_aif_clock(codec, 0);
-	configure_aif_clock(codec, 1);
+	configure_aif_clock(component, 0);
+	configure_aif_clock(component, 1);
 
 	/* Then switch CLK_SYS over to the higher of them; a change
 	 * can only happen as a result of a clocking change which can
@@ -228,7 +228,7 @@ static int configure_clock(struct snd_soc_codec *codec)
 
 	/* If they're equal it doesn't matter which is used */
 	if (wm8994->aifclk[0] == wm8994->aifclk[1]) {
-		wm8958_micd_set_rate(codec);
+		wm8958_micd_set_rate(component);
 		return 0;
 	}
 
@@ -237,12 +237,12 @@ static int configure_clock(struct snd_soc_codec *codec)
 	else
 		new = 0;
 
-	change = snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+	change = snd_soc_component_update_bits(component, WM8994_CLOCKING_1,
 				     WM8994_SYSCLK_SRC, new);
 	if (change)
 		snd_soc_dapm_sync(dapm);
 
-	wm8958_micd_set_rate(codec);
+	wm8958_micd_set_rate(component);
 
 	return 0;
 }
@@ -250,8 +250,8 @@ static int configure_clock(struct snd_soc_codec *codec)
 static int check_clk_sys(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
-	int reg = snd_soc_read(codec, WM8994_CLOCKING_1);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	int reg = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 	const char *clk;
 
 	/* Check what we're currently using for CLK_SYS */
@@ -300,7 +300,7 @@ static int wm8994_put_drc_sw(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	int mask, ret;
 
 	/* Can't enable both ADC and DAC paths simultaneously */
@@ -310,7 +310,7 @@ static int wm8994_put_drc_sw(struct snd_kcontrol *kcontrol,
 	else
 		mask = WM8994_AIF1DAC1_DRC_ENA_MASK;
 
-	ret = snd_soc_read(codec, mc->reg);
+	ret = snd_soc_component_read32(component, mc->reg);
 	if (ret < 0)
 		return ret;
 	if (ret & mask)
@@ -319,9 +319,9 @@ static int wm8994_put_drc_sw(struct snd_kcontrol *kcontrol,
 	return snd_soc_put_volsw(kcontrol, ucontrol);
 }
 
-static void wm8994_set_drc(struct snd_soc_codec *codec, int drc)
+static void wm8994_set_drc(struct snd_soc_component *component, int drc)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int base = wm8994_drc_base[drc];
@@ -329,15 +329,15 @@ static void wm8994_set_drc(struct snd_soc_codec *codec, int drc)
 	int save, i;
 
 	/* Save any enables; the configuration should clear them. */
-	save = snd_soc_read(codec, base);
+	save = snd_soc_component_read32(component, base);
 	save &= WM8994_AIF1DAC1_DRC_ENA | WM8994_AIF1ADC1L_DRC_ENA |
 		WM8994_AIF1ADC1R_DRC_ENA;
 
 	for (i = 0; i < WM8994_DRC_REGS; i++)
-		snd_soc_update_bits(codec, base + i, 0xffff,
+		snd_soc_component_update_bits(component, base + i, 0xffff,
 				    pdata->drc_cfgs[cfg].regs[i]);
 
-	snd_soc_update_bits(codec, base, WM8994_AIF1DAC1_DRC_ENA |
+	snd_soc_component_update_bits(component, base, WM8994_AIF1DAC1_DRC_ENA |
 			     WM8994_AIF1ADC1L_DRC_ENA |
 			     WM8994_AIF1ADC1R_DRC_ENA, save);
 }
@@ -357,8 +357,8 @@ static int wm8994_get_drc(const char *name)
 static int wm8994_put_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int drc = wm8994_get_drc(kcontrol->id.name);
@@ -372,7 +372,7 @@ static int wm8994_put_drc_enum(struct snd_kcontrol *kcontrol,
 
 	wm8994->drc_cfg[drc] = value;
 
-	wm8994_set_drc(codec, drc);
+	wm8994_set_drc(component, drc);
 
 	return 0;
 }
@@ -380,8 +380,8 @@ static int wm8994_put_drc_enum(struct snd_kcontrol *kcontrol,
 static int wm8994_get_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	int drc = wm8994_get_drc(kcontrol->id.name);
 
 	if (drc < 0)
@@ -391,9 +391,9 @@ static int wm8994_get_drc_enum(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static void wm8994_set_retune_mobile(struct snd_soc_codec *codec, int block)
+static void wm8994_set_retune_mobile(struct snd_soc_component *component, int block)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int base = wm8994_retune_mobile_base[block];
@@ -430,7 +430,7 @@ static void wm8994_set_retune_mobile(struct snd_soc_codec *codec, int block)
 		}
 	}
 
-	dev_dbg(codec->dev, "ReTune Mobile %d %s/%dHz for %dHz sample rate\n",
+	dev_dbg(component->dev, "ReTune Mobile %d %s/%dHz for %dHz sample rate\n",
 		block,
 		pdata->retune_mobile_cfgs[best].name,
 		pdata->retune_mobile_cfgs[best].rate,
@@ -439,14 +439,14 @@ static void wm8994_set_retune_mobile(struct snd_soc_codec *codec, int block)
 	/* The EQ will be disabled while reconfiguring it, remember the
 	 * current configuration.
 	 */
-	save = snd_soc_read(codec, base);
+	save = snd_soc_component_read32(component, base);
 	save &= WM8994_AIF1DAC1_EQ_ENA;
 
 	for (i = 0; i < WM8994_EQ_REGS; i++)
-		snd_soc_update_bits(codec, base + i, 0xffff,
+		snd_soc_component_update_bits(component, base + i, 0xffff,
 				pdata->retune_mobile_cfgs[best].regs[i]);
 
-	snd_soc_update_bits(codec, base, WM8994_AIF1DAC1_EQ_ENA, save);
+	snd_soc_component_update_bits(component, base, WM8994_AIF1DAC1_EQ_ENA, save);
 }
 
 /* Icky as hell but saves code duplication */
@@ -464,8 +464,8 @@ static int wm8994_get_retune_mobile_block(const char *name)
 static int wm8994_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
@@ -479,7 +479,7 @@ static int wm8994_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 
 	wm8994->retune_mobile_cfg[block] = value;
 
-	wm8994_set_retune_mobile(codec, block);
+	wm8994_set_retune_mobile(component, block);
 
 	return 0;
 }
@@ -487,8 +487,8 @@ static int wm8994_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 static int wm8994_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
 
 	if (block < 0)
@@ -740,9 +740,9 @@ SOC_SINGLE_TLV("MIXINL IN1RP Boost Volume", WM8994_INPUT_MIXER_1, 8, 1, 0,
 };
 
 /* We run all mode setting through a function to enforce audio mode */
-static void wm1811_jackdet_set_mode(struct snd_soc_codec *codec, u16 mode)
+static void wm1811_jackdet_set_mode(struct snd_soc_component *component, u16 mode)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	if (!wm8994->jackdet || !wm8994->micdet[0].jack)
 		return;
@@ -759,37 +759,37 @@ static void wm1811_jackdet_set_mode(struct snd_soc_codec *codec, u16 mode)
 	if (mode != WM1811_JACKDET_MODE_NONE)
 		mode = WM1811_JACKDET_MODE_AUDIO;
 
-	snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+	snd_soc_component_update_bits(component, WM8994_ANTIPOP_2,
 			    WM1811_JACKDET_MODE_MASK, mode);
 }
 
-static void active_reference(struct snd_soc_codec *codec)
+static void active_reference(struct snd_soc_component *component)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	mutex_lock(&wm8994->accdet_lock);
 
 	wm8994->active_refcount++;
 
-	dev_dbg(codec->dev, "Active refcount incremented, now %d\n",
+	dev_dbg(component->dev, "Active refcount incremented, now %d\n",
 		wm8994->active_refcount);
 
 	/* If we're using jack detection go into audio mode */
-	wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_AUDIO);
+	wm1811_jackdet_set_mode(component, WM1811_JACKDET_MODE_AUDIO);
 
 	mutex_unlock(&wm8994->accdet_lock);
 }
 
-static void active_dereference(struct snd_soc_codec *codec)
+static void active_dereference(struct snd_soc_component *component)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	u16 mode;
 
 	mutex_lock(&wm8994->accdet_lock);
 
 	wm8994->active_refcount--;
 
-	dev_dbg(codec->dev, "Active refcount decremented, now %d\n",
+	dev_dbg(component->dev, "Active refcount decremented, now %d\n",
 		wm8994->active_refcount);
 
 	if (wm8994->active_refcount == 0) {
@@ -799,7 +799,7 @@ static void active_dereference(struct snd_soc_codec *codec)
 		else
 			mode = WM1811_JACKDET_MODE_JACK;
 
-		wm1811_jackdet_set_mode(codec, mode);
+		wm1811_jackdet_set_mode(component, mode);
 	}
 
 	mutex_unlock(&wm8994->accdet_lock);
@@ -808,12 +808,12 @@ static void active_dereference(struct snd_soc_codec *codec)
 static int clk_sys_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		return configure_clock(codec);
+		return configure_clock(component);
 
 	case SND_SOC_DAPM_POST_PMU:
 		/*
@@ -832,30 +832,30 @@ static int clk_sys_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		configure_clock(codec);
+		configure_clock(component);
 		break;
 	}
 
 	return 0;
 }
 
-static void vmid_reference(struct snd_soc_codec *codec)
+static void vmid_reference(struct snd_soc_component *component)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
-	pm_runtime_get_sync(codec->dev);
+	pm_runtime_get_sync(component->dev);
 
 	wm8994->vmid_refcount++;
 
-	dev_dbg(codec->dev, "Referencing VMID, refcount is now %d\n",
+	dev_dbg(component->dev, "Referencing VMID, refcount is now %d\n",
 		wm8994->vmid_refcount);
 
 	if (wm8994->vmid_refcount == 1) {
-		snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
+		snd_soc_component_update_bits(component, WM8994_ANTIPOP_1,
 				    WM8994_LINEOUT1_DISCH |
 				    WM8994_LINEOUT2_DISCH, 0);
 
-		wm_hubs_vmid_ena(codec);
+		wm_hubs_vmid_ena(component);
 
 		switch (wm8994->vmid_mode) {
 		default:
@@ -863,7 +863,7 @@ static void vmid_reference(struct snd_soc_codec *codec)
 			/* fall through */
 		case WM8994_VMID_NORMAL:
 			/* Startup bias, VMID ramp & buffer */
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+			snd_soc_component_update_bits(component, WM8994_ANTIPOP_2,
 					    WM8994_BIAS_SRC |
 					    WM8994_VMID_DISCH |
 					    WM8994_STARTUP_BIAS_ENA |
@@ -875,14 +875,14 @@ static void vmid_reference(struct snd_soc_codec *codec)
 					    (0x2 << WM8994_VMID_RAMP_SHIFT));
 
 			/* Main bias enable, VMID=2x40k */
-			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_1,
 					    WM8994_BIAS_ENA |
 					    WM8994_VMID_SEL_MASK,
 					    WM8994_BIAS_ENA | 0x2);
 
 			msleep(300);
 
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+			snd_soc_component_update_bits(component, WM8994_ANTIPOP_2,
 					    WM8994_VMID_RAMP_MASK |
 					    WM8994_BIAS_SRC,
 					    0);
@@ -890,7 +890,7 @@ static void vmid_reference(struct snd_soc_codec *codec)
 
 		case WM8994_VMID_FORCE:
 			/* Startup bias, slow VMID ramp & buffer */
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+			snd_soc_component_update_bits(component, WM8994_ANTIPOP_2,
 					    WM8994_BIAS_SRC |
 					    WM8994_VMID_DISCH |
 					    WM8994_STARTUP_BIAS_ENA |
@@ -902,14 +902,14 @@ static void vmid_reference(struct snd_soc_codec *codec)
 					    (0x2 << WM8994_VMID_RAMP_SHIFT));
 
 			/* Main bias enable, VMID=2x40k */
-			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_1,
 					    WM8994_BIAS_ENA |
 					    WM8994_VMID_SEL_MASK,
 					    WM8994_BIAS_ENA | 0x2);
 
 			msleep(400);
 
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+			snd_soc_component_update_bits(component, WM8994_ANTIPOP_2,
 					    WM8994_VMID_RAMP_MASK |
 					    WM8994_BIAS_SRC,
 					    0);
@@ -918,120 +918,120 @@ static void vmid_reference(struct snd_soc_codec *codec)
 	}
 }
 
-static void vmid_dereference(struct snd_soc_codec *codec)
+static void vmid_dereference(struct snd_soc_component *component)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	wm8994->vmid_refcount--;
 
-	dev_dbg(codec->dev, "Dereferencing VMID, refcount is now %d\n",
+	dev_dbg(component->dev, "Dereferencing VMID, refcount is now %d\n",
 		wm8994->vmid_refcount);
 
 	if (wm8994->vmid_refcount == 0) {
 		if (wm8994->hubs.lineout1_se)
-			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_3,
+			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_3,
 					    WM8994_LINEOUT1N_ENA |
 					    WM8994_LINEOUT1P_ENA,
 					    WM8994_LINEOUT1N_ENA |
 					    WM8994_LINEOUT1P_ENA);
 
 		if (wm8994->hubs.lineout2_se)
-			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_3,
+			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_3,
 					    WM8994_LINEOUT2N_ENA |
 					    WM8994_LINEOUT2P_ENA,
 					    WM8994_LINEOUT2N_ENA |
 					    WM8994_LINEOUT2P_ENA);
 
 		/* Start discharging VMID */
-		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+		snd_soc_component_update_bits(component, WM8994_ANTIPOP_2,
 				    WM8994_BIAS_SRC |
 				    WM8994_VMID_DISCH,
 				    WM8994_BIAS_SRC |
 				    WM8994_VMID_DISCH);
 
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_1,
 				    WM8994_VMID_SEL_MASK, 0);
 
 		msleep(400);
 
 		/* Active discharge */
-		snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
+		snd_soc_component_update_bits(component, WM8994_ANTIPOP_1,
 				    WM8994_LINEOUT1_DISCH |
 				    WM8994_LINEOUT2_DISCH,
 				    WM8994_LINEOUT1_DISCH |
 				    WM8994_LINEOUT2_DISCH);
 
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_3,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_3,
 				    WM8994_LINEOUT1N_ENA |
 				    WM8994_LINEOUT1P_ENA |
 				    WM8994_LINEOUT2N_ENA |
 				    WM8994_LINEOUT2P_ENA, 0);
 
 		/* Switch off startup biases */
-		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+		snd_soc_component_update_bits(component, WM8994_ANTIPOP_2,
 				    WM8994_BIAS_SRC |
 				    WM8994_STARTUP_BIAS_ENA |
 				    WM8994_VMID_BUF_ENA |
 				    WM8994_VMID_RAMP_MASK, 0);
 
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_1,
 				    WM8994_VMID_SEL_MASK, 0);
 	}
 
-	pm_runtime_put(codec->dev);
+	pm_runtime_put(component->dev);
 }
 
 static int vmid_event(struct snd_soc_dapm_widget *w,
 		      struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		vmid_reference(codec);
+		vmid_reference(component);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		vmid_dereference(codec);
+		vmid_dereference(component);
 		break;
 	}
 
 	return 0;
 }
 
-static bool wm8994_check_class_w_digital(struct snd_soc_codec *codec)
+static bool wm8994_check_class_w_digital(struct snd_soc_component *component)
 {
 	int source = 0;  /* GCC flow analysis can't track enable */
 	int reg, reg_r;
 
 	/* We also need the same AIF source for L/R and only one path */
-	reg = snd_soc_read(codec, WM8994_DAC1_LEFT_MIXER_ROUTING);
+	reg = snd_soc_component_read32(component, WM8994_DAC1_LEFT_MIXER_ROUTING);
 	switch (reg) {
 	case WM8994_AIF2DACL_TO_DAC1L:
-		dev_vdbg(codec->dev, "Class W source AIF2DAC\n");
+		dev_vdbg(component->dev, "Class W source AIF2DAC\n");
 		source = 2 << WM8994_CP_DYN_SRC_SEL_SHIFT;
 		break;
 	case WM8994_AIF1DAC2L_TO_DAC1L:
-		dev_vdbg(codec->dev, "Class W source AIF1DAC2\n");
+		dev_vdbg(component->dev, "Class W source AIF1DAC2\n");
 		source = 1 << WM8994_CP_DYN_SRC_SEL_SHIFT;
 		break;
 	case WM8994_AIF1DAC1L_TO_DAC1L:
-		dev_vdbg(codec->dev, "Class W source AIF1DAC1\n");
+		dev_vdbg(component->dev, "Class W source AIF1DAC1\n");
 		source = 0 << WM8994_CP_DYN_SRC_SEL_SHIFT;
 		break;
 	default:
-		dev_vdbg(codec->dev, "DAC mixer setting: %x\n", reg);
+		dev_vdbg(component->dev, "DAC mixer setting: %x\n", reg);
 		return false;
 	}
 
-	reg_r = snd_soc_read(codec, WM8994_DAC1_RIGHT_MIXER_ROUTING);
+	reg_r = snd_soc_component_read32(component, WM8994_DAC1_RIGHT_MIXER_ROUTING);
 	if (reg_r != reg) {
-		dev_vdbg(codec->dev, "Left and right DAC mixers different\n");
+		dev_vdbg(component->dev, "Left and right DAC mixers different\n");
 		return false;
 	}
 
 	/* Set the source up */
-	snd_soc_update_bits(codec, WM8994_CLASS_W_1,
+	snd_soc_component_update_bits(component, WM8994_CLASS_W_1,
 			    WM8994_CP_DYN_SRC_SEL_MASK, source);
 
 	return true;
@@ -1040,8 +1040,8 @@ static bool wm8994_check_class_w_digital(struct snd_soc_codec *codec)
 static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 		      struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int mask = WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC1R_ENA;
 	int i;
@@ -1064,7 +1064,7 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 		if (wm8994->channels[0] <= 2)
 			mask &= ~(WM8994_AIF1DAC2L_ENA | WM8994_AIF1DAC2R_ENA);
 
-		val = snd_soc_read(codec, WM8994_AIF1_CONTROL_1);
+		val = snd_soc_component_read32(component, WM8994_AIF1_CONTROL_1);
 		if ((val & WM8994_AIF1ADCL_SRC) &&
 		    (val & WM8994_AIF1ADCR_SRC))
 			adc = WM8994_AIF1ADC1R_ENA | WM8994_AIF1ADC2R_ENA;
@@ -1075,7 +1075,7 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 			adc = WM8994_AIF1ADC1R_ENA | WM8994_AIF1ADC2R_ENA |
 				WM8994_AIF1ADC1L_ENA | WM8994_AIF1ADC2L_ENA;
 
-		val = snd_soc_read(codec, WM8994_AIF1_CONTROL_2);
+		val = snd_soc_component_read32(component, WM8994_AIF1_CONTROL_2);
 		if ((val & WM8994_AIF1DACL_SRC) &&
 		    (val & WM8994_AIF1DACR_SRC))
 			dac = WM8994_AIF1DAC1R_ENA | WM8994_AIF1DAC2R_ENA;
@@ -1086,21 +1086,21 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 			dac = WM8994_AIF1DAC1R_ENA | WM8994_AIF1DAC2R_ENA |
 				WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC2L_ENA;
 
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_4,
 				    mask, adc);
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_5,
 				    mask, dac);
-		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+		snd_soc_component_update_bits(component, WM8994_CLOCKING_1,
 				    WM8994_AIF1DSPCLK_ENA |
 				    WM8994_SYSDSPCLK_ENA,
 				    WM8994_AIF1DSPCLK_ENA |
 				    WM8994_SYSDSPCLK_ENA);
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4, mask,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_4, mask,
 				    WM8994_AIF1ADC1R_ENA |
 				    WM8994_AIF1ADC1L_ENA |
 				    WM8994_AIF1ADC2R_ENA |
 				    WM8994_AIF1ADC2L_ENA);
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5, mask,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_5, mask,
 				    WM8994_AIF1DAC1R_ENA |
 				    WM8994_AIF1DAC1L_ENA |
 				    WM8994_AIF1DAC2R_ENA |
@@ -1109,24 +1109,24 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 
 	case SND_SOC_DAPM_POST_PMU:
 		for (i = 0; i < ARRAY_SIZE(wm8994_vu_bits); i++)
-			snd_soc_write(codec, wm8994_vu_bits[i].reg,
-				      snd_soc_read(codec,
+			snd_soc_component_write(component, wm8994_vu_bits[i].reg,
+				      snd_soc_component_read32(component,
 						   wm8994_vu_bits[i].reg));
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_5,
 				    mask, 0);
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_4,
 				    mask, 0);
 
-		val = snd_soc_read(codec, WM8994_CLOCKING_1);
+		val = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 		if (val & WM8994_AIF2DSPCLK_ENA)
 			val = WM8994_SYSDSPCLK_ENA;
 		else
 			val = 0;
-		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+		snd_soc_component_update_bits(component, WM8994_CLOCKING_1,
 				    WM8994_SYSDSPCLK_ENA |
 				    WM8994_AIF1DSPCLK_ENA, val);
 		break;
@@ -1138,7 +1138,7 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 		      struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	int i;
 	int dac;
 	int adc;
@@ -1146,7 +1146,7 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		val = snd_soc_read(codec, WM8994_AIF2_CONTROL_1);
+		val = snd_soc_component_read32(component, WM8994_AIF2_CONTROL_1);
 		if ((val & WM8994_AIF2ADCL_SRC) &&
 		    (val & WM8994_AIF2ADCR_SRC))
 			adc = WM8994_AIF2ADCR_ENA;
@@ -1157,7 +1157,7 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 			adc = WM8994_AIF2ADCL_ENA | WM8994_AIF2ADCR_ENA;
 
 
-		val = snd_soc_read(codec, WM8994_AIF2_CONTROL_2);
+		val = snd_soc_component_read32(component, WM8994_AIF2_CONTROL_2);
 		if ((val & WM8994_AIF2DACL_SRC) &&
 		    (val & WM8994_AIF2DACR_SRC))
 			dac = WM8994_AIF2DACR_ENA;
@@ -1167,23 +1167,23 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 		else
 			dac = WM8994_AIF2DACL_ENA | WM8994_AIF2DACR_ENA;
 
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_4,
 				    WM8994_AIF2ADCL_ENA |
 				    WM8994_AIF2ADCR_ENA, adc);
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_5,
 				    WM8994_AIF2DACL_ENA |
 				    WM8994_AIF2DACR_ENA, dac);
-		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+		snd_soc_component_update_bits(component, WM8994_CLOCKING_1,
 				    WM8994_AIF2DSPCLK_ENA |
 				    WM8994_SYSDSPCLK_ENA,
 				    WM8994_AIF2DSPCLK_ENA |
 				    WM8994_SYSDSPCLK_ENA);
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_4,
 				    WM8994_AIF2ADCL_ENA |
 				    WM8994_AIF2ADCR_ENA,
 				    WM8994_AIF2ADCL_ENA |
 				    WM8994_AIF2ADCR_ENA);
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_5,
 				    WM8994_AIF2DACL_ENA |
 				    WM8994_AIF2DACR_ENA,
 				    WM8994_AIF2DACL_ENA |
@@ -1192,26 +1192,26 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 
 	case SND_SOC_DAPM_POST_PMU:
 		for (i = 0; i < ARRAY_SIZE(wm8994_vu_bits); i++)
-			snd_soc_write(codec, wm8994_vu_bits[i].reg,
-				      snd_soc_read(codec,
+			snd_soc_component_write(component, wm8994_vu_bits[i].reg,
+				      snd_soc_component_read32(component,
 						   wm8994_vu_bits[i].reg));
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_5,
 				    WM8994_AIF2DACL_ENA |
 				    WM8994_AIF2DACR_ENA, 0);
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
+		snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_4,
 				    WM8994_AIF2ADCL_ENA |
 				    WM8994_AIF2ADCR_ENA, 0);
 
-		val = snd_soc_read(codec, WM8994_CLOCKING_1);
+		val = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 		if (val & WM8994_AIF1DSPCLK_ENA)
 			val = WM8994_SYSDSPCLK_ENA;
 		else
 			val = 0;
-		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+		snd_soc_component_update_bits(component, WM8994_CLOCKING_1,
 				    WM8994_SYSDSPCLK_ENA |
 				    WM8994_AIF2DSPCLK_ENA, val);
 		break;
@@ -1223,8 +1223,8 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 static int aif1clk_late_ev(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -1241,8 +1241,8 @@ static int aif1clk_late_ev(struct snd_soc_dapm_widget *w,
 static int aif2clk_late_ev(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -1259,14 +1259,14 @@ static int aif2clk_late_ev(struct snd_soc_dapm_widget *w,
 static int late_enable_ev(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		if (wm8994->aif1clk_enable) {
 			aif1clk_ev(w, kcontrol, SND_SOC_DAPM_PRE_PMU);
-			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
+			snd_soc_component_update_bits(component, WM8994_AIF1_CLOCKING_1,
 					    WM8994_AIF1CLK_ENA_MASK,
 					    WM8994_AIF1CLK_ENA);
 			aif1clk_ev(w, kcontrol, SND_SOC_DAPM_POST_PMU);
@@ -1274,7 +1274,7 @@ static int late_enable_ev(struct snd_soc_dapm_widget *w,
 		}
 		if (wm8994->aif2clk_enable) {
 			aif2clk_ev(w, kcontrol, SND_SOC_DAPM_PRE_PMU);
-			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
+			snd_soc_component_update_bits(component, WM8994_AIF2_CLOCKING_1,
 					    WM8994_AIF2CLK_ENA_MASK,
 					    WM8994_AIF2CLK_ENA);
 			aif2clk_ev(w, kcontrol, SND_SOC_DAPM_POST_PMU);
@@ -1292,21 +1292,21 @@ static int late_enable_ev(struct snd_soc_dapm_widget *w,
 static int late_disable_ev(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMD:
 		if (wm8994->aif1clk_disable) {
 			aif1clk_ev(w, kcontrol, SND_SOC_DAPM_PRE_PMD);
-			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
+			snd_soc_component_update_bits(component, WM8994_AIF1_CLOCKING_1,
 					    WM8994_AIF1CLK_ENA_MASK, 0);
 			aif1clk_ev(w, kcontrol, SND_SOC_DAPM_POST_PMD);
 			wm8994->aif1clk_disable = 0;
 		}
 		if (wm8994->aif2clk_disable) {
 			aif2clk_ev(w, kcontrol, SND_SOC_DAPM_PRE_PMD);
-			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
+			snd_soc_component_update_bits(component, WM8994_AIF2_CLOCKING_1,
 					    WM8994_AIF2CLK_ENA_MASK, 0);
 			aif2clk_ev(w, kcontrol, SND_SOC_DAPM_POST_PMD);
 			wm8994->aif2clk_disable = 0;
@@ -1334,10 +1334,10 @@ static int micbias_ev(struct snd_soc_dapm_widget *w,
 static int dac_ev(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	unsigned int mask = 1 << w->shift;
 
-	snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+	snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_5,
 			    mask, mask);
 	return 0;
 }
@@ -1375,9 +1375,9 @@ SOC_DAPM_SINGLE("DAC1 Switch", WM8994_SPEAKER_MIXER, 0, 1, 0),
 static int post_ev(struct snd_soc_dapm_widget *w,
 	    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	dev_dbg(codec->dev, "SRC status: %x\n",
-		snd_soc_read(codec,
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	dev_dbg(component->dev, "SRC status: %x\n",
+		snd_soc_component_read32(component,
 			     WM8994_RATE_STATUS));
 	return 0;
 }
@@ -1443,12 +1443,12 @@ SOC_DAPM_SINGLE("AIF1.1 Switch", WM8994_DAC2_RIGHT_MIXER_ROUTING,
 static int wm8994_put_class_w(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
 	int ret;
 
 	ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
 
-	wm_hubs_update_class_w(codec);
+	wm_hubs_update_class_w(component);
 
 	return ret;
 }
@@ -2130,10 +2130,10 @@ static int wm8994_get_fll_config(struct wm8994 *control, struct fll_div *fll,
 	return 0;
 }
 
-static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
+static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 			  unsigned int freq_in, unsigned int freq_out)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int reg_offset, ret;
 	struct fll_div fll;
@@ -2156,7 +2156,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 		return -EINVAL;
 	}
 
-	reg = snd_soc_read(codec, WM8994_FLL1_CONTROL_1 + reg_offset);
+	reg = snd_soc_component_read32(component, WM8994_FLL1_CONTROL_1 + reg_offset);
 	was_enabled = reg & WM8994_FLL1_ENA;
 
 	switch (src) {
@@ -2197,57 +2197,57 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 		return ret;
 
 	/* Make sure that we're not providing SYSCLK right now */
-	clk1 = snd_soc_read(codec, WM8994_CLOCKING_1);
+	clk1 = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 	if (clk1 & WM8994_SYSCLK_SRC)
 		aif_reg = WM8994_AIF2_CLOCKING_1;
 	else
 		aif_reg = WM8994_AIF1_CLOCKING_1;
-	reg = snd_soc_read(codec, aif_reg);
+	reg = snd_soc_component_read32(component, aif_reg);
 
 	if ((reg & WM8994_AIF1CLK_ENA) &&
 	    (reg & WM8994_AIF1CLK_SRC_MASK) == aif_src) {
-		dev_err(codec->dev, "FLL%d is currently providing SYSCLK\n",
+		dev_err(component->dev, "FLL%d is currently providing SYSCLK\n",
 			id + 1);
 		return -EBUSY;
 	}
 
 	/* We always need to disable the FLL while reconfiguring */
-	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_1 + reg_offset,
+	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_1 + reg_offset,
 			    WM8994_FLL1_ENA, 0);
 
 	if (wm8994->fll_byp && src == WM8994_FLL_SRC_BCLK &&
 	    freq_in == freq_out && freq_out) {
-		dev_dbg(codec->dev, "Bypassing FLL%d\n", id + 1);
-		snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_5 + reg_offset,
+		dev_dbg(component->dev, "Bypassing FLL%d\n", id + 1);
+		snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_5 + reg_offset,
 				    WM8958_FLL1_BYP, WM8958_FLL1_BYP);
 		goto out;
 	}
 
 	reg = (fll.outdiv << WM8994_FLL1_OUTDIV_SHIFT) |
 		(fll.fll_fratio << WM8994_FLL1_FRATIO_SHIFT);
-	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_2 + reg_offset,
+	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_2 + reg_offset,
 			    WM8994_FLL1_OUTDIV_MASK |
 			    WM8994_FLL1_FRATIO_MASK, reg);
 
-	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_3 + reg_offset,
+	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_3 + reg_offset,
 			    WM8994_FLL1_K_MASK, fll.k);
 
-	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_4 + reg_offset,
+	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_4 + reg_offset,
 			    WM8994_FLL1_N_MASK,
 			    fll.n << WM8994_FLL1_N_SHIFT);
 
 	if (fll.lambda) {
-		snd_soc_update_bits(codec, WM8958_FLL1_EFS_1 + reg_offset,
+		snd_soc_component_update_bits(component, WM8958_FLL1_EFS_1 + reg_offset,
 				    WM8958_FLL1_LAMBDA_MASK,
 				    fll.lambda);
-		snd_soc_update_bits(codec, WM8958_FLL1_EFS_2 + reg_offset,
+		snd_soc_component_update_bits(component, WM8958_FLL1_EFS_2 + reg_offset,
 				    WM8958_FLL1_EFS_ENA, WM8958_FLL1_EFS_ENA);
 	} else {
-		snd_soc_update_bits(codec, WM8958_FLL1_EFS_2 + reg_offset,
+		snd_soc_component_update_bits(component, WM8958_FLL1_EFS_2 + reg_offset,
 				    WM8958_FLL1_EFS_ENA, 0);
 	}
 
-	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_5 + reg_offset,
+	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_5 + reg_offset,
 			    WM8994_FLL1_FRC_NCO | WM8958_FLL1_BYP |
 			    WM8994_FLL1_REFCLK_DIV_MASK |
 			    WM8994_FLL1_REFCLK_SRC_MASK,
@@ -2263,15 +2263,15 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	if (freq_out) {
 		/* Enable VMID if we need it */
 		if (!was_enabled) {
-			active_reference(codec);
+			active_reference(component);
 
 			switch (control->type) {
 			case WM8994:
-				vmid_reference(codec);
+				vmid_reference(component);
 				break;
 			case WM8958:
 				if (control->revision < 1)
-					vmid_reference(codec);
+					vmid_reference(component);
 				break;
 			default:
 				break;
@@ -2285,7 +2285,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 		if (src == WM8994_FLL_SRC_INTERNAL)
 			reg |= WM8994_FLL1_OSC_ENA;
 
-		snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_1 + reg_offset,
+		snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_1 + reg_offset,
 				    WM8994_FLL1_ENA | WM8994_FLL1_OSC_ENA |
 				    WM8994_FLL1_FRAC, reg);
 
@@ -2293,7 +2293,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 			timeout = wait_for_completion_timeout(&wm8994->fll_locked[id],
 							      msecs_to_jiffies(10));
 			if (timeout == 0)
-				dev_warn(codec->dev,
+				dev_warn(component->dev,
 					 "Timed out waiting for FLL lock\n");
 		} else {
 			msleep(5);
@@ -2302,17 +2302,17 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 		if (was_enabled) {
 			switch (control->type) {
 			case WM8994:
-				vmid_dereference(codec);
+				vmid_dereference(component);
 				break;
 			case WM8958:
 				if (control->revision < 1)
-					vmid_dereference(codec);
+					vmid_dereference(component);
 				break;
 			default:
 				break;
 			}
 
-			active_dereference(codec);
+			active_dereference(component);
 		}
 	}
 
@@ -2321,29 +2321,29 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	wm8994->fll[id].out = freq_out;
 	wm8994->fll[id].src = src;
 
-	configure_clock(codec);
+	configure_clock(component);
 
 	/*
 	 * If SYSCLK will be less than 50kHz adjust AIFnCLK dividers
 	 * for detection.
 	 */
 	if (max(wm8994->aifclk[0], wm8994->aifclk[1]) < 50000) {
-		dev_dbg(codec->dev, "Configuring AIFs for 128fs\n");
+		dev_dbg(component->dev, "Configuring AIFs for 128fs\n");
 
-		wm8994->aifdiv[0] = snd_soc_read(codec, WM8994_AIF1_RATE)
+		wm8994->aifdiv[0] = snd_soc_component_read32(component, WM8994_AIF1_RATE)
 			& WM8994_AIF1CLK_RATE_MASK;
-		wm8994->aifdiv[1] = snd_soc_read(codec, WM8994_AIF2_RATE)
+		wm8994->aifdiv[1] = snd_soc_component_read32(component, WM8994_AIF2_RATE)
 			& WM8994_AIF1CLK_RATE_MASK;
 
-		snd_soc_update_bits(codec, WM8994_AIF1_RATE,
+		snd_soc_component_update_bits(component, WM8994_AIF1_RATE,
 				    WM8994_AIF1CLK_RATE_MASK, 0x1);
-		snd_soc_update_bits(codec, WM8994_AIF2_RATE,
+		snd_soc_component_update_bits(component, WM8994_AIF2_RATE,
 				    WM8994_AIF2CLK_RATE_MASK, 0x1);
 	} else if (wm8994->aifdiv[0]) {
-		snd_soc_update_bits(codec, WM8994_AIF1_RATE,
+		snd_soc_component_update_bits(component, WM8994_AIF1_RATE,
 				    WM8994_AIF1CLK_RATE_MASK,
 				    wm8994->aifdiv[0]);
-		snd_soc_update_bits(codec, WM8994_AIF2_RATE,
+		snd_soc_component_update_bits(component, WM8994_AIF2_RATE,
 				    WM8994_AIF2CLK_RATE_MASK,
 				    wm8994->aifdiv[1]);
 
@@ -2368,14 +2368,14 @@ static int opclk_divs[] = { 10, 20, 30, 40, 55, 60, 80, 120, 160 };
 static int wm8994_set_fll(struct snd_soc_dai *dai, int id, int src,
 			  unsigned int freq_in, unsigned int freq_out)
 {
-	return _wm8994_set_fll(dai->codec, id, src, freq_in, freq_out);
+	return _wm8994_set_fll(dai->component, id, src, freq_in, freq_out);
 }
 
 static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	int i;
 
 	switch (dai->id) {
@@ -2424,12 +2424,12 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 					break;
 			if (i == ARRAY_SIZE(opclk_divs))
 				return -EINVAL;
-			snd_soc_update_bits(codec, WM8994_CLOCKING_2,
+			snd_soc_component_update_bits(component, WM8994_CLOCKING_2,
 					    WM8994_OPCLK_DIV_MASK, i);
-			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_2,
+			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_2,
 					    WM8994_OPCLK_ENA, WM8994_OPCLK_ENA);
 		} else {
-			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_2,
+			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_2,
 					    WM8994_OPCLK_ENA, 0);
 		}
 
@@ -2437,29 +2437,29 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	configure_clock(codec);
+	configure_clock(component);
 
 	/*
 	 * If SYSCLK will be less than 50kHz adjust AIFnCLK dividers
 	 * for detection.
 	 */
 	if (max(wm8994->aifclk[0], wm8994->aifclk[1]) < 50000) {
-		dev_dbg(codec->dev, "Configuring AIFs for 128fs\n");
+		dev_dbg(component->dev, "Configuring AIFs for 128fs\n");
 
-		wm8994->aifdiv[0] = snd_soc_read(codec, WM8994_AIF1_RATE)
+		wm8994->aifdiv[0] = snd_soc_component_read32(component, WM8994_AIF1_RATE)
 			& WM8994_AIF1CLK_RATE_MASK;
-		wm8994->aifdiv[1] = snd_soc_read(codec, WM8994_AIF2_RATE)
+		wm8994->aifdiv[1] = snd_soc_component_read32(component, WM8994_AIF2_RATE)
 			& WM8994_AIF1CLK_RATE_MASK;
 
-		snd_soc_update_bits(codec, WM8994_AIF1_RATE,
+		snd_soc_component_update_bits(component, WM8994_AIF1_RATE,
 				    WM8994_AIF1CLK_RATE_MASK, 0x1);
-		snd_soc_update_bits(codec, WM8994_AIF2_RATE,
+		snd_soc_component_update_bits(component, WM8994_AIF2_RATE,
 				    WM8994_AIF2CLK_RATE_MASK, 0x1);
 	} else if (wm8994->aifdiv[0]) {
-		snd_soc_update_bits(codec, WM8994_AIF1_RATE,
+		snd_soc_component_update_bits(component, WM8994_AIF1_RATE,
 				    WM8994_AIF1CLK_RATE_MASK,
 				    wm8994->aifdiv[0]);
-		snd_soc_update_bits(codec, WM8994_AIF2_RATE,
+		snd_soc_component_update_bits(component, WM8994_AIF2_RATE,
 				    WM8994_AIF2CLK_RATE_MASK,
 				    wm8994->aifdiv[1]);
 
@@ -2470,13 +2470,13 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int wm8994_set_bias_level(struct snd_soc_codec *codec,
+static int wm8994_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 
-	wm_hubs_set_bias_level(codec, level);
+	wm_hubs_set_bias_level(component, level);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -2487,26 +2487,26 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		switch (control->type) {
 		case WM8958:
 		case WM1811:
-			snd_soc_update_bits(codec, WM8958_MICBIAS1,
+			snd_soc_component_update_bits(component, WM8958_MICBIAS1,
 					    WM8958_MICB1_MODE, 0);
-			snd_soc_update_bits(codec, WM8958_MICBIAS2,
+			snd_soc_component_update_bits(component, WM8958_MICBIAS2,
 					    WM8958_MICB2_MODE, 0);
 			break;
 		default:
 			break;
 		}
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY)
-			active_reference(codec);
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_STANDBY)
+			active_reference(component);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			switch (control->type) {
 			case WM8958:
 				if (control->revision == 0) {
 					/* Optimise performance for rev A */
-					snd_soc_update_bits(codec,
+					snd_soc_component_update_bits(component,
 							    WM8958_CHARGE_PUMP_2,
 							    WM8958_CP_DISCH,
 							    WM8958_CP_DISCH);
@@ -2518,24 +2518,24 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 			}
 
 			/* Discharge LINEOUT1 & 2 */
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
+			snd_soc_component_update_bits(component, WM8994_ANTIPOP_1,
 					    WM8994_LINEOUT1_DISCH |
 					    WM8994_LINEOUT2_DISCH,
 					    WM8994_LINEOUT1_DISCH |
 					    WM8994_LINEOUT2_DISCH);
 		}
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE)
-			active_dereference(codec);
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_PREPARE)
+			active_dereference(component);
 
 		/* MICBIAS into bypass mode on newer devices */
 		switch (control->type) {
 		case WM8958:
 		case WM1811:
-			snd_soc_update_bits(codec, WM8958_MICBIAS1,
+			snd_soc_component_update_bits(component, WM8958_MICBIAS1,
 					    WM8958_MICB1_MODE,
 					    WM8958_MICB1_MODE);
-			snd_soc_update_bits(codec, WM8958_MICBIAS2,
+			snd_soc_component_update_bits(component, WM8958_MICBIAS2,
 					    WM8958_MICB2_MODE,
 					    WM8958_MICB2_MODE);
 			break;
@@ -2545,7 +2545,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY)
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_STANDBY)
 			wm8994->cur_fw = NULL;
 		break;
 	}
@@ -2553,10 +2553,10 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-int wm8994_vmid_mode(struct snd_soc_codec *codec, enum wm8994_vmid_mode mode)
+int wm8994_vmid_mode(struct snd_soc_component *component, enum wm8994_vmid_mode mode)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	switch (mode) {
 	case WM8994_VMID_NORMAL:
@@ -2613,8 +2613,8 @@ int wm8994_vmid_mode(struct snd_soc_codec *codec, enum wm8994_vmid_mode mode)
 
 static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int ms_reg;
 	int aif1_reg;
@@ -2717,7 +2717,7 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case WM1811:
 	case WM8958:
 		if (dai->id == 2)
-			snd_soc_update_bits(codec, WM8958_AIF3_CONTROL_1,
+			snd_soc_component_update_bits(component, WM8958_AIF3_CONTROL_1,
 					    WM8994_AIF1_LRCLK_INV |
 					    WM8958_AIF3_FMT_MASK, aif1);
 		break;
@@ -2726,15 +2726,15 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		break;
 	}
 
-	snd_soc_update_bits(codec, aif1_reg,
+	snd_soc_component_update_bits(component, aif1_reg,
 			    WM8994_AIF1_BCLK_INV | WM8994_AIF1_LRCLK_INV |
 			    WM8994_AIF1_FMT_MASK,
 			    aif1);
-	snd_soc_update_bits(codec, ms_reg, WM8994_AIF1_MSTR,
+	snd_soc_component_update_bits(component, ms_reg, WM8994_AIF1_MSTR,
 			    ms);
-	snd_soc_update_bits(codec, dac_reg,
+	snd_soc_component_update_bits(component, dac_reg,
 			    WM8958_AIF1_LRCLK_INV, lrclk);
-	snd_soc_update_bits(codec, adc_reg,
+	snd_soc_component_update_bits(component, adc_reg,
 			    WM8958_AIF1_LRCLK_INV, lrclk);
 
 	return 0;
@@ -2769,8 +2769,8 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int aif1_reg;
@@ -2798,7 +2798,7 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 			lrclk_reg = WM8994_AIF1DAC_LRCLK;
 		} else {
 			lrclk_reg = WM8994_AIF1ADC_LRCLK;
-			dev_dbg(codec->dev, "AIF1 using split LRCLK\n");
+			dev_dbg(component->dev, "AIF1 using split LRCLK\n");
 		}
 		break;
 	case 2:
@@ -2811,7 +2811,7 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 			lrclk_reg = WM8994_AIF2DAC_LRCLK;
 		} else {
 			lrclk_reg = WM8994_AIF2ADC_LRCLK;
-			dev_dbg(codec->dev, "AIF2 using split LRCLK\n");
+			dev_dbg(component->dev, "AIF2 using split LRCLK\n");
 		}
 		break;
 	default:
@@ -2870,7 +2870,7 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 		dai->id, wm8994->aifclk[id], bclk_rate);
 
 	if (wm8994->channels[id] == 1 &&
-	    (snd_soc_read(codec, aif1_reg) & 0x18) == 0x18)
+	    (snd_soc_component_read32(component, aif1_reg) & 0x18) == 0x18)
 		aif2 |= WM8994_AIF1_MONO;
 
 	if (wm8994->aifclk[id] == 0) {
@@ -2920,24 +2920,24 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(dai->dev, "Using LRCLK rate %d for actual LRCLK %dHz\n",
 		lrclk, bclk_rate / lrclk);
 
-	snd_soc_update_bits(codec, aif1_reg, WM8994_AIF1_WL_MASK, aif1);
-	snd_soc_update_bits(codec, aif2_reg, WM8994_AIF1_MONO, aif2);
-	snd_soc_update_bits(codec, bclk_reg, WM8994_AIF1_BCLK_DIV_MASK, bclk);
-	snd_soc_update_bits(codec, lrclk_reg, WM8994_AIF1DAC_RATE_MASK,
+	snd_soc_component_update_bits(component, aif1_reg, WM8994_AIF1_WL_MASK, aif1);
+	snd_soc_component_update_bits(component, aif2_reg, WM8994_AIF1_MONO, aif2);
+	snd_soc_component_update_bits(component, bclk_reg, WM8994_AIF1_BCLK_DIV_MASK, bclk);
+	snd_soc_component_update_bits(component, lrclk_reg, WM8994_AIF1DAC_RATE_MASK,
 			    lrclk);
-	snd_soc_update_bits(codec, rate_reg, WM8994_AIF1_SR_MASK |
+	snd_soc_component_update_bits(component, rate_reg, WM8994_AIF1_SR_MASK |
 			    WM8994_AIF1CLK_RATE_MASK, rate_val);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		switch (dai->id) {
 		case 1:
 			wm8994->dac_rates[0] = params_rate(params);
-			wm8994_set_retune_mobile(codec, 0);
-			wm8994_set_retune_mobile(codec, 1);
+			wm8994_set_retune_mobile(component, 0);
+			wm8994_set_retune_mobile(component, 1);
 			break;
 		case 2:
 			wm8994->dac_rates[1] = params_rate(params);
-			wm8994_set_retune_mobile(codec, 2);
+			wm8994_set_retune_mobile(component, 2);
 			break;
 		}
 	}
@@ -2949,8 +2949,8 @@ static int wm8994_aif3_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int aif1_reg;
 	int aif1 = 0;
@@ -2986,12 +2986,12 @@ static int wm8994_aif3_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	return snd_soc_update_bits(codec, aif1_reg, WM8994_AIF1_WL_MASK, aif1);
+	return snd_soc_component_update_bits(component, aif1_reg, WM8994_AIF1_WL_MASK, aif1);
 }
 
 static int wm8994_aif_mute(struct snd_soc_dai *codec_dai, int mute)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	int mute_reg;
 	int reg;
 
@@ -3011,14 +3011,14 @@ static int wm8994_aif_mute(struct snd_soc_dai *codec_dai, int mute)
 	else
 		reg = 0;
 
-	snd_soc_update_bits(codec, mute_reg, WM8994_AIF1DAC1_MUTE, reg);
+	snd_soc_component_update_bits(component, mute_reg, WM8994_AIF1DAC1_MUTE, reg);
 
 	return 0;
 }
 
 static int wm8994_set_tristate(struct snd_soc_dai *codec_dai, int tristate)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	int reg, val, mask;
 
 	switch (codec_dai->id) {
@@ -3039,19 +3039,19 @@ static int wm8994_set_tristate(struct snd_soc_dai *codec_dai, int tristate)
 	else
 		val = 0;
 
-	return snd_soc_update_bits(codec, reg, mask, val);
+	return snd_soc_component_update_bits(component, reg, mask, val);
 }
 
 static int wm8994_aif2_probe(struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
 	/* Disable the pulls on the AIF if we're using it to save power. */
-	snd_soc_update_bits(codec, WM8994_GPIO_3,
+	snd_soc_component_update_bits(component, WM8994_GPIO_3,
 			    WM8994_GPN_PU | WM8994_GPN_PD, 0);
-	snd_soc_update_bits(codec, WM8994_GPIO_4,
+	snd_soc_component_update_bits(component, WM8994_GPIO_4,
 			    WM8994_GPN_PU | WM8994_GPN_PD, 0);
-	snd_soc_update_bits(codec, WM8994_GPIO_5,
+	snd_soc_component_update_bits(component, WM8994_GPIO_5,
 			    WM8994_GPN_PU | WM8994_GPN_PD, 0);
 
 	return 0;
@@ -3152,53 +3152,53 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 };
 
 #ifdef CONFIG_PM
-static int wm8994_codec_suspend(struct snd_soc_codec *codec)
+static int wm8994_component_suspend(struct snd_soc_component *component)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll); i++) {
 		memcpy(&wm8994->fll_suspend[i], &wm8994->fll[i],
 		       sizeof(struct wm8994_fll_config));
-		ret = _wm8994_set_fll(codec, i + 1, 0, 0, 0);
+		ret = _wm8994_set_fll(component, i + 1, 0, 0, 0);
 		if (ret < 0)
-			dev_warn(codec->dev, "Failed to stop FLL%d: %d\n",
+			dev_warn(component->dev, "Failed to stop FLL%d: %d\n",
 				 i + 1, ret);
 	}
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8994_codec_resume(struct snd_soc_codec *codec)
+static int wm8994_component_resume(struct snd_soc_component *component)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll); i++) {
 		if (!wm8994->fll_suspend[i].out)
 			continue;
 
-		ret = _wm8994_set_fll(codec, i + 1,
+		ret = _wm8994_set_fll(component, i + 1,
 				     wm8994->fll_suspend[i].src,
 				     wm8994->fll_suspend[i].in,
 				     wm8994->fll_suspend[i].out);
 		if (ret < 0)
-			dev_warn(codec->dev, "Failed to restore FLL%d: %d\n",
+			dev_warn(component->dev, "Failed to restore FLL%d: %d\n",
 				 i + 1, ret);
 	}
 
 	return 0;
 }
 #else
-#define wm8994_codec_suspend NULL
-#define wm8994_codec_resume NULL
+#define wm8994_component_suspend NULL
+#define wm8994_component_resume NULL
 #endif
 
 static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 {
-	struct snd_soc_codec *codec = wm8994->hubs.codec;
+	struct snd_soc_component *component = wm8994->hubs.component;
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	struct snd_kcontrol_new controls[] = {
@@ -3251,22 +3251,22 @@ static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 		wm8994->retune_mobile_texts = t;
 	}
 
-	dev_dbg(codec->dev, "Allocated %d unique ReTune Mobile names\n",
+	dev_dbg(component->dev, "Allocated %d unique ReTune Mobile names\n",
 		wm8994->num_retune_mobile_texts);
 
 	wm8994->retune_mobile_enum.items = wm8994->num_retune_mobile_texts;
 	wm8994->retune_mobile_enum.texts = wm8994->retune_mobile_texts;
 
-	ret = snd_soc_add_codec_controls(wm8994->hubs.codec, controls,
+	ret = snd_soc_add_component_controls(wm8994->hubs.component, controls,
 				   ARRAY_SIZE(controls));
 	if (ret != 0)
-		dev_err(wm8994->hubs.codec->dev,
+		dev_err(wm8994->hubs.component->dev,
 			"Failed to add ReTune Mobile controls: %d\n", ret);
 }
 
 static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 {
-	struct snd_soc_codec *codec = wm8994->hubs.codec;
+	struct snd_soc_component *component = wm8994->hubs.component;
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int ret, i;
@@ -3274,7 +3274,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 	if (!pdata)
 		return;
 
-	wm_hubs_handle_analogue_pdata(codec, pdata->lineout1_diff,
+	wm_hubs_handle_analogue_pdata(component, pdata->lineout1_diff,
 				      pdata->lineout2_diff,
 				      pdata->lineout1fb,
 				      pdata->lineout2fb,
@@ -3285,7 +3285,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 				      pdata->micbias1_lvl,
 				      pdata->micbias2_lvl);
 
-	dev_dbg(codec->dev, "%d DRC configurations\n", pdata->num_drc_cfgs);
+	dev_dbg(component->dev, "%d DRC configurations\n", pdata->num_drc_cfgs);
 
 	if (pdata->num_drc_cfgs) {
 		struct snd_kcontrol_new controls[] = {
@@ -3298,7 +3298,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		};
 
 		/* We need an array of texts for the enum API */
-		wm8994->drc_texts = devm_kzalloc(wm8994->hubs.codec->dev,
+		wm8994->drc_texts = devm_kzalloc(wm8994->hubs.component->dev,
 			    sizeof(char *) * pdata->num_drc_cfgs, GFP_KERNEL);
 		if (!wm8994->drc_texts)
 			return;
@@ -3309,33 +3309,33 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		wm8994->drc_enum.items = pdata->num_drc_cfgs;
 		wm8994->drc_enum.texts = wm8994->drc_texts;
 
-		ret = snd_soc_add_codec_controls(wm8994->hubs.codec, controls,
+		ret = snd_soc_add_component_controls(wm8994->hubs.component, controls,
 					   ARRAY_SIZE(controls));
 		for (i = 0; i < WM8994_NUM_DRC; i++)
-			wm8994_set_drc(codec, i);
+			wm8994_set_drc(component, i);
 	} else {
-		ret = snd_soc_add_codec_controls(wm8994->hubs.codec,
+		ret = snd_soc_add_component_controls(wm8994->hubs.component,
 						 wm8994_drc_controls,
 						 ARRAY_SIZE(wm8994_drc_controls));
 	}
 
 	if (ret != 0)
-		dev_err(wm8994->hubs.codec->dev,
+		dev_err(wm8994->hubs.component->dev,
 			"Failed to add DRC mode controls: %d\n", ret);
 
 
-	dev_dbg(codec->dev, "%d ReTune Mobile configurations\n",
+	dev_dbg(component->dev, "%d ReTune Mobile configurations\n",
 		pdata->num_retune_mobile_cfgs);
 
 	if (pdata->num_retune_mobile_cfgs)
 		wm8994_handle_retune_mobile_pdata(wm8994);
 	else
-		snd_soc_add_codec_controls(wm8994->hubs.codec, wm8994_eq_controls,
+		snd_soc_add_component_controls(wm8994->hubs.component, wm8994_eq_controls,
 				     ARRAY_SIZE(wm8994_eq_controls));
 
 	for (i = 0; i < ARRAY_SIZE(pdata->micbias); i++) {
 		if (pdata->micbias[i]) {
-			snd_soc_write(codec, WM8958_MICBIAS1 + i,
+			snd_soc_component_write(component, WM8958_MICBIAS1 + i,
 				pdata->micbias[i] & 0xffff);
 		}
 	}
@@ -3344,7 +3344,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 /**
  * wm8994_mic_detect - Enable microphone detection via the WM8994 IRQ
  *
- * @codec:   WM8994 codec
+ * @component:   WM8994 component
  * @jack:    jack to report detection events on
  * @micbias: microphone bias to detect on
  *
@@ -3356,17 +3356,17 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
  * Configuration of detection levels is available via the micbias1_lvl
  * and micbias2_lvl platform data members.
  */
-int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
+int wm8994_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *jack,
 		      int micbias)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994_micdet *micdet;
 	struct wm8994 *control = wm8994->wm8994;
 	int reg, ret;
 
 	if (control->type != WM8994) {
-		dev_warn(codec->dev, "Not a WM8994\n");
+		dev_warn(component->dev, "Not a WM8994\n");
 		return -EINVAL;
 	}
 
@@ -3386,15 +3386,15 @@ int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 			ret = snd_soc_dapm_disable_pin(dapm, "MICBIAS1");
 		break;
 	default:
-		dev_warn(codec->dev, "Invalid MICBIAS %d\n", micbias);
+		dev_warn(component->dev, "Invalid MICBIAS %d\n", micbias);
 		return -EINVAL;
 	}
 
 	if (ret != 0)
-		dev_warn(codec->dev, "Failed to configure MICBIAS%d: %d\n",
+		dev_warn(component->dev, "Failed to configure MICBIAS%d: %d\n",
 			 micbias, ret);
 
-	dev_dbg(codec->dev, "Configuring microphone detection on %d %p\n",
+	dev_dbg(component->dev, "Configuring microphone detection on %d %p\n",
 		micbias, jack);
 
 	/* Store the configuration */
@@ -3407,10 +3407,10 @@ int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 	else
 		reg = 0;
 
-	snd_soc_update_bits(codec, WM8994_MICBIAS, WM8994_MICD_ENA, reg);
+	snd_soc_component_update_bits(component, WM8994_MICBIAS, WM8994_MICD_ENA, reg);
 
 	/* enable MICDET and MICSHRT deboune */
-	snd_soc_update_bits(codec, WM8994_IRQ_DEBOUNCE,
+	snd_soc_component_update_bits(component, WM8994_IRQ_DEBOUNCE,
 			    WM8994_MIC1_DET_DB_MASK | WM8994_MIC1_SHRT_DB_MASK |
 			    WM8994_MIC2_DET_DB_MASK | WM8994_MIC2_SHRT_DB_MASK,
 			    WM8994_MIC1_DET_DB | WM8994_MIC1_SHRT_DB);
@@ -3488,13 +3488,13 @@ static void wm8994_mic_work(struct work_struct *work)
 static irqreturn_t wm8994_mic_irq(int irq, void *data)
 {
 	struct wm8994_priv *priv = data;
-	struct snd_soc_codec *codec = priv->hubs.codec;
+	struct snd_soc_component *component = priv->hubs.component;
 
 #ifndef CONFIG_SND_SOC_WM8994_MODULE
-	trace_snd_soc_jack_irq(dev_name(codec->dev));
+	trace_snd_soc_jack_irq(dev_name(component->dev));
 #endif
 
-	pm_wakeup_event(codec->dev, 300);
+	pm_wakeup_event(component->dev, 300);
 
 	queue_delayed_work(system_power_efficient_wq,
 			   &priv->mic_work, msecs_to_jiffies(250));
@@ -3503,25 +3503,25 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 }
 
 /* Should be called with accdet_lock held */
-static void wm1811_micd_stop(struct snd_soc_codec *codec)
+static void wm1811_micd_stop(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	if (!wm8994->jackdet)
 		return;
 
-	snd_soc_update_bits(codec, WM8958_MIC_DETECT_1, WM8958_MICD_ENA, 0);
+	snd_soc_component_update_bits(component, WM8958_MIC_DETECT_1, WM8958_MICD_ENA, 0);
 
-	wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_JACK);
+	wm1811_jackdet_set_mode(component, WM1811_JACKDET_MODE_JACK);
 
 	if (wm8994->wm8994->pdata.jd_ext_cap)
 		snd_soc_dapm_disable_pin(dapm, "MICBIAS2");
 }
 
-static void wm8958_button_det(struct snd_soc_codec *codec, u16 status)
+static void wm8958_button_det(struct snd_soc_component *component, u16 status)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	int report;
 
 	report = 0;
@@ -3556,14 +3556,14 @@ static void wm8958_open_circuit_work(struct work_struct *work)
 
 	mutex_lock(&wm8994->accdet_lock);
 
-	wm1811_micd_stop(wm8994->hubs.codec);
+	wm1811_micd_stop(wm8994->hubs.component);
 
 	dev_dbg(dev, "Reporting open circuit\n");
 
 	wm8994->jack_mic = false;
 	wm8994->mic_detecting = true;
 
-	wm8958_micd_set_rate(wm8994->hubs.codec);
+	wm8958_micd_set_rate(wm8994->hubs.component);
 
 	snd_soc_jack_report(wm8994->micdet[0].jack, 0,
 			    wm8994->btn_mask |
@@ -3574,13 +3574,13 @@ static void wm8958_open_circuit_work(struct work_struct *work)
 
 static void wm8958_mic_id(void *data, u16 status)
 {
-	struct snd_soc_codec *codec = data;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = data;
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 
 	/* Either nothing present or just starting detection */
 	if (!(status & WM8958_MICD_STS)) {
 		/* If nothing present then clear our statuses */
-		dev_dbg(codec->dev, "Detected open circuit\n");
+		dev_dbg(component->dev, "Detected open circuit\n");
 
 		queue_delayed_work(system_power_efficient_wq,
 				   &wm8994->open_circuit_work,
@@ -3592,12 +3592,12 @@ static void wm8958_mic_id(void *data, u16 status)
 	 * microphone.
 	 */
 	if (status & 0x600) {
-		dev_dbg(codec->dev, "Detected microphone\n");
+		dev_dbg(component->dev, "Detected microphone\n");
 
 		wm8994->mic_detecting = false;
 		wm8994->jack_mic = true;
 
-		wm8958_micd_set_rate(codec);
+		wm8958_micd_set_rate(component);
 
 		snd_soc_jack_report(wm8994->micdet[0].jack, SND_JACK_HEADSET,
 				    SND_JACK_HEADSET);
@@ -3605,13 +3605,13 @@ static void wm8958_mic_id(void *data, u16 status)
 
 
 	if (status & 0xfc) {
-		dev_dbg(codec->dev, "Detected headphone\n");
+		dev_dbg(component->dev, "Detected headphone\n");
 		wm8994->mic_detecting = false;
 
-		wm8958_micd_set_rate(codec);
+		wm8958_micd_set_rate(component);
 
 		/* If we have jackdet that will detect removal */
-		wm1811_micd_stop(codec);
+		wm1811_micd_stop(component);
 
 		snd_soc_jack_report(wm8994->micdet[0].jack, SND_JACK_HEADPHONE,
 				    SND_JACK_HEADSET);
@@ -3624,10 +3624,10 @@ static void wm1811_mic_work(struct work_struct *work)
 	struct wm8994_priv *wm8994 = container_of(work, struct wm8994_priv,
 						  mic_work.work);
 	struct wm8994 *control = wm8994->wm8994;
-	struct snd_soc_codec *codec = wm8994->hubs.codec;
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = wm8994->hubs.component;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
-	pm_runtime_get_sync(codec->dev);
+	pm_runtime_get_sync(component->dev);
 
 	/* If required for an external cap force MICBIAS on */
 	if (control->pdata.jd_ext_cap) {
@@ -3637,7 +3637,7 @@ static void wm1811_mic_work(struct work_struct *work)
 
 	mutex_lock(&wm8994->accdet_lock);
 
-	dev_dbg(codec->dev, "Starting mic detection\n");
+	dev_dbg(component->dev, "Starting mic detection\n");
 
 	/* Use a user-supplied callback if we have one */
 	if (wm8994->micd_cb) {
@@ -3648,54 +3648,54 @@ static void wm1811_mic_work(struct work_struct *work)
 		 * what's actually there.
 		 */
 		wm8994->mic_detecting = true;
-		wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_MIC);
+		wm1811_jackdet_set_mode(component, WM1811_JACKDET_MODE_MIC);
 
-		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+		snd_soc_component_update_bits(component, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, WM8958_MICD_ENA);
 	}
 
 	mutex_unlock(&wm8994->accdet_lock);
 
-	pm_runtime_put(codec->dev);
+	pm_runtime_put(component->dev);
 }
 
 static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 {
 	struct wm8994_priv *wm8994 = data;
 	struct wm8994 *control = wm8994->wm8994;
-	struct snd_soc_codec *codec = wm8994->hubs.codec;
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = wm8994->hubs.component;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	int reg, delay;
 	bool present;
 
-	pm_runtime_get_sync(codec->dev);
+	pm_runtime_get_sync(component->dev);
 
 	cancel_delayed_work_sync(&wm8994->mic_complete_work);
 
 	mutex_lock(&wm8994->accdet_lock);
 
-	reg = snd_soc_read(codec, WM1811_JACKDET_CTRL);
+	reg = snd_soc_component_read32(component, WM1811_JACKDET_CTRL);
 	if (reg < 0) {
-		dev_err(codec->dev, "Failed to read jack status: %d\n", reg);
+		dev_err(component->dev, "Failed to read jack status: %d\n", reg);
 		mutex_unlock(&wm8994->accdet_lock);
-		pm_runtime_put(codec->dev);
+		pm_runtime_put(component->dev);
 		return IRQ_NONE;
 	}
 
-	dev_dbg(codec->dev, "JACKDET %x\n", reg);
+	dev_dbg(component->dev, "JACKDET %x\n", reg);
 
 	present = reg & WM1811_JACKDET_LVL;
 
 	if (present) {
-		dev_dbg(codec->dev, "Jack detected\n");
+		dev_dbg(component->dev, "Jack detected\n");
 
-		wm8958_micd_set_rate(codec);
+		wm8958_micd_set_rate(component);
 
-		snd_soc_update_bits(codec, WM8958_MICBIAS2,
+		snd_soc_component_update_bits(component, WM8958_MICBIAS2,
 				    WM8958_MICB2_DISCH, 0);
 
 		/* Disable debounce while inserted */
-		snd_soc_update_bits(codec, WM1811_JACKDET_CTRL,
+		snd_soc_component_update_bits(component, WM1811_JACKDET_CTRL,
 				    WM1811_JACKDET_DB, 0);
 
 		delay = control->pdata.micdet_delay;
@@ -3703,22 +3703,22 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 				   &wm8994->mic_work,
 				   msecs_to_jiffies(delay));
 	} else {
-		dev_dbg(codec->dev, "Jack not detected\n");
+		dev_dbg(component->dev, "Jack not detected\n");
 
 		cancel_delayed_work_sync(&wm8994->mic_work);
 
-		snd_soc_update_bits(codec, WM8958_MICBIAS2,
+		snd_soc_component_update_bits(component, WM8958_MICBIAS2,
 				    WM8958_MICB2_DISCH, WM8958_MICB2_DISCH);
 
 		/* Enable debounce while removed */
-		snd_soc_update_bits(codec, WM1811_JACKDET_CTRL,
+		snd_soc_component_update_bits(component, WM1811_JACKDET_CTRL,
 				    WM1811_JACKDET_DB, WM1811_JACKDET_DB);
 
 		wm8994->mic_detecting = false;
 		wm8994->jack_mic = false;
-		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+		snd_soc_component_update_bits(component, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, 0);
-		wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_JACK);
+		wm1811_jackdet_set_mode(component, WM1811_JACKDET_MODE_JACK);
 	}
 
 	mutex_unlock(&wm8994->accdet_lock);
@@ -3739,7 +3739,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	 * avoid bootstrapping issues with the core. */
 	snd_soc_jack_report(wm8994->micdet[0].jack, 0, 0);
 
-	pm_runtime_put(codec->dev);
+	pm_runtime_put(component->dev);
 	return IRQ_HANDLED;
 }
 
@@ -3754,7 +3754,7 @@ static void wm1811_jackdet_bootstrap(struct work_struct *work)
 /**
  * wm8958_mic_detect - Enable microphone detection via the WM8958 IRQ
  *
- * @codec:   WM8958 codec
+ * @component:   WM8958 component
  * @jack:    jack to report detection events on
  *
  * Enable microphone detection functionality for the WM8958.  By
@@ -3767,12 +3767,12 @@ static void wm1811_jackdet_bootstrap(struct work_struct *work)
  * flexiblity a callback is provided which allows a completely custom
  * detection algorithm.
  */
-int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
+int wm8958_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *jack,
 		      wm1811_micdet_cb det_cb, void *det_cb_data,
 		      wm1811_mic_id_cb id_cb, void *id_cb_data)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	u16 micd_lvl_sel;
 
@@ -3803,10 +3803,10 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 			wm8994->mic_id_cb_data = id_cb_data;
 		} else {
 			wm8994->mic_id_cb = wm8958_mic_id;
-			wm8994->mic_id_cb_data = codec;
+			wm8994->mic_id_cb_data = component;
 		}
 
-		wm8958_micd_set_rate(codec);
+		wm8958_micd_set_rate(component);
 
 		/* Detect microphones and short circuits by default */
 		if (control->pdata.micd_lvl_sel)
@@ -3818,10 +3818,10 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 			SND_JACK_BTN_2 | SND_JACK_BTN_3 |
 			SND_JACK_BTN_4 | SND_JACK_BTN_5;
 
-		snd_soc_update_bits(codec, WM8958_MIC_DETECT_2,
+		snd_soc_component_update_bits(component, WM8958_MIC_DETECT_2,
 				    WM8958_MICD_LVL_SEL_MASK, micd_lvl_sel);
 
-		WARN_ON(snd_soc_codec_get_bias_level(codec) > SND_SOC_BIAS_STANDBY);
+		WARN_ON(snd_soc_component_get_bias_level(component) > SND_SOC_BIAS_STANDBY);
 
 		/*
 		 * If we can use jack detection start off with that,
@@ -3829,25 +3829,25 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		 */
 		if (wm8994->jackdet) {
 			/* Disable debounce for the initial detect */
-			snd_soc_update_bits(codec, WM1811_JACKDET_CTRL,
+			snd_soc_component_update_bits(component, WM1811_JACKDET_CTRL,
 					    WM1811_JACKDET_DB, 0);
 
-			snd_soc_update_bits(codec, WM8958_MICBIAS2,
+			snd_soc_component_update_bits(component, WM8958_MICBIAS2,
 					    WM8958_MICB2_DISCH,
 					    WM8958_MICB2_DISCH);
-			snd_soc_update_bits(codec, WM8994_LDO_1,
+			snd_soc_component_update_bits(component, WM8994_LDO_1,
 					    WM8994_LDO1_DISCH, 0);
-			wm1811_jackdet_set_mode(codec,
+			wm1811_jackdet_set_mode(component,
 						WM1811_JACKDET_MODE_JACK);
 		} else {
-			snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+			snd_soc_component_update_bits(component, WM8958_MIC_DETECT_1,
 					    WM8958_MICD_ENA, WM8958_MICD_ENA);
 		}
 
 	} else {
-		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+		snd_soc_component_update_bits(component, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, 0);
-		wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_NONE);
+		wm1811_jackdet_set_mode(component, WM1811_JACKDET_MODE_NONE);
 		snd_soc_dapm_disable_pin(dapm, "CLK_SYS");
 		snd_soc_dapm_sync(dapm);
 	}
@@ -3861,9 +3861,9 @@ static void wm8958_mic_work(struct work_struct *work)
 	struct wm8994_priv *wm8994 = container_of(work,
 						  struct wm8994_priv,
 						  mic_complete_work.work);
-	struct snd_soc_codec *codec = wm8994->hubs.codec;
+	struct snd_soc_component *component = wm8994->hubs.component;
 
-	pm_runtime_get_sync(codec->dev);
+	pm_runtime_get_sync(component->dev);
 
 	mutex_lock(&wm8994->accdet_lock);
 
@@ -3871,13 +3871,13 @@ static void wm8958_mic_work(struct work_struct *work)
 
 	mutex_unlock(&wm8994->accdet_lock);
 
-	pm_runtime_put(codec->dev);
+	pm_runtime_put(component->dev);
 }
 
 static irqreturn_t wm8958_mic_irq(int irq, void *data)
 {
 	struct wm8994_priv *wm8994 = data;
-	struct snd_soc_codec *codec = wm8994->hubs.codec;
+	struct snd_soc_component *component = wm8994->hubs.component;
 	int reg, count, ret, id_delay;
 
 	/*
@@ -3885,30 +3885,30 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 	 * with an update of the MICDET status; if so it will have
 	 * stopped detection and we can ignore this interrupt.
 	 */
-	if (!(snd_soc_read(codec, WM8958_MIC_DETECT_1) & WM8958_MICD_ENA))
+	if (!(snd_soc_component_read32(component, WM8958_MIC_DETECT_1) & WM8958_MICD_ENA))
 		return IRQ_HANDLED;
 
 	cancel_delayed_work_sync(&wm8994->mic_complete_work);
 	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 
-	pm_runtime_get_sync(codec->dev);
+	pm_runtime_get_sync(component->dev);
 
 	/* We may occasionally read a detection without an impedence
 	 * range being provided - if that happens loop again.
 	 */
 	count = 10;
 	do {
-		reg = snd_soc_read(codec, WM8958_MIC_DETECT_3);
+		reg = snd_soc_component_read32(component, WM8958_MIC_DETECT_3);
 		if (reg < 0) {
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"Failed to read mic detect status: %d\n",
 				reg);
-			pm_runtime_put(codec->dev);
+			pm_runtime_put(component->dev);
 			return IRQ_NONE;
 		}
 
 		if (!(reg & WM8958_MICD_VALID)) {
-			dev_dbg(codec->dev, "Mic detect data not valid\n");
+			dev_dbg(component->dev, "Mic detect data not valid\n");
 			goto out;
 		}
 
@@ -3919,20 +3919,20 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 	} while (count--);
 
 	if (count == 0)
-		dev_warn(codec->dev, "No impedance range reported for jack\n");
+		dev_warn(component->dev, "No impedance range reported for jack\n");
 
 #ifndef CONFIG_SND_SOC_WM8994_MODULE
-	trace_snd_soc_jack_irq(dev_name(codec->dev));
+	trace_snd_soc_jack_irq(dev_name(component->dev));
 #endif
 
 	/* Avoid a transient report when the accessory is being removed */
 	if (wm8994->jackdet) {
-		ret = snd_soc_read(codec, WM1811_JACKDET_CTRL);
+		ret = snd_soc_component_read32(component, WM1811_JACKDET_CTRL);
 		if (ret < 0) {
-			dev_err(codec->dev, "Failed to read jack status: %d\n",
+			dev_err(component->dev, "Failed to read jack status: %d\n",
 				ret);
 		} else if (!(ret & WM1811_JACKDET_LVL)) {
-			dev_dbg(codec->dev, "Ignoring removed jack\n");
+			dev_dbg(component->dev, "Ignoring removed jack\n");
 			goto out;
 		}
 	} else if (!(reg & WM8958_MICD_STS)) {
@@ -3951,51 +3951,51 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 				   &wm8994->mic_complete_work,
 				   msecs_to_jiffies(id_delay));
 	else
-		wm8958_button_det(codec, reg);
+		wm8958_button_det(component, reg);
 
 out:
-	pm_runtime_put(codec->dev);
+	pm_runtime_put(component->dev);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t wm8994_fifo_error(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
+	struct snd_soc_component *component = data;
 
-	dev_err(codec->dev, "FIFO error\n");
+	dev_err(component->dev, "FIFO error\n");
 
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t wm8994_temp_warn(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
+	struct snd_soc_component *component = data;
 
-	dev_err(codec->dev, "Thermal warning\n");
+	dev_err(component->dev, "Thermal warning\n");
 
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t wm8994_temp_shut(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
+	struct snd_soc_component *component = data;
 
-	dev_crit(codec->dev, "Thermal shutdown\n");
+	dev_crit(component->dev, "Thermal shutdown\n");
 
 	return IRQ_HANDLED;
 }
 
-static int wm8994_codec_probe(struct snd_soc_codec *codec)
+static int wm8994_component_probe(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct wm8994 *control = dev_get_drvdata(codec->dev->parent);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct wm8994 *control = dev_get_drvdata(component->dev->parent);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	unsigned int reg;
 	int ret, i;
 
-	snd_soc_codec_init_regmap(codec, control->regmap);
+	snd_soc_component_init_regmap(component, control->regmap);
 
-	wm8994->hubs.codec = codec;
+	wm8994->hubs.component = component;
 
 	mutex_init(&wm8994->accdet_lock);
 	INIT_DELAYED_WORK(&wm8994->jackdet_bootstrap,
@@ -4070,7 +4070,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		wm8994->hubs.dcs_codes_l = -9;
 		wm8994->hubs.dcs_codes_r = -7;
 
-		snd_soc_update_bits(codec, WM8994_ANALOGUE_HP_1,
+		snd_soc_component_update_bits(component, WM8994_ANALOGUE_HP_1,
 				    WM1811_HPOUT1_ATTN, WM1811_HPOUT1_ATTN);
 		break;
 
@@ -4079,11 +4079,11 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	}
 
 	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR,
-			   wm8994_fifo_error, "FIFO error", codec);
+			   wm8994_fifo_error, "FIFO error", component);
 	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN,
-			   wm8994_temp_warn, "Thermal warning", codec);
+			   wm8994_temp_warn, "Thermal warning", component);
 	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT,
-			   wm8994_temp_shut, "Thermal shutdown", codec);
+			   wm8994_temp_shut, "Thermal shutdown", component);
 
 	switch (control->type) {
 	case WM8994:
@@ -4101,7 +4101,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 					wm8994);
 
 		if (ret != 0)
-			dev_warn(codec->dev,
+			dev_warn(component->dev,
 				 "Failed to request Mic1 detect IRQ: %d\n",
 				 ret);
 
@@ -4111,7 +4111,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 					 wm8994_mic_irq, "Mic 1 short",
 					 wm8994);
 		if (ret != 0)
-			dev_warn(codec->dev,
+			dev_warn(component->dev,
 				 "Failed to request Mic1 short IRQ: %d\n",
 				 ret);
 
@@ -4120,7 +4120,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 					 wm8994_mic_irq, "Mic 2 detect",
 					 wm8994);
 		if (ret != 0)
-			dev_warn(codec->dev,
+			dev_warn(component->dev,
 				 "Failed to request Mic2 detect IRQ: %d\n",
 				 ret);
 
@@ -4129,7 +4129,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 					 wm8994_mic_irq, "Mic 2 short",
 					 wm8994);
 		if (ret != 0)
-			dev_warn(codec->dev,
+			dev_warn(component->dev,
 				 "Failed to request Mic2 short IRQ: %d\n",
 				 ret);
 		break;
@@ -4144,7 +4144,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 						   "Mic detect",
 						   wm8994);
 			if (ret != 0)
-				dev_warn(codec->dev,
+				dev_warn(component->dev,
 					 "Failed to request Mic detect IRQ: %d\n",
 					 ret);
 		} else {
@@ -4180,7 +4180,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Make sure we can read from the GPIOs if they're inputs */
-	pm_runtime_get_sync(codec->dev);
+	pm_runtime_get_sync(component->dev);
 
 	/* Remember if AIFnLRCLK is configured as a GPIO.  This should be
 	 * configured on init - if a system wants to do this dynamically
@@ -4188,7 +4188,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	 */
 	ret = regmap_read(control->regmap, WM8994_GPIO_1, &reg);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read GPIO1 state: %d\n", ret);
+		dev_err(component->dev, "Failed to read GPIO1 state: %d\n", ret);
 		goto err_irq;
 	}
 	if ((reg & WM8994_GPN_FN_MASK) != WM8994_GP_FN_PIN_SPECIFIC) {
@@ -4200,7 +4200,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	ret = regmap_read(control->regmap, WM8994_GPIO_6, &reg);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read GPIO6 state: %d\n", ret);
+		dev_err(component->dev, "Failed to read GPIO6 state: %d\n", ret);
 		goto err_irq;
 	}
 	if ((reg & WM8994_GPN_FN_MASK) != WM8994_GP_FN_PIN_SPECIFIC) {
@@ -4210,22 +4210,22 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		wm8994->lrclk_shared[1] = 0;
 	}
 
-	pm_runtime_put(codec->dev);
+	pm_runtime_put(component->dev);
 
 	/* Latch volume update bits */
 	for (i = 0; i < ARRAY_SIZE(wm8994_vu_bits); i++)
-		snd_soc_update_bits(codec, wm8994_vu_bits[i].reg,
+		snd_soc_component_update_bits(component, wm8994_vu_bits[i].reg,
 				    wm8994_vu_bits[i].mask,
 				    wm8994_vu_bits[i].mask);
 
 	/* Set the low bit of the 3D stereo depth so TLV matches */
-	snd_soc_update_bits(codec, WM8994_AIF1_DAC1_FILTERS_2,
+	snd_soc_component_update_bits(component, WM8994_AIF1_DAC1_FILTERS_2,
 			    1 << WM8994_AIF1DAC1_3D_GAIN_SHIFT,
 			    1 << WM8994_AIF1DAC1_3D_GAIN_SHIFT);
-	snd_soc_update_bits(codec, WM8994_AIF1_DAC2_FILTERS_2,
+	snd_soc_component_update_bits(component, WM8994_AIF1_DAC2_FILTERS_2,
 			    1 << WM8994_AIF1DAC2_3D_GAIN_SHIFT,
 			    1 << WM8994_AIF1DAC2_3D_GAIN_SHIFT);
-	snd_soc_update_bits(codec, WM8994_AIF2_DAC_FILTERS_2,
+	snd_soc_component_update_bits(component, WM8994_AIF2_DAC_FILTERS_2,
 			    1 << WM8994_AIF2DAC_3D_GAIN_SHIFT,
 			    1 << WM8994_AIF2DAC_3D_GAIN_SHIFT);
 
@@ -4235,7 +4235,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	switch (control->type) {
 	case WM8994:
 	case WM8958:
-		snd_soc_update_bits(codec, WM8994_AIF1_CONTROL_1,
+		snd_soc_component_update_bits(component, WM8994_AIF1_CONTROL_1,
 				    WM8994_AIF1ADC_TDM, WM8994_AIF1ADC_TDM);
 		break;
 	default:
@@ -4246,9 +4246,9 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	switch (control->type) {
 	case WM8958:
 	case WM1811:
-		snd_soc_update_bits(codec, WM8958_MICBIAS1,
+		snd_soc_component_update_bits(component, WM8958_MICBIAS1,
 				    WM8958_MICB1_MODE, WM8958_MICB1_MODE);
-		snd_soc_update_bits(codec, WM8958_MICBIAS2,
+		snd_soc_component_update_bits(component, WM8958_MICBIAS2,
 				    WM8958_MICB2_MODE, WM8958_MICB2_MODE);
 		break;
 	default:
@@ -4256,12 +4256,12 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	}
 
 	wm8994->hubs.check_class_w_digital = wm8994_check_class_w_digital;
-	wm_hubs_update_class_w(codec);
+	wm_hubs_update_class_w(component);
 
 	wm8994_handle_pdata(wm8994);
 
-	wm_hubs_add_analogue_controls(codec);
-	snd_soc_add_codec_controls(codec, wm8994_snd_controls,
+	wm_hubs_add_analogue_controls(component);
+	snd_soc_add_component_controls(component, wm8994_snd_controls,
 			     ARRAY_SIZE(wm8994_snd_controls));
 	snd_soc_dapm_new_controls(dapm, wm8994_dapm_widgets,
 				  ARRAY_SIZE(wm8994_dapm_widgets));
@@ -4287,7 +4287,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		}
 		break;
 	case WM8958:
-		snd_soc_add_codec_controls(codec, wm8958_snd_controls,
+		snd_soc_add_component_controls(component, wm8958_snd_controls,
 				     ARRAY_SIZE(wm8958_snd_controls));
 		snd_soc_dapm_new_controls(dapm, wm8958_dapm_widgets,
 					  ARRAY_SIZE(wm8958_dapm_widgets));
@@ -4309,7 +4309,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 
 	case WM1811:
-		snd_soc_add_codec_controls(codec, wm8958_snd_controls,
+		snd_soc_add_component_controls(component, wm8958_snd_controls,
 				     ARRAY_SIZE(wm8958_snd_controls));
 		snd_soc_dapm_new_controls(dapm, wm8958_dapm_widgets,
 					  ARRAY_SIZE(wm8958_dapm_widgets));
@@ -4322,7 +4322,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
-	wm_hubs_add_analogue_routes(codec, 0, 0);
+	wm_hubs_add_analogue_routes(component, 0, 0);
 	ret = wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_DCS_DONE,
 				 wm_hubs_dcs_done, "DC servo done",
 				 &wm8994->hubs);
@@ -4360,7 +4360,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 						ARRAY_SIZE(wm8958_intercon));
 		}
 
-		wm8958_dsp2_init(codec);
+		wm8958_dsp2_init(component);
 		break;
 	case WM1811:
 		snd_soc_dapm_add_routes(dapm, wm8994_lateclk_intercon,
@@ -4385,16 +4385,16 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 				&wm8994->fll_locked[i]);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
-	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, codec);
-	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, codec);
-	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, codec);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, component);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, component);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, component);
 
 	return ret;
 }
 
-static int wm8994_codec_remove(struct snd_soc_codec *codec)
+static void wm8994_component_remove(struct snd_soc_component *component)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int i;
 
@@ -4404,9 +4404,9 @@ static int wm8994_codec_remove(struct snd_soc_codec *codec)
 
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
-	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, codec);
-	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, codec);
-	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, codec);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, component);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, component);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, component);
 
 	if (wm8994->jackdet)
 		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_GPIO(6), wm8994);
@@ -4433,15 +4433,18 @@ static int wm8994_codec_remove(struct snd_soc_codec *codec)
 	release_firmware(wm8994->mbc_vss);
 	release_firmware(wm8994->enh_eq);
 	kfree(wm8994->retune_mobile_texts);
-	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
-	.probe =	wm8994_codec_probe,
-	.remove =	wm8994_codec_remove,
-	.suspend =	wm8994_codec_suspend,
-	.resume =	wm8994_codec_resume,
-	.set_bias_level = wm8994_set_bias_level,
+static const struct snd_soc_component_driver soc_component_dev_wm8994 = {
+	.probe			= wm8994_component_probe,
+	.remove			= wm8994_component_remove,
+	.suspend		= wm8994_component_suspend,
+	.resume			= wm8994_component_resume,
+	.set_bias_level		= wm8994_set_bias_level,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm8994_probe(struct platform_device *pdev)
@@ -4461,13 +4464,12 @@ static int wm8994_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8994,
+	return devm_snd_soc_register_component(&pdev->dev, &soc_component_dev_wm8994,
 			wm8994_dai, ARRAY_SIZE(wm8994_dai));
 }
 
 static int wm8994_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index dd73387b1cc4..a72efb0e6867 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -43,18 +43,18 @@ enum wm8994_vmid_mode {
 typedef void (*wm1811_micdet_cb)(void *data);
 typedef void (*wm1811_mic_id_cb)(void *data, u16 status);
 
-int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
+int wm8994_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *jack,
 		      int micbias);
-int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
+int wm8958_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *jack,
 		      wm1811_micdet_cb cb, void *det_cb_data,
 		      wm1811_mic_id_cb id_cb, void *id_cb_data);
 
-int wm8994_vmid_mode(struct snd_soc_codec *codec, enum wm8994_vmid_mode mode);
+int wm8994_vmid_mode(struct snd_soc_component *component, enum wm8994_vmid_mode mode);
 
 int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event);
 
-void wm8958_dsp2_init(struct snd_soc_codec *codec);
+void wm8958_dsp2_init(struct snd_soc_component *component);
 
 struct wm8994_micdet {
 	struct snd_soc_jack *jack;
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 63b2745f8169..fed6ea9b019f 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -60,9 +60,9 @@ static const char *speaker_mode_text[] = {
 static SOC_ENUM_SINGLE_DECL(speaker_mode,
 			    WM8993_SPKMIXR_ATTENUATION, 8, speaker_mode_text);
 
-static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
+static void wait_for_dc_servo(struct snd_soc_component *component, unsigned int op)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	unsigned int reg;
 	int count = 0;
 	int timeout;
@@ -71,9 +71,9 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
 	val = op | WM8993_DCS_ENA_CHAN_0 | WM8993_DCS_ENA_CHAN_1;
 
 	/* Trigger the command */
-	snd_soc_write(codec, WM8993_DC_SERVO_0, val);
+	snd_soc_component_write(component, WM8993_DC_SERVO_0, val);
 
-	dev_dbg(codec->dev, "Waiting for DC servo...\n");
+	dev_dbg(component->dev, "Waiting for DC servo...\n");
 
 	if (hubs->dcs_done_irq)
 		timeout = 4;
@@ -89,12 +89,12 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
 		else
 			msleep(1);
 
-		reg = snd_soc_read(codec, WM8993_DC_SERVO_0);
-		dev_dbg(codec->dev, "DC servo: %x\n", reg);
+		reg = snd_soc_component_read32(component, WM8993_DC_SERVO_0);
+		dev_dbg(component->dev, "DC servo: %x\n", reg);
 	} while (reg & op && count < timeout);
 
 	if (reg & op)
-		dev_err(codec->dev, "Timed out waiting for DC Servo %x\n",
+		dev_err(component->dev, "Timed out waiting for DC Servo %x\n",
 			op);
 }
 
@@ -108,35 +108,35 @@ irqreturn_t wm_hubs_dcs_done(int irq, void *data)
 }
 EXPORT_SYMBOL_GPL(wm_hubs_dcs_done);
 
-static bool wm_hubs_dac_hp_direct(struct snd_soc_codec *codec)
+static bool wm_hubs_dac_hp_direct(struct snd_soc_component *component)
 {
 	int reg;
 
 	/* If we're going via the mixer we'll need to do additional checks */
-	reg = snd_soc_read(codec, WM8993_OUTPUT_MIXER1);
+	reg = snd_soc_component_read32(component, WM8993_OUTPUT_MIXER1);
 	if (!(reg & WM8993_DACL_TO_HPOUT1L)) {
 		if (reg & ~WM8993_DACL_TO_MIXOUTL) {
-			dev_vdbg(codec->dev, "Analogue paths connected: %x\n",
+			dev_vdbg(component->dev, "Analogue paths connected: %x\n",
 				 reg & ~WM8993_DACL_TO_HPOUT1L);
 			return false;
 		} else {
-			dev_vdbg(codec->dev, "HPL connected to mixer\n");
+			dev_vdbg(component->dev, "HPL connected to mixer\n");
 		}
 	} else {
-		dev_vdbg(codec->dev, "HPL connected to DAC\n");
+		dev_vdbg(component->dev, "HPL connected to DAC\n");
 	}
 
-	reg = snd_soc_read(codec, WM8993_OUTPUT_MIXER2);
+	reg = snd_soc_component_read32(component, WM8993_OUTPUT_MIXER2);
 	if (!(reg & WM8993_DACR_TO_HPOUT1R)) {
 		if (reg & ~WM8993_DACR_TO_MIXOUTR) {
-			dev_vdbg(codec->dev, "Analogue paths connected: %x\n",
+			dev_vdbg(component->dev, "Analogue paths connected: %x\n",
 				 reg & ~WM8993_DACR_TO_HPOUT1R);
 			return false;
 		} else {
-			dev_vdbg(codec->dev, "HPR connected to mixer\n");
+			dev_vdbg(component->dev, "HPR connected to mixer\n");
 		}
 	} else {
-		dev_vdbg(codec->dev, "HPR connected to DAC\n");
+		dev_vdbg(component->dev, "HPR connected to DAC\n");
 	}
 
 	return true;
@@ -149,17 +149,17 @@ struct wm_hubs_dcs_cache {
 	u16 dcs_cfg;
 };
 
-static bool wm_hubs_dcs_cache_get(struct snd_soc_codec *codec,
+static bool wm_hubs_dcs_cache_get(struct snd_soc_component *component,
 				  struct wm_hubs_dcs_cache **entry)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	struct wm_hubs_dcs_cache *cache;
 	unsigned int left, right;
 
-	left = snd_soc_read(codec, WM8993_LEFT_OUTPUT_VOLUME);
+	left = snd_soc_component_read32(component, WM8993_LEFT_OUTPUT_VOLUME);
 	left &= WM8993_HPOUT1L_VOL_MASK;
 
-	right = snd_soc_read(codec, WM8993_RIGHT_OUTPUT_VOLUME);
+	right = snd_soc_component_read32(component, WM8993_RIGHT_OUTPUT_VOLUME);
 	right &= WM8993_HPOUT1R_VOL_MASK;
 
 	list_for_each_entry(cache, &hubs->dcs_cache, list) {
@@ -173,22 +173,22 @@ static bool wm_hubs_dcs_cache_get(struct snd_soc_codec *codec,
 	return false;
 }
 
-static void wm_hubs_dcs_cache_set(struct snd_soc_codec *codec, u16 dcs_cfg)
+static void wm_hubs_dcs_cache_set(struct snd_soc_component *component, u16 dcs_cfg)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	struct wm_hubs_dcs_cache *cache;
 
 	if (hubs->no_cache_dac_hp_direct)
 		return;
 
-	cache = devm_kzalloc(codec->dev, sizeof(*cache), GFP_KERNEL);
+	cache = devm_kzalloc(component->dev, sizeof(*cache), GFP_KERNEL);
 	if (!cache)
 		return;
 
-	cache->left = snd_soc_read(codec, WM8993_LEFT_OUTPUT_VOLUME);
+	cache->left = snd_soc_component_read32(component, WM8993_LEFT_OUTPUT_VOLUME);
 	cache->left &= WM8993_HPOUT1L_VOL_MASK;
 
-	cache->right = snd_soc_read(codec, WM8993_RIGHT_OUTPUT_VOLUME);
+	cache->right = snd_soc_component_read32(component, WM8993_RIGHT_OUTPUT_VOLUME);
 	cache->right &= WM8993_HPOUT1R_VOL_MASK;
 
 	cache->dcs_cfg = dcs_cfg;
@@ -196,10 +196,10 @@ static void wm_hubs_dcs_cache_set(struct snd_soc_codec *codec, u16 dcs_cfg)
 	list_add_tail(&cache->list, &hubs->dcs_cache);
 }
 
-static int wm_hubs_read_dc_servo(struct snd_soc_codec *codec,
+static int wm_hubs_read_dc_servo(struct snd_soc_component *component,
 				  u16 *reg_l, u16 *reg_r)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	u16 dcs_reg, reg;
 	int ret = 0;
 
@@ -220,14 +220,14 @@ static int wm_hubs_read_dc_servo(struct snd_soc_codec *codec,
 	 */
 	switch (hubs->dcs_readback_mode) {
 	case 0:
-		*reg_l = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_1)
+		*reg_l = snd_soc_component_read32(component, WM8993_DC_SERVO_READBACK_1)
 			& WM8993_DCS_INTEG_CHAN_0_MASK;
-		*reg_r = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_2)
+		*reg_r = snd_soc_component_read32(component, WM8993_DC_SERVO_READBACK_2)
 			& WM8993_DCS_INTEG_CHAN_1_MASK;
 		break;
 	case 2:
 	case 1:
-		reg = snd_soc_read(codec, dcs_reg);
+		reg = snd_soc_component_read32(component, dcs_reg);
 		*reg_r = (reg & WM8993_DCS_DAC_WR_VAL_1_MASK)
 			>> WM8993_DCS_DAC_WR_VAL_1_SHIFT;
 		*reg_l = reg & WM8993_DCS_DAC_WR_VAL_0_MASK;
@@ -242,9 +242,9 @@ static int wm_hubs_read_dc_servo(struct snd_soc_codec *codec,
 /*
  * Startup calibration of the DC servo
  */
-static void enable_dc_servo(struct snd_soc_codec *codec)
+static void enable_dc_servo(struct snd_soc_component *component)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	struct wm_hubs_dcs_cache *cache;
 	s8 offset;
 	u16 reg_l, reg_r, dcs_cfg, dcs_reg;
@@ -260,12 +260,12 @@ static void enable_dc_servo(struct snd_soc_codec *codec)
 
 	/* If we're using a digital only path and have a previously
 	 * callibrated DC servo offset stored then use that. */
-	if (wm_hubs_dac_hp_direct(codec) &&
-	    wm_hubs_dcs_cache_get(codec, &cache)) {
-		dev_dbg(codec->dev, "Using cached DCS offset %x for %d,%d\n",
+	if (wm_hubs_dac_hp_direct(component) &&
+	    wm_hubs_dcs_cache_get(component, &cache)) {
+		dev_dbg(component->dev, "Using cached DCS offset %x for %d,%d\n",
 			cache->dcs_cfg, cache->left, cache->right);
-		snd_soc_write(codec, dcs_reg, cache->dcs_cfg);
-		wait_for_dc_servo(codec,
+		snd_soc_component_write(component, dcs_reg, cache->dcs_cfg);
+		wait_for_dc_servo(component,
 				  WM8993_DCS_TRIG_DAC_WR_0 |
 				  WM8993_DCS_TRIG_DAC_WR_1);
 		return;
@@ -273,48 +273,48 @@ static void enable_dc_servo(struct snd_soc_codec *codec)
 
 	if (hubs->series_startup) {
 		/* Set for 32 series updates */
-		snd_soc_update_bits(codec, WM8993_DC_SERVO_1,
+		snd_soc_component_update_bits(component, WM8993_DC_SERVO_1,
 				    WM8993_DCS_SERIES_NO_01_MASK,
 				    32 << WM8993_DCS_SERIES_NO_01_SHIFT);
-		wait_for_dc_servo(codec,
+		wait_for_dc_servo(component,
 				  WM8993_DCS_TRIG_SERIES_0 |
 				  WM8993_DCS_TRIG_SERIES_1);
 	} else {
-		wait_for_dc_servo(codec,
+		wait_for_dc_servo(component,
 				  WM8993_DCS_TRIG_STARTUP_0 |
 				  WM8993_DCS_TRIG_STARTUP_1);
 	}
 
-	if (wm_hubs_read_dc_servo(codec, &reg_l, &reg_r) < 0)
+	if (wm_hubs_read_dc_servo(component, &reg_l, &reg_r) < 0)
 		return;
 
-	dev_dbg(codec->dev, "DCS input: %x %x\n", reg_l, reg_r);
+	dev_dbg(component->dev, "DCS input: %x %x\n", reg_l, reg_r);
 
 	/* Apply correction to DC servo result */
 	if (hubs->dcs_codes_l || hubs->dcs_codes_r) {
-		dev_dbg(codec->dev,
+		dev_dbg(component->dev,
 			"Applying %d/%d code DC servo correction\n",
 			hubs->dcs_codes_l, hubs->dcs_codes_r);
 
 		/* HPOUT1R */
 		offset = (s8)reg_r;
-		dev_dbg(codec->dev, "DCS right %d->%d\n", offset,
+		dev_dbg(component->dev, "DCS right %d->%d\n", offset,
 			offset + hubs->dcs_codes_r);
 		offset += hubs->dcs_codes_r;
 		dcs_cfg = (u8)offset << WM8993_DCS_DAC_WR_VAL_1_SHIFT;
 
 		/* HPOUT1L */
 		offset = (s8)reg_l;
-		dev_dbg(codec->dev, "DCS left %d->%d\n", offset,
+		dev_dbg(component->dev, "DCS left %d->%d\n", offset,
 			offset + hubs->dcs_codes_l);
 		offset += hubs->dcs_codes_l;
 		dcs_cfg |= (u8)offset;
 
-		dev_dbg(codec->dev, "DCS result: %x\n", dcs_cfg);
+		dev_dbg(component->dev, "DCS result: %x\n", dcs_cfg);
 
 		/* Do it */
-		snd_soc_write(codec, dcs_reg, dcs_cfg);
-		wait_for_dc_servo(codec,
+		snd_soc_component_write(component, dcs_reg, dcs_cfg);
+		wait_for_dc_servo(component,
 				  WM8993_DCS_TRIG_DAC_WR_0 |
 				  WM8993_DCS_TRIG_DAC_WR_1);
 	} else {
@@ -324,8 +324,8 @@ static void enable_dc_servo(struct snd_soc_codec *codec)
 
 	/* Save the callibrated offset if we're in class W mode and
 	 * therefore don't have any analogue signal mixed in. */
-	if (wm_hubs_dac_hp_direct(codec))
-		wm_hubs_dcs_cache_set(codec, dcs_cfg);
+	if (wm_hubs_dac_hp_direct(component))
+		wm_hubs_dcs_cache_set(component, dcs_cfg);
 }
 
 /*
@@ -334,8 +334,8 @@ static void enable_dc_servo(struct snd_soc_codec *codec)
 static int wm8993_put_dc_servo(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = snd_soc_put_volsw(kcontrol, ucontrol);
@@ -346,9 +346,9 @@ static int wm8993_put_dc_servo(struct snd_kcontrol *kcontrol,
 		return ret;
 
 	/* Only need to do this if the outputs are active */
-	if (snd_soc_read(codec, WM8993_POWER_MANAGEMENT_1)
+	if (snd_soc_component_read32(component, WM8993_POWER_MANAGEMENT_1)
 	    & (WM8993_HPOUT1L_ENA | WM8993_HPOUT1R_ENA))
-		snd_soc_update_bits(codec,
+		snd_soc_component_update_bits(component,
 				    WM8993_DC_SERVO_0,
 				    WM8993_DCS_TRIG_SINGLE_0 |
 				    WM8993_DCS_TRIG_SINGLE_1,
@@ -499,8 +499,8 @@ SOC_SINGLE_TLV("LINEOUT2 Volume", WM8993_LINE_OUTPUTS_VOLUME, 0, 1, 1,
 static int hp_supply_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -509,28 +509,28 @@ static int hp_supply_event(struct snd_soc_dapm_widget *w,
 			break;
 		case 1:
 			/* Enable the headphone amp */
-			snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_1,
+			snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_1,
 					    WM8993_HPOUT1L_ENA |
 					    WM8993_HPOUT1R_ENA,
 					    WM8993_HPOUT1L_ENA |
 					    WM8993_HPOUT1R_ENA);
 
 			/* Enable the second stage */
-			snd_soc_update_bits(codec, WM8993_ANALOGUE_HP_0,
+			snd_soc_component_update_bits(component, WM8993_ANALOGUE_HP_0,
 					    WM8993_HPOUT1L_DLY |
 					    WM8993_HPOUT1R_DLY,
 					    WM8993_HPOUT1L_DLY |
 					    WM8993_HPOUT1R_DLY);
 			break;
 		default:
-			dev_err(codec->dev, "Unknown HP startup mode %d\n",
+			dev_err(component->dev, "Unknown HP startup mode %d\n",
 				hubs->hp_startup_mode);
 			break;
 		}
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(codec, WM8993_CHARGE_PUMP_1,
+		snd_soc_component_update_bits(component, WM8993_CHARGE_PUMP_1,
 				    WM8993_CP_ENA, 0);
 		break;
 	}
@@ -541,47 +541,47 @@ static int hp_supply_event(struct snd_soc_dapm_widget *w,
 static int hp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	unsigned int reg = snd_soc_read(codec, WM8993_ANALOGUE_HP_0);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	unsigned int reg = snd_soc_component_read32(component, WM8993_ANALOGUE_HP_0);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_update_bits(codec, WM8993_CHARGE_PUMP_1,
+		snd_soc_component_update_bits(component, WM8993_CHARGE_PUMP_1,
 				    WM8993_CP_ENA, WM8993_CP_ENA);
 
 		msleep(5);
 
-		snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_1,
 				    WM8993_HPOUT1L_ENA | WM8993_HPOUT1R_ENA,
 				    WM8993_HPOUT1L_ENA | WM8993_HPOUT1R_ENA);
 
 		reg |= WM8993_HPOUT1L_DLY | WM8993_HPOUT1R_DLY;
-		snd_soc_write(codec, WM8993_ANALOGUE_HP_0, reg);
+		snd_soc_component_write(component, WM8993_ANALOGUE_HP_0, reg);
 
-		snd_soc_update_bits(codec, WM8993_DC_SERVO_1,
+		snd_soc_component_update_bits(component, WM8993_DC_SERVO_1,
 				    WM8993_DCS_TIMER_PERIOD_01_MASK, 0);
 
-		enable_dc_servo(codec);
+		enable_dc_servo(component);
 
 		reg |= WM8993_HPOUT1R_OUTP | WM8993_HPOUT1R_RMV_SHORT |
 			WM8993_HPOUT1L_OUTP | WM8993_HPOUT1L_RMV_SHORT;
-		snd_soc_write(codec, WM8993_ANALOGUE_HP_0, reg);
+		snd_soc_component_write(component, WM8993_ANALOGUE_HP_0, reg);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(codec, WM8993_ANALOGUE_HP_0,
+		snd_soc_component_update_bits(component, WM8993_ANALOGUE_HP_0,
 				    WM8993_HPOUT1L_OUTP |
 				    WM8993_HPOUT1R_OUTP |
 				    WM8993_HPOUT1L_RMV_SHORT |
 				    WM8993_HPOUT1R_RMV_SHORT, 0);
 
-		snd_soc_update_bits(codec, WM8993_ANALOGUE_HP_0,
+		snd_soc_component_update_bits(component, WM8993_ANALOGUE_HP_0,
 				    WM8993_HPOUT1L_DLY |
 				    WM8993_HPOUT1R_DLY, 0);
 
-		snd_soc_write(codec, WM8993_DC_SERVO_0, 0);
+		snd_soc_component_write(component, WM8993_DC_SERVO_0, 0);
 
-		snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_1,
 				    WM8993_HPOUT1L_ENA | WM8993_HPOUT1R_ENA,
 				    0);
 		break;
@@ -593,18 +593,18 @@ static int hp_event(struct snd_soc_dapm_widget *w,
 static int earpiece_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *control, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	u16 reg = snd_soc_read(codec, WM8993_ANTIPOP1) & ~WM8993_HPOUT2_IN_ENA;
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	u16 reg = snd_soc_component_read32(component, WM8993_ANTIPOP1) & ~WM8993_HPOUT2_IN_ENA;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		reg |= WM8993_HPOUT2_IN_ENA;
-		snd_soc_write(codec, WM8993_ANTIPOP1, reg);
+		snd_soc_component_write(component, WM8993_ANTIPOP1, reg);
 		udelay(50);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_write(codec, WM8993_ANTIPOP1, reg);
+		snd_soc_component_write(component, WM8993_ANTIPOP1, reg);
 		break;
 
 	default:
@@ -618,8 +618,8 @@ static int earpiece_event(struct snd_soc_dapm_widget *w,
 static int lineout_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *control, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	bool *flag;
 
 	switch (w->shift) {
@@ -648,8 +648,8 @@ static int lineout_event(struct snd_soc_dapm_widget *w,
 static int micbias_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 
 	switch (w->shift) {
 	case WM8993_MICB1_ENA_SHIFT:
@@ -667,26 +667,26 @@ static int micbias_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-void wm_hubs_update_class_w(struct snd_soc_codec *codec)
+void wm_hubs_update_class_w(struct snd_soc_component *component)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	int enable = WM8993_CP_DYN_V | WM8993_CP_DYN_FREQ;
 
-	if (!wm_hubs_dac_hp_direct(codec))
+	if (!wm_hubs_dac_hp_direct(component))
 		enable = false;
 
-	if (hubs->check_class_w_digital && !hubs->check_class_w_digital(codec))
+	if (hubs->check_class_w_digital && !hubs->check_class_w_digital(component))
 		enable = false;
 
-	dev_vdbg(codec->dev, "Class W %s\n", enable ? "enabled" : "disabled");
+	dev_vdbg(component->dev, "Class W %s\n", enable ? "enabled" : "disabled");
 
-	snd_soc_update_bits(codec, WM8993_CLASS_W_0,
+	snd_soc_component_update_bits(component, WM8993_CLASS_W_0,
 			    WM8993_CP_DYN_V | WM8993_CP_DYN_FREQ, enable);
 
-	snd_soc_write(codec, WM8993_LEFT_OUTPUT_VOLUME,
-		      snd_soc_read(codec, WM8993_LEFT_OUTPUT_VOLUME));
-	snd_soc_write(codec, WM8993_RIGHT_OUTPUT_VOLUME,
-		      snd_soc_read(codec, WM8993_RIGHT_OUTPUT_VOLUME));
+	snd_soc_component_write(component, WM8993_LEFT_OUTPUT_VOLUME,
+		      snd_soc_component_read32(component, WM8993_LEFT_OUTPUT_VOLUME));
+	snd_soc_component_write(component, WM8993_RIGHT_OUTPUT_VOLUME,
+		      snd_soc_component_read32(component, WM8993_RIGHT_OUTPUT_VOLUME));
 }
 EXPORT_SYMBOL_GPL(wm_hubs_update_class_w);
 
@@ -697,12 +697,12 @@ EXPORT_SYMBOL_GPL(wm_hubs_update_class_w);
 static int class_w_put_volsw(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
 	int ret;
 
 	ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
 
-	wm_hubs_update_class_w(codec);
+	wm_hubs_update_class_w(component);
 
 	return ret;
 }
@@ -717,12 +717,12 @@ static int class_w_put_volsw(struct snd_kcontrol *kcontrol,
 static int class_w_put_double(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
 	int ret;
 
 	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
 
-	wm_hubs_update_class_w(codec);
+	wm_hubs_update_class_w(component);
 
 	return ret;
 }
@@ -1113,40 +1113,40 @@ static const struct snd_soc_dapm_route lineout2_se_routes[] = {
 	{ "LINEOUT2P Driver", NULL, "LINEOUT2P Mixer" },
 };
 
-int wm_hubs_add_analogue_controls(struct snd_soc_codec *codec)
+int wm_hubs_add_analogue_controls(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	/* Latch volume update bits & default ZC on */
-	snd_soc_update_bits(codec, WM8993_LEFT_LINE_INPUT_1_2_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_LEFT_LINE_INPUT_1_2_VOLUME,
 			    WM8993_IN1_VU, WM8993_IN1_VU);
-	snd_soc_update_bits(codec, WM8993_RIGHT_LINE_INPUT_1_2_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_RIGHT_LINE_INPUT_1_2_VOLUME,
 			    WM8993_IN1_VU, WM8993_IN1_VU);
-	snd_soc_update_bits(codec, WM8993_LEFT_LINE_INPUT_3_4_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_LEFT_LINE_INPUT_3_4_VOLUME,
 			    WM8993_IN2_VU, WM8993_IN2_VU);
-	snd_soc_update_bits(codec, WM8993_RIGHT_LINE_INPUT_3_4_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_RIGHT_LINE_INPUT_3_4_VOLUME,
 			    WM8993_IN2_VU, WM8993_IN2_VU);
 
-	snd_soc_update_bits(codec, WM8993_SPEAKER_VOLUME_LEFT,
+	snd_soc_component_update_bits(component, WM8993_SPEAKER_VOLUME_LEFT,
 			    WM8993_SPKOUT_VU, WM8993_SPKOUT_VU);
-	snd_soc_update_bits(codec, WM8993_SPEAKER_VOLUME_RIGHT,
+	snd_soc_component_update_bits(component, WM8993_SPEAKER_VOLUME_RIGHT,
 			    WM8993_SPKOUT_VU, WM8993_SPKOUT_VU);
 
-	snd_soc_update_bits(codec, WM8993_LEFT_OUTPUT_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_LEFT_OUTPUT_VOLUME,
 			    WM8993_HPOUT1_VU | WM8993_HPOUT1L_ZC,
 			    WM8993_HPOUT1_VU | WM8993_HPOUT1L_ZC);
-	snd_soc_update_bits(codec, WM8993_RIGHT_OUTPUT_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_RIGHT_OUTPUT_VOLUME,
 			    WM8993_HPOUT1_VU | WM8993_HPOUT1R_ZC,
 			    WM8993_HPOUT1_VU | WM8993_HPOUT1R_ZC);
 
-	snd_soc_update_bits(codec, WM8993_LEFT_OPGA_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_LEFT_OPGA_VOLUME,
 			    WM8993_MIXOUTL_ZC | WM8993_MIXOUT_VU,
 			    WM8993_MIXOUTL_ZC | WM8993_MIXOUT_VU);
-	snd_soc_update_bits(codec, WM8993_RIGHT_OPGA_VOLUME,
+	snd_soc_component_update_bits(component, WM8993_RIGHT_OPGA_VOLUME,
 			    WM8993_MIXOUTR_ZC | WM8993_MIXOUT_VU,
 			    WM8993_MIXOUTR_ZC | WM8993_MIXOUT_VU);
 
-	snd_soc_add_codec_controls(codec, analogue_snd_controls,
+	snd_soc_add_component_controls(component, analogue_snd_controls,
 			     ARRAY_SIZE(analogue_snd_controls));
 
 	snd_soc_dapm_new_controls(dapm, analogue_dapm_widgets,
@@ -1155,13 +1155,13 @@ int wm_hubs_add_analogue_controls(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(wm_hubs_add_analogue_controls);
 
-int wm_hubs_add_analogue_routes(struct snd_soc_codec *codec,
+int wm_hubs_add_analogue_routes(struct snd_soc_component *component,
 				int lineout1_diff, int lineout2_diff)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
-	hubs->codec = codec;
+	hubs->component = component;
 
 	INIT_LIST_HEAD(&hubs->dcs_cache);
 	init_completion(&hubs->dcs_done);
@@ -1191,14 +1191,14 @@ int wm_hubs_add_analogue_routes(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(wm_hubs_add_analogue_routes);
 
-int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *codec,
+int wm_hubs_handle_analogue_pdata(struct snd_soc_component *component,
 				  int lineout1_diff, int lineout2_diff,
 				  int lineout1fb, int lineout2fb,
 				  int jd_scthr, int jd_thr,
 				  int micbias1_delay, int micbias2_delay,
 				  int micbias1_lvl, int micbias2_lvl)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 
 	hubs->lineout1_se = !lineout1_diff;
 	hubs->lineout2_se = !lineout2_diff;
@@ -1206,28 +1206,28 @@ int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *codec,
 	hubs->micb2_delay = micbias2_delay;
 
 	if (!lineout1_diff)
-		snd_soc_update_bits(codec, WM8993_LINE_MIXER1,
+		snd_soc_component_update_bits(component, WM8993_LINE_MIXER1,
 				    WM8993_LINEOUT1_MODE,
 				    WM8993_LINEOUT1_MODE);
 	if (!lineout2_diff)
-		snd_soc_update_bits(codec, WM8993_LINE_MIXER2,
+		snd_soc_component_update_bits(component, WM8993_LINE_MIXER2,
 				    WM8993_LINEOUT2_MODE,
 				    WM8993_LINEOUT2_MODE);
 
 	if (!lineout1_diff && !lineout2_diff)
-		snd_soc_update_bits(codec, WM8993_ANTIPOP1,
+		snd_soc_component_update_bits(component, WM8993_ANTIPOP1,
 				    WM8993_LINEOUT_VMID_BUF_ENA,
 				    WM8993_LINEOUT_VMID_BUF_ENA);
 
 	if (lineout1fb)
-		snd_soc_update_bits(codec, WM8993_ADDITIONAL_CONTROL,
+		snd_soc_component_update_bits(component, WM8993_ADDITIONAL_CONTROL,
 				    WM8993_LINEOUT1_FB, WM8993_LINEOUT1_FB);
 
 	if (lineout2fb)
-		snd_soc_update_bits(codec, WM8993_ADDITIONAL_CONTROL,
+		snd_soc_component_update_bits(component, WM8993_ADDITIONAL_CONTROL,
 				    WM8993_LINEOUT2_FB, WM8993_LINEOUT2_FB);
 
-	snd_soc_update_bits(codec, WM8993_MICBIAS,
+	snd_soc_component_update_bits(component, WM8993_MICBIAS,
 			    WM8993_JD_SCTHR_MASK | WM8993_JD_THR_MASK |
 			    WM8993_MICB1_LVL | WM8993_MICB2_LVL,
 			    jd_scthr << WM8993_JD_SCTHR_SHIFT |
@@ -1239,9 +1239,9 @@ int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(wm_hubs_handle_analogue_pdata);
 
-void wm_hubs_vmid_ena(struct snd_soc_codec *codec)
+void wm_hubs_vmid_ena(struct snd_soc_component *component)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	int val = 0;
 
 	if (hubs->lineout1_se)
@@ -1251,20 +1251,20 @@ void wm_hubs_vmid_ena(struct snd_soc_codec *codec)
 		val |= WM8993_LINEOUT2N_ENA | WM8993_LINEOUT2P_ENA;
 
 	/* Enable the line outputs while we power up */
-	snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_3, val, val);
+	snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_3, val, val);
 }
 EXPORT_SYMBOL_GPL(wm_hubs_vmid_ena);
 
-void wm_hubs_set_bias_level(struct snd_soc_codec *codec,
+void wm_hubs_set_bias_level(struct snd_soc_component *component,
 			    enum snd_soc_bias_level level)
 {
-	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	struct wm_hubs_data *hubs = snd_soc_component_get_drvdata(component);
 	int mask, val;
 
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
 		/* Clamp the inputs to VMID while we ramp to charge caps */
-		snd_soc_update_bits(codec, WM8993_INPUTS_CLAMP_REG,
+		snd_soc_component_update_bits(component, WM8993_INPUTS_CLAMP_REG,
 				    WM8993_INPUTS_CLAMP, WM8993_INPUTS_CLAMP);
 		break;
 
@@ -1291,11 +1291,11 @@ void wm_hubs_set_bias_level(struct snd_soc_codec *codec,
 		if (hubs->lineout2_se && hubs->lineout2p_ena)
 			val |= WM8993_LINEOUT2P_ENA;
 
-		snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_3,
+		snd_soc_component_update_bits(component, WM8993_POWER_MANAGEMENT_3,
 				    mask, val);
 
 		/* Remove the input clamps */
-		snd_soc_update_bits(codec, WM8993_INPUTS_CLAMP_REG,
+		snd_soc_component_update_bits(component, WM8993_INPUTS_CLAMP_REG,
 				    WM8993_INPUTS_CLAMP, 0);
 		break;
 
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index 24c763df21f9..ee339ad8514d 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -19,7 +19,7 @@
 #include <linux/list.h>
 #include <sound/control.h>
 
-struct snd_soc_codec;
+struct snd_soc_component;
 
 extern const unsigned int wm_hubs_spkmix_tlv[];
 
@@ -34,7 +34,7 @@ struct wm_hubs_data {
 
 	bool no_cache_dac_hp_direct;
 	struct list_head dcs_cache;
-	bool (*check_class_w_digital)(struct snd_soc_codec *);
+	bool (*check_class_w_digital)(struct snd_soc_component *);
 
 	int micb1_delay;
 	int micb2_delay;
@@ -50,12 +50,12 @@ struct wm_hubs_data {
 	bool dcs_done_irq;
 	struct completion dcs_done;
 
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 };
 
-extern int wm_hubs_add_analogue_controls(struct snd_soc_codec *);
-extern int wm_hubs_add_analogue_routes(struct snd_soc_codec *, int, int);
-extern int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *,
+extern int wm_hubs_add_analogue_controls(struct snd_soc_component *);
+extern int wm_hubs_add_analogue_routes(struct snd_soc_component *, int, int);
+extern int wm_hubs_handle_analogue_pdata(struct snd_soc_component *,
 					 int lineout1_diff, int lineout2_diff,
 					 int lineout1fb, int lineout2fb,
 					 int jd_scthr, int jd_thr,
@@ -63,10 +63,10 @@ extern int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *,
 					 int micbias1_lvl, int micbias2_lvl);
 
 extern irqreturn_t wm_hubs_dcs_done(int irq, void *data);
-extern void wm_hubs_vmid_ena(struct snd_soc_codec *codec);
-extern void wm_hubs_set_bias_level(struct snd_soc_codec *codec,
+extern void wm_hubs_vmid_ena(struct snd_soc_component *component);
+extern void wm_hubs_set_bias_level(struct snd_soc_component *component,
 				   enum snd_soc_bias_level level);
-extern void wm_hubs_update_class_w(struct snd_soc_codec *codec);
+extern void wm_hubs_update_class_w(struct snd_soc_component *component);
 
 extern const struct snd_kcontrol_new wm_hubs_hpl_mux;
 extern const struct snd_kcontrol_new wm_hubs_hpr_mux;
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 7cb204e649ca..087f8d738dfb 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -258,13 +258,13 @@ static struct snd_soc_jack littlemill_headset;
 static int littlemill_late_probe(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct snd_soc_dai *aif1_dai;
 	struct snd_soc_dai *aif2_dai;
 	int ret;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
-	codec = rtd->codec;
+	component = rtd->codec_dai->component;
 	aif1_dai = rtd->codec_dai;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
@@ -290,10 +290,10 @@ static int littlemill_late_probe(struct snd_soc_card *card)
 		return ret;
 
 	/* This will check device compatibility itself */
-	wm8958_mic_detect(codec, &littlemill_headset, NULL, NULL, NULL, NULL);
+	wm8958_mic_detect(component, &littlemill_headset, NULL, NULL, NULL, NULL);
 
 	/* As will this */
-	wm8994_mic_detect(codec, &littlemill_headset, 1);
+	wm8994_mic_detect(component, &littlemill_headset, 1);
 
 	return 0;
 }
-- 
2.16.1
