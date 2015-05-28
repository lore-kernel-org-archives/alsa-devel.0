From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Dump DSP_SCRATCH1 on DSP shutdown
Date: Thu, 28 May 2015 17:13:13 +0100
Message-ID: <20150528161313.GB19558@opensource.wolfsonmicro.com>
References: <1432820714-31850-1-git-send-email-rf@opensource.wolfsonmicro.com> <20150528135751.GV21577@sirena.org.uk> <20150528142431.GA19558@opensource.wolfsonmicro.com> <20150528143724.GY21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150528143724.GY21577@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2015 at 03:37:24PM +0100, Mark Brown wrote:
> On Thu, May 28, 2015 at 03:24:39PM +0100, Richard Fitzgerald wrote:
> > On Thu, May 28, 2015 at 02:57:51PM +0100, Mark Brown wrote:
> 
> > > > -		adsp_dbg(dsp, "Shutdown complete\n");
> > > > +		adsp_info(dsp, "Shutdown complete (SCRATCH1:0x%x)\n", scratch1);
> 
> > > That seems a bit loud for a diagnostic message, why raise the severity?
> 
> > It's a diagnostic of the firmware, not the driver, and we can't assume that
> > people trying to use a firmware have the ability to build and flash a kernel
> > with a debug version of the driver
> 
> The default is that dev_dbg() is available in dmesg but not on the
> console which usually seems like a reasonable balance for this sort of
> thing - it's there if people want it but not included in the default
> logging.

What you're describing seems to be the default for dev_info().
For me I don't get any dev_dbg() output in the dmesg log unless the source
file has a #define DEBUG at the top.
