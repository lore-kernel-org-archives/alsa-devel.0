From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: [PATCH 2/2] ASOC: fix neo1973 wm8753 initialization
Date: Sun, 26 Feb 2012 19:21:54 +0100
Message-ID: <1330280514-32232-2-git-send-email-GNUtoo@no-log.org>
References: <1330280514-32232-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp204.alice.it (smtp204.alice.it [82.57.200.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 1086A243E8
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2012 19:22:06 +0100 (CET)
In-Reply-To: <1330280514-32232-1-git-send-email-GNUtoo@no-log.org>
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
Cc: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
List-Id: alsa-devel@alsa-project.org

The neo1973 wm8753 driver had wrong codec name
  which prevented the "sound card" from appearing.

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 sound/soc/samsung/neo1973_wm8753.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 24bdb32..321d511 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -367,7 +367,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 	.platform_name = "samsung-audio",
 	.cpu_dai_name = "s3c24xx-iis",
 	.codec_dai_name = "wm8753-hifi",
-	.codec_name = "wm8753-codec.0-001a",
+	.codec_name = "wm8753.0-001a",
 	.init = neo1973_wm8753_init,
 	.ops = &neo1973_hifi_ops,
 },
@@ -376,7 +376,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 	.stream_name = "Voice",
 	.cpu_dai_name = "dfbmcs320-pcm",
 	.codec_dai_name = "wm8753-voice",
-	.codec_name = "wm8753-codec.0-001a",
+	.codec_name = "wm8753.0-001a",
 	.ops = &neo1973_voice_ops,
 },
 };
-- 
1.7.4.1
