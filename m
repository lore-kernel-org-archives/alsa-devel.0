From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: buffer producer/consumer sync
Date: Wed, 31 Mar 2004 10:29:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403311027290.1950@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA0D82DE6E@DBDE01>
 <20040331083114.C27804@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403310936170.1950@pnote.perex-int.cz>
 <20040331085330.A30701@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311004040.1950@pnote.perex-int.cz>
 <20040331091124.B30701@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040331091124.B30701@flint.arm.linux.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: "Gupta, Kshitij" <kshitij@ti.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 31 Mar 2004, Russell King wrote:

> On Wed, Mar 31, 2004 at 10:10:22AM +0200, Jaroslav Kysela wrote:
> > Yes, but if we have at least one API solving this problem, the successors 
> > should replace it completely. I think that it's much better solution than
> > having no way to support ARM or any other platforms with these problems in 
> > ALSA. If you come with a solution, then people not agreeing with you
> > have to propose/implement a better solution.
> 
> Keeping the existing ->nopage will not work - there is no way to get to
> a struct page on ARM given the information available to the ALSA code.

Looking to arch/arm/mm/consistent.c - vm_region_find / pfn_to_page?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
