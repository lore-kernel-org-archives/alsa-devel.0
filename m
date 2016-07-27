From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: da7213 questions
Date: Wed, 27 Jul 2016 14:17:56 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D464A231@SW-EX-MBX01.diasemi.com>
References: <alpine.DEB.2.02.1607131354390.10743@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 08E1C26667C
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 16:17:57 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1607131354390.10743@pmeerw.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On 13 July 2016 14:33, Peter Meerwald-Stadler wrote:

> I have a couple of questions/comments regarding the da7213 driver in
> mainline:
> 
> (1) the da7213 driver enables mclk in BIAS_SUSPEND, so essentially the
> clock is always running (since idle_bias_off is not set); at least on my
> platform, clk_set_rate() fails when the clock is already enabled

I guess depending on the clock being used, some allow for setting rate whilst
enabled and some do not. I had a quick look and it wasn't completely clear as to
how you would determine this. With regards to MCLK running in BIAS_SUSPEND
though, I agree it's not the most efficient. Will take a look at this.

> (2) da7213's srm_en variable is redundant and can be removed

I'd like to look at improving the PLL function a little, so will address this
at that time.

> 
> (3) for 32 kHz PLL mode (DAI master), section 13.28 of the datasheet
> indicates that PLL_SRM_EN should be asserted; the da7213 drivers goesn't
> 

This was noted recently, and is on my TODO list to update. I'll address it as
part of the PLL function improvements.

> (4) is only S16_LE actually supported?
> #define DA7213_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |
> SNDRV_PCM_FMTBIT_S20_3LE |\
> 			SNDRV_PCM_FMTBIT_S24_LE |
> SNDRV_PCM_FMTBIT_S32_LE)
> but in da7213_set_dai_fmt() we have
> 	/* By default only 32 BCLK per WCLK is supported */
> 	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_32;
>

Yes, you're correct here. It's a mistake on my part. Should be 64 not 32. Will
make sure this is updated.
