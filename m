From: Johan Bilien <jobi@via.ecp.fr>
Subject: nforce2 audio problem on 2.6.3
Date: Thu, 19 Feb 2004 09:03:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040219080352.GA7375@via.ecp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,
                                                                                
Since I moved from linux-2.6.2 to linux-2.6.3-rc2, and then 2.6.3, I am
experiencing a strange problem with all the GStreamer applications: as
soon as GStreamer tries to play out a sound, the system gets extremely
slow, and no sound comes out (although the GStreamer applications do not
complain and seem to be playing the sound find). I have only noticed
this behaviour with GStreamer, xmms, mpg321, VLC  etc. play sounds out,
but the sound suffers small interuptions now and then.

I am using a nforce2 motherboard, and the snd_intel8x0 ALSA driver. I
saw the recent thread regarding this driver being broken in the 1.0
serie, so I apply the patch given in the thread, but still get my
problem.

When I load the driver I get:

Starting ALSA (version 1.0.2c):intel8x0_measure_ac97_clock: measured
49402 usecsintel8x0: clocking to 47425
 intel8x0.
                                                                                 
When I play out something, both with GStreamer and other applications, I
get in syslog:
Feb 14 23:30:36 localhost kernel: ac97_pcm_open: rate = 48000, cfg = 2,
slots = 0x3d8
Feb 14 23:30:36 localhost kernel: setting ac97 reg 0x2c to rate 48000
Feb 14 23:30:36 localhost kernel: setting ac97 reg 0x30 to rate 48000
Feb 14 23:30:36 localhost kernel: setting ac97 reg 0x2e to rate 48000
                                                                                 
14/02 23:33 /proc/asound/card0/codec97#0% ls
ac97#0-0  ac97#0-0+regs
                                                                                 
When I play out something with GStreamer, the card seems to be always in
the PREPARED mode:
                                                                                 
14/02 23:34 /proc/asound/card0/pcm0p/sub0% cat status
state: PREPARED
trigger_time: 1076798081.000657025
tstamp      : 1076798081.000708336
delay       : 0
avail       : 8704
avail_max   : 8719
-----
hw_ptr      : 0
appl_ptr    : 0
                                                                                 
I asked the GStreamer crew, they suspected a kernel problem, since
GStreamer has no real playout optimizations, and thus is quite often
among the first application to trigger that kind of problems. And it did
work with the 2.6.2 (ALSA 0.9).
                                                                                 
Tell me if I can provide some more information,
Thanks,
--
Johan


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
