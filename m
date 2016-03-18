From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: snd_hda_core oops with Linux v4.5-6229-gf7813ad5cbfd
Date: Fri, 18 Mar 2016 16:59:51 -0400
Message-ID: <CA+5PVA4BZzYQ3JNUdhbUK3CO9n_VmZhBT5GV+EYTPGmLwyasOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a celeron based NUC that is giving me the following backtraces
after Linus merged the sound tree today.  This is with the top of the
tree at f7813ad5cbfd as mentioned in the subject.

The machine has an HDMI port, but it is not connected to any thing.

josh

[  +0.005071] snd_hda_codec_realtek hdaudioC0D0: autoconfig for
ALC283: line_outs=1 (0x21/0x0/0x0/0x0/0x0) type:hp
[  +0.000009] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[  +0.000005] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=0
(0x0/0x0/0x0/0x0/0x0)
[  +0.000003] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[  +0.000004] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[  +0.000006] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19
[  +0.323524] ------------[ cut here ]------------
[  +0.000019] WARNING: CPU: 0 PID: 550 at sound/hda/hdac_i915.c:129
snd_hdac_acomp_get_eld+0x53/0x70 [snd_hda_core]()
[  +0.000004] Modules linked in: snd_hda_codec_hdmi(+) cfg80211
snd_hda_codec_realtek snd_hda_codec_generic btusb btrtl lpc_ich
i2c_i801 snd_hda_intel snd_hda_codec mei_txe snd_hda_core snd_hwdep
mei snd_intel_sst_acpi snd_intel_sst_core snd_soc_rt5640
snd_soc_sst_mfld_platform snd_soc_rl6231 ir_lirc_codec lirc_dev
snd_soc_sst_match snd_soc_core rc_rc6_mce snd_compress ite_cir
snd_pcm_dmaengine rc_core ac97_bus snd_seq snd_seq_device hci_uart
dw_dmac snd_pcm btbcm dw_dmac_core btqca btintel bluetooth snd_timer
snd rfkill_gpio soundcore rfkill i2c_designware_platform
i2c_designware_core spi_pxa2xx_platform tpm_tis tpm i915 r8169
serio_raw mii i2c_algo_bit drm_kms_helper drm video fjes sdhci_acpi
i2c_hid sdhci mmc_core
[  +0.000086] CPU: 0 PID: 550 Comm: modprobe Tainted: G        W
4.6.0-0.rc0.git11.1.fc25.x86_64 #1
[  +0.000003] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[  +0.000004]  0000000000000286 000000001953c40f ffff880233c679c0
ffffffff81454ea5
[  +0.000007]  0000000000000000 ffffffffc0465eea ffff880233c679f8
ffffffff810b2912
[  +0.000006]  ffff88023308b000 ffff8800b804a000 ffff880233fa3800
ffff8800b804a330
[  +0.000005] Call Trace:
[  +0.000008]  [<ffffffff81454ea5>] dump_stack+0x86/0xc1
[  +0.000007]  [<ffffffff810b2912>] warn_slowpath_common+0x82/0xc0
[  +0.000005]  [<ffffffff810b2a5a>] warn_slowpath_null+0x1a/0x20
[  +0.000009]  [<ffffffffc0463f53>] snd_hdac_acomp_get_eld+0x53/0x70
[snd_hda_core]
[  +0.000009]  [<ffffffffc04f99ae>] hdmi_present_sense+0xae/0x3a0
[snd_hda_codec_hdmi]
[  +0.000007]  [<ffffffffc04fa0b0>]
generic_hdmi_build_controls+0x150/0x1f0 [snd_hda_codec_hdmi]
[  +0.000014]  [<ffffffffc048bcec>]
snd_hda_codec_build_controls+0x1bc/0x200 [snd_hda_codec]
[  +0.000011]  [<ffffffffc0486450>] hda_codec_driver_probe+0x80/0x100
[snd_hda_codec]
[  +0.000006]  [<ffffffff815b0b10>] ? devices_kset_move_last+0x60/0x90
[  +0.000005]  [<ffffffff815b4c5c>] driver_probe_device+0x22c/0x440
[  +0.000004]  [<ffffffff815b4ef8>] __driver_attach+0x88/0x90
[  +0.000004]  [<ffffffff815b4e70>] ? driver_probe_device+0x440/0x440
[  +0.000005]  [<ffffffff815b24a3>] bus_for_each_dev+0x73/0xc0
[  +0.000005]  [<ffffffff815b432e>] driver_attach+0x1e/0x20
[  +0.000003]  [<ffffffff815b3d56>] bus_add_driver+0x1c6/0x290
[  +0.000005]  [<ffffffffc0503000>] ? 0xffffffffc0503000
[  +0.000004]  [<ffffffff815b5b30>] driver_register+0x60/0xe0
[  +0.000009]  [<ffffffffc04860da>]
__hda_codec_driver_register+0x5a/0x60 [snd_hda_codec]
[  +0.000007]  [<ffffffffc050301e>] hdmi_driver_init+0x1e/0x1000
[snd_hda_codec_hdmi]
[  +0.000005]  [<ffffffff81002123>] do_one_initcall+0xb3/0x1f0
[  +0.000005]  [<ffffffff811314c5>] ? rcu_read_lock_sched_held+0x45/0x80
[  +0.000005]  [<ffffffff812656fc>] ? kmem_cache_alloc_trace+0x2ac/0x310
[  +0.000005]  [<ffffffff811f03ee>] ? do_init_module+0x27/0x1da
[  +0.000005]  [<ffffffff811f0426>] do_init_module+0x5f/0x1da
[  +0.000005]  [<ffffffff8115dd18>] load_module+0x21e8/0x2950
[  +0.000004]  [<ffffffff8115a2c0>] ? __symbol_put+0x70/0x70
[  +0.000006]  [<ffffffff811592c0>] ? show_coresize+0x30/0x30
[  +0.000005]  [<ffffffff8103fcb9>] ? sched_clock+0x9/0x10
[  +0.000005]  [<ffffffff8115e5f2>] SYSC_init_module+0x172/0x1b0
[  +0.000006]  [<ffffffff8115e75e>] SyS_init_module+0xe/0x10
[  +0.000004]  [<ffffffff81004029>] do_syscall_64+0x69/0x190
[  +0.000005]  [<ffffffff818bcaff>] entry_SYSCALL64_slow_path+0x25/0x25
[  +0.000005] ---[ end trace 0a6c6b61165f650c ]---

