From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [REGRESSION][HDA] Realtek ALC269: control `Beep
 Playback Volume` missing (was: snd-hda-intel: pcspeaker doesn't work since
 2.6.35 see attached alsa-info-files)
Date: Sun, 21 Nov 2010 18:52:20 +0100
Message-ID: <1290361940.5726.53.camel@mattotaupa>
References: <20101115133710.GA18124@gentoo.local>
	<20101121144559.GA1532@gentoo.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0253445394622916693=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id E6BD610382F
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 18:52:21 +0100 (CET)
Received: from f053040021.adsl.alicedsl.de ([78.53.40.21]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1PKE5N-0000EF-FJ
	for alsa-devel@alsa-project.org; Sun, 21 Nov 2010 17:52:21 +0000
In-Reply-To: <20101121144559.GA1532@gentoo.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0253445394622916693==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Gf0ONvlLTXiF45LMTtyV"


--=-Gf0ONvlLTXiF45LMTtyV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Halim and ALSA folks,


Am Sonntag, den 21.11.2010, 15:45 +0100 schrieb Halim Sahin:

> Maybe I choosed the wrong subject so got no answer???
> Please help :-).

I do not know, sorry. Please do not top post though.

> On Mo, Nov 15, 2010 at 02:37:10 +0100, Halim Sahin wrote:

> > The subject sais it :-(.
> > In alsamixer I can't umute or set any pc speaker related settings since
> > 2.6.35.
> > The control for pc speaker is gone :-(.
> > Now I started the last working kernel 2.6.34, run alsa-info.
> > Then repeated same with 2.6.36.
> >=20
> > can you please help to solve this?
> > For accessibility software a working pc-speaker is really useful :-).

Sorry, I do not know what is causing this. But I compared both files
using `diff -u`, so people reading the list can compare more easily.

         !!Linux Distribution
        @@ -22,7 +22,7 @@
         !!Kernel Information
         !!------------------
        =20
        -Kernel release:    2.6.34-gentoo
        +Kernel release:    2.6.36-gentoo
         Operating System:  GNU/Linux
         Architecture:      i686
         Processor:         Intel(R) Atom(TM) CPU N270 @ 1.60GHz
        @@ -32,7 +32,7 @@
         !!ALSA Version
         !!------------
        =20
        -Driver version:     1.0.22.1
        +Driver version:     1.0.23
         Library version:    1.0.23
         Utilities version:  1.0.23
        =20
        @@ -52,7 +52,7 @@
         !!-----------------------------
        =20
          0 [Intel          ]: HDA-Intel - HDA Intel
        -                      HDA Intel at 0xf0440000 irq 27
        +                      HDA Intel at 0xf0440000 irq 41
          1 [pcsp           ]: PC-Speaker - pcsp
                               Internal PC-Speaker at port 0x61
        =20
        @@ -83,7 +83,7 @@
        =20
         Codec: Realtek ALC269
         Address: 0
        -Function Id: 0x1
        +AFG Function Id: 0x1 (unsol 1)
         Vendor Id: 0x10ec0269
         Subsystem Id: 0x144dc062
         Revision Id: 0x100004
        @@ -129,6 +129,8 @@
             bits [0xe]: 16 20 24
             formats [0x1]: PCM
         Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
        +  Control: name=3D"Capture Switch", index=3D1, device=3D0
        +  Control: name=3D"Capture Volume", index=3D1, device=3D0
           Amp-In caps: ofs=3D0x11, nsteps=3D0x2e, stepsize=3D0x03, mute=3D=
1
           Amp-In vals:  [0x90 0x90]
           Converter: stream=3D0, channel=3D0
        @@ -156,12 +158,8 @@
         Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
         Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
         Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
        -  Control: name=3D"Beep Playback Volume", index=3D0, device=3D0
        -    ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
        -  Control: name=3D"Beep Playback Switch", index=3D0, device=3D0
        -    ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
           Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D=
1
        -  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0=
x14 0x14]
        +  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0=
