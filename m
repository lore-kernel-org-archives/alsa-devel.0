From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: USB recording - repetitive peaks
Date: Wed, 03 Jul 2002 03:04:39 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D21EB37.7070008@boosthardware.com>
References: <3D208C5C.36649172@ladisch.de>	<s5hhejibem0.wl@alsa2.suse.de>	<3D21B878.8090902@boosthardware.com>	<s5hy9curxdr.wl@alsa2.suse.de>	<3D21C827.2060602@boosthardware.com>	<s5hwuseruac.wl@alsa2.suse.de>	<3D21D6CA.7000308@boosthardware.com> <s5hu1nirsni.wl@alsa2.suse.de> <3D21DDFD.6000206@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 >the error message suggests that you didn't make install on alsa-lib.
 >please check whether /usr/share/aclocal/alsa.m4 exists.

I did run make install and have just done so again to make sure but it's 
not in /usr/local/share/aclocal either. I will copy it over and try 
recording again (see below).

Also I get this for snd-usb-midi
----
# modprobe snd-usb-midi
/lib/modules/2.4.19-rc1/kernel/sound/usb/snd-usb-midi.o: unresolved 
symbol snd_virmidi_new_Rc7dd286c
/lib/modules/2.4.19-rc1/kernel/sound/usb/snd-usb-midi.o: insmod 
/lib/modules/2.4.19-rc1/kernel/sound/usb/snd-usb-midi.o failed
/lib/modules/2.4.19-rc1/kernel/sound/usb/snd-usb-midi.o: insmod 
snd-usb-midi failed
----

I just tried recording using the new code and completely hung the 
computer where only alt+sysreq+b worked. That was during recording.

The other person who is debugging with me has experienced simlilar as a 
kernel oops. He is currently using the patch to cvs but he will update 
soon I think.

This is what he said:
----
2) Kernel Oops:
The compilation of the source was rather a nice thing. I build some RPMs 
from
yesterdays snapshot to be able to clean up things after I installed them.
After installing, configuring modules.conf and removing my old 
asound.conf the
module probed finely.
I attached a copy of the aoutput of "arecord -l"

Recording was a bit messy, due to killing the arecord process freezes my 
box.
Deterministically: whenever the process is interuppted (Ctrl-C) or killed
(sig 9).
I attached a copy of the kernel-oops.


Oops: 0002

CPU:    0

EIP:    0010:[<d40c824a>]

EFLAGS: 00010002

eax: 000000b0   ebx: d16bfc00   ecx: 0000002c   edx: d45f4950

esi: d16bfc00   edi: 00002cc8   ebp: 0000002c   esp: c02e5e78

ds: 0018   es: 0018   ss: 0018

Process swapper (pid: 0, stackpage=c02e5000)

Stack: d45f4950 d45f49c0 d4cc19a0 d3efe5e0 00004000 00000000 00000004 
d40c8607

        d45f4950 d54a7c00 d3efe5e0 d3efe5e0 00000000 00000000 d3131e60 
d51b1f58

        d3efe5e0 00000246 d3efe5e0 d51b2660 d3efe5e0 d50f6800 04000001 
d89d8000

Call Trace: [<d40c8607>] [<d51b1f58>] [<d51b2660>] [<d51b3260>] 
[<c010814e>]

    [<c01082ae>] [<c010a118>] [<c01ad465>] [<c01ad2d4>] [<c0105407>] 
[<c0105000>]

    [<c0105027>]


Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 9c 59 fa 8b 5c 24 20

  <0>Kernel panic: Aiee, killing interrupt handler!

In interrupt handler - not syncing


----





-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
