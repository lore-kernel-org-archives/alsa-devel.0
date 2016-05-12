From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8985: rework and fix the clock
	calculation
Date: Thu, 12 May 2016 16:10:22 +0100
Message-ID: <20160512151022.GK1646@localhost.localdomain>
References: <1463035734-24477-1-git-send-email-petr@barix.com>
 <20160512121558.GJ1646@localhost.localdomain>
 <57347FC4.5040009@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 506AB266636
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 17:10:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57347FC4.5040009@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: Plamen Prodanov <plamen@barix.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 12, 2016 at 03:06:12PM +0200, Petr Kulhavy wrote:
> 
> 
> On 12.05.2016 14:15, Charles Keepax wrote:
> >On Thu, May 12, 2016 at 08:48:54AM +0200, Petr Kulhavy wrote:
> >@@ -693,15 +682,18 @@ static int wm8985_hw_params(struct snd_pcm_substream *substream,
> >  	struct snd_soc_codec *codec;
> >  	struct wm8985_priv *wm8985;
> >  	u16 blen, srate_idx;
> >-	unsigned int tmp;
> >  	int srate_best;
> >+	unsigned int bclk;	/* bit clock matching the current params */
> >+	unsigned int sysclk;	/* the actual sysclk after post division */
> >  	codec = dai->codec;
> >  	wm8985 = snd_soc_codec_get_drvdata(codec);
> >-	wm8985->bclk = snd_soc_params_to_bclk(params);
> >-	if ((int)wm8985->bclk < 0)
> >-		return wm8985->bclk;
> >+	/* always use 256 * fs in order to get best filter quality */
> >+	sysclk = 256 * params_rate(params);
> >Seems quite bold to assume we always want to use 256*fs, I am not
> >super familiar with the part itself but are there good reasons to
> >do that? What if someone wanted to use say a direct MCLK and a
> >lower multiple?
> >
> >The intent presumably here is that set_sysclk is where we set the
> >target SYSCLK and set_pll should set the PLL output then here we
> >probably should work out the correct MCLKDIV to get those.
> As I understand the datasheet the codec is basically designed for 256*fs
> clock:
> DAC and ADC expect it, so do the cutoffs for the digital filters, ALC attack
> and delay times.
> Also all the timing diagrams are specified at 256fs clock.

Ok that seems pretty conclusive that we should always have this
at 256fs.

> >>  static int pll_factors(struct pll_div *pll_div, unsigned int target,
> >>  		       unsigned int source)
> >>  {
> >>@@ -872,17 +867,23 @@ static int wm8985_set_sysclk(struct snd_soc_dai *dai,
> >>  				    WM8985_CLKSEL_MASK, 0);
> >>  		snd_soc_update_bits(codec, WM8985_POWER_MANAGEMENT_1,
> >>  				    WM8985_PLLEN_MASK, 0);
> >>+		wm8985->pllout = freq;
> >>  		break;
> >>  	case WM8985_CLKSRC_PLL:
> >>  		snd_soc_update_bits(codec, WM8985_CLOCK_GEN_CONTROL,
> >>  				    WM8985_CLKSEL_MASK, WM8985_CLKSEL);
> >>+		/*
> >>+		 * in order to run the PLL within the recommended 90MHz
> >>+		 * operating range the wm8985_set_pll() configures the PLL
> >>+		 * to output double the required frequency
> >>+		 */
> >>+		wm8985->pllout = 2 * freq;
> >Were does this *2 come from? Is this the PLLPRESCALE?
> It comes from the following line in wm8985_set_pll() :
>                  ret = pll_factors(&pll_div, freq_out * 4 * 2, freq_in);
> 
> This formula is taken over from the datasheet (the section Master Clock and
> PLL, calculation of the f2) and is correct.
> It attempts to get the PLL to run at approx. 90MHz where it performs the
> best.
> But since there is only f/4 fixed post-divider after the PLL (see the Figure
> 40 in the wm8758 or Figure 38 in the wm8985 datasheet) the F_pllout is
> effectively freq*2.

Ok that also makes sense.

I will have another quick look over the patch.

Thanks,
Charles
