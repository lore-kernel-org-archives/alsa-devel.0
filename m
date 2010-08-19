From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH v2] ASoC: multi-component: fix au1x platform
Date: Thu, 19 Aug 2010 20:26:46 +0200
Message-ID: <1282242406-10741-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes up the au1x audio platform to compile, and prepares
the I2S and PCM modules for multiple card operation (no more globals for dma
and i2s).

The AC97 part is limited to one instance only for now due to other
issues (see code).

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Run-tested on DB1200, both I2S and AC97 playback and recording work.

AC97 spits out this kobject warning, which is caused by the "device_register()"
in soc-core.c::soc_ac97_dev_register():

asoc: ac97-hifi <-> au1xpsc-ac97.1 mapping ok
kobject (8fdc59b0): tried to init an initialized object, something is
seriously wrong.
Call Trace:
[<804959c4>] dump_stack+0x8/0x34
[<802a30e4>] kobject_init+0x50/0xcc
[<802ec27c>] device_initialize+0x2c/0x70
[<802ecb64>] device_register+0x14/0x28
[<8039e058>] snd_soc_instantiate_cards+0xa00/0xb10
[<8039e27c>] soc_probe+0x114/0x154
[<802ef0fc>] driver_probe_device+0xe4/0x1a0
[<802ee404>] bus_for_each_drv+0x60/0xb0
[<802ef370>] device_attach+0x74/0xa8
[<802ee1e8>] bus_probe_device+0x30/0x54
[<802ec9a0>] device_add+0x384/0x534
[<802f09a4>] platform_device_add+0x15c/0x1c8
[<805ccb14>] db1200_audio_load+0x70/0x9c
[<801004fc>] do_one_initcall+0xfc/0x1e0
[<805ba32c>] kernel_init+0xc8/0x168
[<80105904>] kernel_thread_helper+0x10/0x18

ALSA device list:
 #0: DB1200_AC97

 arch/mips/alchemy/devboards/db1200/platform.c |   10 ++-
 sound/soc/au1x/db1200.c                       |   18 ++--
 sound/soc/au1x/dbdma2.c                       |  130 ++++++++-----------------
 sound/soc/au1x/psc-ac97.c                     |   56 ++++++-----
 sound/soc/au1x/psc-i2s.c                      |   42 +++------
 sound/soc/au1x/psc.h                          |    7 +-
 6 files changed, 109 insertions(+), 154 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index 3fa34c3..f985373 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -429,8 +429,14 @@ static struct platform_device db1200_audio_dev = {
 	.resource	= au1200_psc1_res,
 };
 
+static struct platform_device db1200_ac97_codec = {
+	.name		= "ac97-codec",
+	.id		= 1,	/* on PSC1 */
+};
+
 static struct platform_device *db1200_devs[] __initdata = {
 	NULL,		/* PSC0, selected by S6.8 */
+	&db1200_ac97_codec,
 	&db1200_ide_dev,
 	&db1200_eth_dev,
 	&db1200_rtc_dev,
@@ -494,11 +500,11 @@ static int __init db1200_dev_init(void)
 	sw &= BCSR_SWITCHES_DIP_8 | BCSR_SWITCHES_DIP_7;
 	if (sw == BCSR_SWITCHES_DIP_8) {
 		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_PSC1MUX);
-		db1200_audio_dev.name = "au1xpsc_i2s";
+		db1200_audio_dev.name = "au1xpsc-i2s";
 		printk(KERN_INFO " S6.7 ON : PSC1 mode I2S\n");
 	} else {
 		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC1MUX, 0);
