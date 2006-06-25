From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002226]: Intel 82801G / ASUSTeK 1153 -
	driver snd_hda_loads but no sound and freeze when doing
	alsasound restart
Date: Sun, 25 Jun 2006 16:42:21 +0200
Message-ID: <e3985810230d1c7e1609c9a50016a8a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0D2221D
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jun 2006 16:42:21 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2226> 
======================================================================
Reported By:                bgrieder
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2226
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2133_FC5smp #1 SMP
======================================================================
Date Submitted:             06-23-2006 07:58 CEST
Last Modified:              06-25-2006 16:42 CEST
======================================================================
Summary:                    Intel 82801G / ASUSTeK 1153 - driver snd_hda_loads
but no sound and freeze when doing alsasound restart
Description: 
Hi,

I upgraded to alsa-driver 1.0.11 but to no avail.

My card is running on an ASUS A8JM laptop
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Aud io Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device 1153
        Flags: bus master, fast devsel, latency 0, IRQ 23
        Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable -
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)


Th driver was compiled with debug flags; a modprobe snd_hda_intel produces
the following entry in /var/log/messages
Jun 23 07:55:15 asusbg kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI
21 (level, low) -> IRQ 23
Jun 23 07:55:15 asusbg kernel: ALSA
/tmp/alsa-driver-1.0.11/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:654:
codec_mask = 0x3
Jun 23 07:55:17 asusbg kernel: ALSA
/tmp/alsa-driver-1.0.11/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:516:
hda_intel: azx_get_response timeout, switching to single_cmd mode..

Issuing /etc/init.d/alsasound restart will freeze the machine.
No signififcant entry in /var/log/messages

Let me know if you need additional details
Many Thanks and Best Regards


======================================================================

----------------------------------------------------------------------
 bgrieder - 06-25-06 16:11 
