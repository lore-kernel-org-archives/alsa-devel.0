From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 4/4] ALSA: ASoc: DaVinci: davinci-evm use dsp_b
	mode
Date: Fri, 19 Dec 2008 13:05:25 -0700
Message-ID: <1229717125-9859-4-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229717125-9859-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229717125-9859-2-git-send-email-troy.kisky@boundarydevices.com>
	<1229717125-9859-3-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-01.inet.qwest.net (mpls-qmqp-01.inet.qwest.net
	[63.231.195.112])
	by alsa0.perex.cz (Postfix) with ESMTP id A321F1037F8
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 21:05:33 +0100 (CET)
In-Reply-To: <1229717125-9859-3-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: naresh@ti.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Sense DaVinci does not support true I2S mode and
we don't have to use the hack, use dsp_b mode instead

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index a78ff59..93e8cfb 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -28,8 +28,8 @@
 
 #define EVM_CODEC_CLOCK 22579200
 
-#define AUDIO_FORMAT (SND_SOC_DAIFMT_I2S | \
-		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_NB_NF)
+#define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
+		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF)
 static int evm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
-- 
1.5.4.3
