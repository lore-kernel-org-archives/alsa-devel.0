From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: buffer producer/consumer sync
Date: Wed, 31 Mar 2004 08:53:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040331085330.A30701@flint.arm.linux.org.uk>
References: <F509E6111989D311B63700805FA761DA0D82DE6E@DBDE01> <20040331083114.C27804@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403310936170.1950@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403310936170.1950@pnote.perex-int.cz>; from perex@suse.cz on Wed, Mar 31, 2004 at 09:44:45AM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "Gupta, Kshitij" <kshitij@ti.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 31, 2004 at 09:44:45AM +0200, Jaroslav Kysela wrote:
> I think that the consensus was that using "->nopage" callback does not
> make much sense for the DMA pages so remap_page_coherent_range() should be
> used for this case when designed.

The consensus was that ->nopage is fine to use IFF you have RAM-backed
pages.  However, the choice of whether ->nopage is used or not is one
that the architecture must make, and not the device driver.

This requires a dma_mmap_coherent() API for all architectures to
implement.  However, I can not get anyone to even respond to agreeing
what the API requires.

It's no good one architecture implementing one version of the API and
others then deciding that they don't actually like it after all and
needing a different API.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
