From: Adrian Bunk <bunk@stusta.de>
Subject: Re: ALSA bugs with 2.6.12-rc1
Date: Mon, 4 Apr 2005 19:34:53 +0200
Message-ID: <20050404173453.GB4087__28897.1241600395$1112636214$gmane$org@stusta.de>
References: <42515358.7020101@blue-labs.org> <4251749B.5060603@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id E9DE9230
	for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2005 19:34:54 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <4251749B.5060603@gentoo.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Drake <dsd@gentoo.org>, perex@suse.cz
Cc: David Ford <david+challenge-response@blue-labs.org>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2005 at 06:08:43PM +0100, Daniel Drake wrote:
> David Ford wrote:
> > It seems that 2.6.12-rc1 introduced an ALSA bug generating an oops for a
> > null pointer.
> > 
> > codec_semaphore: semaphore is not ready [0x1][0x300300]
> > codec_read 0: semaphore is not ready for register 0x2c
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000
> > 
> > This happens on multiple machines, 32b and 64bit.  I'll be happy to
> > provide further information if needed.
> 
> This only happens when you mismatch your kernel and alsa-lib versions, e.g.
> running alsa-lib-1.0.9-rc2 with alsa-1.0.8 in-kernel drivers, or possibly
> vice-versa.

Are you saying the userspace interface of the ALSA kernel drivers has 
incompatible changes between minor versions of ALSA?

If this is true, that's a serious bug.

> Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
