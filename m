From: Andy Lo-A-Foe <andy@alsaplayer.org>
Subject: Kernel OOP with alsaplayer driver
Date: Tue, 20 Aug 2002 13:06:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020820110644.GA380@orbital.xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We've been experiencing kernel OOPSes with the alsaplayer alsa-final
output plugin. The problems appeared in the 0.9.0rc3 release and
forward. The same code works fine on 0.9.0rc1. The OOP is triggered at
close time (snd_pcm_close()) and only then. This behaviour was
duplicated on at least 2 systems with different soundcards, each time
with alsaplayer 0.99.71 and alsa 0.9.0rc3 ...

I just noticed that the OOPS doesn't happen if I call snd_pcm_drain() just
before snd_pcm_close(). It makes sense, but the OOPS should never happen
right?

See attachement for a trace..

Thanks,
Andy

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3.txt"

ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 00003368
c02bdcc6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c02bdcc6>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00001000   ecx: 00001000   edx: 08303f58
esi: 08302f58   edi: 00003368   ebp: d9152c00   esp: da091cac
ds: 0018   es: 0018   ss: 0018
Process alsaplayer (pid: 8257, stackpage=da091000)
Stack: 00000000 00001000 de36cb80 e0bb5ec0 00001000 e0ba9f86 00003368 08302f58 
       00001000 de36cb80 00024c01 d4bd2000 00000400 00024cda d9602000 e0baa248 
       de36cb80 00000cda 08302f58 00000000 00000400 00072b69 00002000 da090000 
Call Trace:    [<e0bb5ec0>] [<e0ba9f86>] [<e0baa248>] [<e0ba5700>] [<e0baa4a6>]
  [<e0ba9ef0>] [<e0ba526f>] [<c0257002>] [<c02564a0>] [<c0256011>] [<c0254214>]
  [<c0254381>] [<c01166e6>] [<c012175e>] [<c0121a86>] [<c0122284>] [<c0120dcc>]
  [<c011d282>] [<c011d196>] [<c01447fa>] [<c0108d77>]
Code: f3 aa 58 59 e9 55 b0 ff ff ba f2 ff ff ff e9 9e b0 ff ff ba 


>>EIP; c02bdcc6 <rwsem_down_failed_common+3046/30bb>   <=====

>>ebp; d9152c00 <_end+18dbe59c/20561a1c>
>>esp; da091cac <_end+19cfd648/20561a1c>

Trace; e0bb5ec0 <[snd-trident]snd_trident_playback_ops+0/40>
Trace; e0ba9f86 <[snd-pcm]snd_pcm_lib_write_transfer+96/b0>
Trace; e0baa248 <[snd-pcm]snd_pcm_lib_write1+2a8/470>
Trace; e0ba5700 <[snd-pcm]snd_pcm_playback_ioctl+0/40>
Trace; e0baa4a6 <[snd-pcm]snd_pcm_lib_write+96/b0>
Trace; e0ba9ef0 <[snd-pcm]snd_pcm_lib_write_transfer+0/b0>
Trace; e0ba526f <[snd-pcm]snd_pcm_playback_ioctl1+17f/320>
Trace; c0257002 <mousedev_event+c2/230>
Trace; c02564a0 <input_event+e0/2f0>
Trace; c0256011 <hidinput_hid_event+81/200>
Trace; c0254214 <hid_process_event+34/40>
Trace; c0254381 <hid_input_field+161/360>
Trace; c01166e6 <wake_up_process+16/20>
Trace; c012175e <deliver_signal+6e/70>
Trace; c0121a86 <kill_something_info+b6/170>
Trace; c0122284 <sys_kill+54/60>
Trace; c0120dcc <run_timer_list+11c/140>
Trace; c011d282 <bh_action+22/40>
Trace; c011d196 <tasklet_hi_action+46/70>
Trace; c01447fa <sys_ioctl+aa/1b0>
Trace; c0108d77 <system_call+33/38>

Code;  c02bdcc6 <rwsem_down_failed_common+3046/30bb>
00000000 <_EIP>:
Code;  c02bdcc6 <rwsem_down_failed_common+3046/30bb>   <=====
   0:   f3 aa                     repz stos %al,%es:(%edi)   <=====
Code;  c02bdcc8 <rwsem_down_failed_common+3048/30bb>
   2:   58                        pop    %eax
Code;  c02bdcc9 <rwsem_down_failed_common+3049/30bb>
   3:   59                        pop    %ecx
Code;  c02bdcca <rwsem_down_failed_common+304a/30bb>
   4:   e9 55 b0 ff ff            jmp    ffffb05e <_EIP+0xffffb05e> c02b8d24 <__generic_copy_from_user+44/70>
Code;  c02bdccf <rwsem_down_failed_common+304f/30bb>
   9:   ba f2 ff ff ff            mov    $0xfffffff2,%edx
Code;  c02bdcd4 <rwsem_down_failed_common+3054/30bb>
   e:   e9 9e b0 ff ff            jmp    ffffb0b1 <_EIP+0xffffb0b1> c02b8d77 <__strncpy_from_user+27/40>
Code;  c02bdcd9 <rwsem_down_failed_common+3059/30bb>
  13:   ba 00 00 00 00            mov    $0x0,%edx


1 warning issued.  Results may not be reliable.

--ZPt4rx8FFjLCG7dd--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
