From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [BUG REPORT] via8233 oopses in both alsa-0.5.12a and 0.9beta12
Date: Tue, 12 Mar 2002 17:15:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2zo1dlq3d.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Received: from vador.mandrakesoft.com (office.mandrakesoft.com [195.68.114.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA19902
	for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2002 17:14:06 +0100
Received: from vador.mandrakesoft.com (localhost.localdomain [127.0.0.1])
	by vador.mandrakesoft.com (Postfix) with ESMTP id 3C1298E75
	for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2002 17:15:34 +0100 (CET)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

since, i'ven't got any reply from the driver authors:

i've a : "VIA Technologies VT8233 [AC97 Audio Controller]" (pci ids =
vendor:1106 device:3059, pci subids = subv:1462 subd:4720) managed by
snd-card-via8233.

snd-card-via8233 oopses with both kernel-2.4.18 + alsa-0.5.12a and
2.5.6 with integrated alsa.

here is the 2.5.6 oops (the bug occured in snd_pcm_update_hw_ptr) :


--=-=-=
Content-Disposition: attachment; filename=OLOG1

ksymoops 2.4.3 on i686 2.5.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.6/ (default)
     -m /boot/System.map-2.5.6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
CPU:    0
EIP:    0010:[<c024ee92>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 000000ff   ebx: c7f9b7c0   ecx: 00ffffff   edx: 00000000
esi: c7db0ac4   edi: 0000e800   ebp: c7db0ac4   esp: c69a5e6c
ds: 0018   es: 0018   ss: 0018
Stack: c79a1c14 c7db0ac4 c79a1c14 c0248d81 c7db0ac4 00000000 c6978000 c7db0ac4
       c79a1c14 00000000 c024c427 c7db0ac4 00000000 00008000 00000000 00008000
       00000000 00000000 00000000 c0125437 c7d3b274 c793852c 080ad000 c79a1c14
Call Trace: [<c0248d81>] [<c024c427>] [<c0125437>] [<c024c9b5>] [<c024c290>]
   [<c02282ee>] [<c02285ed>] [<c0228743>] [<c022a85d>] [<c0136795>] [<c01257e3>]
   [<c0126734>] [<c0107147>]
Code: f7 73 1c 8b 43 18 0f af d0 29 c8 8b 4e 50 01 c2 8d 04 d5 00

>>EIP; c024ee92 <snd_via8233_playback_pointer+82/b0>   <=====
Trace; c0248d80 <snd_pcm_update_hw_ptr+20/210>
Trace; c024c426 <snd_pcm_lib_write1+d6/510>
Trace; c0125436 <handle_mm_fault+66/110>
Trace; c024c9b4 <snd_pcm_lib_write+154/160>
Trace; c024c290 <snd_pcm_lib_write_transfer+0/c0>
Trace; c02282ee <snd_pcm_oss_write3+5e/a0>
Trace; c02285ec <snd_pcm_oss_write2+ac/d0>
Trace; c0228742 <snd_pcm_oss_write1+132/160>
Trace; c022a85c <snd_pcm_oss_write+7c/a0>
Trace; c0136794 <sys_write+94/130>
Trace; c01257e2 <sys_brk+c2/100>
Trace; c0126734 <sys_munmap+34/50>
Trace; c0107146 <syscall_call+6/a>
Code;  c024ee92 <snd_via8233_playback_pointer+82/b0>
00000000 <_EIP>:
Code;  c024ee92 <snd_via8233_playback_pointer+82/b0>   <=====
   0:   f7 73 1c                  divl   0x1c(%ebx)   <=====
Code;  c024ee94 <snd_via8233_playback_pointer+84/b0>
   3:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c024ee98 <snd_via8233_playback_pointer+88/b0>
   6:   0f af d0                  imul   %eax,%edx
Code;  c024ee9a <snd_via8233_playback_pointer+8a/b0>
   9:   29 c8                     sub    %ecx,%eax
Code;  c024ee9c <snd_via8233_playback_pointer+8c/b0>
   b:   8b 4e 50                  mov    0x50(%esi),%ecx
Code;  c024eea0 <snd_via8233_playback_pointer+90/b0>
   e:   01 c2                     add    %eax,%edx
Code;  c024eea2 <snd_via8233_playback_pointer+92/b0>
  10:   8d 04 d5 00 00 00 00      lea    0x0(,%edx,8),%eax


4 warnings issued.  Results may not be reliable.

--=-=-=




and the 2.4.18 oops (the bug occurent in irq handling) :


--=-=-=
Content-Disposition: attachment; filename=OLOG2
Content-Description: 2.4.18/alsa-0.5.12a oops

ksymoops 2.4.3 on i686 2.4.17-22mdk.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-4mdk (specified)
     -m /boot/System.map-2.4.18-4mdk (specified)

CPU: 0
EIP: 0010:[<c888846c>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c709e800     ecx: c68a23c0       edx: 00000000
esi: c68a23a0   edi: 0000000a     ebp: c0279f84       esp: c0279f18
ds: 0018        es: 0018       ss: 0018
Process swaper (pid: 0, stackpage=c0279000)
Stack: c885596c c75ae510 c75ae540 c8859d00 00000000 00000013 c7449f80 04000001
           c7093c20 04000001 c010836a 0000000a c7093b60 c0279f84 c0279f84 0000000a
           c02bba40 c7449f80 c01084ed 0000000a c0279f84 c7449f80 00000000 00000000
Call Trace: [<c885596c>] [<c010836a>] [<c01084ed>] [<c01053d4>] [<c0111205>]
                   [<c01110f0>] [<c0105442>] [<c0105000>]
Code: f7 71 14 89 51 1c 8b 59 0c 53 e8 55 a3 ff ff 66 8b 5e 0c 59

>>EIP; c888846c <_end+858c058/c5debec>   <=====
Trace; c885596c <_end+8559558/c5debec>
Trace; c010836a <handle_IRQ_event+3a/70>
Trace; c01084ec <do_IRQ+6c/b0>
Trace; c01053d4 <default_idle+24/30>
Trace; c0111204 <apm_cpu_idle+114/150>
Trace; c01110f0 <apm_cpu_idle+0/150>
Trace; c0105442 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Code;  c888846c <_end+858c058/c5debec>
00000000 <_EIP>:
Code;  c888846c <_end+858c058/c5debec>   <=====
   0:   f7 71 14                  divl   0x14(%ecx)   <=====
Code;  c888846e <_end+858c05a/c5debec>
   3:   89 51 1c                  mov    %edx,0x1c(%ecx)
Code;  c8888472 <_end+858c05e/c5debec>
   6:   8b 59 0c                  mov    0xc(%ecx),%ebx
Code;  c8888474 <_end+858c060/c5debec>
   9:   53                        push   %ebx
Code;  c8888476 <_end+858c062/c5debec>
   a:   e8 55 a3 ff ff            call   ffffa364 <_EIP+0xffffa364> c88827d0 <_end+85863bc/c5debec>
Code;  c888847a <_end+858c066/c5debec>
   f:   66 8b 5e 0c               mov    0xc(%esi),%bx
Code;  c888847e <_end+858c06a/c5debec>
  13:   59                        pop    %ecx

--=-=-=



mandrake 8.2'll be released soon and i'll be forced to remove via8233
support since alsa just failled on it and module authors don't care
about after a week.

--=-=-=--


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
