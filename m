From: Robert Hardy <rhardy@webcon.ca>
Subject: Re: [ALSA - driver 0001938]: EPIPE on Audigy with surround sound
 when seeking in 6 channel sound file
Date: Wed, 29 Mar 2006 17:18:59 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603291645290.6977@thor.webcon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

For some reason I can't comment on an existing bug which I didn't author. 
Perhaps this requires a higher level of access?

I'm user rhardy on Mantis...

Basically I was trying to point out I am also affected by this bug:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1938

Two possibilities exist:
1. I missed some of the changes tiwai made. Please point out what if this is
the case.

2. It really isn't fixed in alsa-lib CVS (or isn't visible in viewcvs.)

Testing out the recent changes made by tiwai here:
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-lib/src/pcm/?sortby=date#dirlist

I took alsa-lib-1.0.11rc4 and applied patches extracted from view cvs above
to update the follow files to the listed versions below:

pcm_dmix.c: 1.102
pcm_plugin.h: 1.41
pcm.c: 1.328
pcm_hw.c: 1.149
pcm_rate.c: 1.113
pcm_direct.c: 1.60
pcm_plugin.c: 1.101
pcm_softvol.c: 1.18

This is the resulting patch:
http://webcon.ca/~rhardy/patches/alsa-lib-1.0.11rc4-pcm_fixes.patch.gz

This unfortunately made no difference here. I'm running 2.6.16-rh3 which is 2.6.16.1 with
custom patches including the recent git commit for [ALSA] version 1.0.11rc4 from here:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1c2e02750b992703a8a18634e08b04353face243

My sound card:
02:07.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value
         Subsystem: Creative Labs: Unknown device 1001
         Flags: bus master, medium devsel, latency 32, IRQ 201
         I/O ports at a000 [size=64]
         Capabilities: [dc] Power Management version 2

This card once worked fine unfortunately I'm not sure with what
mplayer/alsa-lib/alsa-driver/kernel....

I'm running a i686/32bit mplayer in a 64 bit environment.

After applying the patch above and upgrading alsa-lib, I still get the same
errors from mplayer when I try to seek 6 channel audio using surround51:

alsa-lib: pcm.c:6300:(snd_pcm_mmap_commit) commit offset (0) doesn't match \
with appl_ptr (216531) % buf_size (16384)
alsa-play: write error: Broken pipe
alsa-play: trying to reset soundcard
alsa-lib: pcm.c:6300:(snd_pcm_mmap_commit) commit offset (0) doesn't match \
with appl_ptr (216531) % buf_size (16384)
alsa-play: write error: Broken pipe
alsa-play: trying to reset soundcard

[same 3 lines repeat forever at 100% cpu usage until I kill mplayer]

Regards,
Rob

-- 
---------------------"Happiness is understanding."----------------------
Robert Hardy, B.Eng Computer Systems                  C.E.O. Webcon Inc.
rhardy <at> webcon <dot> ca    GPG Key available          (613) 276-7327


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
