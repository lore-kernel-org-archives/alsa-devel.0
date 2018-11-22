From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ASoC: sunxi: rename SND_SUN8I_ADDA_PR_REGMAP
Date: Thu, 22 Nov 2018 22:29:05 +0100
Message-ID: <20181122212905.GA13187@zn.tnic>
References: <20181102153406.1528053-1-arnd@arndb.de>
 <13542843.KjxkD9786N@anarsoul-thinkpad>
 <CAK8P3a3A-mq2HLZjp7-5miL2Pk71=FqP5QKUxxda_y5ywCa7TA@mail.gmail.com>
 <CA+E=qVfnkH-e6hoHA1eZ7rCJvJH02zgBSF=y30R6AEGwLpssXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+E=qVfnkH-e6hoHA1eZ7rCJvJH02zgBSF=y30R6AEGwLpssXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Linux-ALSA <alsa-devel@alsa-project.org>, arm-linux <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 02, 2018 at 03:06:59PM -0700, Vasily Khoruzhick wrote:
> On Fri, Nov 2, 2018 at 3:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On 11/2/18, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > > On Friday, November 2, 2018 8:33:40 AM PDT Arnd Bergmann wrote:
> > >> The newly added SND_SUN50I_CODEC_ANALOG driver selects a nonexisting
> > >> symbol SND_SUNXI_ADDA_PR_REGMAP, which was evidently intended to replace
> > >> SND_SUN8I_ADDA_PR_REGMAP, but since they are now mismatched, we can run
> > >> into link errors for some configurations:
> > >>
> > >> sound/soc/sunxi/sun50i-codec-analog.o: In function
> > >> `sun50i_codec_analog_probe': sun50i-codec-analog.c:(.text+0x62):
> > >> undefined
> > >> reference to `sun8i_adda_pr_regmap_init'
> > >>
> > >> The new name appears to be more sensible, and as the symbol is hidden,
> > >> there are no downsides in the rename, so use that consistently now.
> > >
> > > Maxime asked it to be SND_SUN8I_ADDA_PR_REGMAP, and also it would be easier
> > > to
> > > fix it my renaming last remaining SND_SUNXI_ADDA_PR_REGMAP to
> > > SND_SUN8I_ADDA_PR_REGMAP.
> >
> > Sure, I don't care either way. Please send a patch to do that then.
> 
> Will do tonight.

Is that patch coming up or on its way somewhere?

I still hit randconfig build failures:

ERROR: "sun8i_adda_pr_regmap_init" [sound/soc/sunxi/sun50i-codec-analog.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
