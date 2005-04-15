From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]usx2y: prevent oops & dead keyboard on hot usb unplugging
Date: Fri, 15 Apr 2005 15:31:26 +0200 (CEST)
Message-ID: <20050415133126.89168.qmail@web26506.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1361307853-1113571886=:87971"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--0-1361307853-1113571886=:87971
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

--- Clemens Ladisch <clemens@ladisch.de> wrote:
> karsten wiese wrote:
> > Please commit the patch.
> >
> > - snd_card_free_in_thread((snd_card_t*)ptr);
> > + snd_card_free((snd_card_t*)ptr);
>=20
> What happens when you unplug the device while it's still
> playing?

See attached excerpts of /var/log/messages.
they are a bit looong, but critical points are marked with
a comment starting with //.





=09

=09
	=09
___________________________________________________________=20
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anme=
lden: http://mail.yahoo.de
--0-1361307853-1113571886=:87971
Content-Type: text/x-java; name=usx2y-hot-unplug_snd_card_free_in_thread
Content-Description: usx2y-hot-unplug_snd_card_free_in_thread
Content-Disposition: inline; filename=usx2y-hot-unplug_snd_card_free_in_thread

with snd_card_free_in_thread, it oopses:
this is triggered by "rmmod uhci_hcd" while jackd was runnnig.
the effect of unplugging the cable is nearly identicall.
comments begin with //

