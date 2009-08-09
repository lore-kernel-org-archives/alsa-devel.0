From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: [BUG] NULL pointer dereference in patch_sigmatel.c
Date: Sun, 09 Aug 2009 15:10:31 +0300
Message-ID: <4A7EBCB7.8010104@pardus.org.tr>
References: <4A5F84D6.5040708@pardus.org.tr>
	<s5h1vofac2z.wl%tiwai@suse.de>	<s5hy6qn8wyj.wl%tiwai@suse.de>
	<4A7ADD87.4030109@pardus.org.tr>	<s5hfxc5114w.wl%tiwai@suse.de>
	<4A7BF4F7.20405@pardus.org.tr>	<ad2655cb0908070243h6318dbdep80d90a08fa6c435b@mail.gmail.com>	<s5hiqh0ymkn.wl%tiwai@suse.de>
	<4A7C03BE.7040300@pardus.org.tr>	<s5hd477zyo1.wl%tiwai@suse.de>
	<4A7C2E87.1060102@pardus.org.tr> <s5hljlvyc8m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id EB75624392
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 14:10:31 +0200 (CEST)
In-Reply-To: <s5hljlvyc8m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>
>> The patch below doesn't undef CONFIG_SND_HDA_INPUT_JACK after
>> configuring. Actually there are config1.h* and config.h* and both
>> contains def/undefs for *JACK* stuff. But I'll undefine it after
>> configure and then compile to see it the error goes.
>>     
>
> Yeah I realized it, now fixed alsa-driver GIT tree to undef in
> adriver.h instead.
>
>
> Takashi
>   

I've compiled the latest snapshot which includes that fix and made it
try to the guy who has the sigmatel codec. It still oopses but in
another place. I've double checked with #error that SND_HDA_INPUT_JACK
and SND_JACK is unset. The new oops backtrace:

