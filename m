From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Oops in latest CVS on Sony Viao Notebook (nm236)
Date: Fri, 7 Nov 2003 15:45:50 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16300.1150.898901.137926@ronispc.chem.mcgill.ca>
Reply-To: david.ronis@mcgill.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


I've reported this before and the latest CVS still has the problem.
I'm running linux-2.4.22 on a sony Z505S laptop.  Alsa used to run
(CVS versions) on earlier versions of the kernel (at least up to
2.4.19), but hasn't worked on the latest.  I have both the preemptive
and lowlatency patches installed.


Usually what happens is I lock up, but occasionally I get to see an
oops on the screen, and even more infrequenty, am still running.  This
happened yesterday.  I did a build/install of the current CVS and then
ran aplay. Here's what ksymoops reports:

ksymoops 2.4.9 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol IO_APIC_get_PCI_irq_vector_R__ver_IO_APIC_get_PCI_irq_vector not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0113b58
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0113b58>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: cbf49d84   ebx: c7792000   ecx: 00000000   edx: 00000003
esi: cbf49d84   edi: c337b0e0   ebp: c7793f20   esp: c7793f00
ds: 0018   es: 0018   ss: 0018
Process aplay (pid: 7898, stackpage=c7793000)
Stack: c5707a00 cbf49c00 c337b0e0 cbf49d88 cc8b61e0 00000001 00000286 00000003 
       cbf49d4c cc8af805 c337b0e0 00000000 00000286 cbf49d5c cbf49d5c c4fef3a0 
       cbf49c00 cc8b10bd cbf49c00 c337b0e0 00000000 c4fef3c0 cbf49d5c c337b0e0 
Call Trace:    [<cc8b61e0>] [<cc8af805>] [<cc8b10bd>] [<c0136bc4>] [<c0135827>]
  [<c013588b>] [<c0106d9b>]
Code: 8b 01 85 45 fc 74 6a c7 45 f0 00 00 00 00 9c 5f fa ff 43 04 


>>EIP; c0113b58 <__wake_up+48/ec>   <=====

>>eax; cbf49d84 <_end+bcb17d4/c582ab0>
>>ebx; c7792000 <_end+74f9a50/c582ab0>
>>esi; cbf49d84 <_end+bcb17d4/c582ab0>
>>edi; c337b0e0 <_end+30e2b30/c582ab0>
>>ebp; c7793f20 <_end+74fb970/c582ab0>
>>esp; c7793f00 <_end+74fb950/c582ab0>

Trace; cc8b61e0 <[snd]snd_fops+0/60>
Trace; cc8af805 <[snd]snd_card_file_remove+b5/e0>
Trace; cc8b10bd <[snd]snd_ctl_release+11d/140>
Trace; c0136bc4 <fput+4c/f8>
Trace; c0135827 <filp_close+93/a0>
Trace; c013588b <sys_close+57/7c>
Trace; c0106d9b <system_call+33/38>

Code;  c0113b58 <__wake_up+48/ec>
00000000 <_EIP>:
Code;  c0113b58 <__wake_up+48/ec>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0113b5a <__wake_up+4a/ec>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0113b5d <__wake_up+4d/ec>
   5:   74 6a                     je     71 <_EIP+0x71>
Code;  c0113b5f <__wake_up+4f/ec>
   7:   c7 45 f0 00 00 00 00      movl   $0x0,0xfffffff0(%ebp)
Code;  c0113b66 <__wake_up+56/ec>
   e:   9c                        pushf  
Code;  c0113b67 <__wake_up+57/ec>
   f:   5f                        pop    %edi
Code;  c0113b68 <__wake_up+58/ec>
  10:   fa                        cli    
Code;  c0113b69 <__wake_up+59/ec>
  11:   ff 43 04                  incl   0x4(%ebx)


2 warnings issued.  Results may not be reliable.

--------------------------------------------------------------------------
Here's how my kernel's sound section is configured:

CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_NM256=m

everything else is not set.

David


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
