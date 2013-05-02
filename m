From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 2/3] ASoC: ux500: move clock controls to ab8500-codec
Date: Thu, 2 May 2013 09:54:21 +0200
Message-ID: <20130502075421.GA23346@balto.lan>
References: <1367330994-7259-1-git-send-email-fabio.baltieri@linaro.org>
 <1367330994-7259-3-git-send-email-fabio.baltieri@linaro.org>
 <20130430183035.GC26160@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130430183035.GC26160@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 30, 2013 at 07:30:35PM +0100, Mark Brown wrote:
> On Tue, Apr 30, 2013 at 04:09:53PM +0200, Fabio Baltieri wrote:
> > Move ab8500 clock control definitions to the ab8500 codec driver,
> > leaving only card specific setting in mop500_ab8500_ctrls.
> 
> So, if this is some generic thing and not some weird stuff for the card
> this really reopens the question about why this is done with user
> visible controls...
> 
> >  static struct snd_kcontrol_new ab8500_ctrls[] = {
> > +	/* Digital interface - Clocks */
> > +	SOC_SINGLE("Digital Interface Master Generator Switch",
> > +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENMASTGEN,
> > +		1, 0),
> > +	SOC_SINGLE("Digital Interface 0 Bit-clock Switch",
> > +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK0,
> > +		1, 0),
> > +	SOC_SINGLE("Digital Interface 1 Bit-clock Switch",
> > +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK1,
> > +		1, 0),
> 
> ...this is all stuff that is normally figured out automatically by the
> drivers, we know when the audio interface is in use and hence when it
> needs to be clocked.

It makes sense, I'll poke the documentation I have and try to figure out
how to control those bits from a more appropriate place.

Thanks,
Fabio

-- 
Fabio Baltieri
