From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
 OMAP MCBSP
Date: Thu, 05 Nov 2009 10:05:20 +0000
Message-ID: <1257415520.3603.161.camel@odin>
References: <1257357235.2887.499.camel@odin>
	<200911051026.39538.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A37410391F
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 11:05:23 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 19so1245973fgg.2
	for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2009 02:05:23 -0800 (PST)
In-Reply-To: <200911051026.39538.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-11-05 at 10:26 +0200, Peter Ujfalusi wrote:
> On Wednesday 04 November 2009 19:53:55 ext Liam Girdwood wrote:
> > From: Graeme Gregory <gg@slimlogic.co.uk>
> > 
> > This patch increases the number of supported audio channels from 4
> > to 16 and was sponsored by Shotspotter inc.
> > 
> > Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> > Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> > ---
> >  sound/soc/omap/omap-mcbsp.c |   71
> >  +++++++++++++++++++++++++++++------------- 1 files changed, 49
> >  insertions(+), 22 deletions(-)
> > 

snip

> 
> I would have done this a bit differently:
> 
> ...
> 	/* Check if the number of channels are valid */
> 	if (channels < 1 || channels > 16) {
> 		/* Unsupported number of channels */
> 		/* Probably would be good to have some error message about it? */
> 		return -EINVAL;
> 	}
> 

Not really required as soc-core takes care of this for us :)


> 	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
> 	wpf = channels = params_channels(params);
> 
> 	if (channels == 2 && format == SND_SOC_DAIFMT_I2S) {
> 		/* Use dual-phase frames */
> 		regs->rcr2      |= RPHASE;
> 		regs->xcr2      |= XPHASE;
> 		/* Set 1 word per (McBSP) frame for phase1 and phase2 */
> 		wpf--;
> 		regs->rcr2      |= RFRLEN2(wpf - 1);
> 		regs->xcr2      |= XFRLEN2(wpf - 1);
> 	}
> 	/* Set word per (McBSP) frame for phase1 */
> 	regs->rcr1      |= RFRLEN1(wpf - 1);
> 	regs->xcr1      |= XFRLEN1(wpf - 1);
> 

I prefer this too.

Liam
