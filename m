From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: au88x0: pr_* replaced with
	dev_*
Date: Thu, 16 Oct 2014 11:04:34 +0800
Message-ID: <CAN8cciZXLfWC-vsYq0r64Uw6D0t2z8LFVcF_i31OQg5BO7+uZQ@mail.gmail.com>
References: <1412930199-24797-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1412930199-24797-2-git-send-email-sudipm.mukherjee@gmail.com>
 <CAN8ccibSw_85wdnxbNSKfjXQ-7Lg3C6_5fhKQJJi5xMi8pMabA@mail.gmail.com>
 <20141011090903.GC8231@sudip-PC>
 <1413024491.16385.10.camel@joe-AO725>
 <20141011113349.GA9962@sudip-PC>
 <1413041569.16385.20.camel@joe-AO725> <20141011182510.GA1917@fool>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
 [209.85.216.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B48D261292
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 05:04:35 +0200 (CEST)
Received: by mail-qc0-f176.google.com with SMTP id r5so2094561qcx.7
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 20:04:34 -0700 (PDT)
In-Reply-To: <20141011182510.GA1917@fool>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Joe Perches <joe@perches.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

> > > > > > >
> > > <snip>
> > > > > > > ---
> > > > > > >
> > > > > >
> > > > > > >  static int vortex_core_init(vortex_t *vortex)
> > > > > > >  {
> > > > > > >
> > > > > > > -       pr_info( "Vortex: init.... ");
> > > > > > > +       dev_info(vortex->card->dev, "init.... ");
> > > > > >
> > > > > > Is it possible to add linefeed  since "done/n" won't appear in
the same
> > > > > > line with init nor shutdown?
> > > > > >
> > > > > should we add linefeed ?
> > > > > as of now it will print init.... then it will print done as the
init is complete.
> > > > > so dmesg will show us:
> > > > >
> > > > > init....done.
> > > > >
> > > > > same for shutdown.
> > > > > but if we give linefeed , then it will become :
> > > > >
> > > > > init....
> > > > > done.
> > > > >
> > > > > the meaning will be lost. and many user might just wonder what is
done ?
> > > > []
> > > > > > > @@ -2738,7 +2744,7 @@ static int vortex_core_init(vortex_t
*vortex)
> > > > > > >  static int vortex_core_shutdown(vortex_t * vortex)
> > > > > > >  {
> > > > > > >
> > > > > > > -       pr_info( "Vortex: shutdown...");
> > > > > > > +       dev_info(vortex->card->dev, "shutdown...");
> > > > > > >  #ifndef CHIP_AU8820
> > > > > > >         vortex_eq_free(vortex);
> > > > > > >         vortex_Vort3D_disable(vortex);
> > > > > > > @@ -2760,7 +2766,7 @@ static int
vortex_core_shutdown(vortex_t * vortex)
> > > > > > >         msleep(5);
> > > > > > >         hwwrite(vortex->mmio, VORTEX_IRQ_SOURCE, 0xffff);
> > > > > > >
> > > > > > > -       pr_info( "done.\n");
> > > > > > > +       dev_info(vortex->card->dev, "done.\n");
> > > > > > >         return 0;
> > > > > > >  }
> > > >
> > > > It's actually on 2 lines before your patch.
> > > >
> > > >   pr_info("a");
> > > >   pr_info("b\n");
> > > >
> > > > already emits 2 separate lines.
> > > >
> > > >   pr_info("a");
> > > >   pr_cont("b\n");
> > > >
> > > > emits a single line "ab"
> > > > (unless some other thread emits something in-between)
> > > >
> > > > pr_cont or a bare printk can be used after a dev_info
> > > > without a newline to avoid unwanted newlines.
> > >
> > > i think i was not thinking while writing the previous mail.
> >
> > It seems you were thinking then and now,
> > but unfortunately, you are assuming a bit
> > more than you have actual experience or
> > knowledge of printk inner workings.
> >
> > > pr_info("a");
> > > pr_info("b\n");
> > > should print as "ab" ,
> >
> > This is not true.
> >
> > All pr_<level> uses but pr_cont always
> > start on a new line by emitting a newline
> > if the last line did not have one.
> >
>
> oops... i have never tried with pr_* without a \n. I was thinking it will
> work like printf. sorry for the noise i created.
> and thanks for the information about those 2 commits.
> so, now in this case what will you suggest - shutdown and done both
> terminated by \n or some thing like : "shutdown process started" and then
> "shutdown done"....
>
> thanks
> sudip
>
>
> > The difference between using:
> >
> > pr_info("a")
> > pr_info("b\n")
> >
> > and
> >
> > pr_info("a\n")
> > pr_info("b\n")
> >
> > is not emitted line count.
> >
> > The first may unintentionally be continued
> > by another thread using a printk that does
> > not start with a KERN_<LEVEL>.
> >
> > printk has had this behavior for ~5 years
> > since these 2 commits:
> >
> > commit e28d713704117bca0820c732210df6075b09f13b
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Tue Jun 16 11:02:28 2009 -0700
> >
> >     printk: Add KERN_DEFAULT printk log-level
> >
> >     This adds a KERN_DEFAULT loglevel marker, for when you cannot decide
> >     which loglevel you want, and just want to keep an existing printk
> >     with the default loglevel.
> >
> >     The difference between having KERN_DEFAULT and having no log-level
> >     marker at all is two-fold:
> >
> >      - having the log-level marker will now force a new-line if the
> >        previous printout had not added one (perhaps because it forgot,
> >        but perhaps because it expected a continuation)
> >
> >      - having a log-level marker is required if you are printing out a
> >        message that otherwise itself could perhaps otherwise be mistaken
> >        for a log-level.
> >
> > and
> >
> > commit 5fd29d6ccbc98884569d6f3105aeca70858b3e0f
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Tue Jun 16 10:57:02 2009 -0700
> >
> >     printk: clean up handling of log-levels and newlines
> >
> >     It used to be that we would only look at the log-level in a printk()
> >     after explicit newlines, which can cause annoying problems when the
> >     previous printk() did not end with a '\n'. In that case, the
log-level
> >     marker would be just printed out in the middle of the line, and be
> >     seen as just noise rather than change the logging level.
> >
> >     This changes things to always look at the log-level in the first
> >     bytes of the printout. If a log level marker is found, it is always
> >     used as the log-level. Additionally, if no newline existed, one is
> >     added (unless the log-level is the explicit KERN_CONT marker, to
> >     explicitly show that it's a continuation of a previous line).
> >
> >
> >

Do the driver still need two dev_info at startup and shutdown since most
pci drivers won't print anything to system log when the driver is loaded or
unloaded ?

The only case when the driver is not loaded without any error message when
user specify snd-au8830 index=0 but the other sound card (e.g.
snd-usb-audio already loaded as card 0)
