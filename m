From: Drake Wilson <drake@libcom.com>
Subject: Kernel oops/panic/hang with ALSA 1.0.0pre1 on Linux 2.4.22 with OSS emulation
Date: Thu, 20 Nov 2003 20:30:25 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031121013025.GA140@ampersand>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

After installing an unpatched ALSA 1.0.0pre1 on Linux 2.4.22, modprobe
of snd-intel8x0 caused a kernel oops, and left the module in some
strange half-initialized state from which it was impossible to rmmod
it.  Reboot followed.

Patching with the recent intel8x0-fix.dif posted to the list, modprobe
of snd-intel8x0 seemed to work okay, but then trying to run mikmod
(which uses the OSS interface) caused the kernel to panic; SysRq would
attempt to give some response, but only cause more panicking, with a
growing stack trace.  Reboot followed.

Later modprobe'ing of snd-intel8x0 in order to attempt a ksymoops on
the panic seemed to work okay, but trying to rmmod it after the
ksymoops was finished caused the kernel to hang so hard that SysRq no
longer gave any response.  Reboot followed.

This mail follows that last reboot.  Both ksymoops logs are included
inline, as well as the relevant (I think) entry from /proc/pci.  I
think the first ksymoops may be wrong, however, as I was stupid enough
not to capture it before patching ALSA; the second ksymoops doesn't
seem to give as much useful information.  I also apologize if this bug
report contains insufficient or redundant information, as I am not a
Linux kernel, ALSA development, or bug reporting expert.  :-)  If more
information is needed, I will mail it on request.

kern-1.log.ksymoops:
"""
ksymoops 2.4.9 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map (specified)

Nov 20 19:37:31 ampersand kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Nov 20 19:37:31 ampersand kernel: c0115743
Nov 20 19:37:31 ampersand kernel: *pde = 00000000
Nov 20 19:37:31 ampersand kernel: Oops: 0000
Nov 20 19:37:31 ampersand kernel: CPU:    0
Nov 20 19:37:31 ampersand kernel: EIP:    0010:[__wake_up+51/160]    Not tainted
Nov 20 19:37:31 ampersand kernel: EFLAGS: 00010097
Nov 20 19:37:31 ampersand kernel: eax: cdddc0a8   ebx: cdddc0a8   ecx: 00000000   edx: 00000003
Nov 20 19:37:31 ampersand kernel: esi: cdddc0ac   edi: 00000001   ebp: cefb3dec   esp: cefb3dd4
Nov 20 19:37:31 ampersand kernel: ds: 0018   es: 0018   ss: 0018
Nov 20 19:37:31 ampersand kernel: Process mikmod (pid: 529, stackpage=cefb3000)
Nov 20 19:37:31 ampersand kernel: Stack: cde2b000 cde16000 cdddc000 cdddc0ac 00000082 00000003 00000013 d09244d5 
Nov 20 19:37:31 ampersand kernel:        cf89be80 00000013 d091fce6 00000013 00000000 00000000 00001806 00000001 
Nov 20 19:37:31 ampersand kernel:        cf89be80 cdddc000 00000000 d0927f2f cf89be80 cefb3e58 d09519ae cf5fb1a0 
Nov 20 19:37:31 ampersand kernel: Call Trace:    [<d09244d5>] [<d091fce6>] [<d0927f2f>] [<d09519ae>] [<d095466f>]
Nov 20 19:37:31 ampersand kernel:   [<d0927fd0>] [<d0927a80>] [<d094d1a8>] [<d0951df7>] [<d094d52f>] [<d094dad2>]
Nov 20 19:37:31 ampersand kernel:   [<d094dc29>] [<d094f07e>] [fput+76/224] [filp_close+85/96] [sys_close+67/84] [system_call+51/56]
Nov 20 19:37:31 ampersand kernel: Code: 8b 01 85 45 fc 74 4c 31 c0 9c 5e fa c7 01 00 00 00 00 83 79 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; cdddc0a8 <_end+d987cd0/1045ec88>
>>ebx; cdddc0a8 <_end+d987cd0/1045ec88>
>>esi; cdddc0ac <_end+d987cd4/1045ec88>
>>ebp; cefb3dec <_end+eb5fa14/1045ec88>
>>esp; cefb3dd4 <_end+eb5f9fc/1045ec88>

Trace; d09244d5 <[snd-pcm]snd_pcm_update_hw_ptr+145/1f0>
Trace; d091fce6 <[snd-pcm]snd_pcm_action+46/50>
Trace; d0927f2f <[snd-pcm]snd_pcm_lib_write1+3ff/410>
Trace; d09519ae <END_OF_CODE+12067/????>
Trace; d095466f <END_OF_CODE+14d28/????>
Trace; d0927fd0 <[snd-pcm]snd_pcm_lib_write+90/b0>
Trace; d0927a80 <[snd-pcm]snd_pcm_lib_write_transfer+0/b0>
Trace; d094d1a8 <END_OF_CODE+d861/????>
Trace; d0951df7 <END_OF_CODE+124b0/????>
Trace; d094d52f <END_OF_CODE+dbe8/????>
Trace; d094dad2 <END_OF_CODE+e18b/????>
Trace; d094dc29 <END_OF_CODE+e2e2/????>
Trace; d094f07e <END_OF_CODE+f737/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 01                     mov    (%ecx),%eax
Code;  00000002 Before first symbol
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  00000005 Before first symbol
   5:   74 4c                     je     53 <_EIP+0x53>
Code;  00000007 Before first symbol
   7:   31 c0                     xor    %eax,%eax
Code;  00000009 Before first symbol
   9:   9c                        pushf  
Code;  0000000a Before first symbol
   a:   5e                        pop    %esi
Code;  0000000b Before first symbol
   b:   fa                        cli    
Code;  0000000c Before first symbol
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  00000012 Before first symbol
  12:   83 79 00 00               cmpl   $0x0,0x0(%ecx)
"""

