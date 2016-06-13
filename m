From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 2/2] sound: lpass-platform: Move dma channel allocation to pcmops
Date: Mon, 13 Jun 2016 14:23:17 +0100
Message-ID: <1465824197-7735-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1465824197-7735-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465824197-7735-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Patrick Lai <plai@codeaurora.org>, kwestfie@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Move dma channel allocations to pcmops open and close functions. Reason
to do this is that, lpass_platform_pcm_free() accesses snd_soc_pcm_runtime
via substream->private data, However By this time runtimes are already
freed as part of soc_cleanup_card_resources() sequence.

This patch moves the channel allocations/deallocations to pcmops open()
and close() respectively, where the code has valid snd_soc_pcm_runtime.

Without this patch unloading lpass sound card module would result in below
crash:

Unable to handle kernel NULL pointer dereference at virtual address
00000000
pgd = ffff800038f0d000
[00000000] *pgd=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in: snd_soc_apq8016_sbc(-) snd_soc_lpass_apq8016
snd_soc_lpass_cpu snd_soc_lpass_platform
CPU: 0 PID: 1573 Comm: rmmod Not tainted 4.7.0-rc2-next-20160609+ #59
Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
task: ffff800038cd0000 ti: ffff80003929c000 task.ti: ffff80003929c000
PC is at lpass_platform_pcm_free+0xc4/0x1c0 [snd_soc_lpass_platform]
LR is at lpass_platform_pcm_free+0xb8/0x1c0 [snd_soc_lpass_platform]
pc : [<ffff000000b20b64>] lr : [<ffff000000b20b58>] pstate: 60000145
sp : ffff80003929fa90
x29: ffff80003929fa90 x28: ffff000000b22438
x27: ffff000000b22450 x26: ffff000000b22468
x25: ffff000000b22488 x24: ffff000000b223f0
x23: ffff000000b22418 x22: ffff800038f428c0
x21: ffff8000392ae280 x20: 0000000000000001
x19: ffff000000b22118 x18: 0000ffffdc331600
x17: 0000ffffb78036c0 x16: ffff0000081c16e8
x15: 0000ffffb77f0588 x14: 3d4d554e51455300
x13: ffffffffffff0000 x12: 0000000000000028
x11: 0000000000000044 x10: ffff80003929f822
x9 : ffff80003929f823 x8 : 0000000000000000
x7 : 0000000000000004 x6 : ffff000008864890
x5 : 0000000000000000 x4 : 0000000000000000
x3 : 0000000000000000 x2 : ffff80003efac228
x1 : ffff000000b22118 x0 : ffff000000b22450

