From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000657]: modprobe snd-pcm-oss SIGSEGV with emu10k1 + azx
Date: Mon, 22 Nov 2004 15:07:17 +0100
Message-ID: <21ce469965eaf3973a0841cb23de8fbb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EDECE20C
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 15:07:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=657> 
======================================================================
Reported By:                fejf
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   657
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.9 (unpatched kernel.org)
======================================================================
Date Submitted:             11-19-2004 11:53 CET
Last Modified:              11-22-2004 15:07 CET
======================================================================
Summary:                    modprobe snd-pcm-oss SIGSEGV with emu10k1 + azx
Description: 
i'm using the onboard azx codec (intel 915pgl board) + an emu10k1
soundcard. the azx codec was detected but i couldn't get sound out of it.
i only got 2 mixers (master+caputre) with alsa-driver-1.0.6a so i tried to
upgrade to 1.0.7 - after reboot the following happened:

--------------------------------------------------------------------------
 * Loading ALSA drivers ...
 *   Loading: snd-azx ... [ ok ]
 *   Loading: snd-emu10k1 ... [ ok ]
 *   Loading: snd-seq-oss ... [ ok ]
 *   Loading: snd-pcm-oss ...
Oops: 0000 [https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
SMP
Modules linked in: snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq
snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_util_mem
snd_hwdep
snd_azx snd_pcm snd_timer snd snd_page_alloc
CPU:    1
EIP:    0060:[<e0899b41>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9)
EIP is at snd_azx_cap_select_info+0x3a/0x4d [snd_azx]
eax: 00000000   ebx: e0931b00   ecx: de2ea000   edx: dd9a7d0c
esi: 00000000   edi: dd9a7d64   ebp: dd9a7eb8   esp: dd9a7ce4
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 23438, threadinfo=dd9a6000 task=dad16130)
Stack: 00000000 dd9a7e1c e092f13a db171a00 dd9a7d0c 00000000 00000000
00000009
       00000000 db171a00 00000000 00000000 00000000 00000000 00000000
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
Call Trace:
 [<e092f13a>] snd_mixer_oss_build_input+0x502/0x681 [snd_mixer_oss]
 [<c0391a77>] sound_insert_unit+0x103/0x13c
 [<e092f75f>] snd_mixer_oss_build+0x35/0x60 [snd_mixer_oss]
 [<e092f97b>] snd_mixer_oss_notify_handler+0x1a1/0x24b [snd_mixer_oss]
 [<e088f03b>] alsa_mixer_oss_init+0x3b/0x48 [snd_mixer_oss]
 [<c013ca6c>] sys_init_module+0x188/0x231
 [<c010609f>] syscall_call+0x7/0xb
Code: 44 24 0c 8d 7a 58 8b 48 5c c7 42 40 03 00 00 00 c7 42 48 01 00 00 00
0f
b6 81 3c 02 00 00 89 42 50 8b 42 54 8b b4 81 40 02 00
00 <ac> aa 84 c0 75 fa 31 c0 8b 34 24 8b 7c 24 04 83 c4 08 c3 53 83
 /etc/init.d/alsasound: line 76: 23438 Segmentation fault     
/sbin/modprobe
${DRIVER}                                       [ !! ] *   Loading:
snd-emu10k1-synth ... [ ok ]
*   Loading: snd-seq-midi ... [ ok ]
* Restoring Mixer Levels
--------------------------------------------------------------------------

trying to restore/saving the mixer levels always hangs the boot
process/the shell.

btw: the driver from the intel site (Audio: Intel® HD Audio Controller -
Realtek codec: http://www.intel.com/design/motherbd/gn/gn_drive.htm) works
fine (i get more mixer chans and sound). it's based on alsa-1.0.5-sth. -
but then i can't get sound with my emu10k1...
======================================================================

----------------------------------------------------------------------
 tiwai - 11-22-04 14:39 
----------------------------------------------------------------------
Yeah azx driver is really unstable for the time being.
The merge with realtek's driver and more fixes are in progress now.

----------------------------------------------------------------------
 cevans - 11-22-04 15:07 
----------------------------------------------------------------------
Hey, just a note to say I finally found a combination to get my Azalia to
play sound properly!! It's v1.0.6a patched with the recent ALSA CVS commit
entitled "Summary: Patch to fix broken audio playback". Thanks Takeshi!!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-04 11:53 fejf           New Issue                                    
11-19-04 11:53 fejf           Kernel Version            => 2.6.9 (unpatched
kernel.org)
11-19-04 12:17 eradicator     Issue Monitored: eradicator                    
11-22-04 14:37 cevans         Note Added: 0002497                          
11-22-04 14:39 tiwai          Note Added: 0002499                          
11-22-04 15:07 cevans         Note Added: 0002507                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
