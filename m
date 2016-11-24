From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: cq93vc: enable compiling on COMPILE_TEST
Date: Thu, 24 Nov 2016 08:48:09 +0000
Message-ID: <20161124084809.GT10134@dell.home>
References: <878ttafb84.wl%kuninori.morimoto.gx@renesas.com>
 <8760ndei6k.wl%kuninori.morimoto.gx@renesas.com>
 <87wpftcw2v.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wpftcw2v.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Arnd Bergmann <arnd@arndb.de>, anish kumar <yesanishhere@gmail.com>, Michael Trimarchi <michael@amarulasolutions.com>, Jacob Siverskog <jacob@teenage.engineering>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Jeremy McDermond <nh6z@nh6z.net>, Bard Liao <bardliao@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 24 Nov 2016, Kuninori Morimoto wrote:

> 
> Hi Lee, Mark
> 
> > > Current cq93vc sound codec indicates that it has
> > > MFD_DAVINCI_VOICECODEC dependency, but it doesn't.
> > > This means we can compile it from non DAVINCE environment
> > > by COMPILE_TEST.
> > > These patches solve this issue.
> > > I tested this on ARCH=x86 + make allyesconfig, and
> > > ARCH=ARM + shmobile_defconfig + COMPILE_TEST.
> > > 
> > > Kuninori Morimoto (2):
> > >       mfd: davinci_voicecodec: tidyup header difinitions
> > >       ASoC: cq93vc: remove MFD_DAVINCI_VOICECODEC dependency for CQ0093VC
> > 
> > I know [2/2] had Acked-by from Mark, and [1/2] was accepted by Lee.
> > I could find [1/2] patch on linux-next tree today.
> > But, I'm afraid I can't find [2/2] patch on linux-next.
> 
> I mean, I (and Mark too?) thought Lee can handle [2/2] patch,
> but it seems not (?). So, my question is who can handle it ?

I didn't see anything build-time dependant.

Unless I missed something?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
