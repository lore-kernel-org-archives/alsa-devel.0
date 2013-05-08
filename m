From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 3/6] ASoC: ux500: Drop pinctrl sleep support
Date: Wed, 8 May 2013 15:10:20 +0200
Message-ID: <20130508131020.GA30503@balto.lan>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-4-git-send-email-fabio.baltieri@linaro.org>
 <20130508105124.GA7478@sirena.org.uk>
 <20130508114216.GB29130@balto.lan>
 <20130508123225.GK7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508123225.GK7478@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 08, 2013 at 01:32:25PM +0100, Mark Brown wrote:
> On Wed, May 08, 2013 at 01:42:16PM +0200, Fabio Baltieri wrote:
> > On Wed, May 08, 2013 at 11:51:24AM +0100, Mark Brown wrote:
> 
> > > I tend to agree with Lee that this looks like a bad approach - there's a
> > > whole bunch of other code in there which I'd guess is probably equally
> > > broken but only the pinctrl code is being removed.  Why not just fix it
> > > (or better yet simplify all this stuff)?
> 
> > Sorry I did not get the subject, are you referring to other broken code
> > in the ux500 driver or to pinctrl and shared pins in generals?
> 
> I'm saying that if functions like enable_msp() don't work reliably then
> removing some but not all of their functionality isn't an obviously good
> approach to fixing that.  Why does the other functionality work well but
> not this bit?  It sounds like there's some reference counting bug here
> is all...

Yes, it started as a reference counting bug, due to the actual counter
not being shared between ux500-msp-i2s instances.

That said, the actual fork of this driver deployed by STE internally
does not handle I2S pin sleep state, and I was not able to find any
other ASoC driver that does that, which seems reasonable to me as I
can't come up with a reason to put those pins in hi-z anyway.

If I understood the problem correctly you do that when you want to cut
power completely to some peripherals to avoid spurious current paths,
and that should not be the case for the audio codec, especially in this
case where it's part of a big multifuntion IC.

So this is why I'm proposing to drop that code altogheter rather than
fix it.

Fabio

-- 
Fabio Baltieri
