From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 1/3 Implement generic device DMA mapping support
Date: Tue, 2 Mar 2004 14:55:27 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040302145527.E12353@flint.arm.linux.org.uk>
References: <20040229223820.C17862@flint.arm.linux.org.uk> <s5heksch8xf.wl@alsa2.suse.de> <20040301174517.J24955@flint.arm.linux.org.uk> <s5hznb0foar.wl@alsa2.suse.de> <s5h8yijfiic.wl@alsa2.suse.de> <20040302142632.A12353@flint.arm.linux.org.uk> <s5h65dnfh5n.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h65dnfh5n.wl@alsa2.suse.de>; from tiwai@suse.de on Tue, Mar 02, 2004 at 03:38:28PM +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 02, 2004 at 03:38:28PM +0100, Takashi Iwai wrote:
> BTW, there are some typos in your patches, and missing replacement of
> PCI -> DEV dma type.  the attached patch should fix.

Thanks for finding these - as you can guess, the code didn't get built
for x86 when I tested it, neither was debugging enabled.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
