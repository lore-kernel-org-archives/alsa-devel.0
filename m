From: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Sat, 19 Jul 2003 13:49:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F193061.2050505@free.fr>
References: <Pine.LNX.4.44.0307191018430.3903-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307191018430.3903-100000@pnote.perex-int.cz>
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

Jaroslav Kysela wrote:
> On Fri, 18 Jul 2003, Vince wrote:
> 
> 
>>P.S.: I intended to test alsa 0.9.5 (in the hope that this bug was 
>>already known & has already been fixed), but unfortunately I get a 
>>compile error (I simply dropped alsa-kernel 0.9.5 in the 2.6.0-test1-mm1 
>>source tree):
> 
> 
> Copy also header files from alsa-kernel/include to linux/include/sound.
> 
> 						Jaroslav

Thanks... If I made no mistake in installation, it appears that I still 
get the exact same oops with 0.9.5 (btw alsa-kernel/include/version.h 
still says 0.9.4 in the tarball):

--------------------------------------------------------------------
Unable to handle kernel paging request at virtual address d0c38000
  printing eip:
d0acafbb
*pde = 0c404067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<d0acafbb>]    Tainted: PF  VLI
EFLAGS: 00210202
EIP is at resample_expand+0x34b/0x380 [snd_pcm_oss]
eax: d0acafbb   ebx: 00000001   ecx: 000007ff   edx: ffecffec
esi: d0c55ff6   edi: cd6e3f4c   ebp: d0c37ffe   esp: c559fe58
ds: 007b   es: 007b   ss: 0068
Process festival (pid: 1381, threadinfo=c559e000 task=c606aca0)
Stack: d0ac8252 cd6e3ec0 c7f243a0 c559fe84 0000ffec c559e000 ffffffff 
cee9a600
        d0acade1 d0acaf32 d0acafbb cd6e3f30 00000000 00000002 00000002 
00000000
        ffecffec 000002a8 000017fd 00000800 cd6e3ec0 c7de3640 d0acb4ac 
cd6e3ec0
Call Trace:
  [<d0ac8252>] snd_pcm_plug_playback_channels_mask+0x72/0xe0 [snd_pcm_oss]
  [<d0acade1>] resample_expand+0x171/0x380 [snd_pcm_oss]
  [<d0acaf32>] resample_expand+0x2c2/0x380 [snd_pcm_oss]
  [<d0acafbb>] resample_expand+0x34b/0x380 [snd_pcm_oss]
  [<d0acb4ac>] rate_transfer+0x5c/0x60 [snd_pcm_oss]
  [<d0ac8647>] snd_pcm_plug_write_transfer+0x97/0x100 [snd_pcm_oss]
  [<d0ac43e0>] snd_pcm_oss_write2+0xd0/0x150 [snd_pcm_oss]
  [<d0ac4606>] snd_pcm_oss_write1+0x1a6/0x1d0 [snd_pcm_oss]
  [<d0ac6713>] snd_pcm_oss_write+0x43/0x60 [snd_pcm_oss]
  [<d0ac66d0>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
  [<c014e6f8>] vfs_write+0xb8/0x130
  [<c014e822>] sys_write+0x42/0x70
  [<c0109107>] syscall_call+0x7/0xb

Code: 66 35 00 80 eb d4 8b 45 00 c1 e8 08 eb cc 8b 45 00 c1 e8 08 66 35 
00 80 eb c2 8b 45 00 c1 e8 08 eb ba eb a6 eb b1 8b 55 00 eb bf <8b> 45 
00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00 b8
-----------------------------------------------------------------------

The tainted flag comes from the nvidia binary driver, but I can 
reproduce without if necessary...

Vincent



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
