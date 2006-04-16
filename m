From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Unaligned fixup error
Date: Sun, 16 Apr 2006 20:04:03 +0100
Message-ID: <1145214243.9266.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I assume this is a problem with my tools rather than alsa, but I'd
better check.

Switched over to using the alsa-driver/alsa-kernel modules on my
Dreamcast (as opposed to 2.6.15 vanilla) and I get this:

/ # ./mpg123 -g 55 /Simple\ Minds/01\ Song\ For\ The\ Tribes.mp3 &
/ # High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2 and 3.
Version 0.59r-gpl (2005/04/Fault in unaligned fixup: 0000 [#1]

Pid : 1232, Comm:               mpg123
PC is at aica_pcmvolume_put+0x6/0x80 [snd_aica]
PC  : c0100ee6 SP  : 8c2cfe0c SR  : 40008100 TEA : c01011de    Not
tainted
R0  : c0100ee0 R1  : 8c3c6180 R2  : 00000000 R3  : ffffffe7
R4  : 8c3c6180 R5  : 8c9e8c00 R6  : 00000064 R7  : 0000ffff
R8  : 8cb17640 R9  : 8cd59200 R10 : 8c3c6140 R11 : 8c9e8c00
R12 : 8cb17600 R13 : 00000037 R14 : 8c2cfe10
MACH: 000002b0 MACL: 000036c9 GBR : 00000000 PR  : c0128352

Call trace:
[<c0128352>] snd_mixer_oss_put_volume1_vol+0x112/0x180 [snd_mixer_oss]
[<c01286ca>] snd_mixer_oss_put_volume1+0x16a/0x260 [snd_mixer_oss]
[<c0128240>] snd_mixer_oss_put_volume1_vol+0x0/0x180 [snd_mixer_oss]
[<c0127628>] snd_mixer_oss_ioctl1+0x308/0x8a0 [snd_mixer_oss]
[<8c00d6c4>] __do_page_fault+0xa4/0x1c0
[<c0127be0>] snd_mixer_oss_ioctl_card+0x0/0x60 [snd_mixer_oss]
[<8c005024>] call_dpf+0x10/0x3c
[<8c005090>] ret_from_exception+0x0/0x8
[<c0127be0>] snd_mixer_oss_ioctl_card+0x0/0x60 [snd_mixer_oss]
[<c0127be0>] snd_mixer_oss_ioctl_card+0x0/0x60 [snd_mixer_oss]
[<c0127c1c>] snd_mixer_oss_ioctl_card+0x3c/0x60 [snd_mixer_oss]
[<c015a27a>] snd_pcm_oss_ioctl+0x15a/0x1080 [snd_pcm_oss]
[<8c078704>] do_ioctl+0x84/0xc0
[<8c0787b2>] vfs_ioctl+0x72/0x440
[<8c05e20a>] do_sys_open+0x8a/0x120
[<8c078bae>] sys_ioctl+0x2e/0xa0
[<8c0051bc>] syscall_call+0xc/0xe
[<8c078b80>] sys_ioctl+0x0/0xa0

08). Copyright 1995-2005 by The Mpg123 Project.
Uses code from various people, see 'AUTHORS' for full list.
This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (GPL).


If I try without the gain command there is no problem, though I can
hardly hear the output obviously



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
