From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 3/7] ASoC: wm8903: generalize GPIO control
	register bits
Date: Thu, 4 Jun 2015 09:47:36 +0100
Message-ID: <20150604084736.GB3902@opensource.wolfsonmicro.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com> <1433200158-6890-3-git-send-email-vz@mleia.com> <CACRpkdaGf+oQA3OF5HnVGXh5exz2L8RSye1Fj=r-=wzsMay_ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaGf+oQA3OF5HnVGXh5exz2L8RSye1Fj=r-=wzsMay_ag@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2015 at 10:30:10AM +0200, Linus Walleij wrote:
> On Tue, Jun 2, 2015 at 1:09 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> 
> > All GPIO1/2/3/4/5 control registers have the same bit map, but in
> > implementation of gpiolib callbacks WM8903_GPn_*, WM8903_GP1_* and
> > WM8903_GP2_* macro are mixed up. Replace particular GPIOn control
> > register bit definitions with generic ones and save ~150 LoCs.
> >
> > No functional change.
> >
> > Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> > Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Axel Lin <axel.lin@ingics.com>
> > Cc: patches@opensource.wolfsonmicro.com
> 
> This comment is not about the refactoring as such, which is OK...
> 
> > +#define WM8903_GPn_FN_MASK                      0x1F00  /* GPn_FN - [12:8] */
> > +#define WM8903_GPn_FN_SHIFT                          8  /* GPn_FN - [12:8] */
> > +#define WM8903_GPn_FN_WIDTH                          5  /* GPn_FN - [12:8] */
> 
> Function selection?
> 
> > +#define WM8903_GPn_PD                           0x0008  /* GPn_PD */
> > +#define WM8903_GPn_PD_MASK                      0x0008  /* GPn_PD */
> > +#define WM8903_GPn_PD_SHIFT                          3  /* GPn_PD */
> > +#define WM8903_GPn_PD_WIDTH                          1  /* GPn_PD */
> > +#define WM8903_GPn_PU                           0x0004  /* GPn_PU */
> > +#define WM8903_GPn_PU_MASK                      0x0004  /* GPn_PU */
> > +#define WM8903_GPn_PU_SHIFT                          2  /* GPn_PU */
> > +#define WM8903_GPn_PU_WIDTH                          1  /* GPn_PU */
> 
> Pull-down/pull-up?
> 
> That is pin control, not GPIO.
> 
> I know I should probably be a bit relaxed on enforcing strict frameworks
> on ASoC and DRI/DRM alike, because the drivers are complex and sometimes
> need to be on top of things rather than split things apart and set up
> complex cobwebs of subsystem cross-dependencies, but I'd
> like to know a bit more about the design philisophy here.
> 
> I guess this dates back to the time before the pin control subsystem?
> 

Yeah this all dates back to before pin control, I have had some
initial looks at converting some of the newer drivers over to use
pin control instead but it is still very much a work in progress
and to be fair it is debatable when I will find time for older
drivers such as this one.

Thanks,
Charles
