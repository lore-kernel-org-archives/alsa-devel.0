From: "Ted T. Logian" <tedtheologian@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Sat, 11 Oct 2008 11:03:22 -0500
Message-ID: <1223741002.13219.1.camel@home>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de> <1223619975.4700.2.camel@home>
	<s5hzlld6j6u.wl%tiwai@suse.de>
	<6d00fe310810100939h6cd61e0cg7817c7f54f6261f6@mail.gmail.com>
	<s5hfxn3p206.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 044E91037F2
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Oct 2008 18:03:43 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so321078qwj.56
	for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2008 09:03:25 -0700 (PDT)
In-Reply-To: <s5hfxn3p206.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, The Source <thesourcehim@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2008-10-11 at 17:47 +0200, Takashi Iwai wrote:

> At Fri, 10 Oct 2008 20:39:48 +0400,
> The Source wrote:
> > 
> > 2008/10/10 Takashi Iwai <tiwai@suse.de>
> > 
> >     At Fri, 10 Oct 2008 01:26:15 -0500,
> >     Ted T. Logian wrote:
> >     >
> >     >
> >     >
> >     > On Fri, 2008-10-10 at 08:01 +0200, Takashi Iwai wrote:
> >     > > At Thu, 09 Oct 2008 15:17:58 -0500,
> >     > > Ted T. Logian wrote:
> >     > > >
> >     > > > Sorry for the multiple posts, but once I rmmod snd-sbxfi, running
> >     mixer does
> >     > > > fine.  It seems if I have snd-sbxfi loaded and I run alsamixer, it
> >     locks the
> >     > > > entire system.
> >     > >
> >     > > So, do you mean loading the driver itself doesn't lock up?  If so,
> >     > > it's better than I expected.
> >     > >
> >     > > Did you run ever PCM playback/capture before that?  This is more
> >     > > dangerous :)
> >     > >
> >     > > Also, please give your hardware details, as there are different models
> >     > > for X-Fi, and some are handled pretty differently.
> >     > >
> >     > > [BTW, please stop top-posting, and avoid HTML mails for ML.  It's easy
> >     > >  to switch to normal (plain) mail mode on Gmail, just a click.]
> >     > >
> >     > >
> >     > > thanks,
> >     > >
> >     > > Takashi
> >     >
> >     >
> >     > I think perhaps from uninstalling pulseaudio I got further.  I can use
> >     > mixer now, and it even has a "Master" device, but nothing else...
> >     >
> >     > however, I do get a lock up later.
> >     >
> >     > I get this from running aplay, too, if this helps...
> >    
> >     Thanks!  That's rather a stupid bug.
> >     The patch is below.
> > 
> >     Takashi
> >    
> >     diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
> >     index 8066bf4..8a0eea0 100644
> >     --- a/sound/pci/sbxfi/sbxfi.c
> >     +++ b/sound/pci/sbxfi/sbxfi.c
> >     @@ -831,7 +831,7 @@ static struct sbxfi_port *sbxfi_port_alloc(struct
> >     sbxfi *chip,
> >            port->src[0] = src;
> >            port->src[1] = src + 1;
> >            spin_lock_irq(&chip->port_lock);
> >     -       list_add(&chip->port_list, &port->list);
> >     +       list_add(&port->list, &chip->port_list);
> >            spin_unlock_irq(&chip->port_lock);
> >            return port;
> >      }
> >     _______________________________________________
> >     Alsa-devel mailing list
> >     Alsa-devel@alsa-project.org
> >     http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> > Hello, I have tried the driver with the fix you provided, but I couldn't get
> > anything. Kernel panic on any attempt to use sound or mixer. Also kernel panic
> > several seconds after Xorg starts. Each crash causes either hang or reboot so
> > I couldn't get any error messages. If there are some logs left, please tell me
> > where they are and I'll send them to you.
> > My card is X-Fi Platinum Fatality Champion Series.
> 
> For testing, first try without X but just use Linux console, so that
> you have a better chance to see Oops messages.  It's pretty important
> to see whether it's an Oops or a panic.  Also, double-check whether
> you really installed the corrected drivers.  Often it's missing in the
> right place by stupid reasons.
> 
> For first tests, don't use any sound server.  Try with aplay like:
> 	% aplay -Dhw foo.wav
> Try first 96kHz samples, 48kHz samples, and then others.
> 
> 
> thanks,
> 
> Takashi



Tak,

I just wanted to make sure you knew of the different types of sbxfi
cards.

For instance, I have this one:
http://www.geeks.com/details.asp?invtid=SB0670-BULK&cat=SND

It's still emu20k1.  However, it is impossible to use with creative's
drivers, as it always causes a lockup, but it works with oss4 drivers.

I don't know if this matters to you at all, but I wanted to let you know
in case it affected how the driver progressed to be compatible with the
most emu20k1 cards.
