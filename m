From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Unsuspend the device while
	reading GPIO statuses
Date: Mon,  6 Feb 2012 18:46:55 +0000
Message-ID: <1328554015-10321-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 31103103EE5
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 19:46:59 +0100 (CET)
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

Otherwise we might get an error if the GPIO is configured as an input
since that makes the register volatile and a suspended device can't be
read from.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 1653000..a0eaf93 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3554,6 +3554,9 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 			wm8994->fll_locked_irq = false;
 	}
 
+	/* Make sure we can read from the GPIOs if they're inputs */
+	pm_runtime_get_sync(codec->dev);
+
 	/* Remember if AIFnLRCLK is configured as a GPIO.  This should be
 	 * configured on init - if a system wants to do this dynamically
 	 * at runtime we can deal with that then.
@@ -3582,6 +3585,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		wm8994->lrclk_shared[1] = 0;
 	}
 
+	pm_runtime_put(codec->dev);
+
 	/* Latch volume updates (right only; we always do left then right). */
 	snd_soc_update_bits(codec, WM8994_AIF1_DAC1_LEFT_VOLUME,
 			    WM8994_AIF1DAC1_VU, WM8994_AIF1DAC1_VU);
-- 
1.7.9.rc1
