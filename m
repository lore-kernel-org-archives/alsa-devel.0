From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Fix WM8958 default microphone
	detection argument ordering
Date: Tue, 22 Feb 2011 04:52:05 +0000
Message-ID: <1298350326-15840-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B72C244FD
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 05:52:08 +0100 (CET)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 4df047e..5f16870 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3012,11 +3012,10 @@ static void wm8958_default_micdet(u16 status, void *data)
 		report |= SND_JACK_BTN_5;
 
 done:
-	snd_soc_jack_report(wm8994->micdet[0].jack,
+	snd_soc_jack_report(wm8994->micdet[0].jack, report,
 			    SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 			    SND_JACK_BTN_3 | SND_JACK_BTN_4 | SND_JACK_BTN_5 |
-			    SND_JACK_MICROPHONE | SND_JACK_VIDEOOUT,
-			    report);
+			    SND_JACK_MICROPHONE | SND_JACK_VIDEOOUT);
 }
 
 /**
-- 
1.7.2.3
