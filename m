From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Wed, 6 May 2015 13:21:53 +0100
Message-ID: <20150506122153.GA29266@opensource.wolfsonmicro.com>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com> <1430493319-23808-8-git-send-email-rf@opensource.wolfsonmicro.com> <20150504113943.GB15510@sirena.org.uk> <20150505092411.GA15549@opensource.wolfsonmicro.com> <20150505105327.GZ22845@sirena.org.uk> <20150505133129.GA26101@opensource.wolfsonmicro.com> <20150505215934.GH15510@sirena.org.uk> <20150506092405.GA17710@opensource.wolfsonmicro.com> <20150506114849.GM22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150506114849.GM22845@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 06, 2015 at 12:48:49PM +0100, Mark Brown wrote:
> On Wed, May 06, 2015 at 10:24:05AM +0100, Richard Fitzgerald wrote:
> 
> > No, I'm just saying I don't see how calling the mux positions "IN1AL"
> > is any clearer than calling them "A" and "B". The "IN1AL" names of the
> > DAPM widgets is purely an internal detail that you wouldn't see through
> > the ALSA interface anyway so they don't relate any more closely to what
> > Joe user is seeing in the control list. The IN1L mux is for IN1L
> > so including that information in the mux position is redundant. For me
> 
> Providing that people remember that this is what's going on here and
> that they remember that for this mux this shortened name is used rather
> than the full one.  We're relatively consistent in doing this for most
> drivers, it's helpful that "I want to connect X to Y" usually translates
> directly into one of "amixer cset X Y" or "amixer cset 'X Y' on".
> 
> > the real benefit of the "A"/"B" naming is that if you're reading through
> > a configuration script and saw something like
> 
> >     'IN1L Mux' = 'B'
> >     'IN1R Mux' = 'B'
> 
> > It's much more readably obvious that both channels are set the same
> > rather than
> 
> Right, but as I said on the initial version in the case where you care
> the user probably shouldn't have the ability to set them independently
> in the first place.

They don't. In this version I've got a custom put so that in the
configuration where they must both change together changing one will force
the other to the same state.
