From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Fix reporting of accessory
	removal on WM8958
Date: Mon, 27 May 2013 12:57:38 +0100
Message-ID: <1369655858-12643-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D42C4261AC9
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2013 13:57:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

During recent refactoring the code to report removal when MICDET reports
an absent microphone was removed, causing problems for systems which rely
solely on the MICDET for this functionality. Restore it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 0bcbd12..5f51127 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3856,6 +3856,11 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 			dev_dbg(codec->dev, "Ignoring removed jack\n");
 			return IRQ_HANDLED;
 		}
+	} else if (!(reg & WM8958_MICD_STS)) {
+		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
+				    SND_JACK_MECHANICAL | SND_JACK_HEADSET |
+				    wm8994->btn_mask);
+		goto out;
 	}
 
 	if (wm8994->mic_detecting)
-- 
1.7.10.4