[  +7.313791] ------------[ cut here ]------------
[  +0.000020] WARNING: CPU: 1 PID: 1316 at sound/hda/hdac_i915.c:129
snd_hdac_acomp_get_eld+0x53/0x70 [snd_hda_core]()
[  +0.000003] Modules linked in: xt_CHECKSUM ipt_MASQUERADE
nf_nat_masquerade_ipv4 tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp
llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw bnep iTCO_wdt intel_rapl
iTCO_vendor_support intel_soc_dts_iosf coretemp kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel arc4 vfat fat iwlmvm mac80211 iwlwifi
snd_hda_codec_hdmi cfg80211 snd_hda_codec_realtek
snd_hda_codec_generic btusb btrtl lpc_ich i2c_i801 snd_hda_intel
snd_hda_codec mei_txe
[  +0.000089]  snd_hda_core snd_hwdep mei snd_intel_sst_acpi
snd_intel_sst_core snd_soc_rt5640 snd_soc_sst_mfld_platform
snd_soc_rl6231 ir_lirc_codec lirc_dev snd_soc_sst_match snd_soc_core
rc_rc6_mce snd_compress ite_cir snd_pcm_dmaengine rc_core ac97_bus
snd_seq snd_seq_device hci_uart dw_dmac snd_pcm btbcm dw_dmac_core
btqca btintel bluetooth snd_timer snd rfkill_gpio soundcore rfkill
i2c_designware_platform i2c_designware_core spi_pxa2xx_platform
tpm_tis tpm i915 r8169 serio_raw mii i2c_algo_bit drm_kms_helper drm
video fjes sdhci_acpi i2c_hid sdhci mmc_core
[  +0.000073] CPU: 1 PID: 1316 Comm: pulseaudio Tainted: G        W
   4.6.0-0.rc0.git11.1.fc25.x86_64 #1