-		db1200_audio_dev.name = "au1xpsc_ac97";
+		db1200_audio_dev.name = "au1xpsc-ac97";
 		printk(KERN_INFO " S6.7 OFF: PSC1 mode AC97\n");
 	}
 
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 8780c90..2065d03 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -26,11 +26,11 @@
 
 static struct snd_soc_dai_link db1200_ac97_dai = {
 	.name		= "AC97",
-	.stream_name	= "AC97 HiFi",
-	.cpu_dai_name	= "au1xpsc-ac97",
+	.stream_name	= "AC97 Playback",
+	.cpu_dai_name	= "au1xpsc-ac97.1",
 	.codec_dai_name	= "ac97-hifi",
-	.platform_name	=  "au1xpsc-pcm-audio",
-	.codec_name	= "ac97-codec",
+	.platform_name	= "au1xpsc-pcm-audio.1",
+	.codec_name	= "ac97-codec.1",
 };
 
 static struct snd_soc_card db1200_ac97_machine = {
@@ -74,11 +74,11 @@ static struct snd_soc_ops db1200_i2s_wm8731_ops = {
 
 static struct snd_soc_dai_link db1200_i2s_dai = {
 	.name		= "WM8731",
-	.stream_name	= "WM8731 PCM",
-	.cpu_dai_name	= "au1xpsc",
-	.codec_dai_name	= "wm8731-hifi"
-	.platform_name	= "au1xpsc-pcm-audio",
-	.codec_name	= "wm8731-codec.0-001a",
+	.stream_name	= "WM8731",
+	.cpu_dai_name	= "au1xpsc-i2s.1",
+	.codec_dai_name	= "wm8731-hifi",
+	.platform_name	= "au1xpsc-pcm-audio.1",
+	.codec_name	= "wm8731-codec.0-001b",
 	.ops		= &db1200_i2s_wm8731_ops,
 };
 
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 00fdb9c..383c241 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -10,9 +10,6 @@
  *
  * DMA glue for Au1x-PSC audio.
  *
- * NOTE: all of these drivers can only work with a SINGLE instance
- *	 of a PSC. Multiple independent audio devices are impossible
- *	 with ASoC v1.
  */
 
 
@@ -61,9 +58,6 @@ struct au1xpsc_audio_dmadata {
 	int msbits;
 };
 
-/* instance data. There can be only one, MacLeod!!!! */
-static struct au1xpsc_audio_dmadata *au1xpsc_audio_pcmdma[2];
-
 /*
  * These settings are somewhat okay, at least on my machine audio plays
  * almost skip-free. Especially the 64kB buffer seems to help a LOT.
@@ -199,19 +193,26 @@ out:
 	return 0;
 }
 
-static int au1xpsc_pcm_hw_params(struct snd_pcm_substream *substream,
+static inline struct au1xpsc_audio_dmadata *to_dmadata(struct snd_pcm_substream *ss)
+{
+	struct snd_soc_pcm_runtime *rtd = ss->private_data;
+	struct au1xpsc_audio_dmadata *pcd =
+				snd_soc_platform_get_drvdata(rtd->platform);
+	return &pcd[SUBSTREAM_TYPE(ss)];
+}
+
+static int au1xpsc_pcm_hw_params(struct snd_pcm_substream *ss,
 				 struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct au1xpsc_audio_dmadata *pcd;
+	struct snd_pcm_runtime *runtime = ss->runtime;
+	struct au1xpsc_audio_dmadata *pcd = to_dmadata(ss);
 	int stype, ret;
 
-	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	ret = snd_pcm_lib_malloc_pages(ss, params_buffer_bytes(params));
 	if (ret < 0)
 		goto out;
 
-	stype = SUBSTREAM_TYPE(substream);
-	pcd = au1xpsc_audio_pcmdma[stype];
+	stype = SUBSTREAM_TYPE(ss);
 
 	DBG("runtime->dma_area = 0x%08lx dma_addr_t = 0x%08lx dma_size = %d "
 	    "runtime->min_align %d\n",
@@ -222,13 +223,13 @@ static int au1xpsc_pcm_hw_params(struct snd_pcm_substream *substream,
 	DBG("bits %d  frags %d  frag_bytes %d  is_rx %d\n", params->msbits,
 		params_periods(params), params_period_bytes(params), stype);
 
-	ret = au1x_pcm_dbdma_realloc(pcd, stype, params->msbits);
+	ret = au1x_pcm_dbdma_realloc(pcd, SUBSTREAM_TYPE(ss), params->msbits);
 	if (ret) {
 		MSG("DDMA channel (re)alloc failed!\n");
 		goto out;
 	}
 
-	pcd->substream = substream;
+	pcd->substream = ss;
 	pcd->period_bytes = params_period_bytes(params);
 	pcd->periods = params_periods(params);
 	pcd->dma_area_s = pcd->dma_area = runtime->dma_addr;
@@ -249,8 +250,7 @@ static int au1xpsc_pcm_hw_free(struct snd_pcm_substream *substream)
 
 static int au1xpsc_pcm_prepare(struct snd_pcm_substream *substream)
 {
-	struct au1xpsc_audio_dmadata *pcd =
-			au1xpsc_audio_pcmdma[SUBSTREAM_TYPE(substream)];
+	struct au1xpsc_audio_dmadata *pcd = to_dmadata(substream);
 
 	au1xxx_dbdma_reset(pcd->ddma_chan);
 
@@ -267,16 +267,16 @@ static int au1xpsc_pcm_prepare(struct snd_pcm_substream *substream)
 
 static int au1xpsc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	u32 c = au1xpsc_audio_pcmdma[SUBSTREAM_TYPE(substream)]->ddma_chan;
+	struct au1xpsc_audio_dmadata *pcd = to_dmadata(substream);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		au1xxx_dbdma_start(c);
+		au1xxx_dbdma_start(pcd->ddma_chan);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		au1xxx_dbdma_stop(c);
+		au1xxx_dbdma_stop(pcd->ddma_chan);
 		break;
 	default:
 		return -EINVAL;
@@ -287,8 +287,9 @@ static int au1xpsc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 static snd_pcm_uframes_t
 au1xpsc_pcm_pointer(struct snd_pcm_substream *substream)
 {
-	return bytes_to_frames(substream->runtime,
-		au1xpsc_audio_pcmdma[SUBSTREAM_TYPE(substream)]->pos);
+	struct au1xpsc_audio_dmadata *pcd = to_dmadata(substream);
+
+	return bytes_to_frames(substream->runtime, pcd->pos);
 }
 
 static int au1xpsc_pcm_open(struct snd_pcm_substream *substream)
@@ -299,7 +300,9 @@ static int au1xpsc_pcm_open(struct snd_pcm_substream *substream)
 
 static int au1xpsc_pcm_close(struct snd_pcm_substream *substream)
 {
-	au1x_pcm_dbdma_free(au1xpsc_audio_pcmdma[SUBSTREAM_TYPE(substream)]);
+	struct au1xpsc_audio_dmadata *pcd = to_dmadata(substream);
+
+	au1x_pcm_dbdma_free(pcd);
 	return 0;
 }
 
@@ -329,83 +332,55 @@ static int au1xpsc_pcm_new(struct snd_card *card,
 	return 0;
 }
 
-static int au1xpsc_pcm_probe(struct snd_soc_platform *platform)
-{
-	if (!au1xpsc_audio_pcmdma[PCM_TX] || !au1xpsc_audio_pcmdma[PCM_RX])
-		return -ENODEV;
-
-	return 0;
-}
-
 /* au1xpsc audio platform */
 struct snd_soc_platform_driver au1xpsc_soc_platform = {
-	.probe		= au1xpsc_pcm_probe,
 	.ops		= &au1xpsc_pcm_ops,
 	.pcm_new	= au1xpsc_pcm_new,
 	.pcm_free	= au1xpsc_pcm_free_dma_buffers,
 };
-EXPORT_SYMBOL_GPL(au1xpsc_soc_platform);
 
 static int __devinit au1xpsc_pcm_drvprobe(struct platform_device *pdev)
 {
+	struct au1xpsc_audio_dmadata *dmadata;
 	struct resource *r;
 	int ret;
 
-	if (au1xpsc_audio_pcmdma[PCM_TX] || au1xpsc_audio_pcmdma[PCM_RX])
-		return -EBUSY;
-
-	/* TX DMA */
-	au1xpsc_audio_pcmdma[PCM_TX]
-		= kzalloc(sizeof(struct au1xpsc_audio_dmadata), GFP_KERNEL);
-	if (!au1xpsc_audio_pcmdma[PCM_TX])
+	dmadata = kzalloc(2 * sizeof(struct au1xpsc_audio_dmadata), GFP_KERNEL);
+	if (!dmadata)
 		return -ENOMEM;
 
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!r) {
 		ret = -ENODEV;
-		goto out1;
+		goto out2;
 	}
-	(au1xpsc_audio_pcmdma[PCM_TX])->ddma_id = r->start;
+	dmadata[PCM_TX].ddma_id = r->start;
 
 	/* RX DMA */
-	au1xpsc_audio_pcmdma[PCM_RX]
-		= kzalloc(sizeof(struct au1xpsc_audio_dmadata), GFP_KERNEL);
-	if (!au1xpsc_audio_pcmdma[PCM_RX])
-		return -ENOMEM;
-
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!r) {
 		ret = -ENODEV;
 		goto out2;
 	}
-	(au1xpsc_audio_pcmdma[PCM_RX])->ddma_id = r->start;
+	dmadata[PCM_RX].ddma_id = r->start;
+
+	platform_set_drvdata(pdev, dmadata);
 
 	ret = snd_soc_register_platform(&pdev->dev, &au1xpsc_soc_platform);
 	if (!ret)
 		return ret;
 
 out2:
-	kfree(au1xpsc_audio_pcmdma[PCM_RX]);
-	au1xpsc_audio_pcmdma[PCM_RX] = NULL;
-out1:
-	kfree(au1xpsc_audio_pcmdma[PCM_TX]);
-	au1xpsc_audio_pcmdma[PCM_TX] = NULL;
+	kfree(dmadata);
 	return ret;
 }
 
 static int __devexit au1xpsc_pcm_drvremove(struct platform_device *pdev)
 {
-	int i;
+	struct au1xpsc_audio_dmadata *dmadata = platform_get_drvdata(pdev);
 
 	snd_soc_unregister_platform(&pdev->dev);
-
-	for (i = 0; i < 2; i++) {
-		if (au1xpsc_audio_pcmdma[i]) {
-			au1x_pcm_dbdma_free(au1xpsc_audio_pcmdma[i]);
-			kfree(au1xpsc_audio_pcmdma[i]);
-			au1xpsc_audio_pcmdma[i] = NULL;
-		}
-	}
+	kfree(dmadata);
 
 	return 0;
 }
