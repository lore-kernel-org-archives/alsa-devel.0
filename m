From: Daniel Mack <zonque@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Tue, 16 Oct 2012 09:40:29 +0200
Message-ID: <507D0F6D.1000102@gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
 <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A6346261742
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 09:40:35 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so2228591bku.38
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 00:40:35 -0700 (PDT)
In-Reply-To: <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pete Leigh <pete.leigh@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pete,

On 16.10.2012 01:59, Pete Leigh wrote:
> I tried posting this  a couple of days ago, but no response... I'm
> wondering if the (text) attachment stopped people from seeing it, or
> if there's something else I missed?

It's probably rather that people are too busy to respond :)

> It's just a request to look over the lsusb output and new quirks-table
> entry included, with a view to getting this added to a release.
> 
> Since the initial post, I've done more testing (I'm using a kernel
> based on 3.4.11-1.rt19.1.fc17.ccrma.x86_64.rt) and everything seems to
> work fine (including midi in, which I wasn't sure of at the time of
> posting)

Ok, well done :) But are you sure 44100 is the only supported sample rate?

> apart from one apparently cosmetic issue -  the device name
> no longer shows up in lsusb output, though it did before applying the
> quirk. (?)

lsusb -v should still show it. For the normal output, you could submit
an entry here: http://www.linux-usb.org/usb-ids.html

> I'll include the quirk entry as text rather than an attachment this time.
> 
> If I actually need to go through the process of generating a patch and
> sending mail via git, as per the developer page on the alsa-project
> site, could someone let me know, and I'll give it a go (it's something
> I was hoping to avoid, I admit!)

Yes, in order to prepare a proper patch, you'll have to do that please.
Check out the latestes sound.git[*] and make sure your patch applies
there. Also note that the entries in this file are sorted by VID/PID.

If you want to avoid that by all means, I can do it for you, but I can't
test it of course.


Thanks for pushing your work back to mainline!

Daniel
