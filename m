From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA bugs with 2.6.12-rc1
Date: Mon, 4 Apr 2005 20:39:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0504042034400.1764@pnote.perex-int.cz>
References: <42515358.7020101@blue-labs.org> <4251749B.5060603@gentoo.org>
 <20050404173453.GB4087@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3592C230
	for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2005 20:39:39 +0200 (MEST)
In-Reply-To: <20050404173453.GB4087@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: Daniel Drake <dsd@gentoo.org>, David Ford <david+challenge-response@blue-labs.org>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Apr 2005, Adrian Bunk wrote:

> On Mon, Apr 04, 2005 at 06:08:43PM +0100, Daniel Drake wrote:
> > David Ford wrote:
> > > It seems that 2.6.12-rc1 introduced an ALSA bug generating an oops for a
> > > null pointer.
> > > 
> > > codec_semaphore: semaphore is not ready [0x1][0x300300]
> > > codec_read 0: semaphore is not ready for register 0x2c
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 00000000
> > > 
> > > This happens on multiple machines, 32b and 64bit.  I'll be happy to
> > > provide further information if needed.
> > 
> > This only happens when you mismatch your kernel and alsa-lib versions, e.g.
> > running alsa-lib-1.0.9-rc2 with alsa-1.0.8 in-kernel drivers, or possibly
> > vice-versa.
> 
> Are you saying the userspace interface of the ALSA kernel drivers has 
> incompatible changes between minor versions of ALSA?
> 
> If this is true, that's a serious bug.

Nope, but newer alsa-lib use an ALSA timer API feature which was not well 
debugged. This oops should be fixed in 2.6.12-rc2 and older libraries will 
work with newer kernels as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
