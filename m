From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: buffer producer/consumer sync
Date: Tue, 9 Mar 2004 10:43:46 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040309104346.C1987@flint.arm.linux.org.uk>
References: <F509E6111989D311B63700805FA761DA09F2906A@DBDE01> <Pine.LNX.4.58.0403091050010.3966@pnote.perex-int.cz> <20040309101827.A1987@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403091122140.3966@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403091122140.3966@pnote.perex-int.cz>; from perex@suse.cz on Tue, Mar 09, 2004 at 11:23:45AM +0100
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

On Tue, Mar 09, 2004 at 11:23:45AM +0100, Jaroslav Kysela wrote:
> Ok, I though that vma->vm_page_prot fix is sufficient for this purpose but 
> appearently not.

Unfortunately not - as the code currently stands, not only are
userspace mappings cached, but also kernel mappings of the same pages.
Unfortunately changing userspace mappings to be uncached only solves
half the problem.  We also need to solve the kernel space problem as
well.  However, this needs to be done in an architecture specific way,
which in turn means sorting out something which architecture people
are happy with.

Then there's the issue about the abuse of virt_to_page() taking a
mapped virtual address (ie from pci_alloc_consistent or
dma_alloc_coherent) rather than a direct-mapped virtual address
(alloc_pages / kmalloc).

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