[  +0.000004] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[  +0.000003]  0000000000000286 00000000fefe8725 ffff8800ac403878
ffffffff81454ea5
[  +0.000007]  0000000000000000 ffffffffc0465eea ffff8800ac4038b0
ffffffff810b2912
[  +0.000006]  ffff88023308b000 ffff8800b804a000 ffff880233fa3800
ffff8800b804a330
[  +0.000006] Call Trace:
[  +0.000008]  [<ffffffff81454ea5>] dump_stack+0x86/0xc1
[  +0.000007]  [<ffffffff810b2912>] warn_slowpath_common+0x82/0xc0
[  +0.000004]  [<ffffffff810b2a5a>] warn_slowpath_null+0x1a/0x20
[  +0.000009]  [<ffffffffc0463f53>] snd_hdac_acomp_get_eld+0x53/0x70
[snd_hda_core]
[  +0.000007]  [<ffffffffc04f99ae>] hdmi_present_sense+0xae/0x3a0
[snd_hda_codec_hdmi]
[  +0.000005]  [<ffffffff811314c5>] ? rcu_read_lock_sched_held+0x45/0x80
[  +0.000013]  [<ffffffffc0488b00>] ?
snd_hda_add_imux_item+0x120/0x120 [snd_hda_codec]
[  +0.000006]  [<ffffffffc04f9f50>] generic_hdmi_resume+0x50/0x60
[snd_hda_codec_hdmi]
[  +0.000010]  [<ffffffffc048879e>] hda_call_codec_resume+0xce/0x120
[snd_hda_codec]
[  +0.000010]  [<ffffffffc0488b35>] hda_codec_runtime_resume+0x35/0x50
[snd_hda_codec]
[  +0.000005]  [<ffffffff815bf622>] __rpm_callback+0x32/0x70
[  +0.000010]  [<ffffffffc0488b00>] ?
snd_hda_add_imux_item+0x120/0x120 [snd_hda_codec]
[  +0.000005]  [<ffffffff815bf684>] rpm_callback+0x24/0x80
[  +0.000010]  [<ffffffffc0488b00>] ?
snd_hda_add_imux_item+0x120/0x120 [snd_hda_codec]
[  +0.000004]  [<ffffffff815c00e6>] rpm_resume+0x566/0x840
[  +0.000005]  [<ffffffff815c161e>] __pm_runtime_resume+0x4e/0x80
[  +0.000008]  [<ffffffffc045e163>] snd_hdac_power_up+0x13/0x20 [snd_hda_core]
[  +0.000011]  [<ffffffffc0491292>] azx_pcm_open+0x1f2/0x4b0 [snd_hda_codec]
[  +0.000011]  [<ffffffffc0338cae>] snd_pcm_open_substream+0x7e/0x130 [snd_pcm]
[  +0.000009]  [<ffffffffc0338e19>] snd_pcm_open+0xb9/0x260 [snd_pcm]
[  +0.000005]  [<ffffffff818b9d5a>] ? __mutex_unlock_slowpath+0xfa/0x1c0
[  +0.000005]  [<ffffffff810e75e0>] ? wake_up_q+0x70/0x70
[  +0.000010]  [<ffffffffc0339074>] snd_pcm_playback_open+0x44/0x70 [snd_pcm]
[  +0.000009]  [<ffffffffc0298463>] snd_open+0xb3/0x180 [snd]
[  +0.000004]  [<ffffffff811314c5>] ? rcu_read_lock_sched_held+0x45/0x80
[  +0.000005]  [<ffffffff81299690>] chrdev_open+0xb0/0x1d0
[  +0.000005]  [<ffffffff81291a69>] do_dentry_open+0x219/0x310
[  +0.000004]  [<ffffffff812995e0>] ? cdev_put+0x30/0x30
[  +0.000004]  [<ffffffff81292eef>] vfs_open+0x5f/0x70
[  +0.000004]  [<ffffffff812a47db>] path_openat+0x1db/0x1470
[  +0.000005]  [<ffffffff812a6fb1>] do_filp_open+0x91/0x100
[  +0.000006]  [<ffffffff818bc0d7>] ? _raw_spin_unlock+0x27/0x40
[  +0.000004]  [<ffffffff812b7780>] ? __alloc_fd+0x100/0x200
[  +0.000005]  [<ffffffff812932d0>] do_sys_open+0x130/0x220
[  +0.000005]  [<ffffffff81183f4b>] ? __audit_syscall_exit+0x1db/0x260
[  +0.000004]  [<ffffffff812933de>] SyS_open+0x1e/0x20
[  +0.000005]  [<ffffffff81004029>] do_syscall_64+0x69/0x190
[  +0.000004]  [<ffffffff818bcaff>] entry_SYSCALL64_slow_path+0x25/0x25
[  +0.000005] ---[ end trace 0a6c6b61165f650d ]---
[  +0.004980] ------------[ cut here ]------------
[  +0.000021] WARNING: CPU: 1 PID: 1316 at sound/hda/hdac_i915.c:129
snd_hdac_sync_audio_rate+0x53/0x70 [snd_hda_core]()
[  +0.000004] Modules linked in: xt_CHECKSUM ipt_MASQUERADE
nf_nat_masquerade_ipv4 tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp
llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw bnep iTCO_wdt intel_rapl
iTCO_vendor_support intel_soc_dts_iosf coretemp kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel arc4 vfat fat iwlmvm mac80211 iwlwifi
snd_hda_codec_hdmi cfg80211 snd_hda_codec_realtek
snd_hda_codec_generic btusb btrtl lpc_ich i2c_i801 snd_hda_intel
snd_hda_codec mei_txe
[  +0.000142]  snd_hda_core snd_hwdep mei snd_intel_sst_acpi
snd_intel_sst_core snd_soc_rt5640 snd_soc_sst_mfld_platform
snd_soc_rl6231 ir_lirc_codec lirc_dev snd_soc_sst_match snd_soc_core
rc_rc6_mce snd_compress ite_cir snd_pcm_dmaengine rc_core ac97_bus
snd_seq snd_seq_device hci_uart dw_dmac snd_pcm btbcm dw_dmac_core
btqca btintel bluetooth snd_timer snd rfkill_gpio soundcore rfkill
i2c_designware_platform i2c_designware_core spi_pxa2xx_platform
tpm_tis tpm i915 r8169 serio_raw mii i2c_algo_bit drm_kms_helper drm
video fjes sdhci_acpi i2c_hid sdhci mmc_core
[  +0.000076] CPU: 1 PID: 1316 Comm: pulseaudio Tainted: G        W
   4.6.0-0.rc0.git11.1.fc25.x86_64 #1
