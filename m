From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: PCM broken in ALSA CVS (on Linux 2.6.3)
Date: Wed, 3 Mar 2004 21:53:11 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040303215311.76587.qmail@web40602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

[Linux 2.6.3-SMP, single 933 MHz PIII, 1 GB RAM,
devfs, gcc-3.2.3]

Hi,

I have just installed the latest ALSA from CVS and
discovered that it has broken PCM playback. This is
what aplay gives me now:

$ aplay /usr/lib/sounds/jungle_exit.wav 
Playing WAVE '/usr/lib/sounds/jungle_exit.wav' :
Signed 16 bit Little Endian, Rate 22050 Hz, Stereo
ALSA lib pcm_params.c:2096:(snd_pcm_hw_refine_slave)
Slave PCM not usable
aplay: set_params:805: Broken configuration for this
PCM: no configurations available

This is with a SB-Live! card.

Also, loading the snd-intel8x0 module for the
motherboard's built-in sound device now gives me these
messages in my kernel log:

Mar  3 21:27:21 twopit kernel: PCI: Setting latency
timer of device 0000:00:1f.5 to 64
Mar  3 21:27:22 twopit kernel: snd-page-alloc:
releasing the used block (type=1, id=0x1
Mar  3 21:27:22 twopit kernel: snd-page-alloc:
releasing the used block (type=1, id=0x101
Mar  3 21:27:22 twopit kernel: ALSA
/home/chris/Programs/alsa/alsa-driver/pci/intel8x0.c:2263:
no playback buffer allocated - aborting measure ac97
clock

It's the last one which worries me, of course... ;-).

Cheers,
Chris



	
	
		
___________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
