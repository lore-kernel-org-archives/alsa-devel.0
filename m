From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Oops in snd_emu10k1_efx_playback_prepare
Date: Fri, 18 Mar 2005 22:30:50 -0500
Message-ID: <1111203050.12740.7.camel@mindpipe>
References: <1110347780.7123.21.camel@mindpipe>
	 <s5hbr9t5efx.wl@alsa2.suse.de> <s5h8y4x5btl.wl@alsa2.suse.de>
	 <s5his40wx9t.wl@alsa2.suse.de> <1110490545.14297.9.camel@mindpipe>
	 <s5hll8uup1p.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hll8uup1p.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-11 at 17:26 +0100, Takashi Iwai wrote:
> At Thu, 10 Mar 2005 16:35:45 -0500,
> Lee Revell wrote:
> > 
> > On Wed, 2005-03-09 at 18:21 +0100, Takashi Iwai wrote:
> > > At Wed, 09 Mar 2005 11:54:30 +0100,
> > > I wrote:
> > > > 
> > > > At Wed, 09 Mar 2005 10:57:54 +0100,
> > > > I wrote:
> > > > > 
> > > > > At Wed, 09 Mar 2005 00:56:19 -0500,
> > > > > Lee Revell wrote:
> > > > > > 
> > > > > > I got an Oops again that seems to be caused by something in mu
> > > > > > multichannel patch.  But, I don't really know what to make of it.
> > > > > > 
> > > > > > ksymoops seems broken for 2.6 kernels, but it was able to disassemble
> > > > > > the offending code.
> > > > > > 
> > > > > > Any ideas?
> > > > > 
> > > > > In snd_emu10k1_pcm_channel_alloc(), epcm->voices[2..NUM_EFX_PLAYBACK]
> > > > > are not freed correctly.  Possibly did this hit?
> > > > 
> > > > Or maybe I misread the code.  Need more coffee now... :)
> > > > 
> > > > Anyway, snd_emu10k1_pcm_channel_alloc() should return immediately at
> > > > the second or later call when all voices have been already allocated.
> > > 
> > > The quick fix patch is below.
> > > But I'm not sure whether this is really related with the given bug.
> > > 
> > 
> > Thanks, I'll try this.  Unfortunately the bug is very hard to hit (I
> > have only triggered it twice) and I have no idea how to reproduce it.
> > It's somwhow associated with restarting JACK.
> 
> I'll apply this fix to CVS anyway.
> Please report if you hit the bug again.
> 
> 

I hit it again.  It's slightly different this time.

The problem triggered when I stopped JACK then restarted with a smaller
period size.

Lee

Unable to handle kernel paging request at virtual address 936e4158
c01d3d63
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01d3d63>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210012   (2.6.12-rc1) 
eax: 00000008   ebx: 936e4170   ecx: 00000002   edx: d0b9fe3c
esi: 936e4158   edi: d0b9fe3c   ebp: d0b9fe0c   esp: d0b9fdf8
ds: 007b   es: 007b   ss: 0068
Stack: 00200046 def60000 0779dfff 03020100 00000001 d0b9fe50 e08e2178 d0b9fe3c 
       936e4158 00000008 00000000 00200216 00000001 00000000 de61e000 00000005 
       00000000 00000002 00000005 00001780 00001780 0000000f d0b9fe88 e08e2597 
Call Trace:
 [<c01031cf>] show_stack+0x7f/0xa0
 [<c010336a>] show_registers+0x15a/0x1c0
 [<c0103560>] die+0xf0/0x190
 [<c010e34b>] do_page_fault+0x31b/0x670
 [<c0102e23>] error_code+0x2b/0x30
 [<e08e2178>] snd_emu10k1_pcm_init_voice+0x5c8/0x610 [snd_emu10k1]
 [<e08e2597>] snd_emu10k1_efx_playback_prepare+0xd7/0xf0 [snd_emu10k1]
 [<e08987f5>] snd_pcm_do_prepare+0x15/0x40 [snd_pcm]
 [<e0897eb4>] snd_pcm_action_single+0x34/0x70 [snd_pcm]
 [<e08980f3>] snd_pcm_action_nonatomic+0x73/0x80 [snd_pcm]
 [<e0898871>] snd_pcm_prepare+0x21/0x30 [snd_pcm]
 [<e089af67>] snd_pcm_playback_ioctl1+0x47/0x2d0 [snd_pcm]
 [<e089be97>] snd_pcm_playback_ioctl_old+0x27/0x40 [snd_pcm]
 [<c01631a3>] do_ioctl+0x63/0x90
 [<c0163362>] vfs_ioctl+0x62/0x1c0
 [<c0163521>] sys_ioctl+0x61/0x80
 [<c0102c75>] syscall_call+0x7/0xb
