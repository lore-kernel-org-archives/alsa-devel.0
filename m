From: Ludovic Drolez <ludovic.drolez@freealter.com>
Subject: Re: Unable to handle kernel paging request with an SB16Pro
Date: Thu, 14 Aug 2003 21:12:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F3BDF14.60406@freealter.com>
References: <3F39393E.104@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030409050009040208050103"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F39393E.104@free.fr>
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

This is a multi-part message in MIME format.
--------------030409050009040208050103
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is the one during the modprobe:


--------------030409050009040208050103
Content-Type: text/plain;
 name="modprobe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modprobe"

ksymoops 2.4.5 on i586 2.4.21-1-k6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-1-k6/ (default)
     -m /boot/System.map-2.4.21-1-k6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.21-1-k6/kernel/fs/reiserfs/reiserfs.o for module reiserfs has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-1-k6/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-1-k6/kernel/fs/jbd/jbd.o for module jbd has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-1-k6/kernel/fs/ext2/ext2.o for module ext2 has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-1-k6/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-1-k6/kernel/drivers/ide/ide-probe-mod.o for module ide-probe-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-1-k6/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-1-k6/kernel/net/unix/unix.o for module unix has changed since load
Warning (compare_maps): mismatch on symbol __nvsym03120  , NVdriver says cac9b400, /lib/modules/2.4.21-1-k6/kernel/drivers/video/NVdriver says cabc1000.  Ignoring /lib/modules/2.4.21-1-k6/kernel/drivers/video/NVdriver entry
Aug 12 20:35:30 red kernel: Unable to handle kernel paging request at virtual address fffffffc
Aug 12 20:35:30 red kernel: c0115280
Aug 12 20:35:30 red kernel: *pde = 00001063
Aug 12 20:35:30 red kernel: Oops: 0000
Aug 12 20:35:30 red kernel: CPU:    0
Aug 12 20:35:30 red kernel: EIP:    0010:[__wake_up+32/96]    Tainted: P 
Aug 12 20:35:30 red kernel: EFLAGS: 00010003
Aug 12 20:35:30 red kernel: eax: c2fba7c0   ebx: 00000000   ecx: 00000001   edx: 00000003
Aug 12 20:35:30 red kernel: esi: c2fba7c0   edi: 00000003   ebp: c3e33ea8   esp: c3e33e94
Aug 12 20:35:30 red kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 20:35:30 red kernel: Process modprobe (pid: 6238, stackpage=c3e33000)
Aug 12 20:35:30 red kernel: Stack: 00000001 00000286 00000004 00000001 c2fba7d4 c2fba600 cbd44b7f 00000004 
Aug 12 20:35:30 red kernel:        00000001 c2fba7d4 c2fba600 20000000 cbd869e0 cbd874c4 00000004 cbd863f7 
Aug 12 20:35:30 red kernel:        c2fba600 00000004 00000001 cbd86f20 00000001 00000004 0000ffff 0000ffff 
Aug 12 20:35:30 red kernel: Call Trace:    [hci_usb:__insmod_hci_usb_S.data_L216+18763487/12151073] [hci_usb:__insmod_hci_usb_S.data_L216+19033408/11881152] [hci_usb:__insmod_hci_usb_S.data_L216+19036196/11878364] [hci_usb:__insmod_hci_usb_S.data_L216+19031895/11882665] [hci_usb:__insmod_hci_usb_S.data_L216+19034752/11879808]
Aug 12 20:35:30 red kernel: Code: 8b 53 fc 8b 02 85 c7 75 17 8b 1b 39 f3 75 f1 ff 75 f0 9d 8d 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; c2fba7c0 <_end+2d203d4/a572c14>
>>esi; c2fba7c0 <_end+2d203d4/a572c14>
>>ebp; c3e33ea8 <_end+3b99abc/a572c14>
>>esp; c3e33e94 <_end+3b99aa8/a572c14>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx
Code;  00000003 Before first symbol
   3:   8b 02                     mov    (%edx),%eax
Code;  00000005 Before first symbol
   5:   85 c7                     test   %eax,%edi
Code;  00000007 Before first symbol
   7:   75 17                     jne    20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000009 Before first symbol
   9:   8b 1b                     mov    (%ebx),%ebx
Code;  0000000b Before first symbol
   b:   39 f3                     cmp    %esi,%ebx
Code;  0000000d Before first symbol
   d:   75 f1                     jne    0 <_EIP>
Code;  0000000f Before first symbol
   f:   ff 75 f0                  pushl  0xfffffff0(%ebp)
Code;  00000012 Before first symbol
  12:   9d                        popf   
Code;  00000013 Before first symbol
  13:   8d 00                     lea    (%eax),%eax


10 warnings issued.  Results may not be reliable.

--------------030409050009040208050103--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
