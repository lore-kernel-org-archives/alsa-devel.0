From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]usx2y: prevent oops & dead keyboard on hot usb unplugging
Date: Sat, 16 Apr 2005 02:31:06 +0200 (CEST)
Message-ID: <20050416003107.68080.qmail@web26501.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1649946686-1113611466=:66759"
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
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: karsten wiese <annabellesgarden@yahoo.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--0-1649946686-1113611466=:66759
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--- Clemens Ladisch <clemens@ladisch.de> wrote:
> Takashi Iwai wrote:
> > karsten wiese wrote:
> > > (-: You apply my patch now?
> >
> > No, not enough :)  This is exactly why
> snd_card_free_in_thread() was
> > introduced.
> >
> > As I asked, please make sure that the files are all
> released before
> > snd_card_free().  Otherwise the disconnect callback
> hangs at this
> > point because of this check.
>=20
> Most programs close the device file when an error occurs,
> so you have
> to test it with something like this to keep the file
> open:
>=20
> #include <stdio.h>
> int main()
> {
>   fopen("/dev/snd/hwC1D0", "rb");
>   getchar();
> }
>=20
Tested with it, see attached shell log (copied+pasted).
Any more tests needed?
I bet a kasten bier that it oopses reliably on first try,
if I revert to snd_card_free_in_thread() nothing else
changed.
And I'll inform you , if any oops should show when i shut
down (pc is still in the state like @ the end of the log).

Regards,
Karsten

P.S.: how about adding a kernelversion depending macro for
backward compatibility,... when was
snd_card_free_in_thread() introduced?


=09

=09
	=09
___________________________________________________________=20
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anme=
lden: http://mail.yahoo.de
--0-1649946686-1113611466=:66759
Content-Type: text/x-java; name=test-snd_card_free-open_hw1
Content-Description: test-snd_card_free-open_hw1
Content-Disposition: inline; filename=test-snd_card_free-open_hw1

[ka@p4 debug]$ /home/ka/kernel/linux-2.6.12-rc2/sound/usb/usx2y/a.out

[root@p4 ~]# lsof /dev/snd/*
COMMAND  PID USER   FD   TYPE DEVICE SIZE  NODE NAME
kmix    3797   ka   11u   CHR  116,0       4515 /dev/snd/controlC0
a.out   7124   ka    4r   CHR 116,36      24757 /dev/snd/hwC1D0