Apr 13 13:22:21 p4 kernel: [4299685.996000] uhci_hcd 0000:00:10.1: remove, state 1
Apr 13 13:22:21 p4 kernel: [4299685.996000] uhci_hcd 0000:00:10.1: roothub graceful disconnect
// usx2y is connnected to usb3:
Apr 13 13:22:21 p4 kernel: [4299685.996000] usb usb3: USB disconnect, address 1
Apr 13 13:22:22 p4 kernel: [4299685.996000] usb 3-2: USB disconnect, address 2
Apr 13 13:22:22 p4 kernel: [4299685.996000] usb 3-2: usb_disable_device nuking all URBs
Apr 13 13:22:22 p4 kernel: [4299685.996000] uhci_hcd 0000:00:10.1: shutdown urb f75cfd80 pipe 40020280 ep4in-intr
Apr 13 13:22:22 p4 kernel: [4299685.996000] uhci_hcd 0000:00:10.1: shutdown urb ed73f480 pipe 40020280 ep4in-intr
// usx2y notices disconnect.....
Apr 13 13:22:22 p4 kernel: [4299685.996000] urb status -108
Apr 13 13:22:22 p4 kernel: [4299685.996000] usb_submit_urb() returned -19
Apr 13 13:22:22 p4 kernel: [4299685.996000] 
// and stops streaming
Apr 13 13:22:22 p4 kernel: [4299685.996000] snd_usX2Y_pcm_trigger(STOP)
Apr 13 13:22:22 p4 kernel: [4299685.996000] snd_usX2Y_pcm_trigger(STOP)
Apr 13 13:22:22 p4 kernel: [4299685.996000] 0 status=-115 start_frame=809
Apr 13 13:22:22 p4 kernel: [4299685.996000] 1 status=0 start_frame=810
Apr 13 13:22:22 p4 kernel: [4299685.996000] 0 status=0 start_frame=808
Apr 13 13:22:22 p4 kernel: [4299685.996000] 1 status=-115 start_frame=809
Apr 13 13:22:22 p4 kernel: [4299685.996000] 0 status=0 start_frame=808
Apr 13 13:22:22 p4 kernel: [4299685.996000] 1 status=-115 start_frame=809
Apr 13 13:22:22 p4 kernel: [4299685.996000] 0 edd64d80 state=4
Apr 13 13:22:22 p4 kernel: [4299685.996000] 1 edd64f80 state=4
Apr 13 13:22:22 p4 kernel: [4299685.996000] 3 edd64e40 state=4
Apr 13 13:22:22 p4 kernel: [4299685.996000] snd_usX2Y_pcm_prepare(e8a8fd00)
Apr 13 13:22:22 p4 kernel: [4299685.996000] usX2Y_subs_prepare(edd64f80) ep=8 urb0=c5f89b00 urb1=c5f89b80
Apr 13 13:22:22 p4 kernel: [4299685.996000] starting capture pipe for self
Apr 13 13:22:22 p4 kernel: [4299685.997000] hcd_frame=1834 ep=8in status=-2 start_frame=809
Apr 13 13:22:22 p4 kernel: [4299685.997000] hcd_frame=1834 ep=10out status=0 start_frame=809
Apr 13 13:22:22 p4 kernel: [4299685.997000] hcd_frame=1834 ep=10in status=0 start_frame=809
Apr 13 13:22:22 p4 kernel: [4299685.997000] cannot usb_submit_urb() for urb 0, err = -19
Apr 13 13:22:22 p4 kernel: [4299685.997000] 0 status=0 start_frame=809
Apr 13 13:22:22 p4 kernel: [4299685.997000] 1 status=0 start_frame=810
Apr 13 13:22:22 p4 kernel: [4299685.997000] 0 status=0 start_frame=-1
Apr 13 13:22:22 p4 kernel: [4299685.997000] 1 status=-2 start_frame=809
Apr 13 13:22:22 p4 kernel: [4299685.997000] 0 status=0 start_frame=808
Apr 13 13:22:22 p4 kernel: [4299685.997000] 1 status=0 start_frame=809
Apr 13 13:22:22 p4 kernel: [4299685.997000] 0 edd64d80 state=0
Apr 13 13:22:22 p4 kernel: [4299685.997000] 1 edd64f80 state=3
Apr 13 13:22:22 p4 kernel: [4299685.997000] 3 edd64e40 state=0
// snd_card_free_in_thread starts working ok
Apr 13 13:22:22 p4 kernel: [4299685.997000] usb 3-2: unregistering interface 3-2:1.0
Apr 13 13:22:22 p4 kernel: [4299685.997000] CLASS: Unregistering class device. ID = 'mixer1'
Apr 13 13:22:22 p4 kernel: [4299685.997000] fill_kobj_path: path = '/class/sound/mixer1'
Apr 13 13:22:22 p4 kernel: [4299685.997000] class_hotplug - name = mixer1
Apr 13 13:22:22 p4 kernel: [4299686.113000] kobject mixer1: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.113000] device class 'mixer1': release.
Apr 13 13:22:22 p4 kernel: [4299686.113000] CLASS: Unregistering class device. ID = 'adsp1'
Apr 13 13:22:22 p4 kernel: [4299686.113000] fill_kobj_path: path = '/class/sound/adsp1'
Apr 13 13:22:22 p4 kernel: [4299686.113000] class_hotplug - name = adsp1
Apr 13 13:22:22 p4 kernel: [4299686.123000] kobject adsp1: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.123000] device class 'adsp1': release.
Apr 13 13:22:22 p4 kernel: [4299686.123000] CLASS: Unregistering class device. ID = 'dsp1'
Apr 13 13:22:22 p4 kernel: [4299686.123000] fill_kobj_path: path = '/class/sound/dsp1'
Apr 13 13:22:22 p4 kernel: [4299686.123000] class_hotplug - name = dsp1
Apr 13 13:22:22 p4 kernel: [4299686.133000] kobject dsp1: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.133000] device class 'dsp1': release.
Apr 13 13:22:22 p4 kernel: [4299686.133000] CLASS: Unregistering class device. ID = 'audio1'
Apr 13 13:22:22 p4 kernel: [4299686.133000] fill_kobj_path: path = '/class/sound/audio1'
Apr 13 13:22:22 p4 kernel: [4299686.133000] class_hotplug - name = audio1
Apr 13 13:22:22 p4 kernel: [4299686.143000] kobject audio1: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.143000] device class 'audio1': release.
Apr 13 13:22:22 p4 kernel: [4299686.143000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2/3-2:1.0'
Apr 13 13:22:22 p4 kernel: [4299686.143000] usb 3-2:1.0: hotplug
Apr 13 13:22:22 p4 kernel: [4299686.161000] kobject 3-2:1.0: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.161000] usb 3-2: unregistering device
Apr 13 13:22:22 p4 kernel: [4299686.161000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'

// since its snd_card_free_IN_THREAD, usX2Y_usb_disconnect() has finished and hotplug thinks,
// it may continue cleaning up:
Apr 13 13:22:22 p4 kernel: [4299686.161000] usb 3-2: hotplug
Apr 13 13:22:22 p4 kernel: [4299686.174000] usb usb3: usb_disable_device nuking all URBs
Apr 13 13:22:22 p4 kernel: [4299686.174000] uhci_hcd 0000:00:10.1: shutdown urb e8336b00 pipe 40408180 ep1in-intr
Apr 13 13:22:22 p4 kernel: [4299686.174000] usb usb3: unregistering interface 3-0:1.0
Apr 13 13:22:22 p4 kernel: [4299686.174000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-0:1.0'
Apr 13 13:22:22 p4 kernel: [4299686.174000] usb 3-0:1.0: hotplug
Apr 13 13:22:22 p4 kernel: [4299686.191000] kobject 3-0:1.0: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.191000] usb usb3: unregistering device
Apr 13 13:22:22 p4 kernel: [4299686.191000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3'
Apr 13 13:22:22 p4 kernel: [4299686.191000] usb usb3: hotplug
Apr 13 13:22:22 p4 kernel: [4299686.193000] snd_usX2Y_usbpcm_hw_free(e8a8fb80)
Apr 13 13:22:22 p4 kernel: [4299686.193000] snd_usX2Y_urbs_release() 10
Apr 13 13:22:22 p4 kernel: [4299686.193000] snd_usX2Y_urbs_release() 8
Apr 13 13:22:22 p4 kernel: [4299686.193000] snd_usX2Y_urbs_release() 10
Apr 13 13:22:22 p4 kernel: [4299686.193000] snd_usX2Y_usbpcm_hw_free(e8a8fd00)
Apr 13 13:22:22 p4 kernel: [4299686.193000] snd_usX2Y_urbs_release() 8
Apr 13 13:22:22 p4 kernel: [4299686.193000] snd_usX2Y_urbs_release() 10
Apr 13 13:22:22 p4 kernel: [4299686.193000] CLASS: Unregistering class device. ID = 'controlC1'
Apr 13 13:22:22 p4 kernel: [4299686.193000] fill_kobj_path: path = '/class/sound/controlC1'
Apr 13 13:22:22 p4 kernel: [4299686.193000] class_hotplug - name = controlC1
Apr 13 13:22:22 p4 kernel: [4299686.193000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 13 13:22:22 p4 kernel: [4299686.198000] kobject controlC1: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.198000] device class 'controlC1': release.
Apr 13 13:22:22 p4 kernel: [4299686.198000] CLASS: Unregistering class device. ID = 'pcmC1D2p'
Apr 13 13:22:22 p4 kernel: [4299686.198000] fill_kobj_path: path = '/class/sound/pcmC1D2p'
Apr 13 13:22:22 p4 kernel: [4299686.198000] class_hotplug - name = pcmC1D2p
Apr 13 13:22:22 p4 kernel: [4299686.198000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 13 13:22:22 p4 kernel: [4299686.199000] kobject pcmC1D2p: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.199000] device class 'pcmC1D2p': release.
Apr 13 13:22:22 p4 kernel: [4299686.199000] CLASS: Unregistering class device. ID = 'pcmC1D2c'
Apr 13 13:22:22 p4 kernel: [4299686.199000] fill_kobj_path: path = '/class/sound/pcmC1D2c'
Apr 13 13:22:22 p4 kernel: [4299686.199000] class_hotplug - name = pcmC1D2c
Apr 13 13:22:22 p4 kernel: [4299686.199000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 13 13:22:22 p4 kernel: [4299686.203000] kobject pcmC1D2c: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.203000] device class 'pcmC1D2c': release.
Apr 13 13:22:22 p4 kernel: [4299686.203000] CLASS: Unregistering class device. ID = 'hwC1D1'
Apr 13 13:22:22 p4 kernel: [4299686.203000] fill_kobj_path: path = '/class/sound/hwC1D1'
Apr 13 13:22:22 p4 kernel: [4299686.203000] class_hotplug - name = hwC1D1
Apr 13 13:22:22 p4 kernel: [4299686.203000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 13 13:22:22 p4 kernel: [4299686.207000] kobject hwC1D1: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.207000] device class 'hwC1D1': release.
Apr 13 13:22:22 p4 kernel: [4299686.207000] CLASS: Unregistering class device. ID = 'pcmC1D1c'
Apr 13 13:22:22 p4 kernel: [4299686.207000] fill_kobj_path: path = '/class/sound/pcmC1D1c'
Apr 13 13:22:22 p4 kernel: [4299686.207000] class_hotplug - name = pcmC1D1c
Apr 13 13:22:22 p4 kernel: [4299686.207000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 13 13:22:22 p4 kernel: [4299686.212000] kobject pcmC1D1c: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.212000] device class 'pcmC1D1c': release.
Apr 13 13:22:22 p4 kernel: [4299686.212000] CLASS: Unregistering class device. ID = 'pcmC1D0p'
Apr 13 13:22:22 p4 kernel: [4299686.212000] fill_kobj_path: path = '/class/sound/pcmC1D0p'
Apr 13 13:22:22 p4 kernel: [4299686.212000] class_hotplug - name = pcmC1D0p
Apr 13 13:22:22 p4 kernel: [4299686.212000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 13 13:22:22 p4 kernel: [4299686.216000] kobject pcmC1D0p: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.216000] device class 'pcmC1D0p': release.
Apr 13 13:22:22 p4 kernel: [4299686.216000] CLASS: Unregistering class device. ID = 'pcmC1D0c'
Apr 13 13:22:22 p4 kernel: [4299686.216000] fill_kobj_path: path = '/class/sound/pcmC1D0c'
Apr 13 13:22:22 p4 kernel: [4299686.216000] class_hotplug - name = pcmC1D0c
Apr 13 13:22:22 p4 kernel: [4299686.216000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 13 13:22:22 p4 kernel: [4299686.218000] kobject pcmC1D0c: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.218000] device class 'pcmC1D0c': release.
Apr 13 13:22:22 p4 kernel: [4299686.218000] CLASS: Unregistering class device. ID = 'midi1'
Apr 13 13:22:22 p4 kernel: [4299686.218000] fill_kobj_path: path = '/class/sound/midi1'
Apr 13 13:22:22 p4 kernel: [4299686.218000] class_hotplug - name = midi1
Apr 13 13:22:22 p4 kernel: [4299686.263000] uhci_hcd 0000:00:10.1: USB bus 3 deregistered
Apr 13 13:22:22 p4 kernel: [4299686.263000] fill_kobj_path: path = '/class/usb_host/usb3'
Apr 13 13:22:22 p4 kernel: [4299686.263000] class_hotplug - name = usb3
Apr 13 13:22:22 p4 kernel: [4299686.263000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1'
Apr 13 13:22:22 p4 kernel: [4299686.319000] kobject midi1: cleaning up
Apr 13 13:22:22 p4 kernel: [4299686.319000] device class 'midi1': release.
Apr 13 13:22:22 p4 kernel: [4299686.319000] CLASS: Unregistering class device. ID = 'dmmidi1'
Apr 13 13:22:22 p4 kernel: [4299686.319000] fill_kobj_path: path = '/class/sound/dmmidi1'
Apr 13 13:22:23 p4 kernel: [4299686.319000] class_hotplug - name = dmmidi1
Apr 13 13:22:23 p4 kernel: [4299686.319000] uhci_hcd 0000:00:10.2: remove, state 1
Apr 13 13:22:23 p4 kernel: [4299686.319000] uhci_hcd 0000:00:10.2: roothub graceful disconnect
Apr 13 13:22:23 p4 kernel: [4299686.319000] usb usb4: USB disconnect, address 1
Apr 13 13:22:23 p4 kernel: [4299686.319000] usb usb4: usb_disable_device nuking all URBs
Apr 13 13:22:23 p4 kernel: [4299686.319000] uhci_hcd 0000:00:10.2: shutdown urb e8336780 pipe 40408180 ep1in-intr
Apr 13 13:22:23 p4 kernel: [4299686.319000] usb usb4: unregistering interface 4-0:1.0
Apr 13 13:22:23 p4 kernel: [4299686.319000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.2/usb4/4-0:1.0'
Apr 13 13:22:23 p4 kernel: [4299686.319000] usb 4-0:1.0: hotplug
Apr 13 13:22:23 p4 kernel: [4299686.327000] kobject dmmidi1: cleaning up
Apr 13 13:22:23 p4 kernel: [4299686.327000] device class 'dmmidi1': release.
Apr 13 13:22:23 p4 kernel: [4299686.327000] CLASS: Unregistering class device. ID = 'midiC1D0'
Apr 13 13:22:23 p4 kernel: [4299686.327000] fill_kobj_path: path = '/class/sound/midiC1D0'
Apr 13 13:22:23 p4 kernel: [4299686.327000] class_hotplug - name = midiC1D0
Apr 13 13:22:23 p4 kernel: [4299686.327000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 13 13:22:23 p4 kernel: [4299686.335000] kobject 4-0:1.0: cleaning up
Apr 13 13:22:23 p4 kernel: [4299686.335000] usb usb4: unregistering device
Apr 13 13:22:23 p4 kernel: [4299686.335000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.2/usb4'
Apr 13 13:22:23 p4 kernel: [4299686.335000] usb usb4: hotplug
Apr 13 13:22:23 p4 kernel: [4299686.353000] kobject midiC1D0: cleaning up
Apr 13 13:22:23 p4 kernel: [4299686.353000] device class 'midiC1D0': release.
Apr 13 13:22:23 p4 kernel: [4299686.353000] CLASS: Unregistering class device. ID = 'hwC1D0'
Apr 13 13:22:23 p4 kernel: [4299686.353000] kobject 3-2: cleaning up
Apr 13 13:22:23 p4 kernel: [4299686.353000] kobject usb3: cleaning up
Apr 13 13:22:23 p4 kernel: [4299686.353000] kobject usb3: cleaning up
Apr 13 13:22:23 p4 kernel: [4299686.353000] device class 'usb3': release.

// usb3 is gone, but snd_card_free_in_thread() hasn't finished yet:
Apr 13 13:22:23 p4 kernel: [4299686.353000] fill_kobj_path: path = '/class/sound/hwC1D0'
Apr 13 13:22:23 p4 kernel: [4299686.353000] class_hotplug - name = hwC1D0
Apr 13 13:22:23 p4 kernel: [4299686.353000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
Apr 13 13:22:23 p4 kernel: [4299686.353000]  printing eip:
Apr 13 13:22:23 p4 kernel: [4299686.353000] c01bd569
Apr 13 13:22:23 p4 kernel: [4299686.353000] *pde = 00000000
Apr 13 13:22:23 p4 kernel: [4299686.353000] Oops: 0000 [#1]
Apr 13 13:22:23 p4 kernel: [4299686.353000] PREEMPT 
Apr 13 13:22:23 p4 kernel: [4299686.353000] Modules linked in: uhci_hcd snd_usb_usx2y snd_seq snd_usb_lib snd_hwdep nfs nvidia agpgart realtime commoncap nfsd exportfs lockd md5 ipv6 autofs4 sunrpc video button ac ehci_hcd i2c_viapro i2c_core snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd floppy ext3 jbd
Apr 13 13:22:23 p4 kernel: [4299686.353000] CPU:    0
Apr 13 13:22:23 p4 kernel: [4299686.353000] EIP:    0060:[<c01bd569>]    Tainted: P      VLI
Apr 13 13:22:23 p4 kernel: [4299686.353000] EFLAGS: 00010246   (2.6.12-rc2) 
Apr 13 13:22:23 p4 kernel: [4299686.353000] EIP is at get_kobj_path_length+0x19/0x30
Apr 13 13:22:23 p4 kernel: [4299686.353000] eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: e12c7c88
Apr 13 13:22:23 p4 kernel: [4299686.353000] esi: 00000001   edi: 00000000   ebp: f7f09d44   esp: f7f09d38
Apr 13 13:22:23 p4 kernel: [4299686.353000] ds: 007b   es: 007b   ss: 0068
Apr 13 13:22:23 p4 kernel: [4299686.353000] Process events/0 (pid: 3, threadinfo=f7f08000 task=c18da020)
Apr 13 13:22:23 p4 kernel: [4299686.353000] Stack: c0345d40 e12c7c64 e8336418 f7f09d68 c01bd60a e12c7c88 e8336400 e8336418 
Apr 13 13:22:23 p4 kernel: [4299686.353000]        f7f09d68 c0345d40 e12c7c64 e8336418 f7f09dac c0229c19 e12c7c88 000000d0 
Apr 13 13:22:23 p4 kernel: [4299686.353000]        e8336e54 ffffffff fffffffd ffffffff c0345d40 e8336400 00000000 e8336e08 
Apr 13 13:22:23 p4 kernel: [4299686.353000] Call Trace:
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c010402f>] show_stack+0x7f/0xa0
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c01041ca>] show_registers+0x15a/0x1d0
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c01043d0>] die+0xf0/0x180
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c0115914>] do_page_fault+0x464/0x66a
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c0103c4b>] error_code+0x4f/0x54
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c01bd60a>] kobject_get_path+0x1a/0x70
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c0229c19>] class_hotplug+0xa9/0x250
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c01be40a>] kobject_hotplug+0x2ba/0x2e0
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c01bd9ca>] kobject_del+0x1a/0x30
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c022a1a1>] class_device_del+0xc1/0xd0
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c022a1d5>] class_device_unregister+0x25/0x40
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<f885059f>] snd_unregister_device+0x7f/0xd0 [snd]
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<f8a39ac2>] snd_hwdep_dev_unregister+0x52/0xb0 [snd_hwdep]
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<f8855bb6>] snd_device_free+0xa6/0xc0 [snd]
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<f8855de4>] snd_device_free_all+0x54/0x70 [snd]
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<f8850d8d>] snd_card_free+0x9d/0x2b0 [snd]
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<f8850ff7>] snd_card_free_thread+0x57/0xd0 [snd]
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c012c3ee>] worker_thread+0x1be/0x2a0
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c0130a4c>] kthread+0x9c/0xd0
Apr 13 13:22:23 p4 kernel: [4299686.353000]  [<c0101365>] kernel_thread_helper+0x5/0x10
Apr 13 13:22:23 p4 kernel: [4299686.353000] Code: 89 34 24 e8 7a 29 fe ff eb dd 90 8d b4 26 00 00 00 00 55 89 e5 57 8b 55 08 56 be 01 00 00 00 53 31 db 8b 3a b9 ff ff ff ff 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 e7 5b 89 f0 5e 5f 