Process rmmod (pid: 1573, stack limit = 0xffff80003929c020)
Stack: (0xffff80003929fa90 to 0xffff8000392a0000)
fa80:                                  ffff80003929fb40 ffff0000086d1f8c
faa0: ffff000008ca5408 ffff800038f42200 ffff000008ca5420 000000000000000b
fac0: ffff80003929fd70 0000000000000015 0000000000000120 000000000000006a
fae0: ffff0000087f2000 ffff80003929c000 ffff80003929fb40 ffff8000392ae358
fb00: ffff8000392af900 0000000000000000 ffff8000392afa48 000000000000000b
fb20: ffff80003929fd70 0000000000000015 ffff80003929fb80 ffff0000086cc070
fb40: ffff80003929fb70 ffff0000086d21d4 ffff800038f7fa00 ffff8000392801a0
fb60: ffff800038cf2000 0000000000000015 ffff80003929fb80 ffff0000086cc064
fb80: ffff80003929fba0 ffff0000086cc1f4 ffff800038f70600 000000000000000b
fba0: ffff80003929fbc0 ffff0000086c68a8 ffff800039280000 ffff800039280540
fbc0: ffff80003929fbe0 ffff0000084a7438 ffff800039280540 ffff800039280550
fbe0: ffff80003929fc10 ffff000008355ddc ffff800039280550 ffff000008c64718
fc00: ffff800038f61d00 ffff000008ca5190 ffff80003929fc40 ffff000008355e5c
fc20: ffff800039280550 ffff800039280000 ffff80003847b618 ffff800039280000
fc40: ffff80003929fc60 ffff0000084a77d8 0000000000000000 0000000000000015
fc60: ffff80003929fc70 ffff0000086c6e58 ffff80003929fc90 ffff0000086c6fbc
fc80: ffff80003929fcb0 ffff800039280000 ffff80003929fcd0 ffff0000086e3e50
fca0: ffff80003847b050 ffff80003847b728 ffff800000000000 ffff000000000000
fcc0: ffff80003929fcc0 ffff80003929fcc0 ffff80003929fd00 ffff0000086e4c8c
fce0: ffff80003847b618 ffff800038f61100 ffff8000399ddf90 000000000000000b
fd00: ffff80003929fd20 ffff0000086f0684 ffff800038f61000 ffff0000080d51c0
fd20: ffff80003929fd30 ffff0000084af904 ffff80003929fd80 ffff0000084afcf8
fd40: ffff8000399ddf90 ffff000000b3c028 ffff8000399ddff0 ffff000008cc8000
fd60: 0000000080000000 ffff0000084ac090 ffff800038f94600 ffff800038f61000
fd80: ffff80003929fda0 ffff0000084ac0b0 ffff8000399ddf90 ffff000000b3c028
fda0: ffff80003929fdc0 ffff0000084ac234 ffff8000399ddf90 ffff000000b3c028
fdc0: ffff80003929fdf0 ffff0000084ab3d4 ffff000000b3c028 ffff000008c64000
fde0: ffff000008c64818 ffff000000000001 ffff80003929fe20 ffff0000084ac8ac
fe00: ffff000000b3c028 ffff000000b3c100 fffffffffffffff5 0000000000000000
fe20: ffff80003929fe40 ffff0000084ad998 ffff000008c2d000 0000000000000015
fe40: ffff80003929fe50 ffff000000b3a460 ffff80003929fe60 ffff000008120fe4
fe60: 0000000000000000 ffff000008084e70 0000000000000000 0000000000000000
fe80: ffffffffffffffff 0000ffff954cca48 0000000000000004 5f636f735f646e73
fea0: 5f36313038717061 0000000000636273 0000000000000000 ffff000008084d64
fec0: 0000000000000000 0000000000000000 0000aaaabc814340 0000000000000800
fee0: 4fdc43dac03e2300 0000000000002002 0000ffff95548e58 0000ffffd9f89fb9
ff00: 0000000000000000 0000000000000000 000000000000006a 1999999999999999
ff20: 00000000ffffffff 0000000000000000 0000000000000005 ffffffffffffffff
ff40: 0000ffff95402a94 0000ffff9554a588 0000ffff954cca40 0000aaaaaf8d22d0
ff60: 0000ffffd9f8ad70 0000aaaabc8142e0 0000000000000000 0000000000000000
ff80: 0000ffffd9f8be7c 0000000000000000 0000ffffd9f8b0e0 0000ffffd9f8b2b8
ffa0: 0000aaaabc8142e0 0000aaaabc813010 0000000000000000 0000ffffd9f8b010
ffc0: 0000aaaaaf8b5ad4 0000ffffd9f8b010 0000ffff954cca48 0000000080000000
ffe0: 0000aaaabc814340 000000000000006a 0000060000000000 00000000fffefcaf
Call trace:
Exception stack(0xffff80003929f8d0 to 0xffff80003929f9f0)
f8c0:                                   ffff000000b22118 00000000000001
f8e0: ffff80003929fa90 ffff000000b20b64 ffff80003929f910 ffff000008a12f40
f900: ffff000008c15b78 0000000100000001 ffff80003929f9b0 ffff0000080f66e0
f920: ffff000000b22118 0000000000000001 ffff8000392ae280 ffff800038f428c0
f940: ffff000000b22418 ffff000000b223f0 ffff000000b22488 ffff000000b22468
f960: ffff000000b22450 ffff000000b22438 ffff000000b22450 ffff000000b22118
f980: ffff80003efac228 0000000000000000 0000000000000000 0000000000000000
f9a0: ffff000008864890 0000000000000004 0000000000000000 ffff80003929f823
f9c0: ffff80003929f822 0000000000000044 0000000000000028 ffffffffffff0000
f9e0: 3d4d554e51455300 0000ffffb77f0588
[<ffff000000b20b64>] lpass_platform_pcm_free+0xc4/0x1c0 [snd_soc_lpass_platform]
[<ffff0000086d1f8c>] snd_pcm_free+0x30/0xa0
[<ffff0000086d21d4>] snd_pcm_dev_free+0x10/0x18
[<ffff0000086cc064>] __snd_device_free+0x58/0xa0
[<ffff0000086cc1f4>] snd_device_free_all+0x2c/0x48
[<ffff0000086c68a8>] release_card_device+0x1c/0x74
[<ffff0000084a7438>] device_release+0x34/0x90
[<ffff000008355ddc>] kobject_release+0x44/0x84
[<ffff000008355e5c>] kobject_put+0x40/0x68
[<ffff0000084a77d8>] put_device+0x14/0x1c
[<ffff0000086c6e58>] snd_card_free_when_closed+0x24/0x34
[<ffff0000086c6fbc>] snd_card_free+0x40/0x60
[<ffff0000086e3e50>] soc_cleanup_card_resources+0x80/0x94
[<ffff0000086e4c8c>] snd_soc_unregister_card+0x28/0x38
[<ffff0000086f0684>] devm_card_release+0x10/0x18
[<ffff0000084af904>] release_nodes+0x124/0x208
[<ffff0000084afcf8>] devres_release_all+0x34/0x54
[<ffff0000084ac0b0>] __device_release_driver+0x84/0xfc
[<ffff0000084ac234>] driver_detach+0xbc/0xc0
[<ffff0000084ab3d4>] bus_remove_driver+0x58/0xac
[<ffff0000084ac8ac>] driver_unregister+0x2c/0x4c
[<ffff0000084ad998>] platform_driver_unregister+0x10/0x18
[<ffff000000b3a460>] apq8016_sbc_platform_driver_exit+0x10/0xbb0 [snd_soc_apq8016_sbc]
[<ffff000008120fe4>] SyS_delete_module+0x1b8/0x1fc
[<ffff000008084e70>] el0_svc_naked+0x24/0x28
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 158 ++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 81 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index db000c6..9987e12 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -61,7 +61,36 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	int ret;
+	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
+	struct lpass_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
+	int ch = -1, reg, ret;
+
+	if (v->alloc_dma_channel) {
+		ch = v->alloc_dma_channel(drvdata, substream->stream);
+
+		if (ch < 0)
+			return ch;
+
+		drvdata->substream[ch] = substream;
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			pcm_data->rdma_ch = ch;
+			reg =  LPAIF_RDMACTL_REG(v, ch);
+		} else {
+			pcm_data->wrdma_ch = ch;
+			reg =  LPAIF_WRDMACTL_REG(v, ch);
+		}
+
+		ret = regmap_write(drvdata->lpaif_map, reg, 0);
+		if (ret) {
+			dev_err(soc_runtime->dev,
+				"%s() error writing to dmactl reg: %d\n",
+				__func__, ret);
+			goto err;
+		}
+	}
 
 	snd_soc_set_runtime_hwparams(substream, &lpass_platform_pcm_hardware);
 
