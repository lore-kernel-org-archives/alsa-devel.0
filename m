From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Mon, 09 Apr 2012 21:21:46 +0200
Message-ID: <4F8336CA.9060809@gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag7_qzPJq44havp=EbFVKud5VvKaOLJk0i0dM43X3urp9Q@mail.gmail.com>
	<CAFz=ag6pqhfOvxv_ScbxJFs6OEZt18GM+Dgs1KWQMG7mdZO21g@mail.gmail.com>
	<CACckToXJAJxGo-LSM3X-q=6Vo=-KzuE2Om9bgFiDnWPFNWmnSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2691A24525
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Apr 2012 21:21:53 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so3523635bkw.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Apr 2012 12:21:52 -0700 (PDT)
In-Reply-To: <CACckToXJAJxGo-LSM3X-q=6Vo=-KzuE2Om9bgFiDnWPFNWmnSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

Hi Grant et al,


Again sorry for catching up so late on this.


On 16.01.2012 21:26, Grant Diffey wrote:
> So I've had a chance to do some testing. I can reliably generate then
> following trace with daniels patch on 3.2-rt10
> 
> [  188.561901] ------------[ cut here ]------------
> [  188.561908] WARNING: at fs/proc/generic.c:586 proc_register+0x181/0x1c7()
> [  188.561909] Hardware name: HP Compaq 6910p
> [  188.561911] proc_dir_entry 'card1/pcm0p' already registered

There might have been a race condition in the shutdown path which I fixed.

Could you repeat the tests you did some months ago and report whether
you still see this issue? I would also appreciate test input from other
people. Any kind of USB device is good to track these issues.

Regarding the difference in reported channel numbers, I can't really
point my finger to any specific line. It really puzzles me, as my patch
set leaves the detection of interfaces and the registration of pcm
streams untouched. It would help to know whether there is any difference
in the output of "aplay -l" with and without my patches applied.

To test the new set of patches, please start off with a 3.4.0 vanilla
kernel and then either

  git pull git://github.com/zonque/linux.git usb-audio

or manually apply the combined patch from https://gist.github.com/1168715


I hope to *finally* get this topic finished in this round, but I need
the some helpers for testing :)



Daniel