x97 0x97]
           Connection: 5
              0x18 0x19 0x1a 0x1b 0x1d
         Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
        @@ -345,14 +343,14 @@
         !!ALSA Device nodes
         !!-----------------
        =20
        -crw-rw----+ 1 root audio 116, 7 Nov 15  2010 /dev/snd/controlC0
        -crw-rw----+ 1 root audio 116, 9 Nov 15  2010 /dev/snd/controlC1
        -crw-rw----+ 1 root audio 116, 6 Nov 15  2010 /dev/snd/hwC0D0
        -crw-rw----+ 1 root audio 116, 5 Nov 15 14:18 /dev/snd/pcmC0D0c
        -crw-rw----+ 1 root audio 116, 4 Nov 15 14:18 /dev/snd/pcmC0D0p
        -crw-rw----+ 1 root audio 116, 8 Nov 15 13:58 /dev/snd/pcmC1D0p
        -crw-rw----+ 1 root audio 116, 3 Nov 15  2010 /dev/snd/seq
        -crw-rw----+ 1 root audio 116, 2 Nov 15  2010 /dev/snd/timer
        +crw-rw---- 1 root audio 116, 7 Nov 15  2010 /dev/snd/controlC0
        +crw-rw---- 1 root audio 116, 9 Nov 15  2010 /dev/snd/controlC1
        +crw-rw---- 1 root audio 116, 6 Nov 15  2010 /dev/snd/hwC0D0
        +crw-rw---- 1 root audio 116, 5 Nov 15  2010 /dev/snd/pcmC0D0c
        +crw-rw---- 1 root audio 116, 4 Nov 15 14:28 /dev/snd/pcmC0D0p
        +crw-rw---- 1 root audio 116, 8 Nov 15  2010 /dev/snd/pcmC1D0p
        +crw-rw---- 1 root audio 116, 3 Nov 15  2010 /dev/snd/seq
        +crw-rw---- 1 root audio 116, 2 Nov 15  2010 /dev/snd/timer
        =20
         /dev/snd/by-path:
         total 0
        @@ -387,7 +385,7 @@
        =20
         !!-------Mixer controls for card 0 [Intel]
        =20
        -Card hw:0 'Intel'/'HDA Intel at 0xf0440000 irq 27'
        +Card hw:0 'Intel'/'HDA Intel at 0xf0440000 irq 41'
           Mixer name	: 'Realtek ALC269'
           Components	: 'HDA:10ec0269,144dc062,00100004'
           Controls      : 14
        @@ -432,19 +430,18 @@
           Limits: 0 - 3
           Front Left: 3 [100%]
           Front Right: 3 [100%]
        -Simple mixer control 'Beep',0
        -  Capabilities: pvolume pswitch penum
        -  Playback channels: Front Left - Front Right
        -  Limits: Playback 0 - 31
        -  Mono:
        -  Front Left: Playback 20 [65%] [-4.50dB] [on]
        -  Front Right: Playback 20 [65%] [-4.50dB] [on]
         Simple mixer control 'Capture',0
           Capabilities: cvolume cswitch penum
           Capture channels: Front Left - Front Right
           Limits: Capture 0 - 46
           Front Left: Capture 46 [100%] [29.00dB] [on]
           Front Right: Capture 46 [100%] [29.00dB] [on]
        +Simple mixer control 'Capture',1
        +  Capabilities: cvolume cswitch penum
        +  Capture channels: Front Left - Front Right
        +  Limits: Capture 0 - 46
        +  Front Left: Capture 16 [35%] [-1.00dB] [off]
        +  Front Right: Capture 16 [35%] [-1.00dB] [off]
         Simple mixer control 'Digital',0
           Capabilities: cvolume penum
           Capture channels: Front Left - Front Right
        @@ -558,6 +555,16 @@
         	}
         	control.8 {
         		comment.access 'read write'
        +		comment.type BOOLEAN
        +		comment.count 2
        +		iface MIXER
        +		name 'Capture Switch'
        +		index 1
        +		value.0 false
        +		value.1 false
        +	}
        +	control.9 {
        +		comment.access 'read write'
         		comment.type INTEGER
         		comment.count 2
         		comment.range '0 - 46'
        @@ -568,26 +575,18 @@
         		value.0 46
         		value.1 46
         	}
        -	control.9 {
        -		comment.access 'read write'
        -		comment.type INTEGER
        -		comment.count 2
        -		comment.range '0 - 31'
        -		comment.dbmin -3450
        -		comment.dbmax 1200
        -		iface MIXER
        -		name 'Beep Playback Volume'
        -		value.0 20
        -		value.1 20
        -	}
         	control.10 {
         		comment.access 'read write'
        -		comment.type BOOLEAN
        +		comment.type INTEGER
         		comment.count 2
        +		comment.range '0 - 46'
        +		comment.dbmin -1700
        +		comment.dbmax 2900
         		iface MIXER
        -		name 'Beep Playback Switch'
        -		value.0 true
        -		value.1 true
        +		name 'Capture Volume'
        +		index 1
        +		value.0 16
        +		value.1 16
         	}
         	control.11 {
         		comment.access 'read write'
        @@ -689,30 +688,28 @@
         l2cap
         uvcvideo
         ath9k
        -ath9k_common
         videodev
        +ath9k_common
         ath9k_hw
        -ath
        -btusb
         snd_pcsp
        -v4l1_compat
        +btusb
        +ath
        =20
        =20
         !!ALSA/HDA dmesg
         !!------------------
        =20
        -[    1.826901]   alloc kstat_irqs on node -1
        -[    1.826921] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,=
 low) -> IRQ 22
        -[    1.827011]   alloc irq_desc for 27 on node -1
        -[    1.827017]   alloc kstat_irqs on node -1
        -[    1.827038] HDA Intel 0000:00:1b.0: irq 27 for MSI/MSI-X
        -[    1.827095] HDA Intel 0000:00:1b.0: setting latency timer to 64
        -[    1.864243] hda_codec: ALC269: BIOS auto-probing.
        -[    1.868869] input: HDA Digital PCBeep as /devices/pci0000:00/00=
