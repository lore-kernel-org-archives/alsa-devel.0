From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000886]: alsactl store = crash
Date: Mon, 14 Feb 2005 19:48:29 +0100
Message-ID: <98bedff12202e4b4b198fa6eeb27c2b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 56BEC248
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:48:29 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=886> 
======================================================================
Reported By:                udasoft
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   886
Category:                   PCI - azx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-06-2005 16:01 CET
Last Modified:              02-14-2005 19:48 CET
======================================================================
Summary:                    alsactl store = crash
Description: 
I have a Intel D915PBL Motherboard with High Definition Audio Controller
(ICH6 Family).

When I save the state of mixer with alsactl, receive this error:

udasoftware root # alsactl  store
Oops: 0000 [https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
PREEMPT SMP
Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_azx snd_hda_codec snd_pcm
snd_timer snd snd_page_alloc nvidia
CPU:    0
EIP:    0060:[<00000000>]    Tainted: P      VLI
EFLAGS: 00010282   (2.6.10-gentoo-r6)
EIP is at 0x0
eax: f2264580   ebx: f705a400   ecx: 00000023   edx: ee59fe4c
esi: f2264580   edi: ffffffe7   ebp: f705a54c   esp: ee59fe30
ds: 007b   es: 007b   ss: 0068
Process alsactl (pid: 16709, threadinfo=ee59f000 task=c191f020)
Stack: f8b2efca f2264580 ee59fe4c 00000110 f2264600 00000000 f2264664
00000022
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
              00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
              Call Trace:
               [<f8b2efca>] snd_ctl_elem_info+0x7a/0x190 [snd]
                [<f8b2fffa>] snd_ctl_ioctl+0x25a/0x390 [snd]
                 [<c016f8ba>] sys_ioctl+0xca/0x230
                  [<c01031af>] syscall_call+0x7/0xb
                  Code:  Bad EIP value.
                   Segmentation fault
======================================================================

----------------------------------------------------------------------
 udasoft - 02-09-05 19:35 
----------------------------------------------------------------------
I have tried with the CVS but the result is the same :(

The only difference I have occurred is in the stack address:

udasoftware root # alsactl store
Oops: 0000 [https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
PREEMPT SMP
Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq_oss
snd_seq_midi_event snd_
seq snd_seq_device snd_azx snd_hda_codec snd_pcm snd_timer snd
snd_page_alloc nv
idia
CPU:    0
EIP:    0060:[<00000000>]    Tainted: P      VLI
EFLAGS: 00010282   (2.6.10-gentoo-r6)
EIP is at 0x0
eax: e2a19980   ebx: ebb3c800   ecx: 00000023   edx: e5ddae4c
esi: e2a19980   edi: ffffffe7   ebp: ebb3c94c   esp: e5ddae30
ds: 007b   es: 007b   ss: 0068
Process alsactl (pid: 25836, threadinfo=e5dda000 task=e1553520)
Stack: f8b2f02a e2a19980 e5ddae4c 00000110 e2a19a00 00000000 e2a19a64
00000022
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
              00000000 00000000 00000000 00000000 00000000 00000000
00000000 000
00000
              Call Trace:
               [<f8b2f02a>] snd_ctl_elem_info+0x7a/0x190 [snd]
                [<f8b3001a>] snd_ctl_ioctl+0x25a/0x390 [snd]
                 [<c016f8ba>] sys_ioctl+0xca/0x230
                  [<c01031af>] syscall_call+0x7/0xb
                  Code:  Bad EIP value.
                   Segmentation fault
***
 I don't understand if  the problem is caused from my error or, otherwise,
from the driver.

 I have tried to install alsa-driver from emerge (emerge alsa-drivers) but
alsaconf didn't found my integrated soundcard (like 1.0.8rc2 and cvs
version).

----------------------------------------------------------------------
 tiwai - 02-14-05 19:48 
----------------------------------------------------------------------
Can't reproduce here.  Try to build alsa-drivers with --with-debug=full
option.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-05 16:01 udasoft        New Issue                                    
02-06-05 16:01 udasoft        Distribution              => Gentoo          
02-06-05 16:01 udasoft        Kernel Version            => 2.6.10          
02-09-05 11:54 tiwai          Note Added: 0003544                          
02-09-05 19:35 udasoft        Note Added: 0003562                          
02-14-05 19:48 tiwai          Note Added: 0003606                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