> [  188.561912] Modules linked in: snd_usb_audio snd_usbmidi_lib
> snd_seq_dummy acpi_cpufreq mperf cpufreq_userspace cpufreq_stats
> cpufreq_conservative cpufreq_powersave ppdev lp parport microcode
> binfmt_misc uinput fuse nfsd exportfs nfs lockd fscache auth_rpcgss
> nfs_acl sunrpc ext2 firewire_sbp2 loop btusb bluetooth
> snd_hda_codec_analog arc4 iwl4965 iwl_legacy i915 mac80211 uhci_hcd
> snd_hda_intel snd_hda_codec ehci_hcd drm_kms_helper snd_hwdep drm
> snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi cfg80211 snd_rawmidi
> snd_seq_midi_event snd_seq usbcore sr_mod mmc_block snd_timer
> tpm_infineon pata_pcmcia snd_seq_device firewire_ohci snd sdhci_pci
> i2c_algo_bit irda cdrom sdhci joydev pcmcia tpm_tis ata_generic ata_piix
> hp_wmi firewire_core i2c_core yenta_socket pcmcia_rsrc iTCO_wdt mmc_core
> battery pcmcia_core sparse_keymap ac power_supply rfkill pcspkr
> soundcore tpm tpm_bios wmi iTCO_vendor_support evdev crc_itu_t crc_ccitt
> psmouse processor container video usb_common snd_page_alloc serio_raw
> button ext3 jbd mbcache sha256_generic aes_x86_64 aes_generic cbc
> dm_crypt dm_mod sd_mod crc_t10dif ahci libahci libata scsi_mod fan
> thermal thermal_sys
> [  188.561979] Pid: 621, comm: khubd Not tainted
> 3.2.0-rt10-00255-g530565d #5
> [  188.561980] Call Trace:
> [  188.561986]  [<ffffffff81036273>] ? warn_slowpath_common+0x78/0x8c
> [  188.561989]  [<ffffffff8103631f>] ? warn_slowpath_fmt+0x45/0x4a
> [  188.561993]  [<ffffffff8102df06>] ? get_parent_ip+0x9/0x1b
> [  188.561995]  [<ffffffff81123ac5>] ? proc_register+0x181/0x1c7
> [  188.561997]  [<ffffffff81123e2c>] ? create_proc_entry+0x6e/0x85
> [  188.562020]  [<ffffffffa0237c18>] ? snd_info_register+0x35/0xbd [snd]
> [  188.562026]  [<ffffffffa02cdf89>] ? snd_pcm_new_stream+0xd6/0x417
> [snd_pcm]
> [  188.562031]  [<ffffffffa05b69e3>] ?
> snd_usb_add_audio_stream+0xd5/0x21c [snd_usb_audio]
> [  188.562035]  [<ffffffffa05b6fd3>] ?
> snd_usb_parse_audio_interface+0x4a9/0x556 [snd_usb_audio]
> [  188.562039]  [<ffffffffa05ae276>] ? snd_usb_create_stream+0xed/0x126
> [snd_usb_audio]
> [  188.562043]  [<ffffffffa05aea74>] ? usb_audio_probe+0x61d/0x72d
> [snd_usb_audio]
> [  188.562057]  [<ffffffffa028c6e3>] ? usb_probe_interface+0xf8/0x163
> [usbcore]
> [  188.562062]  [<ffffffff812170f1>] ? driver_probe_device+0xa8/0x138
> [  188.562064]  [<ffffffff812171f0>] ? __driver_attach+0x6f/0x6f
> [  188.562066]  [<ffffffff81216120>] ? bus_for_each_drv+0x4a/0x7e
> [  188.562069]  [<ffffffff81217012>] ? device_attach+0x6f/0x8f
> [  188.562071]  [<ffffffff8121692c>] ? bus_probe_device+0x1f/0x37
> [  188.562073]  [<ffffffff8121520a>] ? device_add+0x3d4/0x577
> [  188.562076]  [<ffffffff8102df06>] ? get_parent_ip+0x9/0x1b
> [  188.562078]  [<ffffffff81030bf0>] ? migrate_enable+0x150/0x16a
> [  188.562085]  [<ffffffffa028b2b0>] ? usb_set_configuration+0x53f/0x594
> [usbcore]
> [  188.562088]  [<ffffffff811304e6>] ? sysfs_do_create_link+0x149/0x194
> [  188.562094]  [<ffffffffa029231a>] ? generic_probe+0x45/0x73 [usbcore]
> [  188.562097]  [<ffffffff812170f1>] ? driver_probe_device+0xa8/0x138
> [  188.562099]  [<ffffffff812171f0>] ? __driver_attach+0x6f/0x6f
> [  188.562101]  [<ffffffff81216120>] ? bus_for_each_drv+0x4a/0x7e
> [  188.562104]  [<ffffffff81217012>] ? device_attach+0x6f/0x8f
> [  188.562106]  [<ffffffff8121692c>] ? bus_probe_device+0x1f/0x37
> [  188.562108]  [<ffffffff8121520a>] ? device_add+0x3d4/0x577
> [  188.562110]  [<ffffffff81214793>] ? dev_printk+0x48/0x4d
> [  188.562116]  [<ffffffffa0285188>] ? usb_new_device+0x124/0x198 [usbcore]
> [  188.562122]  [<ffffffffa02861eb>] ? hub_thread+0x964/0xe54 [usbcore]
> [  188.562124]  [<ffffffff8102abf4>] ? hrtick_start_fair+0x1a/0x15b
> [  188.562127]  [<ffffffff8102000a>] ? kern_addr_valid+0x5/0x93
> [  188.562131]  [<ffffffff8131adb9>] ? __schedule+0x531/0x548
> [  188.562135]  [<ffffffff8104ff82>] ? __init_waitqueue_head+0x39/0x39
> [  188.562140]  [<ffffffffa0285887>] ? usb_remote_wakeup+0x2f/0x2f [usbcore]
> [  188.562142]  [<ffffffff8104f8b8>] ? kthread+0x78/0x80
> [  188.562145]  [<ffffffff8102df06>] ? get_parent_ip+0x9/0x1b
> [  188.562148]  [<ffffffff81310000>] ? init_amd+0x112/0x3e4
> [  188.562151]  [<ffffffff81322d74>] ? kernel_thread_helper+0x4/0x10
> [  188.562154]  [<ffffffff8104f840>] ? __init_kthread_worker+0x41/0x41
> [  188.562156]  [<ffffffff81322d70>] ? gs_change+0x13/0x13
> [  188.562161] ---[ end trace 0000000000000002 ]---
> 
> 
> Grant
