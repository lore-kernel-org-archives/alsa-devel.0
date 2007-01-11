From: Simon Wood <simon@mungewell.org>
Subject: Re: snd-usb-audio: adding support for X-Box Wireless
 Communicator
Date: Thu, 11 Jan 2007 08:17:27 -0700
Message-ID: <20070111081727.b913d280.simon@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__11_Jan_2007_08_17_27_-0700_ivHu+qqC8T2_emMe"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Thu__11_Jan_2007_08_17_27_-0700_ivHu+qqC8T2_emMe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


On Mon, 08 Jan 2007 12:15:34 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Thanks for the patch!

Don't mention it.... though don't forget it doesn't work!

I did some more thinking and (now) reckon that this device has only an 'in' and 'out' port which 'audio' should be streamed to/from. I don't know the format, but the packet size looks a little small compared to what I could google.

At present the attached patch causes the attached kernel panic. It seems there is a problem trying to create the fixed stream....

Any suggestions are appreciated as I'm a bit lost here (I'm good at soldering though ;-).
Cheers,
Simon.




--Multipart=_Thu__11_Jan_2007_08_17_27_-0700_ivHu+qqC8T2_emMe
Content-Type: text/plain;
 name="temp.txt"
Content-Disposition: attachment;
 filename="temp.txt"
Content-Transfer-Encoding: 7bit

Jan 10 22:02:49 bourne kernel: [17348849.468000] usb 2-1: new full speed USB device using uhci_hcd and address 2
Jan 10 22:02:49 bourne kernel: [17348849.604000] snd-usb-audio: probe of 2-1:1.0 failed with error -5
Jan 10 22:02:49 bourne kernel: [17348849.620000] d0d34430
Jan 10 22:02:49 bourne kernel: [17348849.628000] PREEMPT SMP 
Jan 10 22:02:49 bourne kernel: [17348849.628000] Modules linked in: snd_seq_oss snd_seq_midi snd_seq_midi_event snd_pcm_oss snd_usb_audio snd_pcm snd_seq snd_usb_lib snd_timer snd_rawmidi snd_hwdep snd_seq_device snd_mixer_oss snd soundcore snd_page_alloc nls_utf8 rfcomm l2cap bluetooth ipv6 nvram uinput ppdev radeon drm speedstep_ich speedstep_lib cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand cpufreq_conservative video tc1100_wmi sony_acpi pcc_acpi ibm_acpi hotkey dev_acpi container button acpi_sbs battery ac i2c_acpi_ec i2c_core nls_iso8859_1 nls_cp437 vfat fat aes dm_crypt dm_mod md_mod fuse sr_mod cdrom sbp2 ieee1394 af_packet lp tsdev hostap_pci hostap pcmcia ieee80211_crypt irtty_sir sir_dev irda crc_ccitt parport_pc parport floppy pcspkr e100 mii orinoco_pci orinoco hermes psmouse serio_raw yenta_socket rsrc_nonstatic pcmcia_core hw_random intel_agp
  shpchp pci_hotplug agpgart sg sd_mod evdev ext3 jbd usb_storage scsi_mod ide_generic uhci
 _hcd usbcore ide_disk piix generic t
