From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Disable debounce of jack
	detection on inserted jack
Date: Thu,  1 Mar 2012 19:07:02 +0000
Message-ID: <1330628822-8331-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36C072414F
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2012 20:07:06 +0100 (CET)
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

Don't debounce jack detection for inserted jacks, giving improved
responsiveness.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index bc1f119..81d62a3 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3235,6 +3235,10 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 		snd_soc_update_bits(codec, WM8958_MICBIAS2,
 				    WM8958_MICB2_DISCH, 0);
 
+		/* Disable debounce while inserted */
+		snd_soc_update_bits(codec, WM1811_JACKDET_CTRL,
+				    WM1811_JACKDET_DB, 0);
+
 		/*
 		 * Start off measument of microphone impedence to find
 		 * out what's actually there.
@@ -3270,6 +3274,10 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 				    SND_JACK_MECHANICAL | SND_JACK_HEADSET |
 				    wm8994->btn_mask);
 
+		/* Enable debounce while removed */
+		snd_soc_update_bits(codec, WM1811_JACKDET_CTRL,
+				    WM1811_JACKDET_DB, WM1811_JACKDET_DB);
+
 		wm8994->mic_detecting = false;
 		wm8994->jack_mic = false;
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
-- 
1.7.9.1
