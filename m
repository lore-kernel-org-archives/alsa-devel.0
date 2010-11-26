From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Use DC servo startup mode when not
	doing DCS correction
Date: Fri, 26 Nov 2010 17:23:44 +0000
Message-ID: <1290792224-21758-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290792224-21758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70B4A243E9
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 18:23:50 +0100 (CET)
In-Reply-To: <1290792224-21758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Devices which do not have a DCS correction applied can use the explicit
DC servo startup mode for optimal startup performance. This most
immediately affects the WM8958.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index e7a19d6..b24ba9f 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -105,12 +105,20 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 		return;
 	}
 
-	/* Set for 32 series updates */
-	snd_soc_update_bits(codec, WM8993_DC_SERVO_1,
-			    WM8993_DCS_SERIES_NO_01_MASK,
-			    32 << WM8993_DCS_SERIES_NO_01_SHIFT);
-	wait_for_dc_servo(codec,
-			  WM8993_DCS_TRIG_SERIES_0 | WM8993_DCS_TRIG_SERIES_1);
+	/* Devices not using a DCS code correction have startup mode */
+	if (hubs->dcs_codes) {
+		/* Set for 32 series updates */
+		snd_soc_update_bits(codec, WM8993_DC_SERVO_1,
+				    WM8993_DCS_SERIES_NO_01_MASK,
+				    32 << WM8993_DCS_SERIES_NO_01_SHIFT);
+		wait_for_dc_servo(codec,
+				  WM8993_DCS_TRIG_SERIES_0 |
+				  WM8993_DCS_TRIG_SERIES_1);
+	} else {
+		wait_for_dc_servo(codec,
+				  WM8993_DCS_TRIG_STARTUP_0 |
+				  WM8993_DCS_TRIG_STARTUP_1);
+	}
 
 	/* Different chips in the family support different readback
 	 * methods.
-- 
1.7.1
