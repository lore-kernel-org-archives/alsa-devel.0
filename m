From: Sven Neumann <s.neumann@raumfeld.com>
Subject: [PATCH] ASoC: PXA: formatting
Date: Mon, 31 Jan 2011 16:10:50 +0100
Message-ID: <1296486650-6370-1-git-send-email-s.neumann@raumfeld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 296EA24560
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 16:11:15 +0100 (CET)
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
Cc: Sven Neumann <s.neumann@raumfeld.com>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sven Neumann <s.neumann@raumfeld.com>
---
 sound/soc/pxa/raumfeld.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 0fd60f4..4a4b73e 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -229,19 +229,19 @@ static struct snd_soc_dai_link raumfeld_dai[] = {
 {
 	.name		= "ak4104",
 	.stream_name	= "Playback",
-	.cpu_dai_name = "pxa-ssp-dai.1",
-	.codec_dai_name = "ak4104-hifi",
-	.platform_name = "pxa-pcm-audio",
+	.cpu_dai_name	= "pxa-ssp-dai.1",
+	.codec_dai_name	= "ak4104-hifi",
+	.platform_name	= "pxa-pcm-audio",
 	.ops		= &raumfeld_ak4104_ops,
-	.codec_name = "ak4104-codec.0",
+	.codec_name	= "ak4104-codec.0",
 },
 {
 	.name		= "CS4270",
 	.stream_name	= "CS4270",
-	.cpu_dai_name = "pxa-ssp-dai.0",
-	.platform_name = "pxa-pcm-audio",
-	.codec_dai_name = "cs4270-hifi",
-	.codec_name = "cs4270-codec.0-0048",
+	.cpu_dai_name	= "pxa-ssp-dai.0",
+	.platform_name	= "pxa-pcm-audio",
+	.codec_dai_name	= "cs4270-hifi",
+	.codec_name	= "cs4270-codec.0-0048",
 	.ops		= &raumfeld_cs4270_ops,
 },};
 
-- 
1.7.1
