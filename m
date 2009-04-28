From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 15/17] ASoC: TWL4030: Fix gain control for
	earpiece amplifier
Date: Tue, 28 Apr 2009 16:23:40 +0100
Message-ID: <1240932222-3718-15-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF6ED103888
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:45 +0200 (CEST)
In-Reply-To: <20090428152256.GB2244@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

From: Joonyoung Shim <jy0922.shim@samsung.com>

The gain control for earpiece amplifier uses 0dB ~ 12dB according to the
TRM, but the present code is implemented to -6dB ~ 6dB.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 921b205..df7c8c2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -836,6 +836,12 @@ static DECLARE_TLV_DB_SCALE(analog_tlv, -2400, 200, 0);
 static DECLARE_TLV_DB_SCALE(output_tvl, -1200, 600, 1);
 
 /*
+ * Gain control for earpiece amplifier
+ * 0 dB to 12 dB in 6 dB steps (mute instead of -6)
+ */
+static DECLARE_TLV_DB_SCALE(output_ear_tvl, -600, 600, 1);
+
+/*
  * Capture gain after the ADCs
  * from 0 dB to 31 dB in 1 dB steps
  */
@@ -900,7 +906,7 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 		4, 3, 0, output_tvl),
 
 	SOC_SINGLE_TLV_TWL4030("Earpiece Playback Volume",
-		TWL4030_REG_EAR_CTL, 4, 3, 0, output_tvl),
+		TWL4030_REG_EAR_CTL, 4, 3, 0, output_ear_tvl),
 
 	/* Common capture gain controls */
 	SOC_DOUBLE_R_TLV("TX1 Digital Capture Volume",
-- 
1.6.2.4
