From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 3/6] ASoC: ux500: Drop pinctrl sleep support
Date: Wed, 8 May 2013 11:00:25 +0200
Message-ID: <20130508090025.GC1526@balto.lan>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-4-git-send-email-fabio.baltieri@linaro.org>
 <20130508080708.GH3102@gmail.com>
 <20130508082017.GA1526@balto.lan>
 <20130508084846.GB3459@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508084846.GB3459@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 08, 2013 at 09:48:46AM +0100, Lee Jones wrote:
> On Wed, 08 May 2013, Fabio Baltieri wrote:
> 
> > On Wed, May 08, 2013 at 09:07:08AM +0100, Lee Jones wrote:
> > > On Wed, 08 May 2013, Fabio Baltieri wrote:
> > > 
> > > > Drop pinctrl default/sleep state switching code, as it was breaking the
> > > > capture interface by putting the I2S pins in hi-z mode regardless of its
> > > > usage status, and not giving any real benefit.
> > > > 
> > > > Pinctrl default mode configuration is already managed automatically by a
> > > > specific pinctrl hog.
> > > 
> > > I'm sure we should support pinctrl though shouldn't we?
> > > 
> > > Is there no way of fixing the implementation instead of ripping it out?
> > 
> > Yes, but requesting the default pinctrl configuration should be enough,
> > and as those pins are shared with multiple device ids, a "hog"
> > configuration should be the cleanest.
> > 
> > Actually I asked Linus an opinion before doing this, so maybe he can ack
> > this patch or suggest a better way of doing this, such as declaring the
> > same pins for multiple device ids, but I'm not sure that would work as
> > expected.
> 
> Linus is on vacation at the moment, but I agree he should have the
> final say on this. Better wait until he returns.

Sounds good, I'll send the pinctrl patch in the meantime.  There should
be no dependency issues regardless of merging order so I'll keep that
one on its own.

Fabio

-- 
Fabio Baltieri
