From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Oops still present in lastest CVS/nm256
Date: Tue, 25 Nov 2003 12:38:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16323.37811.445520.249624@ronispc.chem.mcgill.ca>
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

I've posted this problem before, and the oops reported below seems to
be the same one.

I just CVS updated and rebuilt in all alsa-* directories.  Aplay
sigseg's and I get an oops.  The first time I tried lead to a hard
lockup.  After rebooting, all I got was the oops.  I'm using the nm256
driver on a Sony Z505S viao notebook with 2.4.22 of the kernel (with
lowlatency and preemptive patches applied).  [The usual kernal driver
works fine and I have it configured to build as a module].

I'm using gcc 3.3.2 and configure with the following flags:

In alsa-lib "--with-debug=no --with-gnu-ld"
In alsa-driver "--with-cards=nm256 --with-sequencer=yes"
In alsa-oss "--disable-alsatest --with-gnu-ld"

Finally, much earlier versions of alsa (say 6 months old) worked in my
setup, at least on earlier versions of the kernel.

Here's what ksymoops gives:

===========================================================================
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
eax: c7395984   ebx: c6d48000   ecx: 00000000   edx: 00000003
esi: c7395984   edi: c67576e0   ebp: c6d49f20   esp: c6d49f00
ds: 0018   es: 0018   ss: 0018
Process aplay (pid: 12161, stackpage=c6d49000)
Stack: c4115aa0 c7395800 c67576e0 c7395988 cc8a91e0 00000001 00000286 00000003 
       c739594c cc8a2805 c67576e0 00000000 00000282 c739595c c739595c c5bd3ae0 
       c7395800 cc8a40bd c7395800 c67576e0 00000000 c5bd3b00 c739595c c67576e0 
Call Trace:    [<cc8a91e0>] [<cc8a2805>] [<cc8a40bd>] [<c0136bc4>] [<c0135827>]
  [<c013588b>] [<c0106d9b>]
Code: 8b 01 85 45 fc 74 6a c7 45 f0 00 00 00 00 9c 5f fa ff 43 04 


>>EIP; c0113b58 <__wake_up+48/ec>   <=====

>>eax; c7395984 <_end+70fd3d4/c582ab0>
>>ebx; c6d48000 <_end+6aafa50/c582ab0>
>>esi; c7395984 <_end+70fd3d4/c582ab0>
>>edi; c67576e0 <_end+64bf130/c582ab0>
>>ebp; c6d49f20 <_end+6ab1970/c582ab0>
>>esp; c6d49f00 <_end+6ab1950/c582ab0>

Trace; cc8a91e0 <[snd]snd_fops+0/60>
Trace; cc8a2805 <[snd]snd_card_file_remove+b5/e0>
Trace; cc8a40bd <[snd]snd_ctl_release+11d/140>
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
============================================================


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
