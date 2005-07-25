From: Adrian Bunk <bunk@stusta.de>
Subject: Re: BUG: Yamaha OPL3SA2 does not work with ALSA on 2.6 kernels.
Date: Tue, 26 Jul 2005 01:26:05 +0200
Message-ID: <20050725232604.GH3160@stusta.de>
References: <105c793f05072507315cfd1878@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 925DC1B1
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2005 01:26:13 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <105c793f05072507315cfd1878@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Haninger <ahaning@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 25, 2005 at 10:31:37AM -0400, Andrew Haninger wrote:

> Hello.

Hi Andrew,

> I have a 5 year old Gateway Solo 2500 that is currently running Linux
> 2.6.12.2. If I install ALSA and try to have alsaconf bruteforce-detect
> the OPL3SA2 sound card, it will say that it has detected it, but
> loading the modules will fail. If I install Linux 2.4 and
> recompile/rerun alsaconf, the detection works fine and the card works.
> Copying the configuration detected under 2.4 into a modprobe.conf on
> 2.6 allows me to use the card in 2.6 with occasional crashes (which
> might be due to suspend2).

the ALSA people might be able to help you (Cc'ed).

> Searching around the net, I find many other people having trouble with
> these cards and the ALSA-Linux2.6 combination. On one page, someone
> suggested that there were changes made between 2.4 and 2.6 to the ISA
> code that broke ALSA's detection routines.
> 
> I'm not sure what information might be needed in order to get this
> card working well once and for all, but if someone will let me know,
> I'd be happy to provide.

Does the OSS driver work in 2.6?

> Thanks.
> 
> -Andy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
