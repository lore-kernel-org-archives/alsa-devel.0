From: Konstantinos Tsimpoukas <kostaslinuxxx@gmail.com>
Subject: Re: [PATCH 1/1] ice1712: check if snd card loaded,
	if not do not proceed
Date: Fri, 11 Jul 2014 12:50:10 -0500
Message-ID: <CAKs1uqwYkz6OA4si8dsRicVg-tn530QhJAhacmaW1e74REQQdA@mail.gmail.com>
References: <1405052377-3096-1-git-send-email-kostaslinuxxx@gmail.com>
 <s5hfvi8ky4w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f44.google.com (mail-oa0-f44.google.com
 [209.85.219.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 769BA265005
 for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2014 19:50:12 +0200 (CEST)
Received: by mail-oa0-f44.google.com with SMTP id eb12so1543058oac.31
 for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2014 10:50:11 -0700 (PDT)
In-Reply-To: <s5hfvi8ky4w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Then i suppose the same applies for hda snd remove (in hda_intel.c),
as same struct is used there as well.

Regards,
Kostas


2014-07-11 5:06 GMT-05:00 Takashi Iwai <tiwai@suse.de>:

> At Thu, 10 Jul 2014 23:19:37 -0500,
> Konstantinos Tsimpoukas wrote:
> >
> > Just adding a simple if statement, which
> > verifies if actually card is loaded, if not
> > does not continue with the execution
> > of the snd_card_free.
>
> It's already referenced by ice, so a NULL check must be peformed at
> first.  But, basically card is always non-NULL.  The remove callback
> is called only for objects that was properly bound with probe
> callback.  snd_ice1712_probe() always sets the card pointer when it
> succeeds.
>
>
> thanks,
>
> Takashi
>
>
> > Signed-off-by: Konstantinos Tsimpoukas <kostaslinuxxx@gmail.com>
> > ---
> >  sound/pci/ice1712/ice1712.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
> > index d9b9e45..431096b 100644
> > --- a/sound/pci/ice1712/ice1712.c
> > +++ b/sound/pci/ice1712/ice1712.c
> > @@ -2819,7 +2819,8 @@ static void snd_ice1712_remove(struct pci_dev *pci)
> >
> >       if (ice->card_info && ice->card_info->chip_exit)
> >               ice->card_info->chip_exit(ice);
> > -     snd_card_free(card);
> > +     if (card)
> > +             snd_card_free(card);
> >  }
> >
> >  #ifdef CONFIG_PM_SLEEP
> > --
> > 1.9.1
> >
>