[  +0.000004] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[  +0.000003]  0000000000000286 00000000fefe8725 ffff8800ac403bb8
ffffffff81454ea5
[  +0.000007]  0000000000000000 ffffffffc0465eea ffff8800ac403bf0
ffffffff810b2912
[  +0.000006]  ffff88023308b000 0000000000000004 ffff8800b804a000
ffff880233b12000
[  +0.000006] Call Trace:
[  +0.000010]  [<ffffffff81454ea5>] dump_stack+0x86/0xc1
[  +0.000007]  [<ffffffff810b2912>] warn_slowpath_common+0x82/0xc0
[  +0.000005]  [<ffffffff810b2a5a>] warn_slowpath_null+0x1a/0x20
[  +0.000009]  [<ffffffffc0463ee3>] snd_hdac_sync_audio_rate+0x53/0x70
[snd_hda_core]
[  +0.000008]  [<ffffffffc04fa95e>]
generic_hdmi_playback_pcm_prepare+0xbe/0x210 [snd_hda_codec_hdmi]
[  +0.000013]  [<ffffffffc04891e2>] snd_hda_codec_prepare+0x52/0x120
[snd_hda_codec]
[  +0.000011]  [<ffffffffc0490ad8>] azx_pcm_prepare+0x138/0x2b0 [snd_hda_codec]
[  +0.000012]  [<ffffffffc0333a4a>] snd_pcm_do_prepare+0x1a/0x30 [snd_pcm]
[  +0.000009]  [<ffffffffc0333715>] snd_pcm_action_single+0x35/0x80 [snd_pcm]
[  +0.000005]  [<ffffffff818ba2ff>] ? down_read+0x8f/0xa0
[  +0.000009]  [<ffffffffc03338f8>] snd_pcm_action_nonatomic+0x68/0x70 [snd_pcm]
[  +0.000009]  [<ffffffffc0336c68>] snd_pcm_common_ioctl1+0x688/0xc60 [snd_pcm]
[  +0.000010]  [<ffffffffc0337423>]
snd_pcm_playback_ioctl1+0x1e3/0x320 [snd_pcm]
[  +0.000009]  [<ffffffffc0337587>] snd_pcm_playback_ioctl+0x27/0x40 [snd_pcm]
[  +0.000005]  [<ffffffff812aa6e4>] do_vfs_ioctl+0xa4/0x6d0
[  +0.000006]  [<ffffffff81183d2d>] ? __audit_syscall_entry+0xad/0xf0
[  +0.000004]  [<ffffffff812aad89>] SyS_ioctl+0x79/0x90
[  +0.000006]  [<ffffffff81004029>] do_syscall_64+0x69/0x190
[  +0.000004]  [<ffffffff818bcaff>] entry_SYSCALL64_slow_path+0x25/0x25
[  +0.000005] ---[ end trace 0a6c6b61165f650e ]---
[  +0.008253] ------------[ cut here ]------------
[  +0.000018] WARNING: CPU: 1 PID: 1316 at sound/hda/hdac_i915.c:129
snd_hdac_sync_audio_rate+0x53/0x70 [snd_hda_core]()
[  +0.000004] Modules linked in: xt_CHECKSUM ipt_MASQUERADE
nf_nat_masquerade_ipv4 tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp
llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw bnep iTCO_wdt intel_rapl
iTCO_vendor_support intel_soc_dts_iosf coretemp kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel arc4 vfat fat iwlmvm mac80211 iwlwifi
snd_hda_codec_hdmi cfg80211 snd_hda_codec_realtek
snd_hda_codec_generic btusb btrtl lpc_ich i2c_i801 snd_hda_intel
snd_hda_codec mei_txe
[  +0.000093]  snd_hda_core snd_hwdep mei snd_intel_sst_acpi
snd_intel_sst_core snd_soc_rt5640 snd_soc_sst_mfld_platform
snd_soc_rl6231 ir_lirc_codec lirc_dev snd_soc_sst_match snd_soc_core
rc_rc6_mce snd_compress ite_cir snd_pcm_dmaengine rc_core ac97_bus
snd_seq snd_seq_device hci_uart dw_dmac snd_pcm btbcm dw_dmac_core
btqca btintel bluetooth snd_timer snd rfkill_gpio soundcore rfkill
i2c_designware_platform i2c_designware_core spi_pxa2xx_platform
tpm_tis tpm i915 r8169 serio_raw mii i2c_algo_bit drm_kms_helper drm
video fjes sdhci_acpi i2c_hid sdhci mmc_core
[  +0.000077] CPU: 1 PID: 1316 Comm: pulseaudio Tainted: G        W
   4.6.0-0.rc0.git11.1.fc25.x86_64 #1
