From: "The Source" <thesourcehim@gmail.com>
Subject: Fwd:  Backported sbxfi driver (UNTESTED!)
Date: Fri, 10 Oct 2008 20:41:17 +0400
Message-ID: <6d00fe310810100941i44c3f4b3v70d3b235e7c1206@mail.gmail.com>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de> <1223619975.4700.2.camel@home>
	<s5hzlld6j6u.wl%tiwai@suse.de>
	<6d00fe310810100939h6cd61e0cg7817c7f54f6261f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 422A5103811
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 18:41:35 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so440372nfd.32
	for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2008 09:41:17 -0700 (PDT)
In-Reply-To: <6d00fe310810100939h6cd61e0cg7817c7f54f6261f6@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

---------- Forwarded message ----------
From: The Source <thesourcehim@gmail.com>
Date: 2008/10/10
Subject: Re: [alsa-devel] Backported sbxfi driver (UNTESTED!)
To: Takashi Iwai <tiwai@suse.de>




2008/10/10 Takashi Iwai <tiwai@suse.de>

At Fri, 10 Oct 2008 01:26:15 -0500,
> Ted T. Logian wrote:
> >
> >
> >
> > On Fri, 2008-10-10 at 08:01 +0200, Takashi Iwai wrote:
> > > At Thu, 09 Oct 2008 15:17:58 -0500,
> > > Ted T. Logian wrote:
> > > >
> > > > Sorry for the multiple posts, but once I rmmod snd-sbxfi, running
> mixer does
> > > > fine.  It seems if I have snd-sbxfi loaded and I run alsamixer, it
> locks the
> > > > entire system.
> > >
> > > So, do you mean loading the driver itself doesn't lock up?  If so,
> > > it's better than I expected.
> > >
> > > Did you run ever PCM playback/capture before that?  This is more
> > > dangerous :)
> > >
> > > Also, please give your hardware details, as there are different models
> > > for X-Fi, and some are handled pretty differently.
> > >
> > > [BTW, please stop top-posting, and avoid HTML mails for ML.  It's easy
> > >  to switch to normal (plain) mail mode on Gmail, just a click.]
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> >
> >
> > I think perhaps from uninstalling pulseaudio I got further.  I can use
> > mixer now, and it even has a "Master" device, but nothing else...
> >
> > however, I do get a lock up later.
> >
> > I get this from running aplay, too, if this helps...
>
> Thanks!  That's rather a stupid bug.
> The patch is below.
>
>
> Takashi
>
> diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
> index 8066bf4..8a0eea0 100644
> --- a/sound/pci/sbxfi/sbxfi.c
> +++ b/sound/pci/sbxfi/sbxfi.c
> @@ -831,7 +831,7 @@ static struct sbxfi_port *sbxfi_port_alloc(struct sbxfi
> *chip,
>        port->src[0] = src;
>        port->src[1] = src + 1;
>        spin_lock_irq(&chip->port_lock);
> -       list_add(&chip->port_list, &port->list);
> +       list_add(&port->list, &chip->port_list);
>        spin_unlock_irq(&chip->port_lock);
>        return port;
>  }
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


Hello, I have tried the driver with the fix you provided, but I couldn't get
anything. Kernel panic on any attempt to use sound or mixer. Also kernel
panic several seconds after Xorg starts. Each crash causes either hang or
reboot so I couldn't get any error messages. If there are some logs left,
please tell me where they are and I'll send them to you.
My card is X-Fi Platinum Fatality Champion Series.
