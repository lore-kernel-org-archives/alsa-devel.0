From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000645]: azx driver is a bit broken
Date: Sun, 5 Dec 2004 23:46:47 +0100
Message-ID: <08b5d21d99b8af25294cee1635401c76@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D9F13391
	for <alsa-devel@alsa-project.org>; Sun,  5 Dec 2004 23:46:47 +0100 (MET)
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
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=645> 
======================================================================
Reported By:                russell
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   645
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian/Ubuntu
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             11-12-2004 16:58 CET
Last Modified:              12-05-2004 23:46 CET
======================================================================
Summary:                    azx driver is a bit broken
Description: 
The azx driver doesn't work well on the hardware which I have. It pretty
much doesn't work at all in OSS emulation mode. The following patch
improves its stability on my machine enormously (although it is still not
100%), and makes OSS emulation work nicely. As a side effect, the code is
simplified, and to my fairly untrained eyes seems a bit more efficient.

There are also a number of fixes in this patch which make the driver work
more like my understanding of the Intel "High Definition Audio
Specification Revision 1.0" document, and my limited understanding of the
ALSA system. These include:

 - ALSA buffer size now matches the Cyclic Buffer Length (length of entire
buffer)
 - ALSA period size now matches size of each BDL, the number of BDLs are
properly set, and the BDLEs are not changed during playback (as suggested
in the azx spec)

The #define'd STREAM_REST_BIT was renamed to STREAM_RESET_BIT (because
that's what it is).

This is a patch to azx.c only, and is against the current CVS version
(1.11).

I have not done *ANY* work on the capture side of things -- most of my
diffs for output can probably be translated almost directly for input.

There are some other issues which should be addressed in this driver. Off
the top of my head:
 - Will pci_set_dma_mask() be needed if the card is not capable of 64 bit
addressing? Perhaps.
 - The mixer code in 1.0.7rc2 causes a crash on my system, I have pointed
this out to Clemens Ladisch in email. I will work on this problem soon if
nobody else has the time. Commenting out the mixer initialisation code is
working well for me at the moment :)
 - The driver still does not work 100%. When my system is very idle, I get
repeated sections of sound. I used to get a LOT of static, but with my
changes it now just sounds like ALSA is never updating the buffer. I'm
completely baffled by this, any suggestions for me to try, or hints on
debugging this sort of behaviour would be appreciated!

And one issue which I am unclear on, what does the fifo_size field in the
snd_pcm_hardware_t struct actually define?
======================================================================

----------------------------------------------------------------------
 pforai - 11-28-04 12:48 
----------------------------------------------------------------------
@tiwai:

when can we expact to see a working snd_azx ;) ?

no working sound at all makes me go crazy! :D

trying to run alsamixer produces this output: 

Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
df023c81
*pde = 00000000
Oops: 0000 [https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
PREEMPT SMP
Modules linked in: smbus_arp eeprom i2c_i801 lm85 i2c_sensor i2c_core
snd_azx snd_pcm snd_timer snd soundcore snd_page_alloc evdev i915
intel_agp agpgart
CPU:    1
EIP:    0060:[<df023c81>]    Not tainted
EFLAGS: 00210292   (2.6.8.1-ck9)
EIP is at snd_azx_cap_select_info+0x3a/0x4d [snd_azx]
eax: 00000000   ebx: ddf00400   ecx: dce90000   edx: d1676e4c
esi: 00000000   edi: d1676ea4   ebp: ddf25e80   esp: d1676e2c
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 7261, threadinfo=d1676000 task=ddca7140)
Stack: dd078400 dd07854c df010d15 ddf00400 d1676e4c 00000110 000001e6
d1676000
       00000004 00000002 00000000 00000000 74706143 20657275 72756f53
00006563
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
Call Trace:
 [<df010d15>] snd_ctl_elem_info+0x79/0x1d9 [snd]
 [<df011cb7>] snd_ctl_ioctl+0x28c/0x388 [snd]
 [<c0169eee>] sys_ioctl+0x1ba/0x2c4
 [<c01040b9>] sysenter_past_esp+0x52/0x71
Code: ac aa 84 c0 75 fa 31 c0 8b 34 24 8b 7c 24 04 83 c4 08 c3 53
 <4>mtrr: base(0xd0020000) is not aligned on a size(0x180000) boundary
mtrr: 0xd0000000,0x10000000 overlaps existing 0xd0000000,0x400000
snd_pcm_oss: Unknown symbol snd_mixer_oss_ioctl_card
snd_pcm_oss: Unknown symbol snd_mixer_oss_ioctl_card

edited on: 11-28-04 12:48

----------------------------------------------------------------------
 pforai - 12-05-04 23:46 
----------------------------------------------------------------------
anyone got news?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-04 16:58 russell        New Issue                                    
11-12-04 16:58 russell        File Added: azx.c.diff                       
11-12-04 16:58 russell        Distribution              => Debian/Ubuntu   
11-12-04 16:58 russell        Kernel Version            => 2.6.8.1         
11-12-04 17:30 russell        Note Added: 0002399                          
11-15-04 22:28 Grazy          Issue Monitored: Grazy                       
11-23-04 21:53 footcow        Note Added: 0002531                          
11-27-04 16:04 pforai         Note Added: 0002615                          
11-27-04 16:06 pforai         Note Edited: 0002615                         
11-27-04 19:32 tiwai          Note Added: 0002617                          
11-28-04 12:39 pforai         Note Added: 0002622                          
11-28-04 12:48 pforai         Note Edited: 0002622                         
11-28-04 12:49 pforai         Issue Monitored: pforai                      
12-02-04 22:24 swarren        Issue Monitored: swarren                     
12-05-04 23:46 pforai         Note Added: 0002724                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
