From: Tyson Whitehead <twhitehe@uwo.ca>
Subject: ES18xx and IRQ problem
Date: Tue, 24 Jun 2003 15:52:12 -0400
Message-ID: <200306241552.12428.twhitehe@uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-alpha=debian-alpha=m.gmane.org@lists.debian.org>
Content-Disposition: inline
Resent-Message-ID: <B6-OXD.A.tTC.qAL--@murphy>
List-Post: <mailto:debian-alpha@lists.debian.org>
List-Help: <mailto:debian-alpha-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-alpha-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-alpha-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-alpha/>
To: alsa-devel@lists.sourceforge.net
Cc: debian-alpha@lists.debian.org
List-Id: alsa-devel@alsa-project.org

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
