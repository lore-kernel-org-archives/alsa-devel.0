From: Monty Montgomery <xiphmont@gmail.com>
Subject: Re: emi62 (may be slightly off-topic)
Date: Thu, 12 Dec 2013 02:32:13 -0500
Message-ID: <CACrD=+-vF5Q+f0qfU5gdjbkXFOh4eD6Ug8VzeCdk75ihKqZAtA@mail.gmail.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
 <4D821A18.30407@ladisch.de>
 <AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
 <4D894196.4040002@gmail.com>
 <1360657074.2790.71.camel@chello084112006029.chello.at>
 <s5hboblr611.wl%tiwai@suse.de>
 <CACrD=+8-kHTX0AVW5KLHG73mDp4+eccz4LqanpOzNGeCRZ+hRA@mail.gmail.com>
 <CACrD=+9P6Gj51HMRb-rdZeoQ7yjzpu2J=pkq9eNj-ZH8HGAe+A@mail.gmail.com>
 <s5hmwv5imqy.wl%tiwai@suse.de>
 <CACrD=+-aXYKoLdrMw+xOzqhyY9mdpDzLfMTB-06CHYiBqEQOxw@mail.gmail.com>
 <s5hfw0xilwk.wl%tiwai@suse.de>
 <CACrD=+9r4LAiYYsQUSRSm5K=gFpkTp5Z3agfa--msGpF9FKWOg@mail.gmail.com>
 <s5hbo0njw1l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FDA426080B
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 08:32:14 +0100 (CET)
Received: by mail-vc0-f182.google.com with SMTP id lc6so13822vcb.13
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 23:32:13 -0800 (PST)
In-Reply-To: <s5hbo0njw1l.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Karl Grill <kgrill@chello.at>
List-Id: alsa-devel@alsa-project.org

> Monty, would you submit the emi driver patch to upstream?

It's been a few years since I've submitted a patch.  Last I tried,
upstream seriously frowned on any sort of 'I wrote a whole new driver'
type patches. But I'm happy to try if you think it would go through.

>  We can keep
> the old EMI26 and EMI62 at first but make them conflicting with EMI
> driver via Kconfig.  The external firmware files are maintained in
> linux-firmware tree nowadays.  Once all things get merged, the old
> emi26/62 can be faded away.

Sure, that sounds perfectly sensible.

> Looking through the tarball and codes, my only concern is the license
> of the new firmware files...

Yes, that's what has always been problematic in the past.  I see
there's at least a patch now to restore it to the state it was in in
early 2.6 when it worked but was just outdated.

That said, I don't want to go through this yet again where one problem
gets fixed, everyone gets bogged down in arguing over the rest, and
that's the state things stay in.  That's where eMagic support has been
since roughly 2008.  If we're not going to fix it all, and fix it for
real, I'd honestly rather not bother.  No more partial solutions when
the complete solution is already right here.

So before submitting a patch, I'd like to secure agreement over the
firmware update from whomever needs to commit.  Who would that be?  If
we can agree on that, I'm in for the rest.

I mean, it's not like we have explicit permission to distribute the
firmware we're shipping now. :-P

Cheers,
Monty
