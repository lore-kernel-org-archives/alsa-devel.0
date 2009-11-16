From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 1/4] ASoC: DaVinci: remove requirement that dma_params is 1st
	in structure
Date: Mon, 16 Nov 2009 16:52:31 -0700
Message-ID: <1258415554-31069-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Remove requirement that dma_params is 1st in the structures
davinci_audio_dev and davinci_mcbsp_dev.

Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
---
 sound/soc/davinci/davinci-i2s.c   |    6 +-----
 sound/soc/davinci/davinci-mcasp.c |    1 +
 sound/soc/davinci/davinci-mcasp.h |    5 -----
 sound/soc/davinci/davinci-pcm.c   |    7 ++++---
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 4ae7070..9e69a4e 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -98,11 +98,6 @@ enum {
 };
 
 struct davinci_mcbsp_dev {
-	/*
-	 * dma_params must be first because rtd->dai->cpu_dai->private_data
-	 * is cast to a pointer of an array of struct davinci_pcm_dma_params in
-	 * davinci_pcm_open.
-	 */
 	struct davinci_pcm_dma_params	dma_params[2];
 	void __iomem			*base;
 #define MOD_DSP_A	0
@@ -547,6 +542,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
 
 	davinci_i2s_dai.private_data = dev;
+	davinci_i2s_dai.dma_data = dev->dma_params;
 	ret = snd_soc_register_dai(&davinci_i2s_dai);
 	if (ret != 0)
 		goto err_free_mem;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 5d1f98a..5023915 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -907,6 +907,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	dma_data->channel = res->start;
 	davinci_mcasp_dai[pdata->op_mode].private_data = dev;
+	davinci_mcasp_dai[pdata->op_mode].dma_data = dev->dma_params;
 	davinci_mcasp_dai[pdata->op_mode].dev = &pdev->dev;
 	ret = snd_soc_register_dai(&davinci_mcasp_dai[pdata->op_mode]);
 
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 9d179cc..582c924 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -39,11 +39,6 @@ enum {
 };
 
 struct davinci_audio_dev {
-	/*
-	 * dma_params must be first because rtd->dai->cpu_dai->private_data
-	 * is cast to a pointer of an array of struct davinci_pcm_dma_params in
-	 * davinci_pcm_open.
-	 */
 	struct davinci_pcm_dma_params dma_params[2];
 	void __iomem *base;
 	int sample_rate;
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index c73a915..c2c2e85 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -238,10 +238,11 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 	struct davinci_runtime_data *prtd;
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_pcm_dma_params *pa = rtd->dai->cpu_dai->private_data;
-	struct davinci_pcm_dma_params *params = &pa[substream->stream];
-	if (!params)
+	struct davinci_pcm_dma_params *pa = rtd->dai->cpu_dai->dma_data;
+	struct davinci_pcm_dma_params *params;
+	if (!pa)
 		return -ENODEV;
+	params = &pa[substream->stream];
 
 	snd_soc_set_runtime_hwparams(substream, &davinci_pcm_hardware);
 	/* ensure that buffer size is a multiple of period size */
-- 
1.5.6.3