Jan 10 22:02:49 bourne kernel: ermal processor fan capability commoncap vga16fb vgastate fbcon tileblit font bitblit softcursor
Jan 10 22:02:49 bourne kernel: [17348849.628000] CPU:    0
Jan 10 22:02:49 bourne kernel: [17348849.628000] EIP:    0060:[pg0+277713968/1069167616]    Not tainted VLI
Jan 10 22:02:49 bourne kernel: [17348849.628000] EFLAGS: 00010206   (2.6.15-27-686) 
Jan 10 22:02:49 bourne kernel: [17348849.628000] EIP is at add_audio_endpoint+0x30/0x2a0 [snd_usb_audio]
Jan 10 22:02:49 bourne kernel: [17348849.628000] eax: 00000003   ebx: 00000001   ecx: 00000001   edx: 00000001
Jan 10 22:02:49 bourne kernel: [17348849.628000] esi: ca16f4f8   edi: ca16f4e0   ebp: 000001a0   esp: ce449d40
Jan 10 22:02:49 bourne kernel: [17348849.628000] ds: 007b   es: 007b   ss: 0068
Jan 10 22:02:49 bourne kernel: [17348849.628000] Process khubd (pid: 1802, threadinfo=ce448000 task=cfb92580)
Jan 10 22:02:49 bourne kernel: [17348849.628000] Stack: cce293e0 0000a1ff 00000020 cfbd9204 c584abc8 cd0be014 d0d44618 00000001 
Jan 10 22:02:49 bourne kernel: [17348849.628000]        00000000 d0d3a63c ca16f51c ca16f4e0 d0d35507 ca16f4e0 00000001 ca16f4e0 
Jan 10 22:02:49 bourne kernel: [17348849.628000]        c0332b1b cd0be014 d0d44610 cfb16c00 d0d44628 00000001 d0d35b0d ca16f4e0 
Jan 10 22:02:49 bourne kernel: [17348849.628000] Call Trace:
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+277718279/1069167616] create_fixed_stream_quirk+0x67/0x210 [snd_usb_audio]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+277719821/1069167616] create_composite_quirk+0x7d/0xc0 [snd_usb_audio]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+277721825/1069167616] snd_usb_audio_probe+0xc1/0x2b0 [snd_usb_audio]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+277722661/1069167616] usb_audio_probe+0x25/0x40 [snd_usb_audio]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+273014994/1069167616] usb_probe_interface+0x72/0xa0 [usbcore]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [driver_probe_device+84/240] driver_probe_device+0x54/0xf0
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [__device_attach+0/16] __device_attach+0x0/0x10
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [bus_for_each_drv+93/128] bus_for_each_drv+0x5d/0x80
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [device_attach+99/112] device_attach+0x63/0x70
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [__device_attach+0/16] __device_attach+0x0/0x10
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [bus_add_device+53/208] bus_add_device+0x35/0xd0
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [device_pm_add+81/144] device_pm_add+0x51/0x90
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [device_add+295/416] device_add+0x127/0x1a0
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+273054555/1069167616] usb_set_configuration+0x29b/0x4f0 [usbcore]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+273027299/1069167616] usb_new_device+0x133/0x1d0 [usbcore]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+273033515/1069167616] hub_port_connect_change+0x35b/0x430 [usbcore]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+273034451/1069167616] hub_events+0x2d3/0x4d0 [usbcore]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+273034960/1069167616] hub_thread+0x0/0xe0 [usbcore]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [pg0+273034981/1069167616] hub_thread+0x15/0xe0 [usbcore]
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [kthread+200/208] kthread+0xc8/0xd0
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [kthread+0/208] kthread+0x0/0xd0
Jan 10 22:02:49 bourne kernel: [17348849.628000]  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Jan 10 22:02:49 bourne kernel: [17348849.628000] Code: ec 20 8b 44 24 34 8b 54 24 38 8b 7c 24 34 8b 48 18 8d 04 52 8d 2c 82 c1 e5 05 89 cb 8d 77 18 8d b6 00 00 00 00 8d bf 00 00 00 00 <8b> 13 0f 18 02 90 39 de 74 26 8b 7c 24 3c 8b 47 10 39 83 bc fc 




--Multipart=_Thu__11_Jan_2007_08_17_27_-0700_ivHu+qqC8T2_emMe
Content-Type: text/plain;
 name="usbquirk_patch.txt"
Content-Disposition: attachment;
 filename="usbquirk_patch.txt"
Content-Transfer-Encoding: 7bit


{
	/*
	 * SDW hack for X-Box Communicator
	 */
	USB_DEVICE(0x045e, 0x0283),
	.driver_info = (unsigned long) & (struct snd_usb_audio_quirk) {
		.vendor_name = "Microsoft Corp.",
		.product_name = "X-Box Live Communicator",
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = (const snd_usb_audio_quirk_t[]) {
			{
				.ifnum = 0,
#if 0
                               .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                               .data = & (const struct audioformat) {
					.format = SNDRV_PCM_FORMAT_S16_LE,
					.channels = 2,
					.iface = 0,
					.altsetting = 1,
					.altset_idx = 1,
					.attributes = 0,
					.endpoint = 0x04,
					.ep_attr = 0x05,
					.rates = SNDRV_PCM_RATE_CONTINUOUS,
					.rate_min = 44100,
					.rate_max = 44100
				}
#else
				.type = QUIRK_IGNORE_INTERFACE
#endif
			},
			{
				.ifnum = 1,
#if 1
                               .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                               .data = & (const struct audioformat) {
					.format = USB_AUDIO_FORMAT_PCM,
					.channels = 2,
					.iface = 1,
					.altsetting = 1,
					.altset_idx = 1,
					.attributes = EP_CS_ATTR_FILL_MAX,
					.endpoint = 0x85,
					.ep_attr = 0x05,
					.maxpacksize = 0x30,
					.rates = SNDRV_PCM_RATE_CONTINUOUS,
					.rate_min = 44100,
					.rate_max = 44100
				}
#else
				.type = QUIRK_IGNORE_INTERFACE
#endif
			},
			{
				.ifnum = -1
			}
		}
	}
},




--Multipart=_Thu__11_Jan_2007_08_17_27_-0700_ivHu+qqC8T2_emMe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Multipart=_Thu__11_Jan_2007_08_17_27_-0700_ivHu+qqC8T2_emMe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Multipart=_Thu__11_Jan_2007_08_17_27_-0700_ivHu+qqC8T2_emMe--
