From: Christian <evil@g-house.de>
Subject: Oops in 2.6.10-rc1
Date: Thu, 28 Oct 2004 15:12:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4180F026.9090302@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

[repost to alsa-devel as suggested by lkml]

hi,

yesterday i was updating to recent 2.6.10-rc1-BK and booting gives:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
dfc10ce0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: snd_ens1371 snd_rawmidi snd_ac97_codec snd_pcm
snd_timer snd soundcore snd_page_alloc rtc
CPU:    0
EIP:    0060:[<dfc10ce0>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10-rc1)
EIP is at 0xdfc10ce0
eax: 00000000   ebx: dff1f800   ecx: dfc10ce0   edx: dff1f9c4
esi: ffffffed   edi: dff1f800   ebp: dff1f800   esp: de613e50
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 186, threadinfo=de612000 task=deb5e5a0)
Stack: c01fc7b8 dff1f800 000007ff dff1f800 c01fc7ef dff1f800 000007ff 
dfc1e400
        e082729d dff1f800 dfc1e400 00000000 e08469cf dfc1e400 000001f8 
000000d0
        c01667f7 de36da8c c0171759 dffe79e0 dfc1e400 ffffffed dff1f800 
dff1f800
Call Trace:
  [<c01fc7b8>] pci_enable_device_bars+0x28/0x40
  [<c01fc7ef>] pci_enable_device+0x1f/0x40
  [<e082729d>] snd_ensoniq_create+0x1d/0x480 [snd_ens1371]
  [<e08469cf>] snd_card_new+0x1cf/0x2c0 [snd]
  [<c01667f7>] __lookup_hash+0xa7/0xe0
  [<c0171759>] alloc_inode+0x129/0x150
  [<e0827867>] snd_audiopci_probe+0x87/0x1e0 [snd_ens1371]
  [<c016f6c2>] dput+0x92/0x250
  [<c01fd202>] pci_device_probe_static+0x52/0x70
  [<c01fd24c>] __pci_device_probe+0x2c/0x30
  [<c01fd27c>] pci_device_probe+0x2c/0x60
  [<c025adff>] bus_match+0x3f/0x80
  [<c025af52>] driver_attach+0x52/0xa0
  [<c025b478>] bus_add_driver+0x98/0xe0
  [<c025ba8f>] driver_register+0x2f/0x40
  [<c01fd530>] pci_register_driver+0x40/0x50
  [<e08279cf>] alsa_card_ens137x_init+0xf/0x13 [snd_ens1371]
  [<c01341ba>] sys_init_module+0x18a/0x270
  [<c01041fb>] syscall_call+0x7/0xb
Code: 5f 64 65 76 38 62 00 00 00 00 00 00 00 00 00 02 00 00 00 88 0c c1 df
08 0d c1 df 10 fa 3a c0 00 fa 3a c0 00 00 00 00 6c 5a c1 df <0a> 00 00 00
36 46 37 46 00 00 00 00 f0 0c c1 df 69 6e 74 31 33

full dmesg output here:
www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg.txt

updating to an even more recent (read: updated now) does not help and 
the problem is really triggered when loading snd_ens1371. well, the only
"problem" is the oops and i have no sound :-(

just strange that nobody else cries out loud. or am i just lacking 
enough information? ok, this is debian/unstable (i386), gcc3.4.2, 
libc2.3.2, pls tell me if you need more information.

thank you,
Christian.
-- 
BOFH excuse #374:

It's the InterNIC's fault.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
