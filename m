From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 8/8] ALSA: ASoc: DaVinci: davinci-evm use dsp_a
	mode
Date: Thu, 18 Dec 2008 12:36:46 -0700
Message-ID: <1229629006-4261-9-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-3-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-4-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-5-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-6-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-7-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-8-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-02.inet.qwest.net (mpls-qmqp-02.inet.qwest.net
	[63.231.195.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 979651037FA
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 20:36:58 +0100 (CET)
In-Reply-To: <1229629006-4261-8-git-send-email-troy.kisky@boundarydevices.com>
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

Sense DaVinci does not support true I2S mode and
we don't have to use the hack, use dsp_a mode instead

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index a78ff59..6c44e4e 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -28,8 +28,8 @@
 
 #define EVM_CODEC_CLOCK 22579200
 
-#define AUDIO_FORMAT (SND_SOC_DAIFMT_I2S | \
-		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_NB_NF)
+#define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_A | \
+		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF)
 static int evm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
-- 
1.5.4.3
