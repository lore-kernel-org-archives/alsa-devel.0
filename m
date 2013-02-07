From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: How to use implicit feedback with full duplex?
Date: Thu, 7 Feb 2013 21:39:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302072125330.1138@xoschi>
References: <51116F36.9040106@ladisch.de>
 <alpine.LNX.2.00.1302052326150.1207@xoschi> <5112B969.50905@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A0A62652FB
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 21:39:09 +0100 (CET)
Received: by mail-bk0-f44.google.com with SMTP id j4so1359898bkw.17
 for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2013 12:39:09 -0800 (PST)
In-Reply-To: <5112B969.50905@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Wed, 6 Feb 2013, Clemens Ladisch wrote:

> Eldad Zack wrote:
> > On Tue, 5 Feb 2013, Clemens Ladisch wrote:
> >> I thought I'd try to use implicit feedback with my simple audio device:
> >> [...]
> >> This works fine when playing something:
> > ...
> >> But when I then try to record at the same time, the driver refuses to
> >> configure the input endpoint (to the only format, which is already set):
> >> And despite that "alreay in use" check, the input endpoint is affected
> >> so much that playback breaks.
> >>
> >> Is full duplex supposed to work?  Does it work with other devices?
> >
> > This is probably a "yes, but" :)
> > I use my device mostly full duplex, but with jack opening both
> > playback and capture at the same time.
> >
> > I assume you are opening two different streams, one for playback and
> > one for capture.
> 
> Jack *also* uses two different streams, but it opens them at the same
> time.

Oh, right. 

> 
> > Can you try using jackd -d alsa -d hw:x with the device and see if that
> > works for you?
> 
> That works.  This means that there is a race condition in the driver, or
> that the different open/hw_params/prepare order trips it up.

Hmm. I seem to have tested this wrong the other day or just had luck (I 
tried it just once).
But today I can trigger breaking the playback when opening capture 
later every time I try, just like you described.

I get this too when the audio breaks:
[  766.987497] xhci_hcd 0000:00:14.0: shutdown urb ffff880244f89600 ep1in-iso
[  766.987510] xhci_hcd 0000:00:14.0: shutdown urb ffff880244f89400 ep1in-iso
[  766.987519] xhci_hcd 0000:00:14.0: shutdown urb ffff8802438e6000 ep1in-iso
[  766.987527] xhci_hcd 0000:00:14.0: shutdown urb ffff8802438e6200 ep1in-iso
[  766.987534] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 2  with no TDs queued?
[  766.987550] xhci_hcd 0000:00:14.0: shutdown urb ffff8802438e6400 ep1in-iso
[  766.987562] xhci_hcd 0000:00:14.0: shutdown urb ffff880244f89000 ep1in-iso
[  766.987576] xhci_hcd 0000:00:14.0: shutdown urb ffff880244f89200 ep1in-iso
[  766.987584] xhci_hcd 0000:00:14.0: shutdown urb ffff880244f88800 ep1in-iso

I will try to figure out what's happening on the weekend.

Cheers,
Eldad
