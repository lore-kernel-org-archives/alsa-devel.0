From: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Mon, 21 Jul 2003 16:33:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1BF99E.5020607@free.fr>
References: <Pine.LNX.4.44.0307211608520.26922-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307211608520.26922-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 21 Jul 2003, Jaroslav Kysela wrote:
> 
> 
>>On Mon, 21 Jul 2003, Vince wrote:
>>
>>
>>>Sorry, I still get the oops with the patch...
>>
>>Please, change '(src_rate * 105) / 105;' expression from the patch
>>to '(src_rate * 105) / 100;'...
> 
> 
> Ok, here is also a patch which should solve the error for all cases:
> 

Well... I still get an oops :-(
I'm doing a build with frame pointers now... Will tell you the result in 
a few minutes.

Unable to handle kernel paging request at virtual address d0a8a000
  printing eip:
d0c850bb
*pde = 013ea067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<d0c850bb>]    Tainted: PF  VLI
EFLAGS: 00210202
EIP is at resample_expand+0x34b/0x380 [snd_pcm_oss]
eax: d0c850bb   ebx: 00000001   ecx: 00051e16   edx: fca8fd4b
esi: d0a97ff6   edi: cc44a80c   ebp: d0a89ffe   esp: ccc35e54
ds: 007b   es: 007b   ss: 0068
Process festival (pid: 2305, threadinfo=ccc34000 task=cbfacd20)
Stack: ccc35e84 d0c82342 cc44a780 c7e4b2e0 ccc3fd4a 00000000 ccc34000 
ffffffff
        d0c84ee1 d0c85032 d0c850bb cc44a7f0 00000000 00000002 00000002 
00000000
        fd4bfd4b 000002a8 000017fd 00000800 cc44a780 c7e4b220 d0c855b9 
cc44a780
Call Trace:
  [<d0c82342>] snd_pcm_plug_playback_channels_mask+0x72/0xe0 [snd_pcm_oss]
  [<d0c84ee1>] resample_expand+0x171/0x380 [snd_pcm_oss]
  [<d0c85032>] resample_expand+0x2c2/0x380 [snd_pcm_oss]
  [<d0c850bb>] resample_expand+0x34b/0x380 [snd_pcm_oss]
  [<d0c855b9>] rate_transfer+0x69/0x70 [snd_pcm_oss]
  [<d0c82747>] snd_pcm_plug_write_transfer+0x97/0x100 [snd_pcm_oss]
  [<d0c7e3e0>] snd_pcm_oss_write2+0xd0/0x150 [snd_pcm_oss]
  [<d0c7e606>] snd_pcm_oss_write1+0x1a6/0x1d0 [snd_pcm_oss]
  [<d0c80713>] snd_pcm_oss_write+0x43/0x60 [snd_pcm_oss]
  [<d0c806d0>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
  [<c014e6f8>] vfs_write+0xb8/0x130
  [<c014e822>] sys_write+0x42/0x70
  [<c0109107>] syscall_call+0x7/0xb

Code: 66 35 00 80 eb d4 8b 45 00 c1 e8 08 eb cc 8b 45 00 c1 e8 08 66 35 
00 80 eb c2 8b 45 00 c1 e8 08 eb ba eb a6 eb b1 8b 55 00 eb bf <8b> 45 
00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00 b8






-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
