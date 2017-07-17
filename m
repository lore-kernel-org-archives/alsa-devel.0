From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fix pcm-creation regression
Date: Mon, 17 Jul 2017 10:03:48 +0200
Message-ID: <20170717080348.GZ29638@localhost>
References: <20170712155530.17765-1-johan@kernel.org>
 <CACRpkdax+tYOsJphnnP7HE-0srhSZshDu+znDYo=092YotANiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdax+tYOsJphnnP7HE-0srhSZshDu+znDYo=092YotANiQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, Brian Norris <briannorris@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 14, 2017 at 03:35:46PM +0200, Linus Walleij wrote:
> On Wed, Jul 12, 2017 at 5:55 PM, Johan Hovold <johan@kernel.org> wrote:
> 
> > This reverts commit 99b04f4c4051 ("ASoC: add Component level
> > pcm_new/pcm_free"), which started calling the pcm_new callback for every
> > component in a *card* when creating a new pcm, something which does not
> > seem to make any sense.
> >
> > This specifically led to memory leaks in systems with more than one
> > platform component and where DMA memory is allocated in the
> > platform-driver callback. For example, when both mcasp devices are being
> > used on an am335x board, DMA memory would be allocated twice for every
> > DAI link during probe.
> >
> > When CONFIG_SND_VERBOSE_PROCFS was set this fortunately also led to
> > warnings such as:
> >
> > WARNING: CPU: 0 PID: 565 at ../fs/proc/generic.c:346 proc_register+0x110/0x154
> > proc_dir_entry 'sub0/prealloc' already registered
> >
> > Since there seems to be no users of the new component callbacks, and the
> > current implementation introduced a regression, let's revert the
> > offending commit for now.
> >
> > Fixes: 99b04f4c4051 ("ASoC: add Component level pcm_new/pcm_free")
> > Cc: stable <stable@vger.kernel.org>     # 4.10
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Cc: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> I have repeatedly ran into this bug, thanks a *lot* for fixing it.
> It solves a problem not only on this old code but also in my
> development tree where I try to move the Ux500 audio to DT-only
> instantiation and this was a blocker that I just ran my head into
> the last month or two.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for testing these, Linus.

Johan
