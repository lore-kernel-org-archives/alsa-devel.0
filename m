From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: Tascam US-428 USB Problems
Date: Thu, 16 Aug 2007 11:54:48 +0200
Message-ID: <200708161154.49018.fzu@wemgehoertderstaat.de>
References: <8e4fc8270708152345k450c8460la0eb17e33d50fdd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 4756510381B
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Aug 2007 11:54:21 +0200 (CEST)
In-Reply-To: <8e4fc8270708152345k450c8460la0eb17e33d50fdd7@mail.gmail.com>
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
Cc: Michael Bourgeous <sts.nitrogen@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 16. August 2007 schrieb Michael Bourgeous:
> 
> I did some searching through source code, and found that the frame
> status of -70 (ECOMM) indicates an OHCI buffer overflow error.  As
> soon as the usx2y driver receives this it bails out of whatever it's
> doing, and jackd crashes.  I've tried changing the usx2y driver to
> ignore such errors, and while there are audio glitches when such an
> error occurs, jackd no longer crashes and the audio keeps playing.
> This leads to question one: Is there any reason to bail out instead of
> trying to recover from errors?

Audio glitches.
 
> I've tried all the different USB ports on my motherboard, different
> USB cables, and running through a hub instead of a direct connection.
> None of these things helped.  Though the usx2y message says "Most
> probably some hardware problem", I think this is something that is
> software related, as other USB devices have no problems.  So here is
> question two: what kinds of problems, software or hardware, would lead
> to a buffer overflow error, and can I fix this in the driver code?

The US-428 is the only device connected to that particular usb-port?

What are the other devices that work?
Do they also fully utilize usb 1.1 capacity?

      Karsten