[  +0.000003] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[  +0.000004]  0000000000000286 00000000fefe8725 ffff8800ac403bb8
ffffffff81454ea5
[  +0.000008]  0000000000000000 ffffffffc0465eea ffff8800ac403bf0
ffffffff810b2912
[  +0.000006]  ffff88023308b000 0000000000000004 ffff8800b804a000
ffff880233b12000
[  +0.000009] Call Trace:
[  +0.000009]  [<ffffffff81454ea5>] dump_stack+0x86/0xc1
[  +0.000007]  [<ffffffff810b2912>] warn_slowpath_common+0x82/0xc0
[  +0.000004]  [<ffffffff810b2a5a>] warn_slowpath_null+0x1a/0x20
[  +0.000010]  [<ffffffffc0463ee3>] snd_hdac_sync_audio_rate+0x53/0x70
[snd_hda_core]
[  +0.000008]  [<ffffffffc04fa95e>]
generic_hdmi_playback_pcm_prepare+0xbe/0x210 [snd_hda_codec_hdmi]
[  +0.000013]  [<ffffffffc04891e2>] snd_hda_codec_prepare+0x52/0x120
[snd_hda_codec]
[  +0.000011]  [<ffffffffc0490ad8>] azx_pcm_prepare+0x138/0x2b0 [snd_hda_codec]
[  +0.000012]  [<ffffffffc0333a4a>] snd_pcm_do_prepare+0x1a/0x30 [snd_pcm]
[  +0.000009]  [<ffffffffc0333715>] snd_pcm_action_single+0x35/0x80 [snd_pcm]
[  +0.000005]  [<ffffffff818ba2ff>] ? down_read+0x8f/0xa0
[  +0.000009]  [<ffffffffc03338f8>] snd_pcm_action_nonatomic+0x68/0x70 [snd_pcm]
[  +0.000009]  [<ffffffffc0336c68>] snd_pcm_common_ioctl1+0x688/0xc60 [snd_pcm]
[  +0.000010]  [<ffffffffc0337423>]
snd_pcm_playback_ioctl1+0x1e3/0x320 [snd_pcm]
[  +0.000009]  [<ffffffffc0337587>] snd_pcm_playback_ioctl+0x27/0x40 [snd_pcm]
[  +0.000005]  [<ffffffff812aa6e4>] do_vfs_ioctl+0xa4/0x6d0
[  +0.000005]  [<ffffffff81183d2d>] ? __audit_syscall_entry+0xad/0xf0
[  +0.000005]  [<ffffffff812aad89>] SyS_ioctl+0x79/0x90
[  +0.000005]  [<ffffffff81004029>] do_syscall_64+0x69/0x190
[  +0.000005]  [<ffffffff818bcaff>] entry_SYSCALL64_slow_path+0x25/0x25
[  +0.000005] ---[ end trace 0a6c6b61165f650f ]---
[  +0.017644] ------------[ cut here ]------------
[  +0.000021] WARNING: CPU: 1 PID: 1316 at sound/hda/hdac_i915.c:129
snd_hdac_sync_audio_rate+0x53/0x70 [snd_hda_core]()
[  +0.000005] Modules linked in: xt_CHECKSUM ipt_MASQUERADE
nf_nat_masquerade_ipv4 tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp
llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw bnep iTCO_wdt intel_rapl
iTCO_vendor_support intel_soc_dts_iosf coretemp kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel arc4 vfat fat iwlmvm mac80211 iwlwifi
snd_hda_codec_hdmi cfg80211 snd_hda_codec_realtek
snd_hda_codec_generic btusb btrtl lpc_ich i2c_i801 snd_hda_intel
snd_hda_codec mei_txe
[  +0.000096]  snd_hda_core snd_hwdep mei snd_intel_sst_acpi
snd_intel_sst_core snd_soc_rt5640 snd_soc_sst_mfld_platform
snd_soc_rl6231 ir_lirc_codec lirc_dev snd_soc_sst_match snd_soc_core
rc_rc6_mce snd_compress ite_cir snd_pcm_dmaengine rc_core ac97_bus
snd_seq snd_seq_device hci_uart dw_dmac snd_pcm btbcm dw_dmac_core
btqca btintel bluetooth snd_timer snd rfkill_gpio soundcore rfkill
i2c_designware_platform i2c_designware_core spi_pxa2xx_platform
tpm_tis tpm i915 r8169 serio_raw mii i2c_algo_bit drm_kms_helper drm
video fjes sdhci_acpi i2c_hid sdhci mmc_core
[  +0.000079] CPU: 1 PID: 1316 Comm: pulseaudio Tainted: G        W
   4.6.0-0.rc0.git11.1.fc25.x86_64 #1
