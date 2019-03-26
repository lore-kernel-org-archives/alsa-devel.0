From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ASoC: core: Fix use-after-free after deferred card
 registration
Date: Tue, 26 Mar 2019 10:49:00 -0700
Message-ID: <20190326174900.GB9916@roeck-us.net>
References: <1553621018-8944-1-git-send-email-linux@roeck-us.net>
 <CAOReqxhLmTBZx04FZaeS_-9f6bk1RwJ_31UqB8MQ=KyB-5Ou=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOReqxhLmTBZx04FZaeS_-9f6bk1RwJ_31UqB8MQ=KyB-5Ou=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Curtis Malainey <cujomalainey@google.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 26, 2019 at 10:35:41AM -0700, Curtis Malainey wrote:
> This has already been patched. See
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-March/146150.html

Ah, obviously. I missed that one. Sorry for the noise.

Guenter

> 
> On Tue, Mar 26, 2019 at 10:23 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > If snd_soc_register_card() fails because one of its links fails
> > to instantiate with -EPROBE_DEFER, and the to-be-registered link
> > is a legacy link, a subsequent retry will trigger a use-after-free
> > and quite often a system crash.
> >
> > Example:
> >
> > byt-max98090 byt-max98090: ASoC: failed to init link Baytrail Audio
> > byt-max98090 byt-max98090: snd_soc_register_card failed -517
> > ....
> > BUG: KASAN: use-after-free in snd_soc_init_platform+0x233/0x312
> > Read of size 8 at addr ffff888067c43070 by task kworker/1:1/23
> >
> > snd_soc_init_platform() allocates memory attached to the card device.
> > This memory is released when the card device is released. However,
> > the pointer to the memory (dai_link->platforms) is only cleared from
> > soc_cleanup_platform(), which is called from soc_cleanup_card_resources(),
> > but not if snd_soc_register_card() fails early.
> >
> > Add the missing call to soc_cleanup_platform() in the error handling
> > code of snd_soc_register_card() to fix the problem.
> >
> > Fixes: 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")
> > Cc: Curtis Malainey <cujomalainey@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  sound/soc/soc-core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> > index 93d316d5bf8e..6bf9884d0863 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -2799,6 +2799,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
> >                 if (ret) {
> >                         dev_err(card->dev, "ASoC: failed to init link %s\n",
> >                                 link->name);
> > +                       soc_cleanup_platform(card);
> >                         mutex_unlock(&client_mutex);
> >                         return ret;
> >                 }
> > --
> > 2.7.4
> >
