From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: wm8994: fix the codec state machine
Date: Thu, 30 May 2013 21:52:10 +0530
Message-ID: <1369930931-9635-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C3062615D6
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 18:59:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

few places the mic_detecting is not updated correctly when state changes,
causing jack detection to go wrong

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/wm8994.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 49b2b00..43f82d2 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3547,6 +3547,7 @@ static void wm8958_mic_id(void *data, u16 status)
 		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
 				    wm8994->btn_mask |
 				    SND_JACK_HEADSET);
+		wm8994->mic_detecting = true;
 		return;
 	}
 
@@ -3672,7 +3673,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 		snd_soc_update_bits(codec, WM1811_JACKDET_CTRL,
 				    WM1811_JACKDET_DB, WM1811_JACKDET_DB);
 
-		wm8994->mic_detecting = false;
+		wm8994->mic_detecting = true;
 		wm8994->jack_mic = false;
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, 0);
@@ -3696,6 +3697,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	/* Since we only report deltas force an update, ensures we
 	 * avoid bootstrapping issues with the core. */
 	snd_soc_jack_report(wm8994->micdet[0].jack, 0, 0);
+	wm8994->mic_detecting = true;
 
 	pm_runtime_put(codec->dev);
 	return IRQ_HANDLED;
-- 
1.7.0.4
