From: Richard Smith <smithbone@gmail.com>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Mon, 31 Oct 2005 09:47:24 -0600
Message-ID: <8a0c36780510310747j3485f9b5ja5caca0dcf3ff848@mail.gmail.com>
References: <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com>
	 <Pine.HPX.4.33n.0510281416340.24464-100000@studcom.urz.uni-halle.de>
	 <8a0c36780510281134gce42934v61b094b072d8f841@mail.gmail.com>
	 <1130525518.4363.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6470_29392135.1130773644513"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1130525518.4363.57.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_6470_29392135.1130773644513
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Don't use ksymoops for 2.6.  Just post the oops verbatim.
>
> The kernel docs were wrong for a long time but they were recently fixed.

The oops I got is attached.

Oh and I solved my static problems!

You may find this humorous.

I was overdriving the input.  The source I was using turned out to be
a headphone output rather than a line level output.  So if I had the
volume turned up hardly any at all it would bang the input from rail
to rail thus creating what I thought  was noise.

That explains why I wasn't able to repeat any of my findings since it
really had nothing to do with any of the variables I was changing.

Thanks for all your help though.

--
Richard A. Smith

------=_Part_6470_29392135.1130773644513
Content-Type: application/octet-stream; name=oops
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="oops"


Oct 27 10:16:18 engine36 kernel: usb 1-2: USB disconnect, address 3

Oct 27 10:16:18 engine36 kernel: c01915c3
Oct 27 10:16:18 engine36 kernel: PREEMPT SMP 
Oct 27 10:16:18 engine36 kernel: Modules linked in: radeon drm rfcomm l2cap bluetooth sd_mod ipx p8022 psnap llc parport_pc lp parport ipv6 snd_via82xx snd_ac97_codec snd_ac97_bus snd_mpu401_uart i2c_viapro i2c_core via_agp ehci_hcd snd_usb_audio snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_usb_lib snd_rawmidi snd_hwdep snd soundcore uhci_hcd sg sr_mod dm_mod autofs4 af_packet agpgart via_rhine mii thermal processor fan button battery ac rtc usb_storage usbcore ide_cd cdrom ide_scsi scsi_mod
Oct 27 10:16:18 engine36 kernel: CPU:    0
Oct 27 10:16:18 engine36 kernel: EIP:    0060:[<c01915c3>]    Not tainted VLI
Oct 27 10:16:18 engine36 kernel: EFLAGS: 00010246   (2.6.14-rc5) 
Oct 27 10:16:18 engine36 kernel: EIP is at sysfs_hash_and_remove+0x1f/0x102
Oct 27 10:16:18 engine36 kernel: eax: df4912c8   ebx: dea09f08   ecx: dea28dc0   edx: dc0a27fc
Oct 27 10:16:18 engine36 kernel: esi: 00000000   edi: df206fe0   ebp: dedb7b80   esp: df1cbdb0
Oct 27 10:16:18 engine36 kernel: ds: 007b   es: 007b   ss: 0068
Oct 27 10:16:18 engine36 kernel: Process khubd (pid: 996, threadinfo=df1ca000 task=decc6550)
Oct 27 10:16:18 engine36 kernel: Stack: dffe0980 de9048bc de904878 dea09f08 dea09f00 df206fe0 dedb7b80 c02200bb 
Oct 27 10:16:18 engine36 kernel:        df4912c8 df206fe0 dedb7bfc dea09f00 df9baa60 e08f50e2 00000000 c0220121 
Oct 27 10:16:18 engine36 kernel:        dea09f00 df9baa40 e08ef550 dea09f00 07400000 00000000 df206360 df635d40 
Oct 27 10:16:18 engine36 kernel: Call Trace:
Oct 27 10:16:18 engine36 kernel:  [<c02200bb>] class_device_del+0xa5/0xfb
Oct 27 10:16:18 engine36 kernel:  [<c0220121>] class_device_unregister+0x10/0x1d
Oct 27 10:16:18 engine36 kernel:  [<e08ef550>] snd_unregister_device+0x83/0xcf [snd]
Oct 27 10:16:18 engine36 kernel:  [<e08f3c54>] snd_ctl_dev_unregister+0x23/0x39 [snd]
Oct 27 10:16:18 engine36 kernel:  [<e08f4173>] snd_device_free+0x9c/0xae [snd]
Oct 27 10:16:18 engine36 kernel:  [<e08f435b>] snd_device_free_all+0x58/0x61 [snd]
Oct 27 10:16:18 engine36 kernel:  [<e08efd74>] snd_card_free+0xff/0x1f9 [snd]
Oct 27 10:16:18 engine36 kernel:  [<e095fc4d>] snd_usb_audio_disconnect+0xb1/0xe7 [snd_usb_audio]
Oct 27 10:16:18 engine36 kernel:  [<e095fce2>] usb_audio_disconnect+0x22/0x26 [snd_usb_audio]
Oct 27 10:16:18 engine36 kernel:  [<e087e0f5>] usb_unbind_interface+0x41/0x7d [usbcore]
Oct 27 10:16:18 engine36 kernel:  [<c021f109>] __device_release_driver+0x61/0x81
Oct 27 10:16:18 engine36 kernel:  [<c021f146>] device_release_driver+0x1d/0x2f
Oct 27 10:16:18 engine36 kernel:  [<c021e957>] bus_remove_device+0x6a/0x82
Oct 27 10:16:18 engine36 kernel:  [<c021dad8>] device_del+0x34/0x72
Oct 27 10:16:18 engine36 kernel:  [<e088596a>] usb_disable_device+0xcb/0x142 [usbcore]
Oct 27 10:16:18 engine36 kernel:  [<e0880656>] usb_disconnect+0xaa/0x145 [usbcore]
Oct 27 10:16:18 engine36 kernel:  [<e08815ec>] hub_port_connect_change+0x57/0x3f2 [usbcore]
Oct 27 10:16:18 engine36 kernel:  [<e087f147>] clear_port_feature+0x57/0x5b [usbcore]
Oct 27 10:16:18 engine36 kernel:  [<e0881c3a>] hub_events+0x2b3/0x41d [usbcore]
Oct 27 10:16:18 engine36 kernel:  [<e0881da4>] hub_thread+0x0/0xe2 [usbcore]
Oct 27 10:16:18 engine36 kernel:  [<e0881db8>] hub_thread+0x14/0xe2 [usbcore]
Oct 27 10:16:18 engine36 kernel:  [<c0130973>] autoremove_wake_function+0x0/0x4b
Oct 27 10:16:18 engine36 kernel:  [<c013055d>] kthread+0xaf/0xb3
Oct 27 10:16:18 engine36 kernel:  [<c01304ae>] kthread+0x0/0xb3
Oct 27 10:16:18 engine36 kernel:  [<c0101171>] kernel_thread_helper+0x5/0xb
Oct 27 10:16:18 engine36 kernel: Code: e9 7b bc fe ff 83 c4 04 5b 5e 5f c3 55 57 56 53 83 ec 0c 8b 44 24 20 8b 70 58 8b 50 10 85 d2 74 75 f0 ff 4a 78 0f 88 e3 00 00 00 <8b> 46 0c 8d 68 fc 8b 4d 04 0f 18 01 90 89 c3 83 c6 0c 89 74 24 






------=_Part_6470_29392135.1130773644513--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