BUG: unable to handle kernel NULL pointer dereference at 00000000
IP: [<f8c774ba>] :snd_hda_codec_idt:stac92xx_init+0x280/0x504
*pde = 00000000 
Oops: 0000 [#1] SMP 
Modules linked in: snd_hda_codec_idt snd_hda_intel(+) snd_hda_codec aes_i586 aes_generic ipv6 af_packet bridge bnep rfcomm l2cap microcode acpi_cpufreq cpufreq_powersave cpufreq_userspace cpufreq_conservative ndiswrapper vboxdrv snd_hwdep nvidia(P) arc4 snd_seq_dummy ecb iwl4965 snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm hci_usb snd_timer intel_agp iwlcore thermal bluetooth rfkill led_class processor agpgart r5u870 sky2 battery mac80211 usbcam videobuf_dma_sg pcmcia firmware_class videobuf_core sony_laptop uvcvideo compat_ioctl32 videodev v4l1_compat iTCO_wdt tpm_infineon cfg80211 video output tifm_7xx1 tifm_core yenta_socket rsrc_nonstatic snd soundcore snd_page_alloc button rtc_cmos ac rtc_core joydev iTCO_vendor_support tpm tpm_bios i2c_i801 
 i2c_core pcmcia_core rtc_lib sg ext3 jbd mbcache sr_mod cdrom sd_mod ata_piix uhci_hcd pata_acpi ehci_hcd usbcore ohci1394 ieee1394 ata_generic libata scsi_mod dock

Pid: 1899, comm: modprobe Tainted: P         (2.6.25.20-114 #1)
EIP: 0060:[<f8c774ba>] EFLAGS: 00210246 CPU: 0
EIP is at stac92xx_init+0x280/0x504 [snd_hda_codec_idt]
EAX: 00000000 EBX: 00000040 ECX: 00000000 EDX: 0000000a
ESI: f592dc00 EDI: f6a05800 EBP: f6705d4c ESP: f6705d28
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process modprobe (pid: 1899, ti=f6704000 task=f670c000 task.ti=f6704000)
Stack: 00000000 f6705d5c f8c5b24a f6e61800 00000001 00080002 f592dc00 f67ac200 
       f679856c f6705d58 f8c5a6ec f592dc00 f6705d6c f8c5b298 f6798564 f67ac200 
       00000000 f6705dcc f8c6e2e8 f6ea2146 f6705da4 f74a3c00 00000004 00000008 
Call Trace:
 [<f8c5b24a>] ? snd_hda_codec_build_pcms+0x216/0x24c [snd_hda_codec]
 [<f8c5a6ec>] ? snd_hda_codec_build_controls+0x20/0x3d [snd_hda_codec]
 [<f8c5b298>] ? snd_hda_build_controls+0x18/0x67 [snd_hda_codec]
 [<f8c6e2e8>] ? azx_probe+0x863/0x8fb [snd_hda_intel]
 [<f8c6d91a>] ? azx_send_cmd+0x0/0x126 [snd_hda_intel]
 [<f8c6d733>] ? azx_get_response+0x0/0x1e7 [snd_hda_intel]
 [<f8c6cf50>] ? azx_attach_pcm_stream+0x0/0x15c [snd_hda_intel]
 [<f8c6cc06>] ? azx_bus_reset+0x0/0x56 [snd_hda_intel]
 [<f8c6caae>] ? azx_power_notify+0x0/0x57 [snd_hda_intel]
 [<c01e7a37>] ? pci_device_probe+0x39/0x59
 [<c024395f>] ? driver_probe_device+0xa0/0x136
 [<c0243a50>] ? __driver_attach+0x5b/0x91
 [<c024333c>] ? bus_for_each_dev+0x3b/0x63
 [<c0243804>] ? driver_attach+0x14/0x16
 [<c02439f5>] ? __driver_attach+0x0/0x91
 [<c0242d3a>] ? bus_add_driver+0x9d/0x1ba
 [<c0243bc4>] ? driver_register+0x47/0xa7
 [<c0168681>] ? __vunmap+0x93/0x9b
 [<c01e7bec>] ? __pci_register_driver+0x35/0x61
 [<f8a4b017>] ? alsa_card_azx_init+0x17/0x19 [snd_hda_intel]
 [<c0141f9c>] ? sys_init_module+0x18ad/0x19ca
 [<c0109c77>] ? do_syscall_trace+0x138/0x17f
 [<c0104a2e>] ? syscall_call+0x7/0xb
 [<c02d0000>] ? pci_bus_size_bridges+0x362/0x36d
 =======================
Code: 0f b7 94 5f a4 02 00 00 b9 01 00 00 00 89 f0 43 e8 90 ef ff ff 3b 9f 9c 02 00 00 7c e3 f6 47 18 40 74 40 8b 87 08 01 00 00 31 c9 <0f> b7 10 89 f0 6a 00 68 01 07 00 00 e8 0c 1e fe ff 0f b7 97 28 
EIP: [<f8c774ba>] stac92xx_init+0x280/0x504 [snd_hda_codec_idt] SS:ESP 0068:f6705d28
---[ end trace fc30bda5826e9f63 ]---

markup_oops output:

No vmlinux specified, assuming /lib/modules/2.6.25.20-114/build/vmlinux                                           
                 */                                                                                               
                stac92xx_auto_set_pinctl(codec, spec->autocfg.line_out_pins[0],
                                AC_PINCTL_OUT_EN);
                /* fake event to set up pins */
                stac_issue_unsol_event(codec, spec->autocfg.hp_pins[0]);
        } else {
 f8c774a4:      3b 9f 9c 02 00 00       cmp    0x29c(%edi),%ebx    |  %edi = f6a05800  %ebx => 40
 f8c774aa:      7c e3                   jl     f8c7748f <stac92xx_init+0x255>
                stac92xx_auto_init_multi_out(codec);
                stac92xx_auto_init_hp_out(codec);
                for (i = 0; i < cfg->hp_outs; i++)
 f8c774ac:      f6 47 18 40             testb  $0x40,0x18(%edi)    |  %edi = f6a05800
 f8c774b0:      74 40                   je     f8c774f2 <stac92xx_init+0x2b8>
                        stac_toggle_power_map(codec, cfg->hp_pins[i], 1);
        }
 f8c774b2:      8b 87 08 01 00 00       mov    0x108(%edi),%eax    |  %edi = f6a05800  %eax => 0
 f8c774b8:      31 c9                   xor    %ecx,%ecx           |  %ecx => 0
*f8c774ba:      0f b7 10                movzwl (%eax),%edx         |  %eax = 0  %edx = a <--- faulting instruction
 f8c774bd:      89 f0                   mov    %esi,%eax
 f8c774bf:      6a 00                   push   $0x0
 f8c774c1:      68 01 07 00 00          push   $0x701
 f8c774c6:      e8 fc ff ff ff          call   f8c774c7 <stac92xx_init+0x28d>
        if (spec->auto_mic) {
                /* initialize connection to analog input */
 f8c774cb:      0f b7 97 28 01 00 00    movzwl 0x128(%edi),%edx
 f8c774d2:      b9 06 00 00 00          mov    $0x6,%ecx
 f8c774d7:      89 f0                   mov    %esi,%eax
 f8c774d9:      e8 8d fc ff ff          call   f8c7716b <enable_pin_detect>
 f8c774de:      59                      pop    %ecx
 f8c774df:      5b                      pop    %ebx
 f8c774e0:      85 c0                   test   %eax,%eax
 f8c774e2:      74 0e                   je     f8c774f2 <stac92xx_init+0x2b8>
                snd_hda_codec_write_cache(codec, spec->dmux_nids[0], 0,
 f8c774e4:      0f b7 97 28 01 00 00    movzwl 0x128(%edi),%edx
 f8c774eb:      89 f0                   mov    %esi,%eax
 f8c774ed:      e8 8d ed ff ff          call   f8c7627f <stac_issue_unsol_event>
 f8c774f2:      c7 45 f0 00 00 00 00    movl   $0x0,-0x10(%ebp)
...

I had troubles to decode this faulty instruction to the current source code but I've added some printk's to suspicious dereferences and told the guy to retry.

I'll be able to test the conexant one tomorrow.
Thanks,
