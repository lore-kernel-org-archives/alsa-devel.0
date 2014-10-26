From: Ploumistos Alexandros <ch02499@cc.uoi.gr>
Subject: Re: Analog sound (ALC262) lost on linux (any distro
	and kernel) on a dual boot system
Date: Sun, 26 Oct 2014 14:48:00 +0200
Message-ID: <1414327680.544ced80405f0@webmail.uoi.gr>
References: <1414065684.5448ee14f02dd@webmail.uoi.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from phoenix.noc.uoi.gr (phoenix.noc.uoi.gr [195.130.120.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB362606A6
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 13:48:04 +0100 (CET)
In-Reply-To: <1414065684.5448ee14f02dd@webmail.uoi.gr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ploumistos Alexandros <ch02499@cc.uoi.gr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I 'm sorry for spamming the list with this, but I noticed these errors, that I'm
pretty certain they didn't happen when I first installed linux on the machine.
Could they be relevant to the issue?


Oct 26 12:00:44 vaio kernel: [   60.896065] ------------[ cut here ]------------
Oct 26 12:00:44 vaio kernel: [   60.896073] WARNING: CPU: 1 PID: 37 at
/build/buildd/linux-3.13.0/arch/x86/kernel/check.c:140
check_for_bios_corruption+0x10f/0x120()
Oct 26 12:00:44 vaio kernel: [   60.896074] Memory corruption detected in low
memory
Oct 26 12:00:44 vaio kernel: [   60.896075] Modules linked in: cuse
snd_hda_codec_hdmi(OF) rfcomm bnep bluetooth binfmt_misc arc4 uvcvideo iwldvm
videobuf2_vmalloc mac80211 videobuf2_memops videobuf2_core videodev
snd_hda_codec_realtek(OF) snd_hda_codec_generic(OF) snd_hda_intel(OF)
snd_hda_controller(OF) snd_hda_codec(OF) snd_hwdep snd_pcm snd_page_alloc
snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq kvm snd_seq_device
snd_timer iwlwifi radeon joydev serio_raw r592 memstick snd lpc_ich cfg80211
ttm drm_kms_helper mac_hid drm i2c_algo_bit soundcore sony_laptop parport_pc
video ppdev coretemp lp parport hid_generic usbhid hid sdhci_pci sdhci psmouse
firewire_ohci ahci firewire_core libahci crc_itu_t sky2
Oct 26 12:00:44 vaio kernel: [   60.896120] CPU: 1 PID: 37 Comm: kworker/1:1
Tainted: GF          O 3.13.0-35-generic #62-Ubuntu
Oct 26 12:00:44 vaio kernel: [   60.896122] Hardware name: Sony Corporation
VGN-FW21M/VAIO, BIOS R1100Y0 08/27/2009
Oct 26 12:00:44 vaio kernel: [   60.896125] Workqueue: events check_corruption
Oct 26 12:00:44 vaio kernel: [   60.896127]  0000000000000009 ffff880139683d30
ffffffff8171e320 ffff880139683d78
Oct 26 12:00:44 vaio kernel: [   60.896130]  ffff880139683d68 ffffffff8106775d
0000000000000000 ffff880000010000
Oct 26 12:00:44 vaio kernel: [   60.896133]  ffffffff81eb21f0 0000000000000001
ffff880000000000 ffff880139683dc8
Oct 26 12:00:44 vaio kernel: [   60.896135] Call Trace:
Oct 26 12:00:44 vaio kernel: [   60.896140]  [<ffffffff8171e320>]
dump_stack+0x45/0x56
Oct 26 12:00:44 vaio kernel: [   60.896144]  [<ffffffff8106775d>]
warn_slowpath_common+0x7d/0xa0
Oct 26 12:00:44 vaio kernel: [   60.896146]  [<ffffffff810677cc>]
warn_slowpath_fmt+0x4c/0x50
Oct 26 12:00:44 vaio kernel: [   60.896149]  [<ffffffff810524af>]
check_for_bios_corruption+0x10f/0x120
Oct 26 12:00:44 vaio kernel: [   60.896152]  [<ffffffff810524ce>]
check_corruption+0xe/0x40
Oct 26 12:00:44 vaio kernel: [   60.896155]  [<ffffffff810839d2>]
process_one_work+0x182/0x450
Oct 26 12:00:44 vaio kernel: [   60.896163]  [<ffffffff810847c1>]
worker_thread+0x121/0x410
Oct 26 12:00:44 vaio kernel: [   60.896166]  [<ffffffff810846a0>] ?
rescuer_thread+0x430/0x430
Oct 26 12:00:44 vaio kernel: [   60.896169]  [<ffffffff8108b4a2>]
kthread+0xd2/0xf0
Oct 26 12:00:44 vaio kernel: [   60.896171]  [<ffffffff8108b3d0>] ?
kthread_create_on_node+0x1c0/0x1c0
Oct 26 12:00:44 vaio kernel: [   60.896174]  [<ffffffff8172ecbc>]
ret_from_fork+0x7c/0xb0
Oct 26 12:00:44 vaio kernel: [   60.896176]  [<ffffffff8108b3d0>] ?
kthread_create_on_node+0x1c0/0x1c0
Oct 26 12:00:44 vaio kernel: [   60.896178] ---[ end trace 300adf7bd3d057f3 ]---
