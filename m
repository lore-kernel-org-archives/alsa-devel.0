From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: buffer producer/consumer sync
Date: Wed, 31 Mar 2004 10:10:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040331101018.B32258@flint.arm.linux.org.uk>
References: <F509E6111989D311B63700805FA761DA0D82DE6E@DBDE01> <20040331083114.C27804@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403310936170.1950@pnote.perex-int.cz> <20040331085330.A30701@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311004040.1950@pnote.perex-int.cz> <20040331091124.B30701@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311027290.1950@pnote.perex-int.cz> <20040331095306.A32258@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311100510.1950@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403311100510.1950@pnote.perex-int.cz>; from perex@suse.cz on Wed, Mar 31, 2004 at 11:07:03AM +0200
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

On Wed, Mar 31, 2004 at 11:07:03AM +0200, Jaroslav Kysela wrote:
> Do you see any reason to ommit this settings for some cases (including 
> for ISA bus)? I think that dma_alloc_coherent should offer consistent
> API - thus mark all allocated pages as reserved for all cases.

That was another point I was trying to get resolved, but no one is
willing to provide an answer.

It's at times like this that you really start to wonder whether the
open source development model is really capable of working.

I suggest we add a load of preprocessor junk into the ALSA core and
comment exactly _why_ its needed, thereby laying the reason completely
at the door of these ill-defined APIs where questions have been asked
and responses not been received.

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
