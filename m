From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [RFC 3/3] ASoC: davinci-mcasp: add cpu dai health
	callback
Date: Fri, 30 Sep 2011 17:23:03 -0400
Message-ID: <8cf4a5e5fb678cf117803c9a11aaba82d6b5278e.1317417232.git.bengardiner@nanometrics.ca>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id C127F103C01
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 23:23:15 +0200 (CEST)
Received: by mail-qw0-f43.google.com with SMTP id g14so1025841qab.16
	for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2011 14:23:11 -0700 (PDT)
In-Reply-To: <cover.1317417232.git.bengardiner@nanometrics.ca>
In-Reply-To: <cover.1317417232.git.bengardiner@nanometrics.ca>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

The McASP has RERR and XERR bits in its RSTAT and XSTAT registers which
report the OR'd state of several potential errors.

Register a function to check the status of these bits and report HW errors
back up the stack.

[not ready yet, please comment]
Not-Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 sound/soc/davinci/davinci-mcasp.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 7173df2..ca4073f 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -273,6 +273,11 @@
 #define MUTETXDMAERR	BIT(12)
 
 /*
+ * DAVINCI_MCASP_RXSTAT_REG - Receiver Status Register bits
+ */
+#define RERR		BIT(8)
+
+/*
  * DAVINCI_MCASP_REVTCTL_REG - Receiver DMA Event Control Register bits
  */
 #define RXDATADMADIS	BIT(0)
@@ -283,6 +288,11 @@
 #define TXDATADMADIS	BIT(0)
 
 /*
+ * DAVINCI_MCASP_TXSTAT_REG - Transmitter Status Register bits
+ */
+#define XERR		BIT(8)
+
+/*
  * DAVINCI_MCASP_W[R]FIFOCTL - Write/Read FIFO Control Register bits
  */
 #define FIFO_ENABLE	BIT(16)
@@ -813,6 +823,19 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int davinci_mcasp_health(struct snd_pcm_substream *substream,
+		void *data)
+{
+	struct davinci_audio_dev *dev = data;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return  mcasp_get_reg(dev->base + DAVINCI_MCASP_TXSTAT_REG) &
+			XERR;
+	else
+		return  mcasp_get_reg(dev->base + DAVINCI_MCASP_RXSTAT_REG) &
+			RERR;
+}
+
 static struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 	.startup	= davinci_mcasp_startup,
 	.trigger	= davinci_mcasp_trigger,
@@ -919,6 +942,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
 							mem->start);
 
+	dma_data->health = davinci_mcasp_health;
+	dma_data->health_drvdata = dev;
+
 	/* first TX, then RX */
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!res) {
-- 
1.7.4.1
