From: jgotts@linuxsavvy.com
Subject: Null pointer dereference with YMF-744 chipset and ALSA 0.9.3a
Date: Fri, 16 May 2003 04:31:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305160831.h4G8V3W06468@ann-arbor.fmfts.com>
Reply-To: jgotts@linuxsavvy.com
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

I can't load the YMF-744 driver with ALSA 0.9.3a on either one of my Sony
laptops (one is a PictureBook and the other is a PCG-F680).  I am running the
standard Red Hat Linux 7.3 2.4.20-13.7 kernel on both.  ALSA 0.9.2 works fine.

Here is the null pointer dereference, which as far as I can tell is the same
for both laptops:

Unable to handle kernel NULL pointer dereference at virtual address 00000019
 printing eip:
d09571b4
*pde = 00000000
Oops: 0002
snd-ymfpci snd-opl3-lib snd-hwdep snd-pcm snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd-page-alloc snd-ac97-codec snd soundcore sonypi nfs lockd su
CPU:    0
EIP:    0010:[<d09571b4>]    Not tainted
EFLAGS: 00010286

EIP is at snd_card_ymfpci_probe [snd-ymfpci] 0x154 (2.4.20-13.7)
eax: cb982400   ebx: 00000800   ecx: c02dd4f4   edx: 00000001
esi: 00000000   edi: 00000001   ebp: c04f4800   esp: c3125eb4
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 16917, stackpage=c3125000)
Stack: d095a79e 08165000 00000001 c7182594 0388f080 d095c0f0 d095c160 c1aefc00
       00000000 c01b78ec c1aefc00 d095c0f0 c1aefc00 d095c160 00000000 00000006
       c01b7952 d095c160 c1aefc00 d0957000 00000006 00000006 d09576ff d095c160
Call Trace:   [<d095a79e>] .rodata.str1.1 [snd-ymfpci] 0x1e (0xc3125eb4))
[<d095c0f0>] snd_ymfpci_ids [snd-ymfpci] 0x70 (0xc3125ec8))
[<d095c160>] driver [snd-ymfpci] 0x0 (0xc3125ecc))
[<c01b78ec>] pci_announce_device [kernel] 0x3c (0xc3125ed8))
[<d095c0f0>] snd_ymfpci_ids [snd-ymfpci] 0x70 (0xc3125ee0))
[<d095c160>] driver [snd-ymfpci] 0x0 (0xc3125ee8))
[<c01b7952>] pci_register_driver [kernel] 0x42 (0xc3125ef4))
[<d095c160>] driver [snd-ymfpci] 0x0 (0xc3125ef8))
[<d09576ff>] init_module [snd-ymfpci] 0xf (0xc3125f0c))
[<d095c160>] driver [snd-ymfpci] 0x0 (0xc3125f10))
[<c01192c5>] sys_init_module [kernel] 0x535 (0xc3125f2c))
[<d095ab14>] .kmodtab [snd-ymfpci] 0x0 (0xc3125f30))
[<d0957060>] snd_card_ymfpci_probe [snd-ymfpci] 0x0 (0xc3125f58))
[<c01088c3>] system_call [kernel] 0x33 (0xc3125fc0))


Code: 89 42 18 74 2a a1 e0 28 96 d0 be 02 00 00 00 0f b7 04 85 40

John

-- 
John GOTTS <jgotts@linuxsavvy.com>  http://linuxsavvy.com/staff/jgotts


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
