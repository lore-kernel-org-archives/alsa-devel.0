From: maximilian attems <debian@sternwelten.at>
Subject: (fwd) Re: ES18XX Patch for Alpha
Date: Tue, 21 Jun 2005 21:34:54 +0200
Message-ID: <20050621193453.GD11911__44905.3464494229$1119382221$gmane$org@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from baikonur.stro.at (baikonur.stro.at [213.239.196.228])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 352E21F2
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2005 21:34:28 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Chuck Foreman <chuckf@arcor.de>, Tyson Whitehead <twhitehe@uwo.ca>, J.J.vanderHeijden@home.nl, debian-alpha@lists.debian.org
List-Id: alsa-devel@alsa-project.org

forwarding your message to alsa-dev concerning the needed es18xx patch.
commenting out aboves interrupt status read looks like breaking current setups.

i'll append below the patch you talk about.
bug must exist since early alsa, since bkbits shows similar code.
funny that this old outcommented section is still needed,
maybe there a more generic solution is possible nowadays.

----- Forwarded message from Tyson Whitehead <twhitehe@uwo.ca> -----


On June 6, 2005 17:14, Chuck Foreman wrote:
> I picked up your thread from last year because I too am experiencing
> problems with 2.6.x and es18xx  I too had this working under the 2.4 kernel
> with als 1.0.4.
>
> Where could I get thsi patch (using 2.6.11.7 kernel)? Do I still need it?
>
> Ohh Yeah and how do I patch the kernel? .. .. I think if you can share any
> additional info on this driver and alsa.. I'mm mange figuring out how to
> patch the kernel.

I did two patches for the es18xx.

The first fixes interupt recognition.  Without it, the driver doesn't 
recognize it's interupt on some es18xx cards, and so the card just endlessly 
loops the first second or so of sound.

The second fixes an ISA bus problems on certain Alpha kernels.  Basically, the 
DMA mapping functions are suppose to take a understand a NULL as "bus" to be 
the ISA bus.  This support was removed at one time on the Alpha (I think it 
was 2.6.8).  As a result, ISA drivers crashed on loading (you could see a 
crash message in the log by typing "dmesg").

As far as I know (2.6.10) the first is still required.  The second is not (I 
believe it was only required for 2.6.8).  You can double check if you need 
the second by looking at "include/asm-alpha/dma-mapping.h".  If it includes 
"include/asm-generic/dma-mapping.h", you need to patch (generic doesn't 
support the ISA bus).  Otherwise you're fine.

Note that not all es18xx require the first patch.  Again, you will hear 
endless looping of the first second or so of sound if you need it.  If you 
aren't hearing anything, you have other problems.  In this case check if you 
put "options snd-es18xx isapnp=0" into "/etc/modprobe.d/alsa" (without this 
the driver won't detect the card).  Also make sure you've turned up the 
volume and unmuted the channels.

Currently I'm using a recompiled (with the first patch) 2.6.10 Debian kernel 
on my PWS 500au.  Everything works fine for me.  You can get the recompiled 
kernel and the patches from my box (http://whitehead.apmaths.uwo.ca/~tyson/).  
Install the kernel with a "dpkg -i <kernel deb file>".

To do a patch on a manual build, just download the kernel source and do a 
"patch -p0 < <patch file>" in the main directory followed by a build.  If you 
want to recreate all the Debian kernel image packages (like I did) with this 
patch added, its a bit different.

Do an "apt-get install kernel-tree-<version> kernel-package fakeroot" and an 
"apt-get source kernel-image-<version>".  Add a command to apply the patch to 
the patch commands (just search for patch to find it) in 
"kernel-image-<version>/debian/rules".  Then run "dpkg-buildpackage 
- -rfakeroot" in the "kernel-image-<version>" directory.  It will take about a 
day and several hundred megs of disk space to complete, leaving you with some 
nice debs you can just install with "dpkg -i".  Zap "kernel-image-<version>" 
to recover your disk space.

Later & Good Luck!  -T  (email me if you have any more questions)

PS:  I CCed this to this list because someone on it a while ago was asking 
about the second patch and the AWE card (an ISA issue -- the above ISA 
comments apply).

- -- 
 Tyson Whitehead  (-twhitehe@uwo.ca -- WSC-)
 Computer Engineer                          Dept. of Applied Mathematics,
 Graduate Student- Applied Mathematics      University of Western Ontario,
 GnuPG Key ID# 0x8A2AB5D8                   London, Ontario, Canada

-- 
To UNSUBSCRIBE, email to debian-alpha-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org



----- End forwarded message -----

--- sound/isa/es18xx.c~	2003-04-23 06:01:33.000000000 -0400
+++ sound/isa/es18xx.c	2003-06-24 15:14:25.000000000 -0400
@@ -736,10 +736,10 @@
 		/* Read Interrupt status */
 		status = inb(chip->ctrl_port + 6);
+#if 0
 	} else {
 		/* Read Interrupt status */
 		status = snd_es18xx_mixer_read(chip, 0x7f) >> 4;
-	}
-#if 0
-	else {
+#else
+	} else {
 		status = 0;
 		if (inb(chip->port + 0x0C) & 0x01)



--
maks



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
