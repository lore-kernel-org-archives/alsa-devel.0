From: Michael Corlett <ad@corlett.plus.com>
Subject: ISA pnp & kernel 2.6
Date: Wed, 11 Feb 2004 21:57:35 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <402AA54F.3050705@gremlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I have an ISA pnp card (opti931) which stopped working when I
installed kernel 2.6 and the problem is as follows:

The kernel function that sets and activates the card is
isapnp_set_resources (in drivers/pnp/isapnp/core.c) and for
each resource, it is checking that the correct flag is set
before writing to the port (i.e. IORESOURCE_IO, IORESOURCE_IRQ,
IORESOURCE_DMA, IORESOURCE_MEM) however, these flags are never
being set because the driver code is just using
pnp_init_resource_table followed by pnp_resource_change for each
setting and so the configuration is never written to the card.
(I believe that the equivalent code in 2.4 just checked for
flags != 0).

As I see it, there are four options:

1) Manually set the flags in the driver code (this is what I have
    done temporarily to get the card working).


2) Change the test in isapnp_set_resources to

    ((flags & IORESOURCE_xx) | (~flags & IORESOURCE_AUTO))

    as anything that has been auto-allocated should have the
    appropriate flag set.


3) Change pnp_resource_change to clear IORESOURCE_UNSET and change
    the test in isapnp_set_resources to

    (~flags & IORESOURCE_UNSET)


4) In the driver, use something else apart from pnp_resource_change
    (i.e. is there now a preferred method for filling in the
    settings).


I prefer 3) or else 2) but are there any reasons not to do this?
Any advice welcome.


Michael.








-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
