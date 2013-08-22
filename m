From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v2 00/10] ALSA: usb-audio: fix
 playback/capture concurrent usage
Date: Thu, 22 Aug 2013 22:48:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308222240130.6085@heraclitus>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
 <5215AB8D.8020001@gmail.com> <alpine.LNX.2.00.1308221932490.1343@heraclitus>
 <52166854.2040208@gmail.com> <alpine.LNX.2.00.1308222144100.20668@heraclitus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A0C72610C5
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 22:48:45 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id mx12so890157bkb.34
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 13:48:44 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1308222144100.20668@heraclitus>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org



On Thu, 22 Aug 2013, Eldad Zack wrote:
> On Thu, 22 Aug 2013, Daniel Mack wrote:
> > On 22.08.2013 19:43, Eldad Zack wrote:
> > > On Thu, 22 Aug 2013, Daniel Mack wrote:
> > >> On 21.08.2013 23:37, Eldad Zack wrote:
> > >>> Hi,
> > >>>
> > >>> This patch series attempts to fix a long starting problem with the concurrent
> > >>> usage of playback and capture on implicit feedback devices.
> > >>>
> > >>> Applies against current for-next (HEAD b43dd416be21bc8ad60984e13def032f01aaaa18 ).
> > >>
> > >> Thanks a lot for working on this! I'll give that series a test run tonight.
> > > 
> > > That's great, thanks!
> > 
> > So, with your patches applied, I'm getting the NULL pointer Oops below
> > just by plugging in a UAC2 sound card.
> > 
> > Note that on this system, pulseaudio is running and grabs the new card
> > immediately, then closes it again. That might be different on your machine.
> > 
> > Do you want me to dig deeper or do you have an idea already?
> 
> Oh, I think that data_endpoint just doesn't get initialized yet, 
> because it opens and closes immediately.
> 
> Does this fix it?

OK, I could easily reproduce this, though I don't have pulseaudio 
installed. Luckily I started working on a regression tester, so I 
modified it to just open and close (it's trivial, but if anyone is 
interested, I can post it). 
This fixes it for me.

Sorry about the oops and thank you very much for testing!

I also need to fix an error in the code (the altset_idx/altsetting issue 
Clemens pointed out), so you might want to wait until I post a revised 
patchset.

Cheers,
Eldad
