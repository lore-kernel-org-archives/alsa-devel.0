From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Lots of noob questions on writing an ALSA driver
 for SM501
Date: Tue, 26 Jul 2005 17:40:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507261733340.8190@tm8103-a.perex-int.cz>
References: <42E645CE.609@billgatliff.com> <Pine.LNX.4.61.0507261633110.8190@tm8103-a.perex-int.cz>
 <42E656B8.9090406@billgatliff.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42E656B8.9090406@billgatliff.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Gatliff <bgat@billgatliff.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Jul 2005, Bill Gatliff wrote:

> But the sm501 stuff won't be ARM-specific--- it'll be tested on ARM and SH, at
> least.  So where should the source for sm501-pcm.c and sm501-ac97 be placed?

Good question. I think drivers/sm501 directory might be ok for the common 
stuff (library) and place the toplevel modules for architectures to arm/ 
and new sh/ directories. If the toplevel code will be very common, 
something like

#define ARCH_SH
#include "../arm/sm501-ac97.c"

might be used in the sh/ directory.

Or leave everything in drivers/sm501 for this time - we can move it later.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
