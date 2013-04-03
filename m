From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: How to use implicit feedback with full duplex?
Date: Thu, 4 Apr 2013 00:08:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304032359520.1453@xoschi>
References: <51116F36.9040106@ladisch.de>
 <alpine.LNX.2.00.1302052326150.1207@xoschi> <5112B969.50905@ladisch.de>
 <alpine.LNX.2.00.1303242323480.5410@xoschi> <5151FFBE.7040304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D9084260321
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 00:08:43 +0200 (CEST)
Received: by mail-bk0-f43.google.com with SMTP id jm2so1150640bkc.30
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 15:08:43 -0700 (PDT)
In-Reply-To: <5151FFBE.7040304@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


On Tue, 26 Mar 2013, Daniel Mack wrote:

> On 24.03.2013 23:49, Eldad Zack wrote:
> > 
> > On Wed, 6 Feb 2013, Clemens Ladisch wrote:
> > 
> >>> Can you try using jackd -d alsa -d hw:x with the device and see if that
> >>> works for you?
> >>
> >> That works.  This means that there is a race condition in the driver, or
> >> that the different open/hw_params/prepare order trips it up.
> > 
> > Yes, and also on closing (close/hw_free).
> > I finally had some time to look into this - patch below adds some 
> > checks and with it:
> >     
> > * Starting playback, waiting, starting capture: capture doesn't start,
> >   playback continues without breaking.
> >     
> > * Starting capture, waiting, starting playback: playback doesn't start,
> >   capture breaks - but it is possible to restart the streams afterwards.
> >   [On my setup (with xhci), when the streams break I must restart my box
> >   to get them to work again with current code].
> > 
> > * Starting both - no change, works good.
> > 
> > This is the order the ops get called when both are start at once, if it 
> > helps anyone:
> > 
> > playback	capture
> > open
> > 		open
> > 		hw_params
> > 		 set_format
> >  		prepare
> >  		 set_format
> > hw_params
> >  set_format
> > prepare
> >  set_format
> > prepare
> >  set_format
> > 		prepare
> > 		 set_format
> >  trigger
> > 		trigger
> > 
> > I'll try to figure out why capture breaks next.
> > I still quite slow around the code and don't understand some parts of 
> > it so this might take me a while.
> 
> Thanks for looking into this!
> 
> > @Daniel, do you have any hints for this case (capture breaking
> > when starting playback)?
> 
> Give me some time to catch up and rebuild my FTU setup please. I hope
> I'll be able to get back to you by the end of this week.

Cool, thank you!

And it just remembered something. I tried to make the "in use"
check non-fatal (return 0) and with a couple of more changes
(very hacky) I got it to start in both orders.

But the problem was that when I stopped the playback* stream my
kernel "exploded" (hard lock up). But if I stopped the capture,
it was ok. Playback didn't even stop.
(It might have been the other way around, but I think it was 
playback)

I can find that branch when I find some time if you think it
might help.

Cheers,
Eldad
