From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: buffer producer/consumer sync
Date: Wed, 31 Mar 2004 09:44:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403310936170.1950@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA0D82DE6E@DBDE01>
 <20040331083114.C27804@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040331083114.C27804@flint.arm.linux.org.uk>
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

> On Wed, Mar 31, 2004 at 10:32:07AM +0530, Gupta, Kshitij wrote:
> > 	I was just curious to know about by when will we be having a proper
> > reference driver for ARM .  We are ready to help out from here if there are
> > any issues.
> 
> Given the kernel communities general negative reaction to trying to sort
> out these problems,

I think that the consensus was that using "->nopage" callback does not
make much sense for the DMA pages so remap_page_coherent_range() should be
used for this case when designed. Is not that true? We are ready to change
the ALSA core ourself, but we need this API on the kernel core side.

I also don't mind to include some hacks in our midlevel code to let the 
ARM platform working.

> I've decided that its not worth me spending my time fixing the core ALSA
> code any longer.

:-(

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
