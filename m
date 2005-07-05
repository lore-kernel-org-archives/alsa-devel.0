From: Raymond <rayau@netvigator.com>
Subject: Re: alsa dma transfer
Date: Tue, 05 Jul 2005 20:26:49 +0800
Message-ID: <42CA7C89.90005@netvigator.com>
References: <9AEDBAA573BBD346BCF9637D80097D911DCCE9@greysvr02.GreyInnovation.com>	<s5hd5q57bv5.wl%tiwai@suse.de>	<42C29512.7020205@netvigator.com> <s5hvf3x5lj2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvf3x5lj2.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 29 Jun 2005 20:33:22 +0800,
> Raymond wrote:
> 
> 
>>The device hw:0 allow sending 16 mono PCM samples ( change pitch by SRC 
>>and panning by hardware mixer, no reverb and chrous effect) to AC97 codec
>>
>>How to ensure each sound font samples loaded in memory aligned at 4K
>>boundary ?
> 
> 
> Depends.  The emu10k1 doesn't align to 4k boundary but just
> split to different pages since emu10k1 has its own TLB.
> 

In au88x0.c

	chip->max_mem_size=(16*1024*1024);
	chip->memhdr = snd_util_memhdr_new(chip->max_mem_size);
	if (chip->memhdr == NULL) {
		printk(KERN_ERR "snd_util_memhdr_new error\n");
	}
	chip->mem_size=chip->max_mem_size;
         printk(KERN_INFO "%d Bytes wavetable\n",chip->max_mem_size);

What is the reason/advantage of using util_mem.c ?

It is correct to use snd_util_mem_alloc() to allocate memory for sample 
in snd_vortex_sample_new() ?

Why get seg fault in __snd_util_memblk_new() ?


Unable to handle kernel paging request at virtual address 022d02ab
  printing eip:
e1d301e4
*pde = 00000000
Oops: 0000
snd-seq-midi snd-seq-midi-event snd-seq snd-intel8x0 snd-au8830 
snd-util-mem snd-mpu401-uart snd-rawmidi snd-seq-device snd-hwdep 
snd-ac97-codec snd-pcm snd-t
CPU:    0
EIP:    0060:[<e1d301e4>]    Tainted: P
EFLAGS: 00010207

EIP is at __snd_util_memblk_new_R970b7c65 [snd-util-mem] 0x44 
(2.4.22-1.2199.nptl)
eax: db4ee684   ebx: 022d02af   ecx: da63f940   edx: 00000040
esi: db4ee680   edi: 00010b00   ebp: db4ee680   esp: cfc43e58
ds: 0068   es: 0068   ss: 0068
Process arlload (pid: 5852, stackpage=cfc43000)
Stack: 00000010 000001f0 00010b00 db4ee684 00b10029 e1d30197 db4ee680 
00010b00
        022d02af 01000000 db4ee698 db4ee680 cfc43ef8 db4eec80 e1d3025d 
db4ee680
        00010b00 00010b00 d44d0780 e1d86ac4 db4ee680 00010b00 e1d92100 
00010b00
Call Trace:   [<e1d30197>] __snd_util_mem_alloc_Raf5d58ef [snd-util-mem] 
0x77 (0xcfc43e6c)
[<e1d3025d>] snd_util_mem_alloc_Rc40f9ed9 [snd-util-mem] 0x2d (0xcfc43e90)
[<e1d86ac4>] snd_vortex_sample_new [snd-au8830] 0xb4 (0xcfc43ea4)
[<e1d92100>] .rodata.str1.32 [snd-au8830] 0x1a0 (0xcfc43eb0)
[<e1d85fbd>] load_data [snd-au8830] 0x1fd (0xcfc43ec0)
[<e1d861bd>] snd_soundfont_load [snd-au8830] 0x18d (0xcfc43f08)
[<e1d86c89>] snd_vortex_hwdep_load_patch [snd-au8830] 0x99 (0xcfc43f44)
[<e1d86d60>] snd_vortex_hwdep_ioctl [snd-au8830] 0x0 (0xcfc43f6c)
[<e1d21755>] snd_hwdep_ioctl [snd-hwdep] 0x65 (0xcfc43f78)
[<c0153719>] sys_ioctl [kernel] 0xc9 (0xcfc43f94)
[<c0109747>] system_call [kernel] 0x33 (0xcfc43fc0)



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
