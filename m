From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] ASoC: cs4270: Remove mono support
Date: Tue, 18 Sep 2012 13:03:54 -0300
Message-ID: <1347984234-9275-2-git-send-email-fabio.estevam@freescale.com>
References: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EA782650D0
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 18:04:28 +0200 (CEST)
In-Reply-To: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@freescale.com, javier.martin@vista-silicon.com
List-Id: alsa-devel@alsa-project.org

According to cs4270 datasheet, there is no reference to mono mode.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/cs4270.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 815b53b..8e47798 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -459,7 +459,7 @@ static struct snd_soc_dai_driver cs4270_dai = {
 	.name = "cs4270-hifi",
 	.playback = {
 		.stream_name = "Playback",
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.rate_min = 4000,
@@ -468,7 +468,7 @@ static struct snd_soc_dai_driver cs4270_dai = {
 	},
 	.capture = {
 		.stream_name = "Capture",
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.rate_min = 4000,
-- 
1.7.9.5
