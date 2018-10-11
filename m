From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Oops when unloading SOF driver modules
Date: Thu, 11 Oct 2018 10:00:51 +0200
Message-ID: <20181011080046.GA17373@kadasd710.ka.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 45E39267737
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 10:02:00 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm tracking down a kernel Oops, occurring when unloading driver
modules. A complete Oops is below. It triggers because
cpu_dai->driver is NULL after remove_dai() in soc-topology.c freed it.
On my Debian system this only happens when I unload modules directly
after loading. If some time passes after loading the drivers, pulseaudio
completes its probing and releases the hardware, then remove_dai() isn't
called before snd_pcm_do_stop() but after, then everything is running
correctly. I'm not sure what the best way to fix this would be. Any
ideas?

Thanks
Guennadi

Oct  1 10:23:32 UP-APL01 kernel: [  142.978059] BUG: unable to handle kernel NULL pointer dereference at 0000000000000088
Oct  1 10:23:32 UP-APL01 kernel: [  142.978066] PGD 0 P4D 0
Oct  1 10:23:32 UP-APL01 kernel: [  142.978075] Oops: 0000 [#1] SMP NOPTI
Oct  1 10:23:32 UP-APL01 kernel: [  142.978083] CPU: 3 PID: 1240 Comm: alsa-sink-Port0 Tainted: G        W   E     4.18.0-upboard+ #1
Oct  1 10:23:32 UP-APL01 kernel: [  142.978087] Hardware name: AAEON UP-APL01/UP-APL01, BIOS UPA1AM36 04/10/2018
Oct  1 10:23:32 UP-APL01 kernel: [  142.978114] RIP: 0010:soc_pcm_trigger+0x16d/0x1d0 [snd_soc_core]
Oct  1 10:23:32 UP-APL01 kernel: [  142.978117] Code: 31 c0 48 85 c9 74 07 4c 8b 81 88 00 00 00 ba 6c 04 00 00 48 c7 c6 20 14 84 c0 48 c7 c7 72 34 84 c0 e8 55 a3 4a df 49 8b 45 18 <48> 8b 80 88 00 00 00 48 8b 80 88 00 00 00 48 85 c0 74 16 4c 89 ea
Oct  1 10:23:32 UP-APL01 kernel: [  142.978204] RSP: 0018:ffffb6b781243da8 EFLAGS: 00010286
Oct  1 10:23:32 UP-APL01 kernel: [  142.978207] RAX: 0000000000000000 RBX: ffff9146ae2a0800 RCX: 0000000000000000
Oct  1 10:23:32 UP-APL01 kernel: [  142.978210] RDX: 0000000000000000 RSI: ffff9146bfd96738 RDI: ffff9146bfd96738
Oct  1 10:23:32 UP-APL01 kernel: [  142.978212] RBP: ffff9146afdbbc00 R08: 00000000000006fd R09: 0000000000000004
Oct  1 10:23:32 UP-APL01 kernel: [  142.978215] R10: 00000000000001c3 R11: 0000000000000001 R12: 0000000000000000
Oct  1 10:23:32 UP-APL01 kernel: [  142.978217] R13: ffff9146b1b92f80 R14: ffff9146ae2a0eb0 R15: ffff9146ae2a0ea8
Oct  1 10:23:32 UP-APL01 kernel: [  142.978220] FS:  00007f3db6b24700(0000) GS:ffff9146bfd80000(0000) knlGS:0000000000000000
Oct  1 10:23:32 UP-APL01 kernel: [  142.978223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct  1 10:23:32 UP-APL01 kernel: [  142.978225] CR2: 0000000000000088 CR3: 0000000177ce6000 CR4: 00000000003406e0
Oct  1 10:23:32 UP-APL01 kernel: [  142.978228] Call Trace:
Oct  1 10:23:32 UP-APL01 kernel: [  142.978247]  dpcm_fe_dai_do_trigger+0xee/0x220 [snd_soc_core]
Oct  1 10:23:32 UP-APL01 kernel: [  142.978258]  snd_pcm_do_stop+0x65/0x80 [snd_pcm]
Oct  1 10:23:32 UP-APL01 kernel: [  142.978267]  snd_pcm_action_single+0x36/0x80 [snd_pcm]
Oct  1 10:23:32 UP-APL01 kernel: [  142.978275]  snd_pcm_drop+0x6f/0xa0 [snd_pcm]
Oct  1 10:23:32 UP-APL01 kernel: [  142.978283]  snd_pcm_release_substream+0x39/0xd0 [snd_pcm]
Oct  1 10:23:32 UP-APL01 kernel: [  142.978291]  snd_pcm_release+0x5d/0xb0 [snd_pcm]
Oct  1 10:23:32 UP-APL01 kernel: [  142.978298]  __fput+0xd0/0x1e0
Oct  1 10:23:32 UP-APL01 kernel: [  142.978305]  task_work_run+0x8a/0xb0
Oct  1 10:23:32 UP-APL01 kernel: [  142.978311]  exit_to_usermode_loop+0xe6/0xf0
Oct  1 10:23:32 UP-APL01 kernel: [  142.978315]  do_syscall_64+0xf3/0x110
Oct  1 10:23:32 UP-APL01 kernel: [  142.978321]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct  1 10:23:32 UP-APL01 kernel: [  142.978325] RIP: 0033:0x7f3dc0988ab7
Oct  1 10:23:32 UP-APL01 kernel: [  142.978327] Code: 10 e9 67 ff ff ff 0f 1f 44 00 00 48 8b 15 c9 f3 2c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff e9 6b ff ff ff b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a1 f3 2c 00 f7 d8 64 89 01 48
Oct  1 10:23:32 UP-APL01 kernel: [  142.978374] RSP: 002b:00007f3db6b23c38 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
Oct  1 10:23:32 UP-APL01 kernel: [  142.978377] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3dc0988ab7
Oct  1 10:23:32 UP-APL01 kernel: [  142.978380] RDX: 0000000000000010 RSI: 0000000000001000 RDI: 00007f3dc284a000
Oct  1 10:23:32 UP-APL01 kernel: [  142.978382] RBP: 000056431cb73ac0 R08: 00007f3db763a578 R09: 00007f3db6b23b50
Oct  1 10:23:32 UP-APL01 kernel: [  142.978384] R10: 00000000fffffff8 R11: 0000000000000202 R12: 000056431cb73ac0
Oct  1 10:23:32 UP-APL01 kernel: [  142.978387] R13: 000056431cb73ac0 R14: 0000000000000000 R15: 000056431caad4b0
Oct  1 10:23:32 UP-APL01 kernel: [  142.978390] Modules linked in: sof_pci_dev(E-) snd_sof_intel_hda_common(E) sof_acpi_dev(E) snd_sof_intel_bdw(E) snd_sof_intel_byt(E) snd_sof_nocodec(E) snd_sof_intel_hsw(E) snd_sof(E) snd_sof_xtensa_dsp(E) snd_soc_acpi_intel_match(E) snd_soc_acpi(E) snd_soc_da7213(E) snd_soc_rt5640(E) snd_soc_rt5651(E) snd_soc_rt5645(E) snd_soc_rt5670(E) snd_soc_rl6231(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) squashfs(E) loop(E) spi_pxa2xx_platform(E) intel_rapl(E) i2c_designware_platform(E) i2c_designware_core(E) x86_pkg_temp_thermal(E) coretemp(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) snd_hda_core(E) efi_pstore(E) pcbc(E) snd_soc_core(E) snd_compress(E) snd_pcm(E) snd_seq_midi(E) snd_seq_midi_event(E) snd_rawmidi
 (E) aesni_intel(E) aes_x86_64(E) crypto_simd(E)
Oct  1 10:23:32 UP-APL01 kernel: [  142.978445]  cryptd(E) glue_helper(E) intel_cstate(E) intel_rapl_perf(E) pwm_lpss_pci(E) efivars(E) lpc_ich(E) pwm_lpss(E) snd_seq(E) idma64(E) virt_dma(E) intel_lpss_pci(E) intel_lpss(E) mfd_core(E) snd_seq_device(E) snd_timer(E) tpm_crb(E) snd(E) tpm_tis(E) tpm_tis_core(E) tpm(E) evdev(E) rng_core(E) mei_me(E) mei(E) soundcore(E) pcc_cpufreq(E) sch_fq_codel(E) parport_pc(E) ppdev(E) lp(E) parport(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) fscrypto(E) hid_generic(E) usbhid(E) hid(E) mmc_block(E) dwc3(E) sdhci_pci(E) xhci_pci(E) cqhci(E) sdhci(E) crc32c_intel(E) i915(E) mmc_core(E) ahci(E) i2c_algo_bit(E) xhci_hcd(E) libahci(E) drm_kms_helper(E) dwc3_pci(E) usbcore(E) libata(E) r8169(E) mii(E)
  drm(E) scsi_mod(E) video(E) button(E) [last unloaded: snd_sof]
Oct  1 10:23:32 UP-APL01 kernel: [  142.978528] CR2: 0000000000000088
Oct  1 10:23:32 UP-APL01 kernel: [  142.978532] ---[ end trace f60338bc9477e8ed ]---