[  +0.000004] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[  +0.000004]  0000000000000286 00000000fefe8725 ffff8800ac403bb8
ffffffff81454ea5
[  +0.000007]  0000000000000000 ffffffffc0465eea ffff8800ac403bf0
ffffffff810b2912
[  +0.000006]  ffff88023308b000 0000000000000004 ffff8800b804a000
ffff880233b12000
[  +0.000006] Call Trace:
[  +0.000009]  [<ffffffff81454ea5>] dump_stack+0x86/0xc1
[  +0.000007]  [<ffffffff810b2912>] warn_slowpath_common+0x82/0xc0
[  +0.000005]  [<ffffffff810b2a5a>] warn_slowpath_null+0x1a/0x20
[  +0.000010]  [<ffffffffc0463ee3>] snd_hdac_sync_audio_rate+0x53/0x70
[snd_hda_core]
[  +0.000007]  [<ffffffffc04fa95e>]
generic_hdmi_playback_pcm_prepare+0xbe/0x210 [snd_hda_codec_hdmi]
[  +0.000013]  [<ffffffffc04891e2>] snd_hda_codec_prepare+0x52/0x120
[snd_hda_codec]
[  +0.000011]  [<ffffffffc0490ad8>] azx_pcm_prepare+0x138/0x2b0 [snd_hda_codec]
[  +0.000012]  [<ffffffffc0333a4a>] snd_pcm_do_prepare+0x1a/0x30 [snd_pcm]
[  +0.000009]  [<ffffffffc0333715>] snd_pcm_action_single+0x35/0x80 [snd_pcm]
[  +0.000005]  [<ffffffff818ba2ff>] ? down_read+0x8f/0xa0
[  +0.000009]  [<ffffffffc03338f8>] snd_pcm_action_nonatomic+0x68/0x70 [snd_pcm]
[  +0.000009]  [<ffffffffc0336c68>] snd_pcm_common_ioctl1+0x688/0xc60 [snd_pcm]
[  +0.000010]  [<ffffffffc0337423>]
snd_pcm_playback_ioctl1+0x1e3/0x320 [snd_pcm]
[  +0.000009]  [<ffffffffc0337587>] snd_pcm_playback_ioctl+0x27/0x40 [snd_pcm]
[  +0.000005]  [<ffffffff812aa6e4>] do_vfs_ioctl+0xa4/0x6d0
[  +0.000005]  [<ffffffff81183d2d>] ? __audit_syscall_entry+0xad/0xf0
[  +0.000005]  [<ffffffff812aad89>] SyS_ioctl+0x79/0x90
[  +0.000005]  [<ffffffff81004029>] do_syscall_64+0x69/0x190
[  +0.000005]  [<ffffffff818bcaff>] entry_SYSCALL64_slow_path+0x25/0x25
[  +0.000004] ---[ end trace 0a6c6b61165f6510 ]---
[  +0.011138] ------------[ cut here ]------------
[  +0.000020] WARNING: CPU: 0 PID: 1316 at sound/hda/hdac_i915.c:129
snd_hdac_sync_audio_rate+0x53/0x70 [snd_hda_core]()
[  +0.000004] Modules linked in: xt_CHECKSUM ipt_MASQUERADE
nf_nat_masquerade_ipv4 tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp
llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw bnep iTCO_wdt intel_rapl
iTCO_vendor_support intel_soc_dts_iosf coretemp kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel arc4 vfat fat iwlmvm mac80211 iwlwifi
snd_hda_codec_hdmi cfg80211 snd_hda_codec_realtek
snd_hda_codec_generic btusb btrtl lpc_ich i2c_i801 snd_hda_intel
snd_hda_codec mei_txe
[  +0.000091]  snd_hda_core snd_hwdep mei snd_intel_sst_acpi
snd_intel_sst_core snd_soc_rt5640 snd_soc_sst_mfld_platform
snd_soc_rl6231 ir_lirc_codec lirc_dev snd_soc_sst_match snd_soc_core
rc_rc6_mce snd_compress ite_cir snd_pcm_dmaengine rc_core ac97_bus
snd_seq snd_seq_device hci_uart dw_dmac snd_pcm btbcm dw_dmac_core
btqca btintel bluetooth snd_timer snd rfkill_gpio soundcore rfkill
i2c_designware_platform i2c_designware_core spi_pxa2xx_platform
tpm_tis tpm i915 r8169 serio_raw mii i2c_algo_bit drm_kms_helper drm
video fjes sdhci_acpi i2c_hid sdhci mmc_core
[  +0.000075] CPU: 0 PID: 1316 Comm: pulseaudio Tainted: G        W
   4.6.0-0.rc0.git11.1.fc25.x86_64 #1
