From: "thewade" <pdman@aproximation.org>
Subject: hsdploader and hdspmixer errors on AMD x86-64
Date: Fri, 10 Sep 2004 09:09:20 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409101509.i8AF9KXB002740@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

Firstly, thank you for makeing audio on linux a reality!

I have a new AMD 64 laptop with a hammerfall multiface and cardbus. I 
am also running Fedora Core 3 test 1 and the standard 2.6.8.1 kernel.

When I boot the kernel doesnt tell me that my multiface is connected, 
whereas on my old laptop running FC2t1 and 2.6.4 I believe the kernel 
tells me that it is connected.

In both cases the kernel reports its waiting for firmware. On the 
AMD64 when I run hdsploader I get kernel Ooops and a whole bunch of 
address stuff that I dont understand. On the old laptop everything 
works fine.
0 [SI7012         ]: ICH - SiS SI7012
                     SiS SI7012 at 0xe800, irq 18
1 [DSP            ]: H-DSP - Hammerfall DSP
                     RME Hammerfall DSP at 0x40800000, irq 17

hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : SiS SI7012 at 0xe800, irq 18
Card 1 : RME Hammerfall DSP at 0x40800000, irq 17
Upload firmware for card hw:1
Killed

Sep 10 09:05:34 musicbox kernel: wait for FIFO status <= 0 failed after 30 iterations
Sep 10 09:05:35 musicbox kernel: initializing firmware upload
Sep 10 09:05:35 musicbox kernel: Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
Sep 10 09:05:35 musicbox kernel: <ffffffff802c8b92>{snd_hdsp_load_firmware_from_cache+18}
Sep 10 09:05:35 musicbox kernel: PML4 34472067 PGD 34b62067 PMD 0 
Sep 10 09:05:35 musicbox kernel: Oops: 0000 [1] 
Sep 10 09:05:35 musicbox kernel: CPU 0 
Sep 10 09:05:35 musicbox kernel: Modules linked in: ipw2200 ieee80211 ipv6 autofs4 ds yenta_socket pcmcia_core ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables sg scsi_mod ohci1394 ieee1394 dm_mod joydev ohci_hcd ehci_hcd button battery asus_acpi ac ext3 jbd
Sep 10 09:05:35 musicbox kernel: Pid: 3406, comm: hdsploader Not tainted 2.6.8.1-2
Sep 10 09:05:35 musicbox kernel: RIP: 0010:[<ffffffff802c8b92>] <ffffffff802c8b92>{snd_hdsp_load_firmware_from_cache+18}
Sep 10 09:05:35 musicbox kernel: RSP: 0018:0000010034489db8  EFLAGS: 00010206
Sep 10 09:05:35 musicbox kernel: RAX: 0000000000000000 RBX: 0000010034488000 RCX: 00000000fffffff2
Sep 10 09:05:35 musicbox kernel: RDX: 0000000000000000 RSI: 00000000005310a8 RDI: 000001003c7e02b8
Sep 10 09:05:35 musicbox kernel: RBP: 000001003c7e02b8 R08: 0000000000000000 R09: 0000000000000000
Sep 10 09:05:35 musicbox kernel: R10: 0000000000000281 R11: 0000000000000246 R12: 000001003c7e02b8
Sep 10 09:05:35 musicbox kernel: R13: 0000000000000003 R14: 0000007fbffff438 R15: 0000000000000000
Sep 10 09:05:35 musicbox kernel: FS:  0000002a9556bec0(0000) GS:ffffffff8045c240(0000) knlGS:0000000000000000
Sep 10 09:05:35 musicbox kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Sep 10 09:05:35 musicbox kernel: CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
Sep 10 09:05:35 musicbox kernel: Process hdsploader (pid: 3406, threadinfo 0000010034488000, task 00000100386bb750)
Sep 10 09:05:35 musicbox kernel: Stack: ffffffff801d4d14 0000000000000010 0
000010034488000 0000010037ebda00 
Sep 10 09:05:35 musicbox kernel:        000001003c7e02b8 ffffffff802cbbcd 0000000000000000 0000000000000000 
Sep 10 09:05:35 musicbox kernel:        0000000000000000 0000000000000000 
Sep 10 09:05:35 musicbox kernel: Call Trace:<ffffffff801d4d14>{copy_user_generic_c+8} <ffffffff802cbbcd>{snd_hdsp_hwdep_ioctl+3373} 
Sep 10 09:05:35 musicbox kernel:        <ffffffff8015b041>{unmap_vmas+1185} <ffffffff802a510e>{snd_hwdep_ioctl+478} 
Sep 10 09:05:35 musicbox kernel:        <ffffffff8015e718>{do_munmap+936} <ffffffff8017b58f>{sys_ioctl+895} 
Sep 10 09:05:35 musicbox kernel:        <ffffffff8015f275>{sys_munmap+85} <ffffffff80110242>{system_call+126} 
Sep 10 09:05:35 musicbox kernel:        
Sep 10 09:05:35 musicbox kernel: 
Sep 10 09:05:35 musicbox kernel: Code: 8b 00 a9 00 00 20 00 0f 84 8b 01 00 00 48 c7 c7 6b 93 37 80 
Sep 10 09:05:35 musicbox kernel: RIP <ffffffff802c8b92>{snd_hdsp_load_firmware_from_cache+18} RSP <0000010034489db8>
Sep 10 09:05:35 musicbox kernel: CR2: 0000000000000000


hdspmixer wont build because of fltk, even though fltk-config (I built 
fltk, not from rpm) says its installed. It compiles but doesnt link...
Lots of this:
HDSPMixerMeter.o(.gnu.linkonce.t._ZN14HDSPMixerMeterD0Ev+0xc): In function `HDSPMixerMeter::~HDSPMixerMeter()\':
/home/wade/alsa-tools-1.0.6/hdspmixer/src/HDSPMixerMeter.cxx:194: undefined reference to `Fl_Widget::~Fl_Widget()\'

Can anyone help me to get this running?

-kernel doesnt find multiface
-hdsploader causes kernel Ooops on 64 bit arch
-hdspmixer wont build because of -fltk error


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
