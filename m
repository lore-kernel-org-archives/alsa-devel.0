From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 2/8] ALSA: ASoC: DaVinci: davinvi-evm,
	make requests explicit
Date: Thu, 18 Dec 2008 12:36:40 -0700
Message-ID: <1229629006-4261-3-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-02.inet.qwest.net (mpls-qmqp-02.inet.qwest.net
	[63.231.195.113])
	by alsa0.perex.cz (Postfix) with ESMTP id DC3C5244C0
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 20:36:53 +0100 (CET)
In-Reply-To: <1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
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

Add constants with a value of 0 to show more explicitly
what is being requested.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 2ce34d4..555ecb2 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -38,12 +38,14 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 
 	/* set codec DAI configuration */
 	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-					 SND_SOC_DAIFMT_CBM_CFM);
+					SND_SOC_DAIFMT_CBM_CFM |
+					SND_SOC_DAIFMT_NB_NF);
 	if (ret < 0)
 		return ret;
 
 	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_CBM_CFM |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+					SND_SOC_DAIFMT_CBM_CFM |
 				       SND_SOC_DAIFMT_IB_NF);
 	if (ret < 0)
 		return ret;
-- 
1.5.4.3
