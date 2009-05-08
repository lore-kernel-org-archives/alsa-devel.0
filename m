From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Fri,  8 May 2009 09:11:17 +0300
Message-ID: <1241763077-6851-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B371A24894
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 08:11:35 +0200 (CEST)
In-Reply-To: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, getarunks@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch fixes the 'tuck' phenomena observed on the headset
output after the streams are stopped and DAPM send the codec
to standby mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index fd392c6..06042a1 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -599,7 +599,7 @@ static int headsetl_event(struct snd_soc_dapm_widget *w,
 		/* Is this needed? Can we just use whatever gain here? */
 		twl4030_write(w->codec, TWL4030_REG_HS_GAIN_SET,
 				(hs_gain & (~0x0f)) | 0x0a);
-		hs_pop |= TWL4030_RAMP_EN;
+		hs_pop &= ~TWL4030_VMID_EN;
 		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 
 		/* Restore the original volume */
@@ -613,7 +613,7 @@ static int headsetl_event(struct snd_soc_dapm_widget *w,
 		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
 					hs_gain & (~0x0f),
 					TWL4030_REG_HS_GAIN_SET);
-		hs_pop &= ~TWL4030_VMID_EN;
+		hs_pop |= TWL4030_RAMP_EN;
 		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 		break;
 	}
-- 
1.6.2.3