@@ -72,12 +101,43 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 	if (ret < 0) {
 		dev_err(soc_runtime->dev, "%s() setting constraints failed: %d\n",
 				__func__, ret);
-		return -EINVAL;
+		goto err;
 	}
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
 	return 0;
+
+err:
+	if (ch >= 0 && v->free_dma_channel)
+		v->free_dma_channel(drvdata, ch);
+
+	return ret;
+}
+
+static int lpass_platform_pcmops_close(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
+	struct lpass_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
+	int ch = -1;
+
+	if (v->free_dma_channel) {
+		drvdata->substream[ch] = substream;
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			ch = pcm_data->rdma_ch;
+		else
+			ch = pcm_data->wrdma_ch;
+
+		if (ch >= 0)
+			v->free_dma_channel(drvdata, ch);
+
+	}
+
+	return 0;
 }
 
 static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
@@ -374,6 +434,7 @@ static int lpass_platform_pcmops_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops lpass_platform_pcm_ops = {
 	.open		= lpass_platform_pcmops_open,
+	.close		= lpass_platform_pcmops_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= lpass_platform_pcmops_hw_params,
 	.hw_free	= lpass_platform_pcmops_hw_free,
@@ -471,14 +532,12 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	struct snd_pcm *pcm = soc_runtime->pcm;
 	struct snd_pcm_substream *psubstream, *csubstream;
 	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
-	struct lpass_variant *v = drvdata->variant;
-	int ret = -EINVAL;
+	struct device *dev = soc_runtime->platform->dev;
 	struct lpass_pcm_data *data;
 	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
+	int ret = -EINVAL;
 
-	data = devm_kzalloc(soc_runtime->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -487,100 +546,37 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 
 	psubstream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
 	if (psubstream) {
-		if (v->alloc_dma_channel)
-			data->rdma_ch = v->alloc_dma_channel(drvdata,
-						SNDRV_PCM_STREAM_PLAYBACK);
-
-		if (data->rdma_ch < 0)
-			return data->rdma_ch;
-
-		drvdata->substream[data->rdma_ch] = psubstream;
-
-		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-					soc_runtime->platform->dev,
-					size, &psubstream->dma_buffer);
-		if (ret)
-			goto playback_alloc_err;
-
-		ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, data->rdma_ch), 0);
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
+					  &psubstream->dma_buffer);
 		if (ret) {
-			dev_err(soc_runtime->dev,
-				"%s() error writing to rdmactl reg: %d\n",
-				__func__, ret);
-			goto capture_alloc_err;
+			dev_err(dev, "can't alloc playback dma buffer\n");
+			return ret;
 		}
 	}
 
 	csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
 	if (csubstream) {
-		if (v->alloc_dma_channel)
-			data->wrdma_ch = v->alloc_dma_channel(drvdata,
-						SNDRV_PCM_STREAM_CAPTURE);
-
-		if (data->wrdma_ch < 0) {
-			ret = data->wrdma_ch;
-			goto capture_alloc_err;
-		}
-
-		drvdata->substream[data->wrdma_ch] = csubstream;
-
-		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-					soc_runtime->platform->dev,
-					size, &csubstream->dma_buffer);
-		if (ret)
-			goto capture_alloc_err;
-
-		ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_WRDMACTL_REG(v, data->wrdma_ch), 0);
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
+					  &csubstream->dma_buffer);
 		if (ret) {
-			dev_err(soc_runtime->dev,
-				"%s() error writing to wrdmactl reg: %d\n",
-				__func__, ret);
-			goto capture_reg_err;
+			dev_err(dev, "can't alloc capture dma buffer\n");
+			if (psubstream)
+				snd_dma_free_pages(&psubstream->dma_buffer);
+			return ret;
 		}
 	}
 
 	return 0;
