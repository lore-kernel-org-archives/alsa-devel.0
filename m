From: Josh Green <jgreen@users.sourceforge.net>
Subject: Oops with snd-ymfpci and ALSA 0.9.3a
Date: 18 May 2003 19:54:21 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053312860.6552.8.camel@SillyPuddy>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4IOCz8oKy46g3hzKjPlb"
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


--=-4IOCz8oKy46g3hzKjPlb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I upgraded to ALSA 0.9.3a from 0.9.2 and am getting a kernel oops upon
insertion of the snd-ymfpci module. I've attached the output from
ksymoops. This is with stock kernel 2.4.20 on a Panasonic laptop and
Mandrake 9.1. I downgraded back to 0.9.2 which works fine. I can provide
more info if needed, cheers.
	Josh Green

--=-4IOCz8oKy46g3hzKjPlb
Content-Disposition: attachment; filename=alsa_oops.txt
Content-Type: text/plain; name=alsa_oops.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

May 17 13:34:52 SillyPuddy kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000029e
May 17 13:34:52 SillyPuddy kernel: cecc7164
May 17 13:34:52 SillyPuddy kernel: *pde = 00000000
May 17 13:34:52 SillyPuddy kernel: Oops: 0002
May 17 13:34:52 SillyPuddy kernel: CPU:    0
May 17 13:34:52 SillyPuddy kernel: EIP:    0010:[usbcore:usb_devfs_handle_Re9c5f87f+1653716/12475604]    Not tainted
May 17 13:34:52 SillyPuddy kernel: EIP:    0010:[<cecc7164>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
May 17 13:34:52 SillyPuddy kernel: EFLAGS: 00010296
May 17 13:34:52 SillyPuddy kernel: eax: c9a67a20   ebx: 00000286   ecx: 00000388   edx: c029d870
May 17 13:34:52 SillyPuddy kernel: esi: 00000800   edi: 00000000   ebp: cb4bee00   esp: c97c1e94
May 17 13:34:52 SillyPuddy kernel: ds: 0018   es: 0018   ss: 0018
May 17 13:34:52 SillyPuddy kernel: Process insmod (pid: 2075, stackpage=c97c1000)
May 17 13:34:52 SillyPuddy kernel: Stack: c029d870 00000388 00000004 ceccab7f 000001d2 c01292b9 00104025 00000001 
May 17 13:34:52 SillyPuddy kernel:        ceccabf4 09720067 00000286 00001000 c11a0388 ceccb250 ceccb2c0 cdf36c00 
May 17 13:34:52 SillyPuddy kernel:        00000000 c01f6165 cdf36c00 ceccb250 cdf36c00 ceccb2c0 00000000 cecc7000 
May 17 13:34:52 SillyPuddy kernel: Call Trace:    [usbcore:usb_devfs_handle_Re9c5f87f+1668591/12460729] [pm_register+73/144] [usbcore:usb_devfs_handle_Re9c5f87f+1668708/12460612] [usbcore:usb_devfs_handle_Re9c5f87f+1670336/12458984] [usbcore:usb_devfs_handle_Re9c5f87f+1670448/12458872]
May 17 13:34:52 SillyPuddy kernel: Call Trace:    [<ceccab7f>] [<c01292b9>] [<ceccabf4>] [<ceccb250>] [<ceccb2c0>]
May 17 13:34:52 SillyPuddy kernel:   [<c01f6165>] [<ceccb250>] [<ceccb2c0>] [<c01f620c>] [<ceccb2c0>] [<cecc7839>]
May 17 13:34:52 SillyPuddy kernel:   [<ceccb2c0>] [<c011ac93>] [<cecc7060>] [<ceccb0dc>] [<cecc7060>] [<c010741f>]
May 17 13:34:52 SillyPuddy kernel: Code: 89 43 18 85 c0 0f 85 21 04 00 00 8b 15 40 1a cd ce 8b 04 95 


>>EIP; cecc7164 <[snd-ymfpci]snd_card_ymfpci_probe+104/750>   <=====

>>eax; c9a67a20 <_end+973d79c/e7f6ddc>
>>edx; c029d870 <init_signals+190/520>
>>ebp; cb4bee00 <_end+b194b7c/e7f6ddc>
>>esp; c97c1e94 <_end+9497c10/e7f6ddc>

Trace; ceccab7f <[snd-ymfpci]__module_parm_index+3/10>
Trace; c01292b9 <pm_register+49/90>
Trace; ceccabf4 <[snd-ymfpci]__module_generic_string_info_parm_id+8/3b>
Trace; ceccb250 <[snd-ymfpci]snd_ymfpci_ids+70/c4>
Trace; ceccb2c0 <[snd-ymfpci]driver+0/40>
Trace; c01f6165 <cdrom_sysctl_info+65/6f0>
Trace; ceccb250 <[snd-ymfpci]snd_ymfpci_ids+70/c4>
Trace; ceccb2c0 <[snd-ymfpci]driver+0/40>
Trace; c01f620c <cdrom_sysctl_info+10c/6f0>
Trace; ceccb2c0 <[snd-ymfpci]driver+0/40>
Trace; cecc7839 <[snd-ymfpci]alsa_card_ymfpci_init+19/60>
Trace; ceccb2c0 <[snd-ymfpci]driver+0/40>
Trace; c011ac93 <get_exec_domain_list+53/80>
Trace; cecc7060 <[snd-ymfpci]snd_card_ymfpci_probe+0/750>
Trace; ceccb0dc <[snd-ymfpci]__module_using_checksums+362/3c6>
Trace; cecc7060 <[snd-ymfpci]snd_card_ymfpci_probe+0/750>
Trace; c010741f <system_call+33/38>

Code;  cecc7164 <[snd-ymfpci]snd_card_ymfpci_probe+104/750>
00000000 <_EIP>:
Code;  cecc7164 <[snd-ymfpci]snd_card_ymfpci_probe+104/750>   <=====
   0:   89 43 18                  mov    %eax,0x18(%ebx)   <=====
Code;  cecc7167 <[snd-ymfpci]snd_card_ymfpci_probe+107/750>
   3:   85 c0                     test   %eax,%eax
Code;  cecc7169 <[snd-ymfpci]snd_card_ymfpci_probe+109/750>
   5:   0f 85 21 04 00 00         jne    42c <_EIP+0x42c>
Code;  cecc716f <[snd-ymfpci]snd_card_ymfpci_probe+10f/750>
   b:   8b 15 40 1a cd ce         mov    0xcecd1a40,%edx
Code;  cecc7175 <[snd-ymfpci]snd_card_ymfpci_probe+115/750>
  11:   8b 04 95 00 00 00 00      mov    0x0(,%edx,4),%eax


--=-4IOCz8oKy46g3hzKjPlb--



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
