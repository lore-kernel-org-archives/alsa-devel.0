From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] ASoC: Extend range of supported sample rates
 for CS4271 CODEC.
Date: Sat, 05 Mar 2011 03:55:04 +0300
Message-ID: <1299286504.27359.100.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward8.mail.yandex.net (forward8.mail.yandex.net
	[77.88.61.38]) by alsa0.perex.cz (Postfix) with ESMTP id BD92D2436F
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 01:55:09 +0100 (CET)
Received: from smtp6.mail.yandex.net (smtp6.mail.yandex.net [77.88.61.56])
	by forward8.mail.yandex.net (Yandex) with ESMTP id 5F30FF622EA
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 03:55:06 +0300 (MSK)
Received: from [192.168.1.202] (ppp91-77-173-192.pppoe.mtu-net.ru
	[91.77.173.192])
	by smtp6.mail.yandex.net (Yandex) with ESMTPA id 300A52A8056
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 03:55:06 +0300 (MSK)
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
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Extend range of supported sample rates for CS4271 CODEC.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/codecs/cs4271.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 1791796..e5cc4da 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -33,6 +33,7 @@
 #define CS4271_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 			    SNDRV_PCM_FMTBIT_S24_LE | \
 			    SNDRV_PCM_FMTBIT_S32_LE)
+#define CS4271_PCM_RATES SNDRV_PCM_RATE_8000_192000
 
 /*
  * CS4271 registers
@@ -392,14 +393,14 @@ static struct snd_soc_dai_driver cs4271_dai = {
 		.stream_name	= "Playback",
 		.channels_min	= 2,
 		.channels_max	= 2,
-		.rates		= SNDRV_PCM_RATE_8000_96000,
+		.rates		= CS4271_PCM_RATES,
 		.formats	= CS4271_PCM_FORMATS,
 	},
 	.capture = {
 		.stream_name	= "Capture",
 		.channels_min	= 2,
 		.channels_max	= 2,
-		.rates		= SNDRV_PCM_RATE_8000_96000,
+		.rates		= CS4271_PCM_RATES,
 		.formats	= CS4271_PCM_FORMATS,
 	},
 	.ops = &cs4271_dai_ops,
