From: Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH 2/4] ALSA: ASoC: Davinci: Replaced DAI format
	RIGHT_J by DSP_B for SFFSDR
Date: Mon,  9 Mar 2009 23:32:07 -0400
Message-ID: <1236655929-31688-3-git-send-email-hugo@hugovil.com>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BF8C2445D
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 04:32:32 +0100 (CET)
In-Reply-To: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
---
 sound/soc/davinci/davinci-sffsdr.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 1d10957..b338c71 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -36,6 +36,14 @@
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
 
+/*
+ * CLKX and CLKR are the inputs for the Sample Rate Generator.
+ * FSX and FSR are outputs, driven by the sample Rate Generator.
+ */
+#define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B |	\
+		      SND_SOC_DAIFMT_CBM_CFS |	\
+		      SND_SOC_DAIFMT_IB_NF)
+
 static int sffsdr_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
@@ -56,13 +64,8 @@ static int sffsdr_hw_params(struct snd_pcm_substream *substream,
 	}
 #endif
 
-	/* Set cpu DAI configuration:
-	 * CLKX and CLKR are the inputs for the Sample Rate Generator.
-	 * FSX and FSR are outputs, driven by the sample Rate Generator. */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_RIGHT_J |
-				  SND_SOC_DAIFMT_CBM_CFS |
-				  SND_SOC_DAIFMT_IB_NF);
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
 	if (ret < 0)
 		return ret;
 
-- 
1.5.5