@@ -421,8 +396,6 @@ static struct platform_driver au1xpsc_pcm_driver = {
 
 static int __init au1xpsc_audio_dbdma_load(void)
 {
-	au1xpsc_audio_pcmdma[PCM_TX] = NULL;
-	au1xpsc_audio_pcmdma[PCM_RX] = NULL;
 	return platform_driver_register(&au1xpsc_pcm_driver);
 }
 
@@ -435,37 +408,21 @@ module_init(au1xpsc_audio_dbdma_load);
 module_exit(au1xpsc_audio_dbdma_unload);
 
 
+/* psc-ac97/psc-i2s call this function to create a pcm platform device with
+ * their DMA channel information.
+ */
 struct platform_device *au1xpsc_pcm_add(struct platform_device *pdev)
 {
-	struct resource *res, *r;
 	struct platform_device *pd;
-	int id[2];
 	int ret;
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r)
-		return NULL;
-	id[0] = r->start;
-
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!r)
-		return NULL;
-	id[1] = r->start;
-
-	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
-	if (!res)
-		return NULL;
-
-	res[0].start = res[0].end = id[0];
-	res[1].start = res[1].end = id[1];
-	res[0].flags = res[1].flags = IORESOURCE_DMA;
-
-	pd = platform_device_alloc("au1xpsc-pcm", -1);
+	/* pass on the resources from the PSC, and match its ID */
+	pd = platform_device_alloc("au1xpsc-pcm-audio", pdev->id);
 	if (!pd)
 		goto out;
 
