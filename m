From: <michael@www.tweakoz.com>
Subject: SuSE 9.1 Professional on Sony FR130 (via82xx) persistant stuttering
 problem
Date: Fri, 21 May 2004 11:46:08 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.31.0405211140390.8242-100000@Server.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

I cannot get my audio working on my laptop, the funny thing is it worked fine at first,

Then I had to go mess with things (install a new kernel), and cannot get it working again.

The Subsystem Vendor/Device ID is 0x104d 0x8143 (Sony VAIO fr130), 82xx revision is 0x50

The IRQ (11) is shared with a lot of other devices (not sure if that matters)

This is SuSE 9.1 Professional

I have tried every permutation of dxs_support and ac97_quirk parameters.
I have tried the stock kernel (2.6.4-52), and new kernel (2.6.6)
  For the new kernel I ungzipped /proc/config.gz into /usr/src/linux/.config and ran make menuconfig
I have tried stock alsa (1.0.3a), new alsa (1.0.4) and cvs alsa (may 19th, 2004)
I have formatted the drive and reinstalled the OS from scratch
I have reset the BIOS to defaults
I have tried playing to hw:0,0 and hw:0,1
I have tried -f cd and -f dat

I cannot get it working again.

Here are some symptoms:

Anytime I restart alsa I get a invalid codec error with a return code of 0xfe000000

If I aplay anything it just stutters and loops the same segment over and over again,
 occasionally gets to a new segment, but still just keeps on looping it.

To me it seems like a hardware issue, but its hard to believe I could break the hardware by

Trying to install a new kernel, or at least its never happened to me before.

Only other thing I can think of is resetting the bios might not reset everything?

If it is a hardware issue perhaps, we should investigate it so others dont break their hardware.

And I was just about to finish the ALSA code in my game/gfx/audio engine. doh !

Thanks,

MTM
michael@tweakoz.com
mmayers@soe.sony.com




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
