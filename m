From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: EMU10K1 - CVS: nasty "click" at end of WAV files, and spurious extra modules.
Date: Thu, 30 Jan 2003 00:11:00 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030130001100.60428.qmail@web40603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,

I have just installed the latest ALSA-CVS and I have
noticed a few oddities:

First, these modules are suddenly being compiled. I
don't know why:

snd-emu8000-synth.o
snd-gus-synth.o
snd-trident-synth.o

This is my /etc/astate/driver_args:

# cat /etc/asound/driver_args 
--with-kernel=/home/chris/linux-2.4.20
--with-moddir=/lib/modules/2.4.20/kernel/drivers/sound
--with-oss=yes
--with-sequencer=yes
--with-cards=intel8x0,emu10k1,dummy

More importantly, playing WAV files via my SB Live!
using aplay is making a nasty, loud "click" sound
right at the end. It didn't used to do this. Any idea
which change is causing it, please?

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
