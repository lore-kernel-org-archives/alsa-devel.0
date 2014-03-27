From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Add isr to deal with error
 flag
Date: Thu, 27 Mar 2014 10:29:36 +0800
Message-ID: <20140327022934.GA16197@MrMyself>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6E958E@AcuExch.aculab.com>
 <20140327011424.GB30768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140327011424.GB30768@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 27, 2014 at 01:14:24AM +0000, Mark Brown wrote:
> On Wed, Mar 26, 2014 at 11:59:53AM +0000, David Laight wrote:
> > From: Nicolin Chen
> 
> > > +	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
> > > +	regmap_write(sai->regmap, FSL_SAI_TCSR, xcsr);
> 
> > Assuming these are 'write to clear' bits, you might want
> > to make the write (above) and all the traces (below)
> > conditional on the value being non-zero.
> 
> The trace is already conditional?  I'd also expect to see the driver
> only acknowledging sources it knows about and only reporting that the
> interrupt was handled if it saw one of them - right now all interrupts
> are unconditionally acknowleged.

Will revise it based on the comments from both of you.

Thank you.


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