----------------------------------------------------------------------
Upgraded to kernel 2.6.17-1.2139_FC5smp.
After having recompiled and installed alsa-driver and alsa-libs 1.0.11
Still no sound and
issuing /etc/init.d/alsasound stop  generated the following kernel dump

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: ------------[ cut here ]------------

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: kernel BUG at include/linux/list.h:58!
Jun 25 16:06:25 asusbg kernel: List corruption. next->prev should be
f76d2e48, but was f7323b3c
Jun 25 16:06:25 asusbg kernel: ------------[ cut here ]------------
Jun 25 16:06:25 asusbg kernel: kernel BUG at include/linux/list.h:58!

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: invalid opcode: 0000 [#1]

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: SMP

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: CPU:    0

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: EIP is at snd_seq_delete_all_ports+0x57/0x167 [snd_seq]

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: eax: 00000044   ebx: f76d2e48   ecx: c06d48b0   edx:
00000092

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: esi: f76d2e48   edi: f7323b3c   ebp: f7323ac0   esp:
e5e17ef8

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: ds: 007b   es: 007b   ss: 0068

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: Process rmmod (pid: 3928, threadinfo=e5e17000
task=e5a06610)

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: Stack: f89fb9fd f76d2e48 f7323b3c f7323b54 f7323b44
00000286 22222222 22222222

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel:        f7323ac0 00000020 00000000 e5e17000 f89f5236
f7323ac0 f89f530a f8965448

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel:        c06d6600 c0616447 e5e17f9c c043e996 f7323ac0
f89f77c3 f8a31600 f8a29a2c

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: Call Trace:

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel:  <f89f5236> seq_free_client1+0x8/0x90 [snd_seq]  <f89f530a>
seq_free_client+0x4c/0x98 [snd_seq]

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel:  <f8965448> snd_seq_device_unregister_driver+0xcc/0xd5
[snd_seq_device]  <c0616447> __mutex_unlock_slowpath+0x1e5/0x1ec

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel:  <c043e996> __try_stop_module+0x0/0x44  <f89f77c3>
snd_seq_delete_kernel_client+0x1a/0x2c [snd_seq]

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel:  <f8a29a2c> snd_seq_oss_delete_client+0xe/0x16
[snd_seq_oss]  <f8a2ceaf> alsa_seq_oss_exit+0xf/0x19 [snd_seq_oss]

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel:  <c043eba7> sys_delete_module+0x192/0x1bb  <c045c044>
do_munmap+0x196/0x1af

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel:  <c0403dd5> sysenter_past_esp+0x56/0x79

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: Code: 24 14 39 7d 7c 74 67 8b 5d 7c 8b b5 80 00 00 00 8b 43
04 39 f0 74 1c 89 74 24 04 89 44 24 08 c7 04 24 fd b9 9f f8 e8 ed b4 a2 c7
<0f> 0b 3a 00 e8 b9 9f f8 8b 06 39 d8 74 1c 89 5c 24 04 89 44 24

Message from syslogd@asusbg at Sun Jun 25 16:06:25 2006 ...
asusbg kernel: EIP: [<f89fa5d5>] snd_seq_delete_all_ports+0x57/0x167
[snd_seq] SS:ESP 0068:e5e17ef8
Jun 25 16:06:25 asusbg kernel: invalid opcode: 0000 [#1]
Jun 25 16:06:25 asusbg kernel: SMP
Jun 25 16:06:25 asusbg kernel: last sysfs file:
/devices/pci0000:00/0000:00:1c.0/0000:02:00.0/cmd
Jun 25 16:06:25 asusbg kernel: Modules linked in: autofs4 hidp rfcomm
l2cap sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack
nfnetlink xt_tcpudp iptable_filter ip_tables x_tables nls_utf8 ntfs(U)
dm_mirror dm_mod video button battery asus_acpi ac ipv6 lp parport_pc
parport hci_usb bluetooth snd_seq_oss(U) snd_seq_midi_event(U) ohci1394
snd_seq(U) ieee1394 sdhci mmc_core snd_seq_device(U) nvidia(U) joydev
ehci_hcd snd_pcm_oss(U) snd_mixer_oss(U) i2c_core uhci_hcd snd_pcm(U)
ipw3945(U) snd_timer(U) ieee80211(U) ieee80211_crypt(U) r1000(U) snd(U)
soundcore snd_page_alloc(U) ext3 jbd
Jun 25 16:06:25 asusbg kernel: CPU:    0
Jun 25 16:06:25 asusbg kernel: EIP:    0060:[<f89fa5d5>]    Tainted: PF   
 VLI
Jun 25 16:06:25 asusbg kernel: EFLAGS: 00010096   (2.6.17-1.2139_FC5smp
#1)
Jun 25 16:06:25 asusbg kernel: EIP is at
snd_seq_delete_all_ports+0x57/0x167 [snd_seq]
Jun 25 16:06:25 asusbg kernel: eax: 00000044   ebx: f76d2e48   ecx:
c06d48b0   edx: 00000092
Jun 25 16:06:25 asusbg kernel: esi: f76d2e48   edi: f7323b3c   ebp:
f7323ac0   esp: e5e17ef8
Jun 25 16:06:25 asusbg kernel: ds: 007b   es: 007b   ss: 0068
Jun 25 16:06:25 asusbg kernel: Process rmmod (pid: 3928,
threadinfo=e5e17000 task=e5a06610)
Jun 25 16:06:25 asusbg kernel: Stack: f89fb9fd f76d2e48 f7323b3c f7323b54
f7323b44 00000286 22222222 22222222
Jun 25 16:06:25 asusbg kernel:        f7323ac0 00000020 00000000 e5e17000
f89f5236 f7323ac0 f89f530a f8965448
Jun 25 16:06:25 asusbg kernel:        c06d6600 c0616447 e5e17f9c c043e996
f7323ac0 f89f77c3 f8a31600 f8a29a2c
Jun 25 16:06:25 asusbg kernel: Call Trace:
Jun 25 16:06:25 asusbg kernel:  <f89f5236> seq_free_client1+0x8/0x90
[snd_seq]  <f89f530a> seq_free_client+0x4c/0x98 [snd_seq]
Jun 25 16:06:25 asusbg kernel:  <f8965448>
snd_seq_device_unregister_driver+0xcc/0xd5 [snd_seq_device]  <c0616447>
__mutex_unlock_slowpath+0x1e5/0x1ec
Jun 25 16:06:25 asusbg kernel:  <c043e996> __try_stop_module+0x0/0x44 
<f89f77c3> snd_seq_delete_kernel_client+0x1a/0x2c [snd_seq]
Jun 25 16:06:25 asusbg kernel:  <f8a29a2c>
snd_seq_oss_delete_client+0xe/0x16 [snd_seq_oss]  <f8a2ceaf>
alsa_seq_oss_exit+0xf/0x19 [snd_seq_oss]
Jun 25 16:06:25 asusbg kernel:  <c043eba7> sys_delete_module+0x192/0x1bb 
<c045c044> do_munmap+0x196/0x1af
Jun 25 16:06:25 asusbg kernel:  <c0403dd5> sysenter_past_esp+0x56/0x79
Jun 25 16:06:25 asusbg kernel: Code: 24 14 39 7d 7c 74 67 8b 5d 7c 8b b5
80 00 00 00 8b 43 04 39 f0 74 1c 89 74 24 04 89 44 24 08 c7 04 24 fd b9 9f
f8 e8 ed b4 a2 c7 <0f> 0b 3a 00 e8 b9 9f f8 8b 06 39 d8 74 1c 89 5c 24 04
89 44 24
Jun 25 16:06:25 asusbg kernel: EIP: [<f89fa5d5>]
snd_seq_delete_all_ports+0x57/0x167 [snd_seq] SS:ESP 0068:e5e17ef8
Jun 25 16:06:25 asusbg kernel:  <3>BUG: sleeping function called from
invalid context at include/linux/rwsem.h:43
Jun 25 16:06:25 asusbg kernel: in_atomic():0, irqs_disabled():1
Jun 25 16:06:25 asusbg kernel:  <c0430972>
blocking_notifier_call_chain+0x18/0x4b  <c0427d45> do_exit+0x19/0x795
Jun 25 16:06:25 asusbg kernel:  <c053b868> do_unblank_screen+0x2a/0x127 
<c04054cb> die+0x2a5/0x2ca
Jun 25 16:06:25 asusbg kernel:  <c0405b58> do_invalid_op+0x0/0xab 
<c0405bfa> do_invalid_op+0xa2/0xab
Jun 25 16:06:25 asusbg kernel:  <f89fa5d5>
snd_seq_delete_all_ports+0x57/0x167 [snd_seq]  <c0614f64>
schedule+0xb00/0xb69
Jun 25 16:06:25 asusbg kernel:  <c0617167> _spin_lock_irqsave+0x9/0xd 
<c0439aef> debug_mutex_add_waiter+0x97/0xa9
Jun 25 16:06:25 asusbg kernel:  <f89fa599>
snd_seq_delete_all_ports+0x1b/0x167 [snd_seq]  <c04049d7>
error_code+0x4f/0x54
Jun 25 16:06:25 asusbg kernel:  <f89fa5d5>
snd_seq_delete_all_ports+0x57/0x167 [snd_seq]  <f89f5236>
seq_free_client1+0x8/0x90 [snd_seq]
Jun 25 16:06:25 asusbg kernel:  <f89f530a> seq_free_client+0x4c/0x98
[snd_seq]  <f8965448> snd_seq_device_unregister_driver+0xcc/0xd5
[snd_seq_device]
Jun 25 16:06:25 asusbg kernel:  <c0616447>
__mutex_unlock_slowpath+0x1e5/0x1ec  <c043e996>
__try_stop_module+0x0/0x44
Jun 25 16:06:25 asusbg kernel:  <f89f77c3>
snd_seq_delete_kernel_client+0x1a/0x2c [snd_seq]  <f8a29a2c>
snd_seq_oss_delete_client+0xe/0x16 [snd_seq_oss]
Jun 25 16:06:25 asusbg kernel:  <f8a2ceaf> alsa_seq_oss_exit+0xf/0x19
[snd_seq_oss]  <c043eba7> sys_delete_module+0x192/0x1bb
Jun 25 16:06:25 asusbg kernel:  <c045c044> do_munmap+0x196/0x1af 
<c0403dd5> sysenter_past_esp+0x56/0x79
Jun 25 16:06:25 asusbg kernel: BUG: rmmod/3928, lock held at task exit
time!
Jun 25 16:06:25 asusbg kernel:  [f8a02340] {register_mutex}
Jun 25 16:06:25 asusbg kernel: .. held by:             rmmod: 3928
[e5a06610, 125]
Jun 25 16:06:25 asusbg kernel: ... acquired at:              
seq_free_client+0x10/0x98 [snd_seq]

----------------------------------------------------------------------
 bgrieder - 06-25-06 16:42 
----------------------------------------------------------------------
1.0.12RC1 also dumps

asusbg kernel: ------------[ cut here ]------------

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: kernel BUG at include/linux/list.h:58!

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: invalid opcode: 0000 [#1]

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: SMP

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: CPU:    1

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: EIP is at snd_seq_delete_all_ports+0x57/0x167 [snd_seq]

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: eax: 00000044   ebx: f76c1a48   ecx: c06d48b0   edx:
00200092

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: esi: f76c1a48   edi: f70d0b3c   ebp: f70d0ac0   esp:
e6c67ef8

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: ds: 007b   es: 007b   ss: 0068

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: Process rmmod (pid: 2950, threadinfo=e6c67000
task=f7e8c430)

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: Stack: f897f790 f76c1a48 f70d0b3c f70d0b54 f70d0b44
00200286 22222222 22222222

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel:        f70d0ac0 00000020 00000000 e6c67000 f8979236
f70d0ac0 f897930a f887b448

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel:        c06d6600 c0616447 e6c67f9c c043e996 f70d0ac0
f897b7c3 f89bb600 f89b3a2c

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: Call Trace:

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel:  <f8979236> seq_free_client1+0x8/0x90 [snd_seq]  <f897930a>
seq_free_client+0x4c/0x98 [snd_seq]

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel:  <f887b448> snd_seq_device_unregister_driver+0xcc/0xd5
[snd_seq_device]  <c0616447> __mutex_unlock_slowpath+0x1e5/0x1ec

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel:  <c043e996> __try_stop_module+0x0/0x44  <f897b7c3>
snd_seq_delete_kernel_client+0x1a/0x2c [snd_seq]

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel:  <f89b3a2c> snd_seq_oss_delete_client+0xe/0x16
[snd_seq_oss]  <f89b6eaf> alsa_seq_oss_exit+0xf/0x19 [snd_seq_oss]

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel:  <c043eba7> sys_delete_module+0x192/0x1bb  <c045c044>
do_munmap+0x196/0x1af

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel:  <c0403dd5> sysenter_past_esp+0x56/0x79

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: Code: 24 14 39 7d 7c 74 67 8b 5d 7c 8b b5 80 00 00 00 8b 43
04 39 f0 74 1c 89 74 24 04 89 44 24 08 c7 04 24 90 f7 97 f8 e8 34 75 aa c7
<0f> 0b 3a 00 7b f7 97 f8 8b 06 39 d8 74 1c 89 5c 24 04 89 44 24

Message from syslogd@asusbg at Sun Jun 25 16:40:39 2006 ...
asusbg kernel: EIP: [<f897e58e>] snd_seq_delete_all_ports+0x57/0x167
[snd_seq] SS:ESP 0068:e6c67ef8
Jun 25 16:40:39 asusbg kernel: List corruption. next->prev should be
f76c1a48, but was f70d0b3c
Jun 25 16:40:39 asusbg kernel: ------------[ cut here ]------------
Jun 25 16:40:39 asusbg kernel: kernel BUG at include/linux/list.h:58!
Jun 25 16:40:39 asusbg kernel: invalid opcode: 0000 [#1]
Jun 25 16:40:39 asusbg kernel: SMP
Jun 25 16:40:39 asusbg kernel: last sysfs file:
/devices/pci0000:00/0000:00:1c.0/0000:02:00.0/cmd
Jun 25 16:40:39 asusbg kernel: Modules linked in: autofs4 hidp rfcomm
l2cap sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack
nfnetlink xt_tcpudp iptable_filter ip_tables x_tables nls_utf8 ntfs(U)
dm_mirror dm_mod video button battery asus_acpi ac ipv6 lp parport_pc
parport hci_usb bluetooth ohci1394 ieee1394 snd_seq_oss(U) sdhci mmc_core
ipw3945(U) snd_seq_midi_event(U) snd_seq(U) joydev nvidia(U)
snd_seq_device(U) r1000(U) ehci_hcd snd_pcm_oss(U) snd_mixer_oss(U)
i2c_core snd_pcm(U) ieee80211(U) ieee80211_crypt(U) uhci_hcd snd_timer(U)
snd(U) soundcore snd_page_alloc(U) ext3 jbd
Jun 25 16:40:39 asusbg kernel: CPU:    1
Jun 25 16:40:39 asusbg kernel: EIP:    0060:[<f897e58e>]    Tainted: PF   
 VLI
Jun 25 16:40:39 asusbg kernel: EFLAGS: 00210096   (2.6.17-1.2139_FC5smp
#1)
Jun 25 16:40:39 asusbg kernel: EIP is at
snd_seq_delete_all_ports+0x57/0x167 [snd_seq]
Jun 25 16:40:39 asusbg kernel: eax: 00000044   ebx: f76c1a48   ecx:
c06d48b0   edx: 00200092
Jun 25 16:40:39 asusbg kernel: esi: f76c1a48   edi: f70d0b3c   ebp:
f70d0ac0   esp: e6c67ef8
Jun 25 16:40:39 asusbg kernel: ds: 007b   es: 007b   ss: 0068
Jun 25 16:40:39 asusbg kernel: Process rmmod (pid: 2950,
threadinfo=e6c67000 task=f7e8c430)
Jun 25 16:40:39 asusbg kernel: Stack: f897f790 f76c1a48 f70d0b3c f70d0b54
f70d0b44 00200286 22222222 22222222
Jun 25 16:40:39 asusbg kernel:        f70d0ac0 00000020 00000000 e6c67000
f8979236 f70d0ac0 f897930a f887b448
Jun 25 16:40:39 asusbg kernel:        c06d6600 c0616447 e6c67f9c c043e996
f70d0ac0 f897b7c3 f89bb600 f89b3a2c
Jun 25 16:40:39 asusbg kernel: Call Trace:
Jun 25 16:40:39 asusbg kernel:  <f8979236> seq_free_client1+0x8/0x90
[snd_seq]  <f897930a> seq_free_client+0x4c/0x98 [snd_seq]
Jun 25 16:40:39 asusbg kernel:  <f887b448>
snd_seq_device_unregister_driver+0xcc/0xd5 [snd_seq_device]  <c0616447>
__mutex_unlock_slowpath+0x1e5/0x1ecJun 25 16:40:39 asusbg kernel: 
<c043e996> __try_stop_module+0x0/0x44  <f897b7c3>
snd_seq_delete_kernel_client+0x1a/0x2c [snd_seq]
Jun 25 16:40:39 asusbg kernel:  <f89b3a2c>
snd_seq_oss_delete_client+0xe/0x16 [snd_seq_oss]  <f89b6eaf>
alsa_seq_oss_exit+0xf/0x19 [snd_seq_oss]
Jun 25 16:40:39 asusbg kernel:  <c043eba7> sys_delete_module+0x192/0x1bb 
<c045c044> do_munmap+0x196/0x1af
Jun 25 16:40:39 asusbg kernel:  <c0403dd5> sysenter_past_esp+0x56/0x79
Jun 25 16:40:39 asusbg kernel: Code: 24 14 39 7d 7c 74 67 8b 5d 7c 8b b5
80 00 00 00 8b 43 04 39 f0 74 1c 89 74 24 04 89 44 24 08 c7 04 24 90 f7 97
f8 e8 34 75 aa c7 <0f> 0b 3a 00 7b f7 97 f8 8b 06 39 d8 74 1c 89 5c 24 04
89 44 24
Jun 25 16:40:39 asusbg kernel: EIP: [<f897e58e>]
snd_seq_delete_all_ports+0x57/0x167 [snd_seq] SS:ESP 0068:e6c67ef8
Jun 25 16:40:39 asusbg kernel:  <3>BUG: sleeping function called from
invalid context at include/linux/rwsem.h:43
Jun 25 16:40:39 asusbg kernel: in_atomic():0, irqs_disabled():1
Jun 25 16:40:39 asusbg kernel:  <c0430972>
blocking_notifier_call_chain+0x18/0x4b  <c0427d45> do_exit+0x19/0x795
Jun 25 16:40:39 asusbg kernel:  <c053b868> do_unblank_screen+0x2a/0x127 
<c04054cb> die+0x2a5/0x2ca
Jun 25 16:40:39 asusbg kernel:  <c0405b58> do_invalid_op+0x0/0xab 
<c0405bfa> do_invalid_op+0xa2/0xab
Jun 25 16:40:39 asusbg kernel:  <f897e58e>
snd_seq_delete_all_ports+0x57/0x167 [snd_seq]  <c0614f64>
schedule+0xb00/0xb69
Jun 25 16:40:39 asusbg kernel:  <c0446671> do_stop+0x0/0x124  <c0439aef>
debug_mutex_add_waiter+0x97/0xa9
Jun 25 16:40:39 asusbg kernel:  <f897e552>
snd_seq_delete_all_ports+0x1b/0x167 [snd_seq]  <c04049d7>
error_code+0x4f/0x54
Jun 25 16:40:39 asusbg kernel:  <f897e58e>
snd_seq_delete_all_ports+0x57/0x167 [snd_seq]  <f8979236>
seq_free_client1+0x8/0x90 [snd_seq]
Jun 25 16:40:39 asusbg kernel:  <f897930a> seq_free_client+0x4c/0x98
[snd_seq]  <f887b448> snd_seq_device_unregister_driver+0xcc/0xd5
[snd_seq_device]Jun 25 16:40:39 asusbg kernel:  <c0616447>
__mutex_unlock_slowpath+0x1e5/0x1ec  <c043e996>
__try_stop_module+0x0/0x44
Jun 25 16:40:39 asusbg kernel:  <f897b7c3>
snd_seq_delete_kernel_client+0x1a/0x2c [snd_seq]  <f89b3a2c>
snd_seq_oss_delete_client+0xe/0x16 [snd_seq_oss]
Jun 25 16:40:39 asusbg kernel:  <f89b6eaf> alsa_seq_oss_exit+0xf/0x19
[snd_seq_oss]  <c043eba7> sys_delete_module+0x192/0x1bb
Jun 25 16:40:39 asusbg kernel:  <c045c044> do_munmap+0x196/0x1af 
<c0403dd5> sysenter_past_esp+0x56/0x79
Jun 25 16:40:39 asusbg kernel: BUG: rmmod/2950, lock held at task exit
time!
Jun 25 16:40:39 asusbg kernel:  [f8986300] {register_mutex}
Jun 25 16:40:39 asusbg kernel: .. held by:             rmmod: 2950
[f7e8c430, 125]
Jun 25 16:40:39 asusbg kernel: ... acquired at:              
seq_free_client+0x10/0x98 [snd_seq]
Jun 25 16:41:01 asusbg ntpd[2175]: kernel time sync enabled 0001

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-23-06 07:58 bgrieder       New Issue                                    
06-23-06 07:58 bgrieder       Distribution              => Fedora Core 5   
06-23-06 07:58 bgrieder       Kernel Version            => 2.6.16-1.2133_FC5smp
#1 SMP
06-25-06 16:11 bgrieder       Note Added: 0010513                          
06-25-06 16:42 bgrieder       Note Added: 0010514                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
