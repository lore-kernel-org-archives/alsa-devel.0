From: Vince <fuzzy77@free.fr>
Subject: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Fri, 18 Jul 2003 20:17:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1839AF.1050709@free.fr>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, I get the following oops (100% reproductible) with this simple command:

----------------------------------------------------------
diablo:~$ festival
Festival Speech Synthesis System 1.4.3:release Jan 2003
Copyright (C) University of Edinburgh, 1996-2003. All rights reserved.
For details type `(festival_warranty)'
festival> (SayText "Good morning")
zsh: segmentation fault  festival
----------------------------------------------------------

Unable to handle kernel paging request at virtual address d0b5f000
  printing eip:
d0acaf7b
*pde = 013ea067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<d0acaf7b>]    Not tainted VLI
EFLAGS: 00210202
EIP is at resample_expand+0x34b/0x380 [snd_pcm_oss]
eax: d0acaf7b   ebx: 00000001   ecx: 000007ff   edx: ffecffec
esi: d0b7dff6   edi: cee8f8cc   ebp: d0b5effe   esp: c80ffe58
ds: 007b   es: 007b   ss: 0068
Process festival (pid: 1260, threadinfo=c80fe000 task=ce1066d0)
Stack: d0ac8212 cee8f840 ca851d80 c80ffe84 0000ffec c80fe000 ffffffff 
cee8f540
        d0acada1 d0acaef2 d0acaf7b cee8f8b0 00000000 00000002 00000002 
00000000
        ffecffec 000002a8 000017fd 00000800 cee8f840 c91ea8c0 d0acb46c 
cee8f840
Call Trace:
  [<d0ac8212>] snd_pcm_plug_playback_channels_mask+0x72/0xe0 [snd_pcm_oss]
  [<d0acada1>] resample_expand+0x171/0x380 [snd_pcm_oss]
  [<d0acaef2>] resample_expand+0x2c2/0x380 [snd_pcm_oss]
  [<d0acaf7b>] resample_expand+0x34b/0x380 [snd_pcm_oss]
  [<d0acb46c>] rate_transfer+0x5c/0x60 [snd_pcm_oss]
  [<d0ac8607>] snd_pcm_plug_write_transfer+0x97/0x100 [snd_pcm_oss]
  [<d0ac43e0>] snd_pcm_oss_write2+0xd0/0x150 [snd_pcm_oss]
  [<d0ac4606>] snd_pcm_oss_write1+0x1a6/0x1d0 [snd_pcm_oss]
  [<d0ac66c3>] snd_pcm_oss_write+0x43/0x60 [snd_pcm_oss]
  [<d0ac6680>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
  [<c014e6b8>] vfs_write+0xb8/0x130
  [<c014e7e2>] sys_write+0x42/0x70
  [<c0109107>] syscall_call+0x7/0xb

Code: 66 35 00 80 eb d4 8b 45 00 c1 e8 08 eb cc 8b 45 00 c1 e8 08 66 35 
00 80 eb c2 8b 45 00 c1 e8 08 eb ba eb a6 eb b1 8b 55 00 eb bf <8b> 45 
00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00 b8
-------------------------------------------------------------------


More information on my system:
diablo:/usr/src# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 
12:01:18 2003 UTC).
Compiled on Jul 16 2003 for kernel 2.6.0-test1-mm1.

diablo:/usr/src# cat /proc/asound/cards
0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                      Ensoniq AudioPCI ENS1371 at 0xec00, irq 10

diablo:/usr/src# cat /proc/asound/modules
0 snd_ens1371

diablo:/usr/src/linux-2.6.0test1# cat .config | grep -v '#'  | grep SND
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_ENS1371=m


Please let me know if any further information is needed.

Regards,

Vincent

P.S.: I intended to test alsa 0.9.5 (in the hope that this bug was 
already known & has already been fixed), but unfortunately I get a 
compile error (I simply dropped alsa-kernel 0.9.5 in the 2.6.0-test1-mm1 
source tree):


-----------------------------------------------------------
   CC [M]  sound/pci/ac97/ac97_codec.o
sound/pci/ac97/ac97_codec.c: In function `snd_ac97_mixer_build':
sound/pci/ac97/ac97_codec.c:1393: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1393: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1394: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1416: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1416: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1417: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1423: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1423: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1424: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1435: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1435: error: structure has no member named 
`build_ops'
sound/pci/ac97/ac97_codec.c:1436: error: structure has no member named 
`build_ops'
make[3]: *** [sound/pci/ac97/ac97_codec.o] Error 1
make[2]: *** [sound/pci/ac97] Error 2
make[1]: *** [sound/pci] Error 2
make: *** [sound] Error 2
------------------------------------------------------------







-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