-	pd->resource = res;
-	pd->num_resources = 2;
+	pd->resource = pdev->resource;
+	pd->num_resources = pdev->num_resources;
 
 	ret = platform_device_add(pd);
 	if (!ret)
@@ -473,7 +430,6 @@ struct platform_device *au1xpsc_pcm_add(struct platform_device *pdev)
 
 	platform_device_put(pd);
 out:
-	kfree(res);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(au1xpsc_pcm_add);
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 6a9516c..415b5aa 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -10,9 +10,6 @@
  *
  * Au1xxx-PSC AC97 glue.
  *
- * NOTE: all of these drivers can only work with a SINGLE instance
- *	 of a PSC. Multiple independent audio devices are impossible
- *	 with ASoC v1.
  */
 
 #include <linux/init.h>
@@ -56,12 +53,28 @@
 /* instance data. There can be only one, MacLeod!!!! */
 static struct au1xpsc_audio_data *au1xpsc_ac97_workdata;
 
+#if 0
+
+/* this could theoretically work, but ac97->bus->card can be NULL when
+ * snd_ac97_mixer() is called; I don't know if the rest further down the chain
+ * are always valid either.
+ */
+static inline struct au1xpsc_audio_data *ac97_to_pscdata(struct snd_ac97 *x)
+{
+	struct snd_soc_card *c = x->bus->card->private_data;
+	return snd_soc_dai_get_drvdata(c->rtd->cpu_dai);
+}
+
+#else
+
+#define ac97_to_pscdata(x)	au1xpsc_ac97_workdata
+#endif
+
 /* AC97 controller reads codec register */
 static unsigned short au1xpsc_ac97_read(struct snd_ac97 *ac97,
 					unsigned short reg)
 {
-	/* FIXME */
-	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	struct au1xpsc_audio_data *pscdata = ac97_to_pscdata(ac97);
 	unsigned short retry, tmo;
 	unsigned long data;
 
@@ -102,8 +115,7 @@ static unsigned short au1xpsc_ac97_read(struct snd_ac97 *ac97,
 static void au1xpsc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 				unsigned short val)
 {
-	/* FIXME */
-	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	struct au1xpsc_audio_data *pscdata = ac97_to_pscdata(ac97);
 	unsigned int tmo, retry;
 
 	au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
@@ -134,8 +146,7 @@ static void au1xpsc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 /* AC97 controller asserts a warm reset */
 static void au1xpsc_ac97_warm_reset(struct snd_ac97 *ac97)
 {
-	/* FIXME */
-	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	struct au1xpsc_audio_data *pscdata = ac97_to_pscdata(ac97);
 
 	au_writel(PSC_AC97RST_SNC, AC97_RST(pscdata));
 	au_sync();
@@ -146,8 +157,7 @@ static void au1xpsc_ac97_warm_reset(struct snd_ac97 *ac97)
 
 static void au1xpsc_ac97_cold_reset(struct snd_ac97 *ac97)
 {
-	/* FIXME */
-	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	struct au1xpsc_audio_data *pscdata = ac97_to_pscdata(ac97);
 	int i;
 
 	/* disable PSC during cold reset */
@@ -202,8 +212,7 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
 {
-	/* FIXME */
-	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	struct au1xpsc_audio_data *pscdata = dev_get_drvdata(dai->dev);
 	unsigned long r, ro, stat;
 	int chans, t, stype = SUBSTREAM_TYPE(substream);
 
@@ -283,8 +292,7 @@ out:
 static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
-	/* FIXME */
-	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	struct au1xpsc_audio_data *pscdata = dev_get_drvdata(dai->dev);
 	int ret, stype = SUBSTREAM_TYPE(substream);
 
 	ret = 0;
@@ -325,7 +333,7 @@ static struct snd_soc_dai_ops au1xpsc_ac97_dai_ops = {
 	.hw_params	= au1xpsc_ac97_hw_params,
 };
 
-struct snd_soc_dai_driver au1xpsc_ac97_dai = {
+static const struct snd_soc_dai_driver au1xpsc_ac97_dai_template = {
 	.ac97_control		= 1,
 	.probe			= au1xpsc_ac97_probe,
 	.playback = {
@@ -342,7 +350,6 @@ struct snd_soc_dai_driver au1xpsc_ac97_dai = {
 	},
 	.ops = &au1xpsc_ac97_dai_ops,
 };
-EXPORT_SYMBOL_GPL(au1xpsc_ac97_dai);
 
 static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 {
@@ -351,9 +358,6 @@ static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 	unsigned long sel;
 	struct au1xpsc_audio_data *wd;
 
-	if (au1xpsc_ac97_workdata)
-		return -EBUSY;
-
 	wd = kzalloc(sizeof(struct au1xpsc_audio_data), GFP_KERNEL);
 	if (!wd)
 		return -ENOMEM;
@@ -387,14 +391,20 @@ static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 	au_writel(PSC_SEL_PS_AC97MODE | sel, PSC_SEL(wd));
 	au_sync();
 
-	ret = snd_soc_register_dai(&pdev->dev, &au1xpsc_ac97_dai);
+	/* name the DAI like this device instance ("au1xpsc-ac97.PSCINDEX") */
+	memcpy(&wd->dai_drv, &au1xpsc_ac97_dai_template,
+	       sizeof(struct snd_soc_dai_driver));
+	wd->dai_drv.name = dev_name(&pdev->dev);
+
+	platform_set_drvdata(pdev, wd);
+
+	ret = snd_soc_register_dai(&pdev->dev, &wd->dai_drv);
 	if (ret)
 		goto out1;
 
 	wd->dmapd = au1xpsc_pcm_add(pdev);
 	if (wd->dmapd) {
-		platform_set_drvdata(pdev, wd);
-		au1xpsc_ac97_workdata = wd;	/* MDEV */
+		au1xpsc_ac97_workdata = wd;
 		return 0;
 	}
 
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 94e560a..28c0ec4 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -10,9 +10,6 @@
  *
  * Au1xxx-PSC I2S glue.
  *
- * NOTE: all of these drivers can only work with a SINGLE instance
- *	 of a PSC. Multiple independent audio devices are impossible
- *	 with ASoC v1.
  * NOTE: so far only PSC slave mode (bit- and frameclock) is supported.
  */
 
@@ -54,13 +51,10 @@
 	((stype) == PCM_TX ? PSC_I2SPCR_TC : PSC_I2SPCR_RC)
 
 
-/* instance data. There can be only one, MacLeod!!!! */
-static struct au1xpsc_audio_data *au1xpsc_i2s_workdata;
-
 static int au1xpsc_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 			       unsigned int fmt)
 {
-	struct au1xpsc_audio_data *pscdata = au1xpsc_i2s_workdata;
+	struct au1xpsc_audio_data *pscdata = dev_get_drvdata(cpu_dai->dev);
 	unsigned long ct;
 	int ret;
 
@@ -120,7 +114,7 @@ static int au1xpsc_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct au1xpsc_audio_data *pscdata = au1xpsc_i2s_workdata;
+	struct au1xpsc_audio_data *pscdata = dev_get_drvdata(dai->dev);
 
 	int cfgbits;
 	unsigned long stat;
@@ -245,7 +239,7 @@ static int au1xpsc_i2s_stop(struct au1xpsc_audio_data *pscdata, int stype)
 static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
-	struct au1xpsc_audio_data *pscdata = au1xpsc_i2s_workdata;
+	struct au1xpsc_audio_data *pscdata = dev_get_drvdata(dai->dev);
 	int ret, stype = SUBSTREAM_TYPE(substream);
 
 	switch (cmd) {
@@ -263,19 +257,13 @@ static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
-static int au1xpsc_i2s_probe(struct snd_soc_dai *dai)
-{
-	return 	au1xpsc_i2s_workdata ? 0 : -ENODEV;
-}
-
 static struct snd_soc_dai_ops au1xpsc_i2s_dai_ops = {
 	.trigger	= au1xpsc_i2s_trigger,
 	.hw_params	= au1xpsc_i2s_hw_params,
 	.set_fmt	= au1xpsc_i2s_set_fmt,
 };
 
-static struct snd_soc_dai_driver au1xpsc_i2s_dai = {
-	.probe			= au1xpsc_i2s_probe,
+static const struct snd_soc_dai_driver au1xpsc_i2s_dai_template = {
 	.playback = {
 		.rates		= AU1XPSC_I2S_RATES,
 		.formats	= AU1XPSC_I2S_FMTS,
@@ -298,9 +286,6 @@ static int __devinit au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 	int ret;
 	struct au1xpsc_audio_data *wd;
 
-	if (au1xpsc_i2s_workdata)
-		return -EBUSY;
-
 	wd = kzalloc(sizeof(struct au1xpsc_audio_data), GFP_KERNEL);
 	if (!wd)
 		return -ENOMEM;
@@ -337,17 +322,21 @@ static int __devinit au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 	 * time out.
 	 */
 
-	ret = snd_soc_register_dai(&pdev->dev, &au1xpsc_i2s_dai);
+	/* name the DAI like this device instance ("au1xpsc-i2s.PSCINDEX") */
+	memcpy(&wd->dai_drv, &au1xpsc_i2s_dai_template,
+	       sizeof(struct snd_soc_dai_driver));
+	wd->dai_drv.name = dev_name(&pdev->dev);
+
+	platform_set_drvdata(pdev, wd);
+
+	ret = snd_soc_register_dai(&pdev->dev, &wd->dai_drv);
 	if (ret)
 		goto out1;
 
 	/* finally add the DMA device for this PSC */
 	wd->dmapd = au1xpsc_pcm_add(pdev);
-	if (wd->dmapd) {
-		platform_set_drvdata(pdev, wd);
-		au1xpsc_i2s_workdata = wd;
+	if (wd->dmapd)
 		return 0;
-	}
 
 	snd_soc_unregister_dai(&pdev->dev);
 out1:
@@ -376,8 +365,6 @@ static int __devexit au1xpsc_i2s_drvremove(struct platform_device *pdev)
 	release_mem_region(r->start, resource_size(r));
 	kfree(wd);
 
-	au1xpsc_i2s_workdata = NULL;	/* MDEV */
-
 	return 0;
 }
 
@@ -427,7 +414,7 @@ static struct dev_pm_ops au1xpsci2s_pmops = {
 
 static struct platform_driver au1xpsc_i2s_driver = {
 	.driver		= {
-		.name	= "au1xpsc",
+		.name	= "au1xpsc-i2s",
 		.owner	= THIS_MODULE,
 		.pm	= AU1XPSCI2S_PMOPS,
 	},
@@ -437,7 +424,6 @@ static struct platform_driver au1xpsc_i2s_driver = {
 
 static int __init au1xpsc_i2s_load(void)
 {
-	au1xpsc_i2s_workdata = NULL;
 	return platform_driver_register(&au1xpsc_i2s_driver);
 }
 
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index f281443..b30eadd 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -8,16 +8,11 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * NOTE: all of these drivers can only work with a SINGLE instance
- *	 of a PSC. Multiple independent audio devices are impossible
- *	 with ASoC v1.
  */
 
 #ifndef _AU1X_PCM_H
 #define _AU1X_PCM_H
 
-extern struct snd_ac97_bus_ops soc_ac97_ops;
-
 /* DBDMA helpers */
 extern struct platform_device *au1xpsc_pcm_add(struct platform_device *pdev);
 extern void au1xpsc_pcm_destroy(struct platform_device *dmapd);
@@ -28,6 +23,8 @@ struct au1xpsc_audio_data {
 	unsigned long cfg;
 	unsigned long rate;
 
+	struct snd_soc_dai_driver dai_drv;
+
 	unsigned long pm[2];
 	struct mutex lock;
 	struct platform_device *dmapd;
-- 
1.7.2

