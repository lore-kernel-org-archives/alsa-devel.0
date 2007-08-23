From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: Tascam US-428 USB Problems
Date: Thu, 23 Aug 2007 12:05:41 +0200
Message-ID: <200708231205.41813.fzu@wemgehoertderstaat.de>
References: <8e4fc8270708152345k450c8460la0eb17e33d50fdd7@mail.gmail.com>
	<200708170919.37627.fzu@wemgehoertderstaat.de>
	<8e4fc8270708222202j3a3098beu8faf4597530d1876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	by alsa0.perex.cz (Postfix) with ESMTP id CEA9C10384F
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 12:05:31 +0200 (CEST)
In-Reply-To: <8e4fc8270708222202j3a3098beu8faf4597530d1876@mail.gmail.com>
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
To: Michael Bourgeous <sts.nitrogen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >
> > USB 1.1 transfers happen at 1ms bounderies. Setting 64Frames/period period
> > interrupts will happen within 1ms or 2ms distances.
> 
> I was not aware of the 1ms granularity for USB interrupts.  Would USB
> 2.0 or Firewire offer a better granularity?

Technically both operate at down to 1/8ms.

Linux's USB 2.0 ehci driver doesn't go there and limits isochronous
transfer granularity at 1ms.
I posted a patch to linux-usb-devel, which enables 1/8ms granularity
isochronous transfer.
There was exactly 0 answer to it.
And I was too lazy to follow up on that ;-)

Regarding Firewire: I guess the "new stack" can operate at
1/8ms granularity.


      Karsten