// keyboard (usb or ps/2, doesn't matter) stops working

--0-1361307853-1113571886=:87971
Content-Type: text/x-objcsrc; name=usx2y-hot-unplug_snd_card_free
Content-Description: usx2y-hot-unplug_snd_card_free
Content-Disposition: inline; filename=usx2y-hot-unplug_snd_card_free

with snd_card_free, it's ok:
this is triggered by unplugging the usb cable while jackd was runnnig.
comments begin with //


// jackd starts streamin
Apr 14 20:12:10 p4 kernel: [4299805.544000] snd_usX2Y_pcm_trigger(START)
Apr 14 20:12:10 p4 kernel: [4299805.544000] snd_usX2Y_pcm_trigger(START)
Apr 14 20:12:10 p4 kernel: [4299805.546000] cap start 31

// after 10seconds the usb cable is unplugged
Apr 14 20:12:20 p4 kernel: [4299815.118000] ep=10 stalled with status=-84
Apr 14 20:12:20 p4 kernel: [4299815.118000] snd_usX2Y_pcm_trigger(STOP)
Apr 14 20:12:20 p4 kernel: [4299815.118000] snd_usX2Y_pcm_trigger(STOP)
Apr 14 20:12:20 p4 kernel: [4299815.118000] 0 status=0 start_frame=489
Apr 14 20:12:20 p4 kernel: [4299815.118000] 1 status=-115 start_frame=490
Apr 14 20:12:20 p4 kernel: [4299815.118000] 0 status=-115 start_frame=490
Apr 14 20:12:20 p4 kernel: [4299815.118000] 1 status=0 start_frame=489
Apr 14 20:12:20 p4 kernel: [4299815.118000] 0 status=-115 start_frame=490
Apr 14 20:12:20 p4 kernel: [4299815.118000] 1 status=0 start_frame=489
Apr 14 20:12:20 p4 kernel: [4299815.118000] 0 e4a19ac0 state=4
Apr 14 20:12:20 p4 kernel: [4299815.118000] 1 c8ebe8c0 state=4
Apr 14 20:12:20 p4 kernel: [4299815.118000] 3 e4a19c00 state=4
Apr 14 20:12:20 p4 kernel: [4299815.118000] snd_usX2Y_pcm_prepare(ed36b1c0)
Apr 14 20:12:20 p4 kernel: [4299815.118000] usX2Y_subs_prepare(c8ebe8c0) ep=8 urb0=e4d0a200 urb1=e4d0a180
Apr 14 20:12:20 p4 kernel: [4299815.118000] starting capture pipe for self
Apr 14 20:12:20 p4 kernel: [4299815.119000] hcd_frame=491 ep=8in status=-2 start_frame=490
Apr 14 20:12:20 p4 kernel: [4299815.119000] hcd_frame=491 ep=10out status=0 start_frame=490
Apr 14 20:12:20 p4 kernel: [4299815.119000] hcd_frame=491 ep=10in status=-84 start_frame=490
Apr 14 20:12:20 p4 kernel: [4299815.119000] 501
Apr 14 20:12:20 p4 kernel: [4299815.119000] 501
Apr 14 20:12:20 p4 kernel: [4299815.119000] 502
Apr 14 20:12:20 p4 kernel: [4299815.119000] 502
Apr 14 20:12:20 p4 kernel: [4299815.130000] ep=8 stalled with status=-84
Apr 14 20:12:20 p4 kernel: [4299815.130000] 0 status=0 start_frame=489
Apr 14 20:12:20 p4 kernel: [4299815.130000] 1 status=0 start_frame=490
Apr 14 20:12:20 p4 kernel: [4299815.130000] 0 status=0 start_frame=501
Apr 14 20:12:20 p4 kernel: [4299815.130000] 1 status=-115 start_frame=502
Apr 14 20:12:20 p4 kernel: [4299815.130000] 0 status=-84 start_frame=501
Apr 14 20:12:20 p4 kernel: [4299815.130000] 1 status=-115 start_frame=502
Apr 14 20:12:20 p4 kernel: [4299815.130000] 0 e4a19ac0 state=0
Apr 14 20:12:20 p4 kernel: [4299815.130000] 1 c8ebe8c0 state=4
Apr 14 20:12:20 p4 kernel: [4299815.130000] 3 e4a19c00 state=4
Apr 14 20:12:20 p4 kernel: [4299815.130000] hcd_frame=502 ep=10in status=-84 start_frame=501
Apr 14 20:12:20 p4 kernel: [4299815.130000] 0 status=0 start_frame=489
Apr 14 20:12:20 p4 kernel: [4299815.130000] 1 status=0 start_frame=490
Apr 14 20:12:20 p4 kernel: [4299815.130000] 0 status=0 start_frame=501
Apr 14 20:12:20 p4 kernel: [4299815.130000] 1 status=-115 start_frame=502
Apr 14 20:12:20 p4 kernel: [4299815.130000] 0 status=-84 start_frame=501
Apr 14 20:12:20 p4 kernel: [4299815.130000] 1 status=-115 start_frame=502
Apr 14 20:12:20 p4 kernel: [4299815.130000] 0 e4a19ac0 state=0
Apr 14 20:12:20 p4 kernel: [4299815.130000] 1 c8ebe8c0 state=0
Apr 14 20:12:20 p4 kernel: [4299815.130000] 3 e4a19c00 state=0
Apr 14 20:12:20 p4 kernel: [4299815.131000] hcd_frame=503 ep=8in status=-84 start_frame=502
Apr 14 20:12:20 p4 kernel: [4299815.131000] hcd_frame=503 ep=10in status=-84 start_frame=502
Apr 14 20:12:20 p4 kernel: [4299815.133000] snd_usX2Y_usbpcm_hw_free(ed36b340)
Apr 14 20:12:20 p4 kernel: [4299815.133000] snd_usX2Y_urbs_release() 10
Apr 14 20:12:20 p4 kernel: [4299815.133000] snd_usX2Y_urbs_release() 8
Apr 14 20:12:20 p4 kernel: [4299815.133000] snd_usX2Y_urbs_release() 10
Apr 14 20:12:20 p4 kernel: [4299815.133000] snd_usX2Y_usbpcm_hw_free(ed36b1c0)
Apr 14 20:12:20 p4 kernel: [4299815.133000] snd_usX2Y_urbs_release() 8
Apr 14 20:12:20 p4 kernel: [4299815.133000] snd_usX2Y_urbs_release() 10
Apr 14 20:12:20 p4 kernel: [4299815.828000] hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0004
Apr 14 20:12:20 p4 kernel: [4299815.828000] uhci_hcd 0000:00:10.1: port 2 portsc 008a,00
Apr 14 20:12:20 p4 kernel: [4299815.828000] hub 3-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
Apr 14 20:12:20 p4 kernel: [4299815.828000] usb 3-2: USB disconnect, address 2
Apr 14 20:12:20 p4 kernel: [4299815.828000] usb 3-2: usb_disable_device nuking all URBs
Apr 14 20:12:20 p4 kernel: [4299815.828000] usb 3-2: unregistering interface 3-2:1.0

