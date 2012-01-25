From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5100: Make sure we switch to button
	reporting mode
Date: Wed, 25 Jan 2012 15:20:04 +0000
Message-ID: <1327504804-26830-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 44A2924361
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 16:20:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When we have identified an accessory make sure we've flagged that we've
done so in order to make sure we always report buttons and don't continue
to polarity flip.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 6a04ee2..0c82f38 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2161,6 +2161,7 @@ static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 		if (wm5100->jack_detecting) {
 			dev_dbg(wm5100->dev, "Microphone detected\n");
 			wm5100->jack_mic = true;
+			wm5100->jack_detecting = false;
 			snd_soc_jack_report(wm5100->jack,
 					    SND_JACK_HEADSET,
 					    SND_JACK_HEADSET | SND_JACK_BTN_0);
@@ -2199,6 +2200,7 @@ static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 					    SND_JACK_BTN_0);
 		} else if (wm5100->jack_detecting) {
 			dev_dbg(wm5100->dev, "Headphone detected\n");
+			wm5100->jack_detecting = false;
 			snd_soc_jack_report(wm5100->jack, SND_JACK_HEADPHONE,
 					    SND_JACK_HEADPHONE);
 
-- 
1.7.9.rc1
