From: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Mon, 21 Jul 2003 15:54:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1BF0AE.3090105@free.fr>
References: <Pine.LNX.4.44.0307211527460.26922-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307211527460.26922-100000@pnote.perex-int.cz>
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

And I also still get an oops after correcting the patch...

Unable to handle kernel paging request at virtual address d0a91000
  printing eip:
d0c8607b
*pde = 013ea067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<d0c8607b>]    Tainted: PF  VLI
EFLAGS: 00010202
EIP is at resample_expand+0x34b/0x380 [snd_pcm_oss]
eax: d0c8607b   ebx: 00000001   ecx: 00036eb8   edx: fdc6fe33
esi: d0acbff6   edi: cee768cc   ebp: d0a90ffe   esp: c5979e58
ds: 007b   es: 007b   ss: 0068
Process festival (pid: 2322, threadinfo=c5978000 task=c565f940)
Stack: d0c832f2 cee76840 c4f528e0 c5979e84 0000fe32 c5978000 ffffffff 
cee76600
        d0c85ea1 d0c85ff2 d0c8607b cee768b0 00000000 00000002 00000002 
00000000
        fe33fe33 000002a8 000017fd 00000800 cee76840 cebe3140 d0c8656c 
cee76840
Call Trace:
  [<d0c832f2>] snd_pcm_plug_playback_channels_mask+0x72/0xe0 [snd_pcm_oss]
  [<d0c85ea1>] resample_expand+0x171/0x380 [snd_pcm_oss]
  [<d0c85ff2>] resample_expand+0x2c2/0x380 [snd_pcm_oss]
  [<d0c8607b>] resample_expand+0x34b/0x380 [snd_pcm_oss]
  [<d0c8656c>] rate_transfer+0x5c/0x60 [snd_pcm_oss]
  [<d0c836e7>] snd_pcm_plug_write_transfer+0x97/0x100 [snd_pcm_oss]
  [<d0c7f3e0>] snd_pcm_oss_write2+0xd0/0x150 [snd_pcm_oss]
  [<d0c7f606>] snd_pcm_oss_write1+0x1a6/0x1d0 [snd_pcm_oss]
  [<d0c81713>] snd_pcm_oss_write+0x43/0x60 [snd_pcm_oss]
  [<d0c816d0>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
  [<c014e6f8>] vfs_write+0xb8/0x130
  [<c014e822>] sys_write+0x42/0x70
  [<c0109107>] syscall_call+0x7/0xb

Code: 66 35 00 80 eb d4 8b 45 00 c1 e8 08 eb cc 8b 45 00 c1 e8 08 66 35 
00 80 eb  c2 8b 45 00 c1 e8 08 eb ba eb a6 eb b1 8b 55 00 eb bf <8b> 45 
00 eb ac 0f b6 45  00 c1 e0 08 eb a3 81 fa 00 80 00 00 b8



Jaroslav Kysela wrote:
> On Mon, 21 Jul 2003, [iso-8859-1] Ville Syrjälä wrote:
> 
> 
>>On Mon, Jul 21, 2003 at 02:38:03PM +0200, Jaroslav Kysela wrote:
>>
>>>+static int rate_match(unsigned int src_rate, unsigned int dst_rate)
>>>+{
>>>+	unsigned int low = (src_rate * 95) / 100;
>>>+	unsigned int high = (src_rate * 105) / 105;
>>
>>                                               ^^^
>>Typo.
> 
> 
> Yes, thanks.
> 
> 			



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
