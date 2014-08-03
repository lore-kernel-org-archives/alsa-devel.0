From: Vincent Lejeune <vljn@ovi.com>
Subject: ASUS Phoebus (CMI8888) HDA Support
Date: Sun, 3 Aug 2014 14:11:34 -0700
Message-ID: <1407100294.67080.YahooMailNeo@web161504.mail.bf1.yahoo.com>
Reply-To: Vincent Lejeune <vljn@ovi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm15.bullet.mail.bf1.yahoo.com (nm15.bullet.mail.bf1.yahoo.com
 [98.139.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B582E2652F5
 for <alsa-devel@alsa-project.org>; Sun,  3 Aug 2014 23:11:35 +0200 (CEST)
References: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I just found this thread http://thread.gmane.org/gmane.linux.alsa.devel/116=
096 =

I'm trying to find what can make the CMI8888 not work in non single_cmd mod=
e and it looks more and more like a DMA issue.
I don't have an "iommu mode" option in my bios like Geoffrey McRae, it =

looks like an AMD only option, and using bigger page size/alignement =

constraint didnt solve the issue.
However I added some code to dump the content of the rirb buffer in the upd=
ate_rirb() function and I copied it below.

The first command seems to be correctly handled the second time it is send =

to the hardware. As the AZX_DCAPS_*DELAY_RIRB doesnt change anything, =

I'm starting to think
that the corb engine may require some delay to be processed.
Is there a way to spy the dma transfer request from the device point of =

view ? I'd like to know when the cmi8888 request a dma read from the =

corb buffer and when it requests a dma write to the rirb buffer
to determine if it parses the corb buffer correctly or not.

In addition the first value returned is very odd : 13f68888. The pci id of =
the phoebus is 13f6:5011.
What does the 100f0001 cmd mean ? hda-decode-verb tells me the verb is "0x0=
"...

[ 4038.467696] snd_hda_intel 0000:01:00.1: Handle VGA-switcheroo audio clie=
nt
[ 4038.467723] snd_hda_intel 0000:01:00.1: irq 50 for MSI/MSI-X
[ 4038.467836] snd_hda_intel 0000:02:00.0: Disabling MSI
[ 4038.469852] snd_hda_intel 0000:01:00.1: Pointers values : rirblbase : ff=
ff8800, corbbase : ffff8000
[
 4038.469887] snd_hda_intel 0000:01:00.1: no codecs initialized
[ 4038.471618] snd_hda_intel 0000:02:00.0: Pointers values : rirblbase : ff=
ff7800, corbbase : ffff7000
[ 4038.471721] snd_hda_intel 0000:02:00.0: corb write @ 1 value 100f0000
[ 4038.471780] snd_hda_intel 0000:02:00.0: rirb content @ 0 : 0 0
[ 4038.471782] snd_hda_intel 0000:02:00.0: rirb content @ 1 : 0 0
... lots of 0 0 ...
[ 4038.471968] snd_hda_intel 0000:02:00.0: rirb content @ 254 : 0 0
[ 4038.471968] snd_hda_intel 0000:02:00.0: rirb content @ 255 : 0 0
[ 4038.471969] snd_hda_intel 0000:02:00.0: rirb pos 1 : 0 0
[ 4038.471970] snd_hda_intel 0000:02:00.0: spurious response 0x0:0x0, rp =
=3D 1, wp =3D 1
[ 4038.471971] ------------[ cut here ]------------
[
 4038.471973] WARNING: CPU: 0 PID: 0 at sound/pci/hda/hda_controller.c:1212=
 azx_update_rirb+0x1a5/0x220 [snd_hda_controller]()
[ 4038.471974] BUG?
[
 4038.471974] Modules linked in: snd_hda_intel snd_hda_controller =

snd_hda_codec_generic snd_hda_codec snd_hwdep snd_pcm nls_utf8 isofs =

fuse ip6t_rpfilter bnep bluetooth ip6t_REJECT cfg80211 xt_conntrack =

rfkill ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables
 ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 =

ip6table_mangle ip6table_security ip6table_raw ip6table_filter =

ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 =

nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw =

x86_pkg_temp_thermal coretemp kvm_intel vfat fat uas kvm usb_storage =

mxm_wmi snd_seq snd_seq_device crct10dif_pclmul crc32_pclmul =

crc32c_intel joydev snd_timer ghash_clmulni_intel mei_me snd mei =

microcode serio_raw pcspkr soundcore shpchp wmi video
 i2c_hid dw_dmac dw_dmac_core i2c_designware_platform
[
 4038.471995]=A0 acpi_pad i2c_designware_core radeon i2c_algo_bit =

drm_kms_helper ttm drm sdhci_acpi sdhci mmc_core alx i2c_core mdio [last
 unloaded: snd_hda_controller]
[ 4038.472001] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G=A0=A0=A0=A0=A0=A0=
=A0 W=A0=A0=A0=A0 3.16.0-rc4+ #2
[ 4038.472001] Hardware name: Gigabyte Technology Co., Ltd. G1.Sniper Z97/G=
1.Sniper Z97, BIOS F6 05/30/2014
[ 4038.472002]=A0 0000000000000000 92922082461d2d28 ffff88021ec03d90 ffffff=
ff816ff2e2
[ 4038.472003]=A0 ffff88021ec03dd8 ffff88021ec03dc8 ffffffff8108bead ffff88=
00d79d3800
[ 4038.472005]=A0 0000000000000000 0000000000000001 0000000000000000 000000=
0000000000
[ 4038.472006] Call Trace:
[ 4038.472007]=A0
 <IRQ>=A0 [<ffffffff816ff2e2>] dump_stack+0x45/0x56
[ 4038.472013]=A0 [<ffffffff8108bead>] warn_slowpath_common+0x7d/0xa0
[ 4038.472014]=A0 [<ffffffff8108bf2c>] warn_slowpath_fmt+0x5c/0x80
[ 4038.472016]=A0 [<ffffffffa0304645>] azx_update_rirb+0x1a5/0x220 [snd_hda=
_controller]
[ 4038.472017]=A0 [<ffffffffa03048c9>] azx_interrupt+0x179/0x1c0 [snd_hda_c=
ontroller]
[ 4038.472020]=A0 [<ffffffff810e697e>] handle_irq_event_percpu+0x3e/0x1a0
[ 4038.472021]=A0 [<ffffffff810e6b16>] handle_irq_event+0x36/0x60
[ 4038.472023]=A0 [<ffffffff810e9ebc>] handle_fasteoi_irq+0x7c/0x140
[ 4038.472026]=A0 [<ffffffff81015eff>] handle_irq+0xbf/0x150
[ 4038.472029]=A0 [<ffffffff810b33fa>] ?
 atomic_notifier_call_chain+0x1a/0x20
[ 4038.472032]=A0 [<ffffffff8170968f>] do_IRQ+0x4f/0xf0
[ 4038.472033]=A0 [<ffffffff8170746d>] common_interrupt+0x6d/0x6d
[ 4038.472033]=A0 <EOI>=A0 [<ffffffff81597792>] ? cpuidle_enter_state+0x52/=
0xc0
[ 4038.472037]=A0 [<ffffffff815978b7>] cpuidle_enter+0x17/0x20
[ 4038.472039]=A0 [<ffffffff810d3035>] cpu_startup_entry+0x315/0x440
[ 4038.472042]=A0 [<ffffffff816f1427>] rest_init+0x77/0x80
[ 4038.472045]=A0 [<ffffffff81d280e1>] start_kernel+0x465/0x486
[ 4038.472046]=A0 [<ffffffff81d27a85>] ? set_init_arg+0x53/0x53
[ 4038.472048]=A0 [<ffffffff81d27120>] ? early_idt_handlers+0x120/0x120
[ 4038.472049]=A0
 [<ffffffff81d275ee>] x86_64_start_reservations+0x2a/0x2c
[ 4038.472050]=A0 [<ffffffff81d2773d>] x86_64_start_kernel+0x14d/0x170
[ 4038.472051] ---[ end trace 63c0b6054db2a1ea ]---
[ 4039.472815] snd_hda_intel 0000:02:00.0: Codec #1 probe error; disabling =
it...
[ 4039.477032] snd_hda_intel 0000:02:00.0: Pointers values : rirblbase : ff=
ff7800, corbbase : ffff7000
[ 4039.477038] snd_hda_intel 0000:02:00.0: corb write @ 1 value 100f0000
[ 4039.477113] snd_hda_intel 0000:02:00.0: rirb content @ 0 : 0 0
[ 4039.477115] snd_hda_intel 0000:02:00.0: rirb content @ 1 : 13f68888 1
[ 4039.477116] snd_hda_intel 0000:02:00.0: rirb content @ 2 : 0 0
[ 4039.477117] snd_hda_intel 0000:02:00.0: rirb content @ 3 : 0 0
... lots of 0 0 ...
[ 4039.477306] snd_hda_intel 0000:02:00.0: rirb content @ 254 : 0 0
[ 4039.477307] snd_hda_intel 0000:02:00.0: rirb content @ 255 : 0 0
[ 4039.477308] snd_hda_intel 0000:02:00.0: rirb pos 1 : 13f68888 1
[ 4039.477318] snd_hda_intel 0000:02:00.0: corb write @ 2 value 100f0001
[ 4039.477373] snd_hda_intel 0000:02:00.0: rirb content @ 0 : 0 0
[ 4039.477374] snd_hda_intel 0000:02:00.0: rirb content @ 1 : 13f68888 1
[ 4039.477375] snd_hda_intel 0000:02:00.0: rirb content @ 2 : 0 0
[ 4039.477376] snd_hda_intel 0000:02:00.0: rirb content @ 3 : 0 0
... lots of 0 0 ...
[ 4039.477568] snd_hda_intel 0000:02:00.0: rirb content @ 253 : 0 0
[ 4039.477568] snd_hda_intel 0000:02:00.0: rirb content @ 254 : 0 0
[ 4039.477569] snd_hda_intel 0000:02:00.0: rirb content @ 255 : 0 0
[ 4039.477570] snd_hda_intel 0000:02:00.0: rirb pos 2 : 0 0
[ 4039.477571] snd_hda_intel 0000:02:00.0: spurious response 0x0:0x0, rp =
=3D 2, wp =3D 2
[ 4039.477572]
 ------------[ cut here ]------------
[ 4039.477575] WARNING: CPU: 0 PID: 0 at sound/pci/hda/hda_controller.c:121=
2 azx_update_rirb+0x1a5/0x220 [snd_hda_controller]()
[ 4039.477576] BUG?
[
 4039.477576] Modules linked in: snd_hda_intel snd_hda_controller =

snd_hda_codec_generic snd_hda_codec snd_hwdep snd_pcm nls_utf8 isofs =

fuse ip6t_rpfilter bnep bluetooth ip6t_REJECT cfg80211 xt_conntrack =

rfkill ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables
 ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 =

ip6table_mangle ip6table_security ip6table_raw ip6table_filter =

ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 =

nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw =

x86_pkg_temp_thermal coretemp kvm_intel vfat fat uas kvm usb_storage =

mxm_wmi snd_seq snd_seq_device crct10dif_pclmul crc32_pclmul =

crc32c_intel joydev snd_timer ghash_clmulni_intel mei_me
 snd mei microcode serio_raw pcspkr soundcore shpchp wmi video i2c_hid =

dw_dmac dw_dmac_core i2c_designware_platform
[
 4039.477599]=A0 acpi_pad i2c_designware_core radeon i2c_algo_bit =

drm_kms_helper ttm drm sdhci_acpi sdhci mmc_core alx i2c_core mdio [last
 unloaded: snd_hda_controller]
[ 4039.477605] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G=A0=A0=A0=A0=A0=A0=
=A0 W=A0=A0=A0=A0 3.16.0-rc4+ #2
[ 4039.477606] Hardware name: Gigabyte Technology Co., Ltd. G1.Sniper Z97/G=
1.Sniper Z97, BIOS F6 05/30/2014
[ 4039.477607]=A0 0000000000000000 92922082461d2d28 ffff88021ec03d90 ffffff=
ff816ff2e2
[ 4039.477608]=A0 ffff88021ec03dd8 ffff88021ec03dc8 ffffffff8108bead ffff88=
00d79d3800
[ 4039.477609]=A0 0000000000000000 0000000000000002 0000000000000000 000000=
0000000000
[ 4039.477611]
 Call Trace:
[ 4039.477612]=A0 <IRQ>=A0 [<ffffffff816ff2e2>] dump_stack+0x45/0x56
[ 4039.477617]=A0 [<ffffffff8108bead>] warn_slowpath_common+0x7d/0xa0
[ 4039.477619]=A0 [<ffffffff8108bf2c>] warn_slowpath_fmt+0x5c/0x80
[ 4039.477620]=A0 [<ffffffffa0304645>] azx_update_rirb+0x1a5/0x220 [snd_hda=
_controller]
[ 4039.477622]=A0 [<ffffffffa03048c9>] azx_interrupt+0x179/0x1c0 [snd_hda_c=
ontroller]
[ 4039.477624]=A0 [<ffffffff810e697e>] handle_irq_event_percpu+0x3e/0x1a0
[ 4039.477626]=A0 [<ffffffff810e6b16>] handle_irq_event+0x36/0x60
[ 4039.477628]=A0 [<ffffffff810e9ebc>] handle_fasteoi_irq+0x7c/0x140
[ 4039.477631]=A0 [<ffffffff81015eff>] handle_irq+0xbf/0x150
[
 4039.477633]=A0 [<ffffffff810b33fa>] ? atomic_notifier_call_chain+0x1a/0x20
[ 4039.477636]=A0 [<ffffffff8170968f>] do_IRQ+0x4f/0xf0
[ 4039.477637]=A0 [<ffffffff8170746d>] common_interrupt+0x6d/0x6d
[ 4039.477638]=A0 <EOI>=A0 [<ffffffff81597792>] ? cpuidle_enter_state+0x52/=
0xc0
[ 4039.477641]=A0 [<ffffffff815978b7>] cpuidle_enter+0x17/0x20
[ 4039.477643]=A0 [<ffffffff810d3035>] cpu_startup_entry+0x315/0x440
[ 4039.477646]=A0 [<ffffffff816f1427>] rest_init+0x77/0x80
[ 4039.477649]=A0 [<ffffffff81d280e1>] start_kernel+0x465/0x486
[ 4039.477651]=A0 [<ffffffff81d27a85>] ? set_init_arg+0x53/0x53
[ 4039.477652]=A0 [<ffffffff81d27120>] ? early_idt_handlers+0x120/0x120
[ 4039.477654]=A0 [<ffffffff81d275ee>] x86_64_start_reservations+0x2a/0x2c
[ 4039.477655]=A0 [<ffffffff81d2773d>] x86_64_start_kernel+0x14d/0x170
[ 4039.477656] ---[ end trace 63c0b6054db2a1eb ]---


Regards,Vincent
