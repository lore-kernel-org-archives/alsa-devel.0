From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Dump DSP_SCRATCH1 on DSP shutdown
Date: Thu, 28 May 2015 15:24:39 +0100
Message-ID: <20150528142431.GA19558@opensource.wolfsonmicro.com>
References: <1432820714-31850-1-git-send-email-rf@opensource.wolfsonmicro.com> <20150528135751.GV21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150528135751.GV21577@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2015 at 02:57:51PM +0100, Mark Brown wrote:
> On Thu, May 28, 2015 at 02:45:14PM +0100, Richard Fitzgerald wrote:
> 
> > +#define ADSP2_SCRATCH0        0x40
> > +#define ADSP2_SCRATCH1        0x41
> > +#define ADSP2_SCRATCH2        0x42
> > +#define ADSP2_SCRATCH3        0x43
> 
> May as well dump the other scratches while you're at it?
> 

Fair enough

> > +	unsigned int scratch1 = 0xFFFFFFFF;
> 
> Why is this being initialized?
> 

It was done a way to avoid having two shutdown messages to cover
the rare case that we somehow failed to read the register value, since
the firmware could never write this value (it as 31 bits set).


> > -		adsp_dbg(dsp, "Shutdown complete\n");
> > +		adsp_info(dsp, "Shutdown complete (SCRATCH1:0x%x)\n", scratch1);
> 
> That seems a bit loud for a diagnostic message, why raise the severity?

It's a diagnostic of the firmware, not the driver, and we can't assume that
people trying to use a firmware have the ability to build and flash a kernel
with a debug version of the driver
