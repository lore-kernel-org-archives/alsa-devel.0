From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 9/9] ASoC: TWL4030: Do not alter the Headset
	output volume on power-up/down
Date: Tue,  9 Dec 2008 12:35:52 +0200
Message-ID: <1228818952-31082-10-git-send-email-peter.ujfalusi@nokia.com>
References: <1228818952-31082-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-4-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-5-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-6-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-7-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-8-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-9-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 9722C10386C
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 11:36:13 +0100 (CET)
In-Reply-To: <1228818952-31082-9-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

There is a separate gain control for the Headset output already.
Do not reset the gain to 0 dB at power up.
In power-down, there is no need to set the Headset output gain
to power-down mode, since if the CODECPDZ is in powered off this
setting has no effect.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index d0612a4..358aa2b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -887,7 +887,7 @@ static int twl4030_add_widgets(struct snd_soc_codec *codec)
 
 static void twl4030_power_up(struct snd_soc_codec *codec)
 {
-	u8 anamicl, regmisc1, byte, popn, hsgain;
+	u8 anamicl, regmisc1, byte, popn;
 	int i = 0;
 
 	/* set CODECPDZ to turn on codec */
@@ -925,10 +925,6 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 	popn |=	TWL4030_VMID_EN;
 	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
 
-	/* enable output stage and gain setting */
-	hsgain = TWL4030_HSR_GAIN_0DB | TWL4030_HSL_GAIN_0DB;
-	twl4030_write(codec, TWL4030_REG_HS_GAIN_SET, hsgain);
-
 	/* enable anti-pop ramp */
 	popn |= TWL4030_RAMP_EN;
 	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
@@ -936,17 +932,13 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 
 static void twl4030_power_down(struct snd_soc_codec *codec)
 {
-	u8 popn, hsgain;
+	u8 popn;
 
 	/* disable anti-pop ramp */
 	popn = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
 	popn &= ~TWL4030_RAMP_EN;
 	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
 
-	/* disable output stage and gain setting */
-	hsgain = TWL4030_HSR_GAIN_PWR_DOWN | TWL4030_HSL_GAIN_PWR_DOWN;
-	twl4030_write(codec, TWL4030_REG_HS_GAIN_SET, hsgain);
-
 	/* disable bias out */
 	popn &= ~TWL4030_VMID_EN;
 	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
-- 
1.6.0.3
