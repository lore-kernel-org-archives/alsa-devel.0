From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH] ASoC: DaVinci: Updates to EVM hardware params
	callback
Date: Wed, 20 Jan 2010 17:02:41 +0530
Message-ID: <1263987161-29657-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id AA521244FC
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 13:02:41 +0100 (CET)
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

For S/PDIF transciever codec to work on TI DM6467 EVM,
the codec ops pointer should be checked for in the params callback.
This dummy codec has no set_fmt or set_sysclk implementations.

Tested on TI DM6467 EVM.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
Tested-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/davinci-evm.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 7ccbe66..1760354 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -64,9 +64,11 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, AUDIO_FORMAT);
-	if (ret < 0)
-		return ret;
+	if (codec_dai->ops->set_fmt) {
+		ret = snd_soc_dai_set_fmt(codec_dai, AUDIO_FORMAT);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* set cpu DAI configuration */
 	ret = snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
@@ -74,9 +76,12 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* set the codec system clock */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, sysclk, SND_SOC_CLOCK_OUT);
-	if (ret < 0)
-		return ret;
+	if (codec_dai->ops->set_sysclk) {
+		ret = snd_soc_dai_set_sysclk(codec_dai, 0, sysclk,
+							SND_SOC_CLOCK_OUT);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
1.5.6
