From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: buffer producer/consumer sync
Date: Tue, 9 Mar 2004 11:46:44 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040309114644.A5296@flint.arm.linux.org.uk>
References: <F509E6111989D311B63700805FA761DA09F29071@DBDE01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <F509E6111989D311B63700805FA761DA09F29071@DBDE01>; from kshitij@ti.com on Tue, Mar 09, 2004 at 05:03:37PM +0530
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 09, 2004 at 05:03:37PM +0530, Gupta, Kshitij wrote:
> 	I was referring to a ARM implementation in the ALSA tree for our
> ALSA driver development on OMAP 1610 (ARM 926)
> sound\arm\sa11xx-uda1341.c.  Just wanted to know if sa11xx-uda1341.c is also
> affected by this problem.  

sa11xx-uda1341 isn't a good driver to look at - it's very specific to
the iPAQ as it stands.  I've been working on a properly modularised
driver which separates out the PCM DMA engine from the rest of the
code, which in turn makes it a lot easier to add support for different
platforms.  IOW, I've done the job properly.

However, just as the iPAQ people (didn't) work with the rest of the
ARM community when they created their supposed generic sa11xx-uda1341
implementation, the rest of the ARM community didn't work with them
when creating our driver.  And now various people are calling for
sa11xx-uda1341 to be deleted once my driver is merged.  It's good when
communities fragment, isn't it? 8(

However, the problem I've been describing is a problem with the core
ALSA implementation and affects all hardware drivers on ARM, whether
they be PCI, ISA or ARM specific.

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
