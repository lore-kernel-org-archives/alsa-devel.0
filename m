From: "guan yim" <guanyim@hotmail.com>
Subject: Re: Need to know SBLive Chip difference
Date: Tue, 30 Mar 2004 12:38:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Sea2-F20RC8YwVff1YO0003e284@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hotmail.com (sea2-f20.sea2.hotmail.com [207.68.165.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA11871
	for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2004 12:38:51 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pzad@pobox.sk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Trying to recompile kernel to get rid of something which gives a line in 
/proc/device as:
14 sound

since the oss installer refuse to install..........................

Checking for any previously installed sound drivers... It looks like the 
sound driver is linked in the kernel you are currently executing.
You should configure recompile the kernel without the built in sound driver 
and to
reboot before trying to install OSS/Linux again


Error: OSS cannot be installed because there is another sound driver loaded.
Driver 'sound' has registered the sound device (character major 14) for 
itself.

You seem to have OSS/Free statically linked into kernel.
You need to reconfigure and reinstall the kernel
with sound support disabled.

............................will try my best.


Just FYI. The SIGMATEL codec on SBLive 2003 is:
SIGMATEL
STAC9758T
CB1U004
0318

together with emu10k1 chip as:

EMU10K1-JFF
(C) CREATIVE TECH '97
1G24D02ELQ

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