[  +0.000004] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[  +0.000003]  0000000000000286 00000000fefe8725 ffff8800ac403bb8
ffffffff81454ea5
[  +0.000007]  0000000000000000 ffffffffc0465eea ffff8800ac403bf0
ffffffff810b2912
[  +0.000006]  ffff88023308b000 0000000000000004 ffff8800b804a000
ffff880233b12000
[  +0.000006] Call Trace:
[  +0.000008]  [<ffffffff81454ea5>] dump_stack+0x86/0xc1
[  +0.000007]  [<ffffffff810b2912>] warn_slowpath_common+0x82/0xc0
[  +0.000005]  [<ffffffff810b2a5a>] warn_slowpath_null+0x1a/0x20
[  +0.000009]  [<ffffffffc0463ee3>] snd_hdac_sync_audio_rate+0x53/0x70
[snd_hda_core]
[  +0.000007]  [<ffffffffc04fa95e>]
generic_hdmi_playback_pcm_prepare+0xbe/0x210 [snd_hda_codec_hdmi]
[  +0.000012]  [<ffffffffc04891e2>] snd_hda_codec_prepare+0x52/0x120
[snd_hda_codec]
[  +0.000011]  [<ffffffffc0490ad8>] azx_pcm_prepare+0x138/0x2b0 [snd_hda_codec]
[  +0.000012]  [<ffffffffc0333a4a>] snd_pcm_do_prepare+0x1a/0x30 [snd_pcm]
[  +0.000008]  [<ffffffffc0333715>] snd_pcm_action_single+0x35/0x80 [snd_pcm]
[  +0.000006]  [<ffffffff818ba2ff>] ? down_read+0x8f/0xa0
[  +0.000009]  [<ffffffffc03338f8>] snd_pcm_action_nonatomic+0x68/0x70 [snd_pcm]
[  +0.000009]  [<ffffffffc0336c68>] snd_pcm_common_ioctl1+0x688/0xc60 [snd_pcm]
[  +0.000009]  [<ffffffffc0337423>]
snd_pcm_playback_ioctl1+0x1e3/0x320 [snd_pcm]
[  +0.000009]  [<ffffffffc0337587>] snd_pcm_playback_ioctl+0x27/0x40 [snd_pcm]
[  +0.000006]  [<ffffffff812aa6e4>] do_vfs_ioctl+0xa4/0x6d0
[  +0.000005]  [<ffffffff81183d2d>] ? __audit_syscall_entry+0xad/0xf0
[  +0.000005]  [<ffffffff812aad89>] SyS_ioctl+0x79/0x90
[  +0.000005]  [<ffffffff81004029>] do_syscall_64+0x69/0x190
[  +0.000005]  [<ffffffff818bcaff>] entry_SYSCALL64_slow_path+0x25/0x25
[  +0.000004] ---[ end trace 0a6c6b61165f6511 ]---
[  +0.010960] ------------[ cut here ]------------
[  +0.000018] WARNING: CPU: 0 PID: 1316 at sound/hda/hdac_i915.c:129
snd_hdac_sync_audio_rate+0x53/0x70 [snd_hda_core]()
[  +0.000004] Modules linked in: xt_CHECKSUM ipt_MASQUERADE
nf_nat_masquerade_ipv4 tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp
llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw bnep iTCO_wdt intel_rapl
iTCO_vendor_support intel_soc_dts_iosf coretemp kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel arc4 vfat fat iwlmvm mac80211 iwlwifi
snd_hda_codec_hdmi cfg80211 snd_hda_codec_realtek
snd_hda_codec_generic btusb btrtl lpc_ich i2c_i801 snd_hda_intel
snd_hda_codec mei_txe
[  +0.000092]  snd_hda_core snd_hwdep mei snd_intel_sst_acpi
snd_intel_sst_core snd_soc_rt5640 snd_soc_sst_mfld_platform
snd_soc_rl6231 ir_lirc_codec lirc_dev snd_soc_sst_match snd_soc_core
rc_rc6_mce snd_compress ite_cir snd_pcm_dmaengine rc_core ac97_bus
snd_seq snd_seq_device hci_uart dw_dmac snd_pcm btbcm dw_dmac_core
btqca btintel bluetooth snd_timer snd rfkill_gpio soundcore rfkill
i2c_designware_platform i2c_designware_core spi_pxa2xx_platform
tpm_tis tpm i915 r8169 serio_raw mii i2c_algo_bit drm_kms_helper drm
video fjes sdhci_acpi i2c_hid sdhci mmc_core
[  +0.000076] CPU: 0 PID: 1316 Comm: pulseaudio Tainted: G        W
   4.6.0-0.rc0.git11.1.fc25.x86_64 #1
[  +0.000004] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[  +0.000003]  0000000000000286 00000000fefe8725 ffff8800ac403bb8
ffffffff81454ea5
[  +0.000008]  0000000000000000 ffffffffc0465eea ffff8800ac403bf0
ffffffff810b2912
[  +0.000006]  ffff88023308b000 0000000000000004 ffff8800b804a000
ffff880233b12000
[  +0.000006] Call Trace:
[  +0.000008]  [<ffffffff81454ea5>] dump_stack+0x86/0xc1
[  +0.000008]  [<ffffffff810b2912>] warn_slowpath_common+0x82/0xc0
[  +0.000005]  [<ffffffff810b2a5a>] warn_slowpath_null+0x1a/0x20
[  +0.000010]  [<ffffffffc0463ee3>] snd_hdac_sync_audio_rate+0x53/0x70
[snd_hda_core]
[  +0.000007]  [<ffffffffc04fa95e>]
generic_hdmi_playback_pcm_prepare+0xbe/0x210 [snd_hda_codec_hdmi]
[  +0.000015]  [<ffffffffc04891e2>] snd_hda_codec_prepare+0x52/0x120
[snd_hda_codec]
[  +0.000011]  [<ffffffffc0490ad8>] azx_pcm_prepare+0x138/0x2b0 [snd_hda_codec]
[  +0.000013]  [<ffffffffc0333a4a>] snd_pcm_do_prepare+0x1a/0x30 [snd_pcm]
[  +0.000009]  [<ffffffffc0333715>] snd_pcm_action_single+0x35/0x80 [snd_pcm]
[  +0.000006]  [<ffffffff818ba2ff>] ? down_read+0x8f/0xa0
[  +0.000008]  [<ffffffffc03338f8>] snd_pcm_action_nonatomic+0x68/0x70 [snd_pcm]
[  +0.000009]  [<ffffffffc0336c68>] snd_pcm_common_ioctl1+0x688/0xc60 [snd_pcm]
[  +0.000010]  [<ffffffffc0337423>]
snd_pcm_playback_ioctl1+0x1e3/0x320 [snd_pcm]
[  +0.000009]  [<ffffffffc0337587>] snd_pcm_playback_ioctl+0x27/0x40 [snd_pcm]
[  +0.000005]  [<ffffffff812aa6e4>] do_vfs_ioctl+0xa4/0x6d0
[  +0.000006]  [<ffffffff81183d2d>] ? __audit_syscall_entry+0xad/0xf0
[  +0.000004]  [<ffffffff812aad89>] SyS_ioctl+0x79/0x90
[  +0.000006]  [<ffffffff81004029>] do_syscall_64+0x69/0x190
[  +0.000004]  [<ffffffff818bcaff>] entry_SYSCALL64_slow_path+0x25/0x25
[  +0.000005] ---[ end trace 0a6c6b61165f6512 ]---
[  +0.010145] ------------[ cut here ]------------
[  +0.000018] WARNING: CPU: 0 PID: 1316 at sound/hda/hdac_i915.c:129
snd_hdac_sync_audio_rate+0x53/0x70 [snd_hda_core]()
[  +0.000004] Modules linked in: xt_CHECKSUM ipt_MASQUERADE
nf_nat_masquerade_ipv4 tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp
llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw bnep iTCO_wdt intel_rapl
iTCO_vendor_support intel_soc_dts_iosf coretemp kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel arc4 vfat fat iwlmvm mac80211 iwlwifi
snd_hda_codec_hdmi cfg80211 snd_hda_codec_realtek
snd_hda_codec_generic btusb btrtl lpc_ich i2c_i801 snd_hda_intel
snd_hda_codec mei_txe
[  +0.000119]  snd_hda_core snd_hwdep mei snd_intel_sst_acpi
snd_intel_sst_core snd_soc_rt5640 snd_soc_sst_mfld_platform
snd_soc_rl6231 ir_lirc_codec lirc_dev snd_soc_sst_match snd_soc_core
rc_rc6_mce snd_compress ite_cir snd_pcm_dmaengine rc_core ac97_bus
snd_seq snd_seq_device hci_uart dw_dmac snd_pcm btbcm dw_dmac_core
btqca btintel bluetooth snd_timer snd rfkill_gpio soundcore rfkill
i2c_designware_platform i2c_designware_core spi_pxa2xx_platform
tpm_tis tpm i915 r8169 serio_raw mii i2c_algo_bit drm_kms_helper drm
video fjes sdhci_acpi i2c_hid sdhci mmc_core
[  +0.000075] CPU: 0 PID: 1316 Comm: pulseaudio Tainted: G        W
   4.6.0-0.rc0.git11.1.fc25.x86_64 #1
