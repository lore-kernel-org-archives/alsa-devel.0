From: Lee Revell <rlrevell@joe-job.com>
Subject: Oops in snd_emu10k1_efx_playback_prepare
Date: Wed, 09 Mar 2005 00:56:19 -0500
Message-ID: <1110347780.7123.21.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

I got an Oops again that seems to be caused by something in mu
multichannel patch.  But, I don't really know what to make of it.

ksymoops seems broken for 2.6 kernels, but it was able to disassemble
the offending code.

Any ideas?

Lee

Unable to handle kernel paging request at virtual address 03020108
e08dca22
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e08dca22>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210286   (2.6.11) 
eax: 03020100   ebx: 00002800   ecx: 00000001   edx: deca2a08
esi: 00002800   edi: deca2a08   ebp: c2f41e48   esp: c2f41e0c
ds: 007b   es: 007b   ss: 0068
Stack: deca2000 0808001a 0000003f 00000000 00200216 00000001 00000000
df61a400 
       000000ff 00000000 0e0d000a 00000000 00002800 00002800 0000000c
c2f41e80 
       e08dd3e7 deca2000 00000000 00000000 deca2a08 00002600 00002800
00000200 
Call Trace:
 [<c0102c8f>] show_stack+0x7f/0xa0
 [<c0102e2a>] show_registers+0x15a/0x1c0
 [<c0103020>] die+0xf0/0x190
 [<c010df8b>] do_page_fault+0x31b/0x670
 [<c01028fb>] error_code+0x2b/0x30
 [<e08dd3e7>] snd_emu10k1_efx_playback_prepare+0xd7/0xf0 [snd_emu10k1]
 [<e08987f5>] snd_pcm_do_prepare+0x15/0x40 [snd_pcm]
 [<e0897d65>] snd_pcm_action_group+0x95/0x1b0 [snd_pcm]
 [<e08980c7>] snd_pcm_action_nonatomic+0x47/0x80 [snd_pcm]
 [<e0898871>] snd_pcm_prepare+0x21/0x30 [snd_pcm]
 [<e089af1b>] snd_pcm_playback_ioctl1+0x4b/0x330 [snd_pcm]
 [<e089bef7>] snd_pcm_playback_ioctl_old+0x27/0x40 [snd_pcm]
 [<c0160823>] do_ioctl+0x63/0x90
 [<c0160a42>] vfs_ioctl+0x62/0x1c0
 [<c0160c01>] sys_ioctl+0x61/0xa0
 [<c0102753>] syscall_call+0x7/0xb
Code: 00 00 00 fe 05 00 00 00 06 c9 c3 8d b4 26 00 00 00 00 8d bc 27 00
00 00 00 55 89 e5 57 56 53 83 ec 30 8b 7d 14 8b 55 14 8b 42 10 <8b> 50
08 8b 4a 60 89 4d e0 83 78 04 01 8b 77 04 0f 84 ba 05 00 


>>EIP; e08dca22 No symbols available   <=====

Trace; c0102c8f No symbols available
Trace; c0102e2a No symbols available
Trace; c0103020 No symbols available
Trace; c010df8b No symbols available
Trace; c01028fb No symbols available
Trace; e08dd3e7 No symbols available
Trace; e08987f5 No symbols available
Trace; e0897d65 No symbols available
Trace; e08980c7 No symbols available
Trace; e0898871 No symbols available
Trace; e089af1b No symbols available
Trace; e089bef7 No symbols available
Trace; c0160823 No symbols available
Trace; c0160a42 No symbols available
Trace; c0160c01 No symbols available
Trace; c0102753 No symbols available

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  e08dc9f7 No symbols available
00000000 <_EIP>:
Code;  e08dc9f7 No symbols available
   0:   00 00                     add    %al,(%eax)
Code;  e08dc9f9 No symbols available
   2:   00 fe                     add    %bh,%dh
Code;  e08dc9fb No symbols available
   4:   05 00 00 00 06            add    $0x6000000,%eax
Code;  e08dca00 No symbols available
   9:   c9                        leave  
Code;  e08dca01 No symbols available
   a:   c3                        ret    
Code;  e08dca02 No symbols available
   b:   8d b4 26 00 00 00 00      lea    0x0(%esi),%esi
Code;  e08dca09 No symbols available
  12:   8d bc 27 00 00 00 00      lea    0x0(%edi),%edi
Code;  e08dca10 No symbols available
  19:   55                        push   %ebp
Code;  e08dca11 No symbols available
  1a:   89 e5                     mov    %esp,%ebp
Code;  e08dca13 No symbols available
  1c:   57                        push   %edi
Code;  e08dca14 No symbols available
  1d:   56                        push   %esi
Code;  e08dca15 No symbols available
  1e:   53                        push   %ebx
Code;  e08dca16 No symbols available
  1f:   83 ec 30                  sub    $0x30,%esp
Code;  e08dca19 No symbols available
  22:   8b 7d 14                  mov    0x14(%ebp),%edi
Code;  e08dca1c No symbols available
  25:   8b 55 14                  mov    0x14(%ebp),%edx
Code;  e08dca1f No symbols available
  28:   8b 42 10                  mov    0x10(%edx),%eax

This decode from eip onwards should be reliable

Code;  e08dca22 No symbols available
00000000 <_EIP>:
Code;  e08dca22 No symbols available   <=====
   0:   8b 50 08                  mov    0x8(%eax),%edx   <=====
Code;  e08dca25 No symbols available
   3:   8b 4a 60                  mov    0x60(%edx),%ecx
Code;  e08dca28 No symbols available
   6:   89 4d e0                  mov    %ecx,0xffffffe0(%ebp)
Code;  e08dca2b No symbols available
   9:   83 78 04 01               cmpl   $0x1,0x4(%eax)
Code;  e08dca2f No symbols available
   d:   8b 77 04                  mov    0x4(%edi),%esi
Code;  e08dca32 No symbols available
  10:   0f                        .byte 0xf
Code;  e08dca33 No symbols available
  11:   84                        .byte 0x84
Code;  e08dca34 No symbols available
  12:   ba                        .byte 0xba
Code;  e08dca35 No symbols available
  13:   05                        .byte 0x5


2 warnings and 2 errors issued.  Results may not be reliable.





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
