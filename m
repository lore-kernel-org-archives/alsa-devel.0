From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: RE: [PATCH 1/2] ASoC: mxs-saif: add record function
Date: Wed, 24 Aug 2011 11:08:15 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F772223F4A@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1313942545-21403-1-git-send-email-b29396@freescale.com>
	<20110822113054.GC2006@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110822113054.GC2006@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Monday, August 22, 2011 7:31 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; linux-arm-kernel@lists.infradead.org;
> broonie@opensource.wolfsonmicro.com; lrg@ti.com; s.hauer@pengutronix.de
> Subject: Re: [PATCH 1/2] ASoC: mxs-saif: add record function
> 
> On Mon, Aug 22, 2011 at 12:02:25AM +0800, Dong Aisheng wrote:
> > 1. add different clkmux mode handling for record.
> > SAIF can use two instances to implement full duplex (playback &
> > recording) and record saif may work on EXTMASTER mode that is using
> > other saif's BITCLK&LRCLK.
> > The clkmux mode is determined by saif's platform data and machine
> > specific clkmux setting is done in pdata->init().
> > 2. support playback and capture simutaneously however the sample rates
> > can not be different due to hw limitation.
> >
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@ti.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> 
> Will test and review, but probably not before Wednesday.
> 

If you want to test, you may need to apply another sgtl5000 patch
to fix noise issue.

BTW, since MX28EVK only has line-in (no mic-in), i just tested by
capturing data from line-in and connected the line-in to a PC's
Headphone output.

Not sure if there might be some issue due to line-in level is a
little different from headphone out level.
(Any comments from the person who knows?)

Anyway, it just sounds well at my side.

The patch for your reference:
It's just for testing and I'm going to check it with our ic people
for the root cause.

Regards
Dong Aisheng

>From a29191c7716680966c82132e50356b78f9b1c9b6 Mon Sep 17 00:00:00 2001
From: Dong Aisheng <b29396@freescale.com>
Date: Wed, 17 Aug 2011 21:29:12 +0800
Subject: [PATCH 1/1] sgtl5000: fix record unwork issue

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 5a0d8e4..ef52890 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -198,13 +198,13 @@ static int small_pop_event(struct snd_soc_dapm_widget *w,
 {
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
-			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
+//		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
+//			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
-			SGTL5000_VAG_POWERUP, 0);
+//		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
+//			SGTL5000_VAG_POWERUP, 0);
 		msleep(400);
 		break;
 	default:
@@ -1153,11 +1153,13 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 				SGTL5000_VDDC_CHRGPMP_POWERUP, 0);
 
 		/* VDDC use VDDIO rail */
-		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
-		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
-			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+//		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
+//		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
+//			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
 	}
 
+//	ana_pwr |= SGTL5000_VDDC_CHRGPMP_POWERUP | SGTL5000_VAG_POWERUP | SGTL5000_HP_POWERUP;
+	ana_pwr |= 0x5afb;
 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
 
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
@@ -1194,9 +1196,9 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 	else
 		vag = (vag - SGTL5000_ANA_GND_BASE) / SGTL5000_ANA_GND_STP;
 
-	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
-			vag << SGTL5000_ANA_GND_SHIFT,
-			vag << SGTL5000_ANA_GND_SHIFT);
+//	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
+//			vag << SGTL5000_ANA_GND_SHIFT,
+///			vag << SGTL5000_ANA_GND_SHIFT);
 
 	/* set line out VAG to vddio / 2, in range (0.8v, 1.675v) */
 	vag = vddio / 2;
@@ -1208,14 +1210,15 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 	else
 		vag = (vag - SGTL5000_LINE_OUT_GND_BASE) /
 		    SGTL5000_LINE_OUT_GND_STP;
-
+#if 1
 	snd_soc_update_bits(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-			vag << SGTL5000_LINE_OUT_GND_SHIFT |
+//			vag << SGTL5000_LINE_OUT_GND_SHIFT |
 			SGTL5000_LINE_OUT_CURRENT_360u <<
 				SGTL5000_LINE_OUT_CURRENT_SHIFT,
-			vag << SGTL5000_LINE_OUT_GND_SHIFT |
+//			vag << SGTL5000_LINE_OUT_GND_SHIFT |
 			SGTL5000_LINE_OUT_CURRENT_360u <<
 				SGTL5000_LINE_OUT_CURRENT_SHIFT);
+#endif
 
 	return 0;
 }
@@ -1378,7 +1381,8 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_CTRL,
 			SGTL5000_HP_ZCD_EN |
-			SGTL5000_ADC_ZCD_EN);
+			SGTL5000_ADC_ZCD_EN 
+			| SGTL5000_LINE_OUT_MUTE);
 
 	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 0);
 
-- 
1.7.0.4
