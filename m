From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Simplify default WM8958 jack
	detection code
Date: Tue, 22 Feb 2011 04:52:06 +0000
Message-ID: <1298350326-15840-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <>
	<1298350326-15840-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C90A103851
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 05:52:08 +0100 (CET)
In-Reply-To: <1298350326-15840-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The default WM8958 jack detection handler implements a full set of buttons
and also support for video detection. Support for multi-button jacks is
fairly system specific and will usually require some tuning for headsets
so simplify the implementation to only report a simple short to ground
button, leaving multi-button headsets to be handled by system specific
code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   38 ++++----------------------------------
 1 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 5f16870..42e5ebe 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -102,8 +102,6 @@ struct wm8994_priv {
 
 	wm8958_micdet_cb jack_cb;
 	void *jack_cb_data;
-	bool jack_is_mic;
-	bool jack_is_video;
 	int micdet_irq;
 
 	int revision;
@@ -2976,46 +2974,18 @@ static void wm8958_default_micdet(u16 status, void *data)
 	int report = 0;
 
 	/* If nothing present then clear our statuses */
-	if (!(status & WM8958_MICD_STS)) {
-		wm8994->jack_is_video = false;
-		wm8994->jack_is_mic = false;
+	if (!(status & WM8958_MICD_STS))
 		goto done;
-	}
-
-	/* Assume anything over 475 ohms is a microphone and remember
-	 * that we've seen one (since buttons override it) */
-	if (status & 0x600)
-		wm8994->jack_is_mic = true;
-	if (wm8994->jack_is_mic)
-		report |= SND_JACK_MICROPHONE;
 
-	/* Video has an impedence of approximately 75 ohms; assume
-	 * this isn't used as a button and remember it since buttons
-	 * override it. */
-	if (status & 0x40)
-		wm8994->jack_is_video = true;
-	if (wm8994->jack_is_video)
-		report |= SND_JACK_VIDEOOUT;
+	report = SND_JACK_MICROPHONE;
 
 	/* Everything else is buttons; just assign slots */
-	if (status & 0x4)
+	if (status & 0x1c0)
 		report |= SND_JACK_BTN_0;
-	if (status & 0x8)
-		report |= SND_JACK_BTN_1;
-	if (status & 0x10)
-		report |= SND_JACK_BTN_2;
-	if (status & 0x20)
-		report |= SND_JACK_BTN_3;
-	if (status & 0x80)
-		report |= SND_JACK_BTN_4;
-	if (status & 0x100)
-		report |= SND_JACK_BTN_5;
 
 done:
 	snd_soc_jack_report(wm8994->micdet[0].jack, report,
-			    SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-			    SND_JACK_BTN_3 | SND_JACK_BTN_4 | SND_JACK_BTN_5 |
-			    SND_JACK_MICROPHONE | SND_JACK_VIDEOOUT);
+			    SND_JACK_BTN_0 | SND_JACK_MICROPHONE);
 }
 
 /**
-- 
1.7.2.3
