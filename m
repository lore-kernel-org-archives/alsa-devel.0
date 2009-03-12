From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/3][RFC] ASoC: pxa-ssp: Don't
	use	SSCR0_SerClkDiv and SSCR0_SCR
Date: Thu, 12 Mar 2009 11:27:49 +0100
Message-ID: <20090312102749.GA14526@buzzloop.caiaq.de>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
	<20090311184416.GA29865@buzzloop.caiaq.de>
	<74d0deb30903111410v5a601709jf779c0d2e64e7de7@mail.gmail.com>
	<20090312004639.GB7462@buzzloop.caiaq.de>
	<20090312102355.GB4038@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 83B041038BE
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 11:27:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090312102355.GB4038@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 12, 2009 at 10:23:56AM +0000, Mark Brown wrote:
> On Thu, Mar 12, 2009 at 01:46:39AM +0100, Daniel Mack wrote:
> 
> > (Just for the reference - this one needs to be applied on top of my last
> >  'network vs psp mode' patch, otherwise the second hunk won't apply).
> 
> Could you please resubmit the most current versions of your outstanding
> patches?  There's too many versions of patches floating around in the
> middle of threads and I want to make sure I'm looking at the most
> current versions.

Sorry. See below. There's only one left now and this one shrunk a lot.

Daniel


>From ad8734e93eed130a55482b0e937729578e6d93c8 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Wed, 11 Mar 2009 19:38:15 +0100
Subject: [PATCH] pxa-ssp: switch from network mode to PSP

This switches the pxa ssp port usage from network mode to PSP mode.
Removed some comments and checks for configured TDM channels.
A special case is added to support configuration where BCLK = 64fs. We
need to do some black magic in this case which doesn't look nice but
there is unfortunately no other option than that.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/soc/pxa/pxa-ssp.c |   44 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 52d97c4..3cde686 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -558,18 +558,17 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		sscr0 |= SSCR0_MOD | SSCR0_PSP;
+		sscr0 |= SSCR0_PSP;
 		sscr1 |= SSCR1_RWOT | SSCR1_TRAIL;
 
 		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 		case SND_SOC_DAIFMT_NB_NF:
-			sspsp |= SSPSP_FSRT;
 			break;
 		case SND_SOC_DAIFMT_NB_IF:
-			sspsp |= SSPSP_SFRMP | SSPSP_FSRT;
+			sspsp |= SSPSP_SFRMP;
 			break;
 		case SND_SOC_DAIFMT_IB_IF:
-			sspsp |= SSPSP_SFRMP;
+			sspsp |= SSPSP_SFRMP | SSPSP_SCMODE(3);
 			break;
 		default:
 			return -EINVAL;
@@ -655,33 +654,56 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 			sscr0 |= SSCR0_FPCKE;
 #endif
 		sscr0 |= SSCR0_DataSize(16);
-		/* use network mode (2 slots) for 16 bit stereo */
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(8));
-		/* we must be in network mode (2 slots) for 24 bit stereo */
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
-		/* we must be in network mode (2 slots) for 32 bit stereo */
 		break;
 	}
 	ssp_write_reg(ssp, SSCR0, sscr0);
 
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		/* Cleared when the DAI format is set */
-		sspsp = ssp_read_reg(ssp, SSPSP) | SSPSP_SFRMWDTH(width);
+	       sspsp = ssp_read_reg(ssp, SSPSP);
+
+		if (((sscr0 & SSCR0_SCR) == SSCR0_SerClkDiv(4)) &&
+		     (width == 16)) {
+			/* This is a special case where the bitclk is 64fs
+			* and we're not dealing with 2*32 bits of audio
+			* samples.
+			*
+			* The SSP values used for that are all found out by
+			* trying and failing a lot; some of the registers
+			* needed for that mode are only available on PXA3xx.
+			*/
+
+#ifdef CONFIG_PXA3xx
+			if (!cpu_is_pxa3xx())
+				return -EINVAL;
+
+			sspsp |= SSPSP_SFRMWDTH(width * 2);
+			sspsp |= SSPSP_SFRMDLY(width * 4);
+			sspsp |= SSPSP_EDMYSTOP(3);
+			sspsp |= SSPSP_DMYSTOP(3);
+			sspsp |= SSPSP_DMYSTRT(1);
+#else
+			return -EINVAL;
+#endif
+		} else
+			sspsp |= SSPSP_SFRMWDTH(width);
+
 		ssp_write_reg(ssp, SSPSP, sspsp);
 		break;
 	default:
 		break;
 	}
 
-	/* We always use a network mode so we always require TDM slots
+	/* When we use a network mode, we always require TDM slots
 	 * - complain loudly and fail if they've not been set up yet.
 	 */
-	if (!(ssp_read_reg(ssp, SSTSA) & 0xf)) {
+	if ((sscr0 & SSCR0_MOD) && !(ssp_read_reg(ssp, SSTSA) & 0xf)) {
 		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
 		return -EINVAL;
 	}
-- 
1.6.2
