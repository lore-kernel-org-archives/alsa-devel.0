From: Clemens Ladisch <clemens@ladisch.de>
Subject: ES18xx and IRQ problem (fwd)
Date: Thu, 26 Jun 2003 11:40:18 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306251926300.12226-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


(It seems this message didn't get past the list moderator.
 The current moderator is still Dave Null, isn't it?

 Could the moderation message be changed to something like "your
 message has gone to the bit bucket instead of alsa-devel", or could
 posting from non-subscribers be disabled entirely?)


----- Original Message -----
From: Tyson Whitehead <twhitehe@uwo.ca>
Date: Tue, 24 Jun 2003 22:20:05 +0200
X-Original-Cc: debian-alpha@lists.debian.org
X-Original-To: alsa-devel@lists.sourceforge.net

The latest version of alsa-driver (0.9.4) seems to have an IRQ problem on the
DEC version of the ES1888.  Any PCM stuff I tried to play would just result
in endless looping of the first bit of sound.

Checking /proc/interrupts and revealed that the interrupt counter for the
ES1888 would go to 4 upon loading the snd-es18xx module, and then remain
there.

Browsing through the source (es18xx.c), I discovered that, in the
snd_es18xx_interrupt routine, some alternative interrupt source determination
code (in the case of the chip not having a control port -- the only two of
which seem to be the ES1887 and ES1888) was '#if 0'ed out.

I re-enabled this code (and disabling the snd_es18xx_mixer_read source based
code) and the driver now works fine on my Alpha box.

Maybe someone more knowledgable then me could make some comment of relevance
here?

Later -T

PS:  Very clean code layout in the alsa drivers guys and gals (or at least the
es18xx driver -- I haven't looked at the rest *grin*).  I'm impressed.  Great
job!

PPS:  The alternative code seems to handle the mixer as well (or, at least, I
can still change my mixer settings and hear the results). :-)

-- 
 Tyson Whitehead  (-twhitehe@uwo.ca -- WSC-)
 Computer Engineer                        Dept. of Applied Mathematics,
 Graduate Student- Applied Mathematics    University of Western Ontario,
 GnuPG Key ID# 0x8A2AB5D8                 London, Ontario, Canada




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
