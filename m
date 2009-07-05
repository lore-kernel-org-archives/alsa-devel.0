From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 06/11] ASoC: DaVinci: i2s,
	minor cleanup of davinci_i2s_startup
Date: Sat,  4 Jul 2009 19:29:56 -0700
Message-ID: <1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-05.inet.qwest.net (mpls-qmqp-05.inet.qwest.net
	[63.231.195.116])
	by alsa0.perex.cz (Postfix) with ESMTP id C5A80103846
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:10 +0200 (CEST)
In-Reply-To: <1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Save a few lines of code.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 4260965..5b31b56 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -210,14 +210,10 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
 }
 
 static int davinci_i2s_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
+			       struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
-
+	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
 	cpu_dai->dma_data = dev->dma_params[substream->stream];
-
 	return 0;
 }
 
-- 
1.5.6.3