-
-capture_reg_err:
-	if (csubstream)
-		snd_dma_free_pages(&csubstream->dma_buffer);
-
-capture_alloc_err:
-	if (psubstream)
-		snd_dma_free_pages(&psubstream->dma_buffer);
-
- playback_alloc_err:
-	dev_err(soc_runtime->dev, "Cannot allocate buffer(s)\n");
-
-	return ret;
 }
 
 static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 {
-	struct snd_soc_pcm_runtime *rt;
-	struct lpass_data *drvdata;
-	struct lpass_pcm_data *data;
-	struct lpass_variant *v;
 	struct snd_pcm_substream *substream;
-	int ch, i;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
 		substream = pcm->streams[i].substream;
 		if (substream) {
-			rt = substream->private_data;
-			data = snd_soc_pcm_get_drvdata(rt);
-			drvdata = snd_soc_platform_get_drvdata(rt->platform);
-
-			ch = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-				? data->rdma_ch
-				: data->wrdma_ch;
-			v = drvdata->variant;
-			drvdata->substream[ch] = NULL;
-			if (v->free_dma_channel)
-				v->free_dma_channel(drvdata, ch);
-
 			snd_dma_free_pages(&substream->dma_buffer);
 			substream->dma_buffer.area = NULL;
 			substream->dma_buffer.addr = 0;
-- 
2.8.3
