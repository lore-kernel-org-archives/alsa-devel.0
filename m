From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH] ASoC: DaVinci: Update suspend/resume support
	for McASP driver
Date: Wed,  2 Dec 2009 12:39:00 +0530
Message-ID: <1259737740-27324-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 73A7324359
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 08:26:22 +0100 (CET)
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
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add clock enable and disable calls to resume and suspend respectively.
Also add a member to the audio device data structure which tracks the clock
status.

Tested on DA850/OMAP-L138 EVM. For the purpose of testing, the patches[1] which 
add suspend-to-RAM support to DA850/OMAP-L138 SoC were applied.

[1] http://linux.davincidsp.com/pipermail/davinci-linux-open-source/
2009-November/016958.html

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/davinci-mcasp.c |   18 ++++++++++++++++--
 sound/soc/davinci/davinci-mcasp.h |    1 +
 sound/soc/davinci/davinci-pcm.c   |    2 +-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0a302e1..0d263f1 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -767,14 +767,27 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	int ret = 0;
 
 	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
+		if (!dev->clk_active) {
+			clk_enable(dev->clk);
+			dev->clk_active = 1;
+		}
+
+	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		davinci_mcasp_start(dev, substream->stream);
 		break;
 
-	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+		davinci_mcasp_stop(dev, substream->stream);
+		if (dev->clk_active) {
+			clk_disable(dev->clk);
+			dev->clk_active = 0;
+		}
+
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		davinci_mcasp_stop(dev, substream->stream);
 		break;
@@ -866,6 +879,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	clk_enable(dev->clk);
+	dev->clk_active = 1;
 
 	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
 	dev->op_mode = pdata->op_mode;
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 582c924..e755b51 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -44,6 +44,7 @@ struct davinci_audio_dev {
 	int sample_rate;
 	struct clk *clk;
 	unsigned int codec_fmt;
+	u8 clk_active;
 
 	/* McASP specific data */
 	int	tdm_slots;
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index ad4d7f4..80c7fdf 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -49,7 +49,7 @@ static void print_buf_info(int slot, char *name)
 static struct snd_pcm_hardware pcm_hardware_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		 SNDRV_PCM_INFO_PAUSE),
+		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
 	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
-- 
1.5.6
