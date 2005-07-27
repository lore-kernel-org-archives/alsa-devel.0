From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 2.6.12 sound problem
Date: Wed, 27 Jul 2005 09:14:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507270912370.8129@tm8103.perex-int.cz>
References: <42E6C89C.1060009@earthlink.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42E6C89C.1060009@earthlink.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sclark46@earthlink.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Jul 2005, Stephen Clark wrote:

> Hello List,
> 
> 
> I recently upgraded my laptop, HP Pavilion N5430, from a 2.4.21 kernel
> to 2.6.12. As a result of
> doing this my sound no longer works correctly. It plays the same thing
> repeatedly some number
> of times - if it plays at all.

It looks like an interrupt problem. Try acpi=off and some other switches 
like pci=biosirq etc.

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