[root@p4 ~]# dmesg | tail -n5
[4297447.497000] CLASS: registering class device: ID = 'pcmC1D2c'
[4297447.497000] kobject pcmC1D2c: registering. parent: sound, set: class_obj
[4297447.497000] fill_kobj_path: path = '/class/sound/pcmC1D2c'
[4297447.497000] class_hotplug - name = pcmC1D2c
[4297447.497000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'

#switch off us428

[root@p4 ~]# dmesg | tail -n29
[4297447.497000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298506.550000] hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0004
[4298506.550000] uhci_hcd 0000:00:10.1: port 2 portsc 008a,00
[4298506.550000] hub 3-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
[4298506.550000] usb 3-2: USB disconnect, address 6
[4298506.550000] usb 3-2: usb_disable_device nuking all URBs
[4298506.550000] usb 3-2: unregistering interface 3-2:1.0
[4298506.550000] usX2Y_usb_disconnect(f1946c00,e8483c00)
[4298506.550000] CLASS: Unregistering class device. ID = 'mixer1'
[4298506.550000] fill_kobj_path: path = '/class/sound/mixer1'
[4298506.550000] class_hotplug - name = mixer1
[4298506.569000] kobject mixer1 @ f74b1f90: cleaning up
[4298506.569000] device class 'mixer1': release.
[4298506.569000] CLASS: Unregistering class device. ID = 'adsp1'
[4298506.569000] fill_kobj_path: path = '/class/sound/adsp1'
[4298506.569000] class_hotplug - name = adsp1
[4298506.588000] kobject adsp1 @ e79a5790: cleaning up
[4298506.588000] device class 'adsp1': release.
[4298506.588000] CLASS: Unregistering class device. ID = 'dsp1'
[4298506.588000] fill_kobj_path: path = '/class/sound/dsp1'
[4298506.588000] class_hotplug - name = dsp1
[4298506.608000] kobject dsp1 @ f7841110: cleaning up
[4298506.608000] device class 'dsp1': release.
[4298506.608000] CLASS: Unregistering class device. ID = 'audio1'
[4298506.608000] fill_kobj_path: path = '/class/sound/audio1'
[4298506.608000] class_hotplug - name = audio1
[4298506.629000] kobject audio1 @ f6c9da90: cleaning up
[4298506.629000] device class 'audio1': release.
[4298507.572000] uhci_hcd 0000:00:10.1: suspend_hc

[root@p4 ~]# lsof /dev/snd/*
COMMAND  PID USER   FD   TYPE DEVICE SIZE  NODE NAME
kmix    3797   ka   11u   CHR  116,0       4515 /dev/snd/controlC0
a.out   7124   ka    4r   CHR 116,36      24757 /dev/snd/hwC1D0


#way 1 , see below what happens when us428 is switched on while "/dev/snd/hwC1D0" is still open

#control-c to quit a.out
[ka@p4 debug]$

[root@p4 ~]# dmesg | tail -n78
[4298507.572000] uhci_hcd 0000:00:10.1: suspend_hc
[4298653.844000] CLASS: Unregistering class device. ID = 'controlC1'
[4298653.844000] fill_kobj_path: path = '/class/sound/controlC1'
[4298653.844000] class_hotplug - name = controlC1
[4298653.844000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298653.865000] kobject controlC1 @ f6e2c310: cleaning up
[4298653.865000] device class 'controlC1': release.
[4298653.865000] CLASS: Unregistering class device. ID = 'pcmC1D2p'
[4298653.865000] fill_kobj_path: path = '/class/sound/pcmC1D2p'
[4298653.865000] class_hotplug - name = pcmC1D2p
[4298653.865000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298653.886000] kobject pcmC1D2p @ e743c410: cleaning up
[4298653.886000] device class 'pcmC1D2p': release.
[4298653.886000] CLASS: Unregistering class device. ID = 'pcmC1D2c'
[4298653.886000] fill_kobj_path: path = '/class/sound/pcmC1D2c'
[4298653.886000] class_hotplug - name = pcmC1D2c
[4298653.886000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298653.906000] kobject pcmC1D2c @ e743c390: cleaning up
[4298653.906000] device class 'pcmC1D2c': release.
[4298653.906000] CLASS: Unregistering class device. ID = 'hwC1D1'
[4298653.906000] fill_kobj_path: path = '/class/sound/hwC1D1'
[4298653.906000] class_hotplug - name = hwC1D1
[4298653.906000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298653.927000] kobject hwC1D1 @ e79a5610: cleaning up
[4298653.927000] device class 'hwC1D1': release.
[4298653.927000] CLASS: Unregistering class device. ID = 'pcmC1D1c'
[4298653.927000] fill_kobj_path: path = '/class/sound/pcmC1D1c'
[4298653.927000] class_hotplug - name = pcmC1D1c
[4298653.927000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298653.944000] kobject pcmC1D1c @ e79a5810: cleaning up
[4298653.944000] device class 'pcmC1D1c': release.
[4298653.944000] CLASS: Unregistering class device. ID = 'pcmC1D0p'
[4298653.944000] fill_kobj_path: path = '/class/sound/pcmC1D0p'
[4298653.944000] class_hotplug - name = pcmC1D0p
[4298653.944000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298653.950000] kobject pcmC1D0p @ f0e06710: cleaning up
[4298653.950000] device class 'pcmC1D0p': release.
[4298653.950000] CLASS: Unregistering class device. ID = 'pcmC1D0c'
[4298653.950000] fill_kobj_path: path = '/class/sound/pcmC1D0c'
[4298653.950000] class_hotplug - name = pcmC1D0c
[4298653.950000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298653.968000] kobject pcmC1D0c @ f0e06990: cleaning up
[4298653.968000] device class 'pcmC1D0c': release.
[4298653.968000] CLASS: Unregistering class device. ID = 'midi1'
[4298653.968000] fill_kobj_path: path = '/class/sound/midi1'
[4298653.968000] class_hotplug - name = midi1
[4298653.994000] kobject midi1 @ e8be1790: cleaning up
[4298653.994000] device class 'midi1': release.
[4298653.994000] CLASS: Unregistering class device. ID = 'dmmidi1'
[4298653.994000] fill_kobj_path: path = '/class/sound/dmmidi1'
[4298653.994000] class_hotplug - name = dmmidi1
[4298654.013000] kobject dmmidi1 @ e8be1690: cleaning up
[4298654.013000] device class 'dmmidi1': release.
[4298654.013000] CLASS: Unregistering class device. ID = 'midiC1D0'
[4298654.013000] fill_kobj_path: path = '/class/sound/midiC1D0'
[4298654.013000] class_hotplug - name = midiC1D0
[4298654.013000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298654.031000] kobject midiC1D0 @ e8be1310: cleaning up
[4298654.031000] device class 'midiC1D0': release.
[4298654.031000] CLASS: Unregistering class device. ID = 'hwC1D0'
[4298654.031000] fill_kobj_path: path = '/class/sound/hwC1D0'
[4298654.031000] class_hotplug - name = hwC1D0
[4298654.031000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298654.049000] kobject hwC1D0 @ f6e2c090: cleaning up
[4298654.049000] device class 'hwC1D0': release.
[4298654.049000] usX2Y_usb_disconnect() leaving
[4298654.049000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2/3-2:1.0'
[4298654.049000] usb 3-2:1.0: hotplug
[4298654.067000] kobject 3-2:1.0 @ f5423178: cleaning up
[4298654.067000] usb 3-2: unregistering device
[4298654.067000] fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
[4298654.067000] usb 3-2: hotplug
[4298654.099000] kobject 3-2 @ f1946c88: cleaning up
[4298654.206000] hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
[4298654.206000] hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0010
[4298654.206000] ehci_hcd 0000:00:10.4: GetStatus port 4 status 001002 POWER sig=se0  CSC
[4298654.206000] hub 1-0:1.0: port 4, status 0100, change 0001, 12 Mb/s
[4298654.311000] hub 1-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x100


-----------------------------------------

#way 2, us428 is switched on again while a.out still holds  "/dev/snd/hwC1D0" open

[root@p4 ~]# dmesg | tail -n10
[4298822.089000] fill_kobj_path: path = '/class/sound/dsp1'
[4298822.089000] class_hotplug - name = dsp1
[4298822.109000] kobject dsp1 @ f6883b10: cleaning up
[4298822.109000] device class 'dsp1': release.
[4298822.109000] CLASS: Unregistering class device. ID = 'audio1'
[4298822.109000] fill_kobj_path: path = '/class/sound/audio1'
[4298822.109000] class_hotplug - name = audio1
[4298822.129000] kobject audio1 @ f6883890: cleaning up
[4298822.129000] device class 'audio1': release.
[4298822.972000] uhci_hcd 0000:00:10.1: suspend_hc

# looks the same ,  except for memory pointers and timer marks , compared to when we took way 1
# also note: us428 USB light stay's OFF !!

#control-c to quit a.out
[ka@p4 debug]$

# us428 USB light is ON , yesz! also us428control has been started by hotplug:
[root@p4 ~]# lsof /dev/snd/*
COMMAND    PID USER   FD   TYPE DEVICE SIZE  NODE NAME
kmix      3797   ka   11u   CHR  116,0       4515 /dev/snd/controlC0
us428cont 9183 root  mem    CHR 116,36      37064 /dev/snd/hwC1D0
us428cont 9183 root    3u   CHR 116,36      37064 /dev/snd/hwC1D0
us428cont 9183 root    4u   CHR  116,1      12293 /dev/snd/seq

[ka@p4 usx2y]$ arecord -Dhw:1 -fcd | aplay -Dhw:1
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

#...... sounds just fine ....no oops, everything ok  :-)

--0-1649946686-1113611466=:66759--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
