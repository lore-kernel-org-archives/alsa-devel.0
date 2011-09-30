From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [RFC 2/3] ASoC: davinci-pcm: add cpu-dai health
	callbacks
Date: Fri, 30 Sep 2011 17:23:02 -0400
Message-ID: <beb331a90431ab4dfefedc45f53e686df3bc3f61.1317417232.git.bengardiner@nanometrics.ca>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F8B81037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 23:23:11 +0200 (CEST)
Received: by mail-qw0-f53.google.com with SMTP id i31so1157976qaf.40
	for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2011 14:23:10 -0700 (PDT)
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

The CPU DAIs available to the davinci-pcm driver have the capability of
detecting and reporting errors.

Add callbacks to the struct davinci_pcm_dma_params passed to davinci-pcm
from the CPU DAI.

This has several shortcomings:
1) It bubbles up to the user as underruns, not a fatal error -- some may prefer
the former, I realize but the latter is more attractive to me. Same problem
as with the previous patch in this series.
2) passing it in the dma_params struct seems like dual-purposing that structure
3) the device instance must be passed as drvdata since I did not know how to get
back to the cpudai instance from a substream (sorry, please help!)

[not ready yet, please comment]
Not-Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 sound/soc/davinci/davinci-pcm.c |    8 +++++++-
 sound/soc/davinci/davinci-pcm.h |    3 +++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 41a3b5b..cb0e296 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -156,6 +156,8 @@ struct davinci_runtime_data {
 	struct edmacc_param asp_params;
 	struct edmacc_param ram_params;
 	unsigned error:1;
+	int (*cpudai_health)(struct snd_pcm_substream *, void *);
+	void *health_drvdata;
 };
 
 static void davinci_pcm_period_elapsed(struct snd_pcm_substream *substream)
@@ -655,7 +657,8 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 	error = prtd->error;
 	spin_unlock(&prtd->lock);
 
-	if (error)
+	if (error || (prtd->cpudai_health &&
+			prtd->cpudai_health(substream, prtd->health_drvdata)))
 		return SNDRV_PCM_POS_XRUN;
 
 	if (asp_count < 0)
@@ -706,6 +709,9 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 	prtd->ram_link = -1;
 	prtd->ram_link2 = -1;
 
+	prtd->cpudai_health = pa->health;
+	prtd->health_drvdata = pa->health_drvdata;
+
 	runtime->private_data = prtd;
 
 	ret = davinci_pcm_dma_request(substream);
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index c0d6c9b..0474d97 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -26,6 +26,9 @@ struct davinci_pcm_dma_params {
 	unsigned char data_type;	/* xfer data type */
 	unsigned char convert_mono_stereo;
 	unsigned int fifo_level;
+
+	int (*health)(struct snd_pcm_substream *, void *drvdata);
+	void *health_drvdata;
 };
 
 #endif
-- 
1.7.4.1
