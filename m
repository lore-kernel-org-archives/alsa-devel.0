From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 2/2] ASoC: mxs-sgtl5000: add record function
Date: Mon, 22 Aug 2011 20:20:30 +0800
Message-ID: <1314015630-25022-2-git-send-email-b29396@freescale.com>
References: <1314015630-25022-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id E6BA31038C7
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 14:08:02 +0200 (CEST)
In-Reply-To: <1314015630-25022-1-git-send-email-b29396@freescale.com>
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Acked-by: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/soc/mxs/mxs-sgtl5000.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index a0d89c9..7fbeaec 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -85,13 +85,21 @@ static struct snd_soc_ops mxs_sgtl5000_hifi_ops = {
 
 static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
 	{
-		.name		= "HiFi",
+		.name		= "HiFi Tx",
 		.stream_name	= "HiFi Playback",
 		.codec_dai_name	= "sgtl5000",
 		.codec_name	= "sgtl5000.0-000a",
 		.cpu_dai_name	= "mxs-saif.0",
 		.platform_name	= "mxs-pcm-audio.0",
 		.ops		= &mxs_sgtl5000_hifi_ops,
+	}, {
+		.name		= "HiFi Rx",
+		.stream_name	= "HiFi Capture",
+		.codec_dai_name	= "sgtl5000",
+		.codec_name	= "sgtl5000.0-000a",
+		.cpu_dai_name	= "mxs-saif.1",
+		.platform_name	= "mxs-pcm-audio.1",
+		.ops		= &mxs_sgtl5000_hifi_ops,
 	},
 };
 
-- 
1.7.0.4
