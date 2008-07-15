From: "Tony \"Chainsaw\" Vroon" <chainsaw@gentoo.org>
Subject: Re: SB0880 X-Fi Titanium Fatal1ty Pro (with	codecgraph)
Date: Tue, 15 Jul 2008 18:22:18 +0100
Message-ID: <1216142538.4014.8.camel@localhost>
References: <1215985902.4196.11.camel@localhost> <s5h4p6rw5zu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8802456278738475638=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id D18C42446F
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 19:21:53 +0200 (CEST)
In-Reply-To: <s5h4p6rw5zu.wl%tiwai@suse.de>
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


--===============8802456278738475638==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GjteR+paILDpJueL8VPe"


--=-GjteR+paILDpJueL8VPe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Being without power for longer reset it properly, it seems:
ACPI: PCI Interrupt Link [LK2E] enabled at IRQ 47
ACPI: PCI Interrupt 0000:83:00.0[A] -> Link [LK2E] -> GSI 47 (level,
high) -> IRQ 47
PCI: Setting latency timer of device 0000:83:00.0 to 64
ALSA sound/pci/hda/hda_intel.c:2022: chipset global capabilities =3D
0x3500
ALSA sound/pci/hda/hda_intel.c:754: codec_mask =3D 0x2
ALSA sound/pci/hda/hda_codec.c:3242: autoconfig: line_outs=3D4
(0xd/0xf/0xe/0x10/0x0)
ALSA sound/pci/hda/hda_codec.c:3246:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3250:    hp_outs=3D1 (0x11/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3251:    mono: mono_out=3D0x0
ALSA sound/pci/hda/hda_codec.c:3259:    inputs: mic=3D0x14, fmic=3D0x0,
line=3D0x13, fline=3D0x0, cd=3D0x0, aux=3D0x0
ALSA device list:
  #0: HDA Intel at 0xd0100000 irq 47

The mixer restore script then complained about control #4, saying it was
unable to set it; the ALSA mixer state dump contains:
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                comment.dbmin -3450
                comment.dbmax 1200
                iface MIXER
                name 'Mic Playback Volume'
                value.0 0
                value.1 0
        }

All seemed normal, until I started mplayer and got no audio:
[AO_ALSA] alsa-lib: pcm_dmix.c:996:(snd_pcm_dmix_open) unable to open
slave
[AO_ALSA] Playback open error: Invalid argument
Could not open/initialize audio device -> no sound.
Audio: no sound

Kernel-side, things look like the usual 'short attention span' bug:
Pid: 3987, comm: mplayer Not tainted 2.6.26-rc7-00240-gfae47c0 #1

Call Trace:
 [<ffffffff80453c7e>] snd_pcm_hw_constraints_complete+0xbf/0x2b7
 [<ffffffff80453ee8>] snd_pcm_open_substream+0x72/0xb9
 [<ffffffff804ee718>] mutex_lock+0xd/0x1e
 [<ffffffff80453fbe>] snd_pcm_open+0x8f/0x188
 [<ffffffff80228d82>] default_wake_function+0x0/0xe
 [<ffffffff8027f1ec>] exact_lock+0xc/0x14
 [<ffffffff804466f8>] snd_open+0x40/0x53
 [<ffffffff8027f3f6>] chrdev_open+0x120/0x144
 [<ffffffff80285d28>] do_path_lookup+0x1cc/0x1ec
 [<ffffffff8027f2d6>] chrdev_open+0x0/0x144
 [<ffffffff8027b9b1>] __dentry_open+0xe6/0x1e2
 [<ffffffff80286e56>] do_filp_open+0x3ac/0x7f6
 [<ffffffff8027b740>] get_unused_fd_flags+0x7f/0x10e
 [<ffffffff8027b815>] do_sys_open+0x46/0xca
 [<ffffffff8020bdeb>] system_call_after_swapgs+0x7b/0x80

ALSA sound/core/pcm_native.c:2051: snd_pcm_hw_constraints_complete
failed
ALSA sound/pci/hda/hda_codec.c:774: hda_codec_cleanup_stream: NID=3D0x2
ALSA sound/pci/hda/hda_codec.c:774: hda_codec_cleanup_stream: NID=3D0x4
ALSA sound/pci/hda/hda_codec.c:774: hda_codec_cleanup_stream: NID=3D0x3
ALSA sound/pci/hda/hda_codec.c:774: hda_codec_cleanup_stream: NID=3D0x5
hda_codec: num_steps =3D 0 for NID=3D0x2 (ctl =3D Front Playback Volume)
hda_codec: num_steps =3D 0 for NID=3D0x4 (ctl =3D Surround Playback Volume)
hda_codec: num_steps =3D 0 for NID=3D0x3 (ctl =3D Center Playback Volume)
hda_codec: num_steps =3D 0 for NID=3D0x3 (ctl =3D LFE Playback Volume)
hda_codec: num_steps =3D 0 for NID=3D0x5 (ctl =3D Side Playback Volume)
ALSA sound/pci/hda/hda_intel.c:601: hda_intel: azx_get_response timeout,
switching to polling mode: last cmd=3D0x102ba000
ALSA sound/pci/hda/hda_intel.c:608: hda_intel: azx_get_response timeout,
switching to single_cmd mode: last cmd=3D0x102ba000
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
__ratelimit: 455 messages suppressed
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
__ratelimit: 21 messages suppressed
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
__ratelimit: 155 messages suppressed
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0

PCM streams are advertised, which is new:
prometheus ~ # aplay -L
default:CARD=3DIntel
    HDA Intel, CA0110 Analog
    Default Audio Device
front:CARD=3DIntel,DEV=3D0
    HDA Intel, CA0110 Analog
    Front speakers
surround40:CARD=3DIntel,DEV=3D0
    HDA Intel, CA0110 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=3DIntel,DEV=3D0
    HDA Intel, CA0110 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=3DIntel,DEV=3D0
    HDA Intel, CA0110 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=3DIntel,DEV=3D0
    HDA Intel, CA0110 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=3DIntel,DEV=3D0
    HDA Intel, CA0110 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
null
    Discard all samples (playback) or generate zero samples (capture)
prometheus ~ # aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: CA0110 Analog [CA0110 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: CA0110 Digital [CA0110 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Sorry to report that I was too late in capturing codec info, this had
already reverted to the phantom 255 GPIOs configuration.

Regards,
Tony V.

--=-GjteR+paILDpJueL8VPe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh83MoACgkQp5vW4rUFj5oGgwCeOEsyCvjBG6Qb+h/KxwdcajW3
XmcAn0hmqxQ42PS8JBBDNppI8XOY9c5k
=mxFc
-----END PGP SIGNATURE-----

--=-GjteR+paILDpJueL8VPe--


--===============8802456278738475638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8802456278738475638==--