// usX2Y_usb_disconnect() is called. I added this debugstatement only now, not in the other trace.
Apr 14 20:12:20 p4 kernel: [4299815.828000] usX2Y_usb_disconnect(e25ae400, ef741000)
Apr 14 20:12:20 p4 kernel: [4299815.828000] CLASS: Unregistering class device. ID = 'mixer1'
Apr 14 20:12:20 p4 kernel: [4299815.828000] fill_kobj_path: path = '/class/sound/mixer1'
Apr 14 20:12:20 p4 kernel: [4299815.828000] class_hotplug - name = mixer1
Apr 14 20:12:20 p4 kernel: [4299815.828000] kobject mixer1 @ e2c9e310: cleaning up
Apr 14 20:12:20 p4 kernel: [4299815.828000] device class 'mixer1': release.
Apr 14 20:12:20 p4 kernel: [4299815.828000] CLASS: Unregistering class device. ID = 'adsp1'
Apr 14 20:12:20 p4 kernel: [4299815.828000] fill_kobj_path: path = '/class/sound/adsp1'
Apr 14 20:12:20 p4 kernel: [4299815.828000] class_hotplug - name = adsp1
Apr 14 20:12:20 p4 kernel: [4299815.840000] kobject adsp1 @ e4ebef10: cleaning up
Apr 14 20:12:20 p4 kernel: [4299815.840000] device class 'adsp1': release.
Apr 14 20:12:20 p4 kernel: [4299815.840000] CLASS: Unregistering class device. ID = 'dsp1'
Apr 14 20:12:20 p4 kernel: [4299815.840000] fill_kobj_path: path = '/class/sound/dsp1'
Apr 14 20:12:20 p4 kernel: [4299815.840000] class_hotplug - name = dsp1
Apr 14 20:12:20 p4 kernel: [4299815.852000] kobject dsp1 @ e2dcdb10: cleaning up
Apr 14 20:12:20 p4 kernel: [4299815.852000] device class 'dsp1': release.
Apr 14 20:12:21 p4 kernel: [4299815.852000] CLASS: Unregistering class device. ID = 'audio1'
Apr 14 20:12:21 p4 kernel: [4299815.852000] fill_kobj_path: path = '/class/sound/audio1'
Apr 14 20:12:21 p4 kernel: [4299815.852000] class_hotplug - name = audio1
Apr 14 20:12:21 p4 kernel: [4299815.863000] kobject audio1 @ e2dcda90: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.863000] device class 'audio1': release.
Apr 14 20:12:21 p4 kernel: [4299815.863000] CLASS: Unregistering class device. ID = 'controlC1'
Apr 14 20:12:21 p4 kernel: [4299815.863000] fill_kobj_path: path = '/class/sound/controlC1'
Apr 14 20:12:21 p4 kernel: [4299815.863000] class_hotplug - name = controlC1
Apr 14 20:12:21 p4 kernel: [4299815.863000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299815.876000] kobject controlC1 @ e2c9e810: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.876000] device class 'controlC1': release.
Apr 14 20:12:21 p4 kernel: [4299815.876000] CLASS: Unregistering class device. ID = 'pcmC1D2p'
Apr 14 20:12:21 p4 kernel: [4299815.876000] fill_kobj_path: path = '/class/sound/pcmC1D2p'
Apr 14 20:12:21 p4 kernel: [4299815.876000] class_hotplug - name = pcmC1D2p
Apr 14 20:12:21 p4 kernel: [4299815.876000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299815.887000] kobject pcmC1D2p @ ec9f1d90: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.887000] device class 'pcmC1D2p': release.
Apr 14 20:12:21 p4 kernel: [4299815.887000] CLASS: Unregistering class device. ID = 'pcmC1D2c'
Apr 14 20:12:21 p4 kernel: [4299815.887000] fill_kobj_path: path = '/class/sound/pcmC1D2c'
Apr 14 20:12:21 p4 kernel: [4299815.887000] class_hotplug - name = pcmC1D2c
Apr 14 20:12:21 p4 kernel: [4299815.887000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299815.899000] kobject pcmC1D2c @ e4d0ac90: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.899000] device class 'pcmC1D2c': release.
Apr 14 20:12:21 p4 kernel: [4299815.900000] CLASS: Unregistering class device. ID = 'hwC1D1'
Apr 14 20:12:21 p4 kernel: [4299815.900000] fill_kobj_path: path = '/class/sound/hwC1D1'
Apr 14 20:12:21 p4 kernel: [4299815.900000] class_hotplug - name = hwC1D1
Apr 14 20:12:21 p4 kernel: [4299815.900000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299815.911000] kobject hwC1D1 @ e4ebed90: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.911000] device class 'hwC1D1': release.
Apr 14 20:12:21 p4 kernel: [4299815.911000] CLASS: Unregistering class device. ID = 'pcmC1D1c'
Apr 14 20:12:21 p4 kernel: [4299815.911000] fill_kobj_path: path = '/class/sound/pcmC1D1c'
Apr 14 20:12:21 p4 kernel: [4299815.911000] class_hotplug - name = pcmC1D1c
Apr 14 20:12:21 p4 kernel: [4299815.911000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299815.923000] kobject pcmC1D1c @ e4ebef90: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.923000] device class 'pcmC1D1c': release.
Apr 14 20:12:21 p4 kernel: [4299815.923000] CLASS: Unregistering class device. ID = 'pcmC1D0p'
Apr 14 20:12:21 p4 kernel: [4299815.923000] fill_kobj_path: path = '/class/sound/pcmC1D0p'
Apr 14 20:12:21 p4 kernel: [4299815.923000] class_hotplug - name = pcmC1D0p
Apr 14 20:12:21 p4 kernel: [4299815.923000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299815.936000] kobject pcmC1D0p @ e2dcdc10: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.936000] device class 'pcmC1D0p': release.
Apr 14 20:12:21 p4 kernel: [4299815.936000] CLASS: Unregistering class device. ID = 'pcmC1D0c'
Apr 14 20:12:21 p4 kernel: [4299815.936000] fill_kobj_path: path = '/class/sound/pcmC1D0c'
Apr 14 20:12:21 p4 kernel: [4299815.936000] class_hotplug - name = pcmC1D0c
Apr 14 20:12:21 p4 kernel: [4299815.936000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299815.959000] kobject pcmC1D0c @ e2dcdb90: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.959000] device class 'pcmC1D0c': release.
Apr 14 20:12:21 p4 kernel: [4299815.959000] CLASS: Unregistering class device. ID = 'midi1'
Apr 14 20:12:21 p4 kernel: [4299815.959000] fill_kobj_path: path = '/class/sound/midi1'
Apr 14 20:12:21 p4 kernel: [4299815.959000] class_hotplug - name = midi1
Apr 14 20:12:21 p4 kernel: [4299815.959000] kobject midi1 @ f79e0210: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.959000] device class 'midi1': release.
Apr 14 20:12:21 p4 kernel: [4299815.959000] CLASS: Unregistering class device. ID = 'dmmidi1'
Apr 14 20:12:21 p4 kernel: [4299815.959000] fill_kobj_path: path = '/class/sound/dmmidi1'
Apr 14 20:12:21 p4 kernel: [4299815.959000] class_hotplug - name = dmmidi1
Apr 14 20:12:21 p4 kernel: [4299815.969000] kobject dmmidi1 @ f79e0390: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.969000] device class 'dmmidi1': release.
Apr 14 20:12:21 p4 kernel: [4299815.969000] CLASS: Unregistering class device. ID = 'midiC1D0'
Apr 14 20:12:21 p4 kernel: [4299815.969000] fill_kobj_path: path = '/class/sound/midiC1D0'
Apr 14 20:12:21 p4 kernel: [4299815.969000] class_hotplug - name = midiC1D0
Apr 14 20:12:21 p4 kernel: [4299815.969000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299815.983000] kobject midiC1D0 @ f79e0190: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.983000] device class 'midiC1D0': release.
Apr 14 20:12:21 p4 kernel: [4299815.983000] CLASS: Unregistering class device. ID = 'hwC1D0'
Apr 14 20:12:21 p4 kernel: [4299815.983000] fill_kobj_path: path = '/class/sound/hwC1D0'
Apr 14 20:12:21 p4 kernel: [4299815.983000] class_hotplug - name = hwC1D0
Apr 14 20:12:21 p4 kernel: [4299815.983000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299815.992000] kobject hwC1D0 @ e2c9e890: cleaning up
Apr 14 20:12:21 p4 kernel: [4299815.992000] device class 'hwC1D0': release.
// snd_card_free() has finished.
// now hotplug continues cleaning up usb3:
Apr 14 20:12:21 p4 kernel: [4299815.992000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2/3-2:1.0'
Apr 14 20:12:21 p4 kernel: [4299815.992000] usb 3-2:1.0: hotplug
Apr 14 20:12:21 p4 kernel: [4299816.001000] kobject 3-2:1.0 @ f7940078: cleaning up
Apr 14 20:12:21 p4 kernel: [4299816.001000] usb 3-2: unregistering device
Apr 14 20:12:21 p4 kernel: [4299816.002000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
Apr 14 20:12:21 p4 kernel: [4299816.002000] usb 3-2: hotplug
Apr 14 20:12:21 p4 kernel: [4299816.033000] kobject 3-2 @ e25ae488: cleaning up
Apr 14 20:12:21 p4 kernel: [4299816.137000] hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
Apr 14 20:12:21 p4 kernel: [4299816.137000] hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0010
Apr 14 20:12:21 p4 kernel: [4299816.137000] ehci_hcd 0000:00:10.4: GetStatus port 4 status 001002 POWER sig=se0  CSC
Apr 14 20:12:21 p4 kernel: [4299816.137000] hub 1-0:1.0: port 4, status 0100, change 0001, 12 Mb/s
Apr 14 20:12:21 p4 kernel: [4299816.241000] hub 1-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x100
Apr 14 20:12:21 p4 kernel: [4299816.713000] uhci_hcd 0000:00:10.1: suspend_hc

// everything still ok. no oops, keyboard workin.

--0-1361307853-1113571886=:87971--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
