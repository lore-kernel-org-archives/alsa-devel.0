From: Ralf Haller <ralf@brap.de>
Subject: alsa probelm with RedHat 8.0 and kernel 2.4.20-4.11.acpi
Date: Sun, 13 Apr 2003 03:47:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E98C1C9.50201@brap.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi everybody,

I installed the kernel 2.4.20 and the lates alsa drivers from planet 
ccrma. When starting the alsa drivers I get the following kernel oops:

[root@Baden root]# cat alsastart.log | ksymoops
ksymoops 2.4.5 on i586 2.4.20-4.ll.acpi.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-4.ll.acpi/ (default)
     -m /boot/System.map-2.4.20-4.ll.acpi (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
/usr/bin/find: /lib/modules/2.4.20-4.ll.acpi/build: Datei oder 
Verzeichnis nicht gefunden
Error (pclose_local): find_objects pclose failed 0x100
Warning (map_ksym_to_module): cannot match loaded module ext3 to a 
unique module object.  Trace may not be reliable.
invalid operand: 0000
CPU:    0
EIP:    0010:[<d093fc11>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 000021b6   ebx: c3627860   ecx: 00000021   edx: d09478e8
esi: 00000000   edi: 00000074   ebp: 00000021   esp: c958bed0
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1109, stackpage=c958b000)
Stack: d093d000 00000000 00000246 c3627860 00000021 d09475d4 d094f80a 
d093d3c8
       d094f80a 00000021 00000000 c975aae0 00000001 00000001 d094c000 
d094f114
       00000021 00000000 00000000 d09510c8 d094f80a ffffffea c011a224 
d094fcc8
Call Trace:    [<d09475d4>] [<d094f80a>] [<d093d3c8>] [<d094f80a>] 
[<d094f114>]
  [<d09510c8>] [<d094f80a>] [<c011a224>] [<d094fcc8>] [<d094c060>] 
[<c0108b0f>]
Code: 0f 44 f0 a1 c8 75 94 d0 c7 44 24 08 00 00 00 00 25 b6 01 00


 >>EIP; d093fc11 <[snd]snd_info_create_device+31/110>   <=====

 >>eax; 000021b6 Before first symbol
 >>ebx; c3627860 <_end+32f1ec0/104d76c0>
 >>edx; d09478e8 <[snd]snd_minors_hash+8/40>
 >>esp; c958bed0 <_end+9256530/104d76c0>

Trace; d09475d4 <[snd]sound_mutex+0/2c>
Trace; d094f80a <[snd-timer]__kstrtab_snd_timer_global_register+2/40>
Trace; d093d3c8 <[snd]snd_register_device+c8/120>
Trace; d094f80a <[snd-timer]__kstrtab_snd_timer_global_register+2/40>
Trace; d094f114 <[snd-timer]alsa_timer_init+a4/110>
Trace; d09510c8 <[snd-timer]snd_timer_reg+0/1c>
Trace; d094f80a <[snd-timer]__kstrtab_snd_timer_global_register+2/40>
Trace; c011a224 <sys_init_module+4c4/60c>
Trace; d094fcc8 <[snd-timer]__kstrtab_snd_timer_system_resolution+420/1758>
Trace; d094c060 <[snd-timer]snd_timer_instance_new+0/c0>
Trace; c0108b0f <system_call+33/38>

Code;  d093fc11 <[snd]snd_info_create_device+31/110>
00000000 <_EIP>:
Code;  d093fc11 <[snd]snd_info_create_device+31/110>   <=====
   0:   0f 44 f0                  cmove  %eax,%esi   <=====
Code;  d093fc14 <[snd]snd_info_create_device+34/110>
   3:   a1 c8 75 94 d0            mov    0xd09475c8,%eax
Code;  d093fc19 <[snd]snd_info_create_device+39/110>
   8:   c7 44 24 08 00 00 00      movl   $0x0,0x8(%esp,1)
Code;  d093fc20 <[snd]snd_info_create_device+40/110>
   f:   00
Code;  d093fc21 <[snd]snd_info_create_device+41/110>
  10:   25 b6 01 00 00            and    $0x1b6,%eax


2 warnings and 3 errors issued.  Results may not be reliable.

The following rpms are installed:

[root@Baden root]# rpm -qa | grep alsa
alsa-driver-0.9.2-4.1.cvs
alsa-kernel-2.4.20-4.ll.acpi-0.9.2-4.1.cvs
alsa-lib-0.9.2-4.cvs
alsa-lib-devel-0.9.2-4.cvs
alsa-utils-0.9.2-4.cvs
alsa-tools-0.9.2-4.cvs

Any ideas what goes wrong here? Everything works great with kernel 
2.4.19 though.

r@l.f



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