kern-2.log.ksymoops:
"""
ksymoops 2.4.9 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map (specified)

Nov 20 19:20:06 ampersand kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000020
Nov 20 19:20:06 ampersand kernel: d09427cc
Nov 20 19:20:06 ampersand kernel: *pde = 00000000
Nov 20 19:20:06 ampersand kernel: Oops: 0000
Nov 20 19:20:06 ampersand kernel: CPU:    0
Nov 20 19:20:06 ampersand kernel: EIP:    0010:[<d09427cc>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 20 19:20:06 ampersand kernel: EFLAGS: 00010206
Nov 20 19:20:06 ampersand kernel: eax: 00000000   ebx: 00000002   ecx: 0000002a   edx: 00000001
Nov 20 19:20:06 ampersand kernel: esi: cf226000   edi: c6b74f60   ebp: 4015d8c0   esp: cbc0dc90
Nov 20 19:20:06 ampersand kernel: ds: 0018   es: 0018   ss: 0018
Nov 20 19:20:06 ampersand kernel: Process modprobe (pid: 17474, stackpage=cbc0d000)
Nov 20 19:20:06 ampersand kernel: Stack: cf226000 00000080 d0945300 00000005 cfa18a00 ca2b2760 00000000 cf226000 
Nov 20 19:20:06 ampersand kernel:        d09424e0 00000000 c13b8800 00000000 00000000 00000000 00000000 00000000 
Nov 20 19:20:06 ampersand kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Nov 20 19:20:06 ampersand kernel: Call Trace:    [<d0945300>] [<d09424e0>] [<d0942bb4>] [<d0941310>] [<d09413b0>]
Nov 20 19:20:06 ampersand kernel:   [<d09424d0>] [<d09455a0>] [<d0943e0a>] [<d0944d10>] [<d0945700>] [pci_announce_device+53/80]
Nov 20 19:20:06 ampersand kernel:   [<d0944d10>] [<d0945700>] [pci_register_driver+72/96] [<d0945700>] [<d0944113>] [<d0945700>]
Nov 20 19:20:06 ampersand kernel: Code: 0f b7 40 20 0f b6 84 86 c8 02 00 00 c0 e0 06 08 c1 eb cc 80 


>>EIP; d09427cc <.data.end+2e85/????>   <=====

>>esi; cf226000 <_end+edd1c28/1045ec88>
>>edi; c6b74f60 <_end+6720b88/1045ec88>
>>esp; cbc0dc90 <_end+b7b98b8/1045ec88>

Trace; d0945300 <.data.end+59b9/????>
Trace; d09424e0 <.data.end+2b99/????>
Trace; d0942bb4 <.data.end+326d/????>
Trace; d0941310 <.data.end+19c9/????>
Trace; d09413b0 <.data.end+1a69/????>
Trace; d09424d0 <.data.end+2b89/????>
Trace; d09455a0 <.data.end+5c59/????>
Trace; d0943e0a <.data.end+44c3/????>
Trace; d0944d10 <.data.end+53c9/????>
Trace; d0945700 <.data.end+5db9/????>
Trace; d0944d10 <.data.end+53c9/????>
Trace; d0945700 <.data.end+5db9/????>

Code;  d09427cc <.data.end+2e85/????>
00000000 <_EIP>:
Code;  d09427cc <.data.end+2e85/????>   <=====
   0:   0f b7 40 20               movzwl 0x20(%eax),%eax   <=====
Code;  d09427d0 <.data.end+2e89/????>
   4:   0f b6 84 86 c8 02 00      movzbl 0x2c8(%esi,%eax,4),%eax
Code;  d09427d7 <.data.end+2e90/????>
   b:   00 
Code;  d09427d8 <.data.end+2e91/????>
   c:   c0 e0 06                  shl    $0x6,%al
Code;  d09427db <.data.end+2e94/????>
   f:   08 c1                     or     %al,%cl
Code;  d09427dd <.data.end+2e96/????>
  11:   eb cc                     jmp    ffffffdf <_EIP+0xffffffdf>
Code;  d09427df <.data.end+2e98/????>
  13:   80 00 00                  addb   $0x0,(%eax)
"""

/proc/pci contains:
"""
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 1).
      IRQ 11.
      I/O at 0xe400 [0xe4ff].
      I/O at 0xe080 [0xe0bf].
      Non-prefetchable 32 bit memory at 0xffa7f800 [0xffa7f9ff].
      Non-prefetchable 32 bit memory at 0xffa7f400 [0xffa7f4ff].
"""

   ---> Drake Wilson


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