[  +0.000004] Hardware name:
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff/DN2820FYK,
BIOS FYBYT10H.86A.0034.2014.0513.1413 05/13/2014
[  +0.000004]  0000000000000286 00000000fefe8725 ffff8800ac403bb8
ffffffff81454ea5
[  +0.000007]  0000000000000000 ffffffffc0465eea ffff8800ac403bf0
ffffffff810b2912
[  +0.000006]  ffff88023308b000 0000000000000004 ffff8800b804a000
ffff880233b12000
[  +0.000006] Call Trace:
[  +0.000009]  [<ffffffff81454ea5>] dump_stack+0x86/0xc1
[  +0.000007]  [<ffffffff810b2912>] warn_slowpath_common+0x82/0xc0
[  +0.000005]  [<ffffffff810b2a5a>] warn_slowpath_null+0x1a/0x20
[  +0.000010]  [<ffffffffc0463ee3>] snd_hdac_sync_audio_rate+0x53/0x70
[snd_hda_core]
[  +0.000007]  [<ffffffffc04fa95e>]
generic_hdmi_playback_pcm_prepare+0xbe/0x210 [snd_hda_codec_hdmi]
[  +0.000014]  [<ffffffffc04891e2>] snd_hda_codec_prepare+0x52/0x120
[snd_hda_codec]
[  +0.000011]  [<ffffffffc0490ad8>] azx_pcm_prepare+0x138/0x2b0 [snd_hda_codec]
[  +0.000011]  [<ffffffffc0333a4a>] snd_pcm_do_prepare+0x1a/0x30 [snd_pcm]
[  +0.000009]  [<ffffffffc0333715>] snd_pcm_action_single+0x35/0x80 [snd_pcm]
[  +0.000006]  [<ffffffff818ba2ff>] ? down_read+0x8f/0xa0
[  +0.000009]  [<ffffffffc03338f8>] snd_pcm_action_nonatomic+0x68/0x70 [snd_pcm]
[  +0.000009]  [<ffffffffc0336c68>] snd_pcm_common_ioctl1+0x688/0xc60 [snd_pcm]
[  +0.000009]  [<ffffffffc0337423>]
snd_pcm_playback_ioctl1+0x1e3/0x320 [snd_pcm]
[  +0.000010]  [<ffffffffc0337587>] snd_pcm_playback_ioctl+0x27/0x40 [snd_pcm]
[  +0.000005]  [<ffffffff812aa6e4>] do_vfs_ioctl+0xa4/0x6d0
[  +0.000006]  [<ffffffff81183d2d>] ? __audit_syscall_entry+0xad/0xf0
[  +0.000005]  [<ffffffff812aad89>] SyS_ioctl+0x79/0x90
[  +0.000005]  [<ffffffff81004029>] do_syscall_64+0x69/0x190
[  +0.000005]  [<ffffffff818bcaff>] entry_SYSCALL64_slow_path+0x25/0x25
[  +0.000004] ---[ end trace 0a6c6b61165f6513 ]---