00:00:1b.0/input/input6
        -[    1.875736] usbcore: registered new interface driver snd-usb-au=
dio
        -[    1.879124] ALSA device list:
        -[    1.881057] usb 1-1: new high speed USB device using ehci_hcd a=
nd address 2
        -[    1.885826]   #0: HDA Intel at 0xf0440000 irq 27
        -[    1.889214] Netfilter messages via NETLINK v0.30.
        +[    1.652428]   alloc kstat_irqs on node -1
        +[    1.652449] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,=
 low) -> IRQ 22
        +[    1.652542]   alloc irq_desc for 41 on node -1
        +[    1.652548]   alloc kstat_irqs on node -1
        +[    1.652569] HDA Intel 0000:00:1b.0: irq 41 for MSI/MSI-X
        +[    1.652633] HDA Intel 0000:00:1b.0: setting latency timer to 64
        +[    1.676782] input: AT Translated Set 2 keyboard as /devices/pla=
tform/i8042/serio0/input/input5
        +[    1.692216] hda_codec: ALC269: BIOS auto-probing.
        +[    1.696369] usbcore: registered new interface driver snd-usb-au=
dio
        +[    1.696376] ALSA device list:
        +[    1.696381]   #0: HDA Intel at 0xf0440000 irq 41
        +[    1.696469] Netfilter messages via NETLINK v0.30.

=46rom the `dmesg` output

        -[    1.868869] input: HDA Digital PCBeep as /devices/pci0000:00/00=
00:00:1b.0/input/input6

is not present in newer ALSA/Linux version. This could be the reason why no=
 controls are created.


Thanks and I hope the developers will be able to help you,

Paul

--=-Gf0ONvlLTXiF45LMTtyV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzpXE0ACgkQPX1aK2wOHVjcFACgg2EGAjTF8gHt7kXllbNNtBS2
T6kAmwUG+DcdwAtRRvEyqlJ4rfy+9S8T
=PgLX
-----END PGP SIGNATURE-----

--=-Gf0ONvlLTXiF45LMTtyV--


--===============0253445394622916693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0253445394622916693==--