Code: 90 90 90 90 90 90 90 90 55 89 e5 83 ec 14 8b 45 10 89 75 f8 89 7d fc 8b 55 08 8b 75 0c 3d ff 01 00 00 77 24 89 c1 89 d7 c1 e9 02 <f3> a5 a8 02 74 02 66 a5 a8 01 74 01 a4 89 d0 8b 75 f8 8b 7d fc 


>>EIP; c01d3d63 No symbols available   <=====

Trace; c01031cf No symbols available
Trace; c010336a No symbols available
Trace; c0103560 No symbols available
Trace; c010e34b No symbols available
Trace; c0102e23 No symbols available
Trace; e08e2178 No symbols available
Trace; e08e2597 No symbols available
Trace; e08987f5 No symbols available
Trace; e0897eb4 No symbols available
Trace; e08980f3 No symbols available
Trace; e0898871 No symbols available
Trace; e089af67 No symbols available
Trace; e089be97 No symbols available
Trace; c01631a3 No symbols available
Trace; c0163362 No symbols available
Trace; c0163521 No symbols available
Trace; c0102c75 No symbols available

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01d3d38 No symbols available
00000000 <_EIP>:
Code;  c01d3d38 No symbols available
   0:   90                        nop    
Code;  c01d3d39 No symbols available
   1:   90                        nop    
Code;  c01d3d3a No symbols available
   2:   90                        nop    
Code;  c01d3d3b No symbols available
   3:   90                        nop    
Code;  c01d3d3c No symbols available
   4:   90                        nop    
Code;  c01d3d3d No symbols available
   5:   90                        nop    
Code;  c01d3d3e No symbols available
   6:   90                        nop    
Code;  c01d3d3f No symbols available
   7:   90                        nop    
Code;  c01d3d40 No symbols available
   8:   55                        push   %ebp
Code;  c01d3d41 No symbols available
   9:   89 e5                     mov    %esp,%ebp
Code;  c01d3d43 No symbols available
   b:   83 ec 14                  sub    $0x14,%esp
Code;  c01d3d46 No symbols available
   e:   8b 45 10                  mov    0x10(%ebp),%eax
Code;  c01d3d49 No symbols available
  11:   89 75 f8                  mov    %esi,0xfffffff8(%ebp)
Code;  c01d3d4c No symbols available
  14:   89 7d fc                  mov    %edi,0xfffffffc(%ebp)
Code;  c01d3d4f No symbols available
  17:   8b 55 08                  mov    0x8(%ebp),%edx
Code;  c01d3d52 No symbols available
  1a:   8b 75 0c                  mov    0xc(%ebp),%esi
Code;  c01d3d55 No symbols available
  1d:   3d ff 01 00 00            cmp    $0x1ff,%eax
Code;  c01d3d5a No symbols available
  22:   77 24                     ja     48 <_EIP+0x48>
Code;  c01d3d5c No symbols available
  24:   89 c1                     mov    %eax,%ecx
Code;  c01d3d5e No symbols available
  26:   89 d7                     mov    %edx,%edi
Code;  c01d3d60 No symbols available
  28:   c1 e9 02                  shr    $0x2,%ecx

This decode from eip onwards should be reliable

Code;  c01d3d63 No symbols available
00000000 <_EIP>:
Code;  c01d3d63 No symbols available   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c01d3d65 No symbols available
   2:   a8 02                     test   $0x2,%al
Code;  c01d3d67 No symbols available
   4:   74 02                     je     8 <_EIP+0x8>
Code;  c01d3d69 No symbols available
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c01d3d6b No symbols available
   8:   a8 01                     test   $0x1,%al
Code;  c01d3d6d No symbols available
   a:   74 01                     je     d <_EIP+0xd>
Code;  c01d3d6f No symbols available
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c01d3d70 No symbols available
   d:   89 d0                     mov    %edx,%eax
Code;  c01d3d72 No symbols available
   f:   8b 75 f8                  mov    0xfffffff8(%ebp),%esi
Code;  c01d3d75 No symbols available
  12:   8b 7d fc                  mov    0xfffffffc(%ebp),%edi


2 warnings and 2 errors issued.  Results may not be reliable.





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
