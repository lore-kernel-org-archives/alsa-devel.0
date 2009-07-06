From: Andreas =?iso-8859-1?q?N=FC=DFlein?= <nutz@unfoog.de>
Subject: Re: No sound with nVidia Corporation MCP79 High
	Definition Audio (rev b1) (Macbook Pro 5, 5)
Date: Mon, 6 Jul 2009 16:03:04 +0200
Message-ID: <200907061603.04580.nutz@unfoog.de>
References: <4A493A56.1050504@gmail.com> <200907061459.09745.nutz@unfoog.de>
	<s5hy6r2exs2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7624743341075687587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.unfoog.de (dom0kun.ath.cx [78.46.99.229])
	by alsa0.perex.cz (Postfix) with ESMTP id E915C245DB
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 16:03:04 +0200 (CEST)
In-Reply-To: <s5hy6r2exs2.wl%tiwai@suse.de>
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

--===============7624743341075687587==
Content-Type: multipart/signed;
  boundary="nextPart1636627.aDY5FnnaJf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1636627.aDY5FnnaJf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 06 July 2009 15:39:09 you wrote:
> At Mon, 6 Jul 2009 14:59:09 +0200,
>
> Andreas N=FC=DFlein wrote:
> > On Monday 06 July 2009 14:44:56 you wrote:
> > > At Mon, 6 Jul 2009 12:19:11 +0200,
> > >
> > > Andreas N=FC=DFlein wrote:
> > > > On Monday 06 July 2009 12:08:11 you wrote:
> > > > > At Mon, 6 Jul 2009 11:45:07 +0200,
> > > > >
> > > > > Andreas N=FC=DFlein wrote:
> > > > > > [1  <text/plain; iso-8859-1 (quoted-printable)>]
> > > > > >
> > > > > > On Monday 06 July 2009 09:23:07 you wrote:
> > > > > > > At Sun, 5 Jul 2009 12:30:52 +0200,
> > > > > > >
> > > > > > > > however i was able to reproduce the "bad kfree", by changing
> > > > > > > > the volumes in alsamixer. it always gave me the same "called
> > > > > > > > from ID" so i tried "while (true) do cat /proc/kallsyms |
> > > > > > > > grep ffffffffa001b08b; done" and then changed the volume, b=
ut
> > > > > > > > the grep never returned anything, dmesg of course got more
> > > > > > > > and more of those kfree-errors.
> > > > > > >
> > > > > > > The address won't match exactly in /proc/kasllsyms.
> > > > > > > But you can guess which function by address.  First sort
> > > > > > > /proc/kallsyms then check the position that fits with the giv=
en
> > > > > > > address.
> > > > > > >
> > > > > > >
> > > > > > > Takashi
> > > > > >
> > > > > > well i'm not really sure _I_ can guess ;)    i guess it's either
> > > > > > "t snd_ctl_ioctl        [snd]" or  "t snd_ctl_ioctl_compat
> > > > > > [snd]".
> > > > > >
> > > > > > here are the greps, "snd: bad kfree (called from
> > > > > > ffffffffa001b08b)" being the error:
> > > > > >
> > > > > >
> > > > > > $ cat /proc/kallsyms | sort | grep ffffffffa001a
> > > > > > ffffffffa001a045 t snd_ctl_elem_info    [snd]
> > > > > > ffffffffa001a17a t copy_ctl_value_from_user     [snd]
> > > > > > ffffffffa001a34f t snd_ctl_elem_read    [snd]
> > > > > > ffffffffa001a413 t snd_ctl_elem_write   [snd]
> > > > > > ffffffffa001a515 T snd_ctl_rename_id    [snd]
> > > > > > ffffffffa001a5b5 T snd_ctl_activate_id  [snd]
> > > > > > ffffffffa001a66e T snd_ctl_remove_id    [snd]
> > > > > > ffffffffa001a6ed T snd_ctl_add  [snd]
> > > > > > ffffffffa001a6ed u snd_ctl_add  [snd_hda_codec]
> > > > > > ffffffffa001a947 t snd_ctl_elem_add     [snd]
> > > > > > ffffffffa001abd3 t snd_ctl_elem_add_compat      [snd]
> > > > > > ffffffffa001ad37 t snd_ctl_elem_add_user        [snd]
> > > > > > ffffffffa001ada6 t snd_ctl_ioctl        [snd]
> > > > > >
> > > > > >
> > > > > > $ cat /proc/kallsyms | sort | grep ffffffffa001b
> > > > > > ffffffffa001b4c4 t snd_ctl_ioctl_compat [snd]
> > > > > > ffffffffa001b9ba T snd_ctl_new1 [snd]
> > > > > > ffffffffa001b9ba u snd_ctl_new1 [snd_hda_codec]
> > > > > > ffffffffa001b9ba u snd_ctl_new1 [snd_hda_codec_cirrus]
> > > > > > ffffffffa001bb30 T snd_pci_quirk_lookup [snd]
> > > > > > ffffffffa001bb30 u snd_pci_quirk_lookup [snd_hda_codec]
> > > > > > ffffffffa001bb30 u snd_pci_quirk_lookup [snd_hda_intel]
> > > > > > ffffffffa001bb93 T snd_verbose_printk   [snd]
> > > > > > ffffffffa001bb93 u snd_verbose_printk   [snd_hda_codec]
> > > > > > ffffffffa001bb93 u snd_verbose_printk   [snd_hda_intel]
> > > > > > ffffffffa001bb93 u snd_verbose_printk   [snd_hwdep]
> > > > > > ffffffffa001bb93 u snd_verbose_printk   [snd_pcm]
> > > > > > ffffffffa001bb93 u snd_verbose_printk   [snd_timer]
> > > > > > ffffffffa001bc7b T release_and_free_resource    [snd]
> > > > > > ffffffffa001bcd4 t snd_device_register_all      [snd]
> > > > > > ffffffffa001bd76 T snd_device_register  [snd]
> > > > > > ffffffffa001bd76 u snd_device_register  [snd_pcm]
> > > > > > ffffffffa001be67 t snd_device_disconnect        [snd]
> > > > > > ffffffffa001bf5d t snd_device_disconnect_all    [snd]
> > > > > >
> > > > > >
> > > > > > hope that helps =3D)
> > > > >
> > > > > Maybe the patch below can give a better clue.
> > > > > This will spew stack traces when this error is triggered.  Don't =
be
> > > > > surprised.
> > > >
> > > > oki - new output =3D)
> > > >
> > > >
> > > > [16306.365597] snd: bad kfree (called from ffffffffa001b08f)
> > > > [16306.365604] Pid: 26533, comm: alsamixer Tainted: P        W=20
> > > > 2.6.30.1 #2 [16306.365610] Call Trace:
> > > > [16306.365632]  [<ffffffffa001b08f>] ? snd_ctl_ioctl+0x2e5/0x71e
> > > > [snd] [16306.365645]  [<ffffffff802b8bf9>] ?
> > > > __inc_zone_state+0x20/0x9b [16306.365655]  [<ffffffff802cfffc>] ?
> > > > alloc_page_vma+0x197/0x1e1 [16306.365666]  [<ffffffff802afb63>] ?
> > > > __lru_cache_add+0x93/0xdd [16306.365676]  [<ffffffff802ea651>] ?
> > > > vfs_ioctl+0x35/0x97
> > > > [16306.365686]  [<ffffffff802eaae5>] ? do_vfs_ioctl+0x432/0x482
> > > > [16306.365696]  [<ffffffff806336bf>] ? _spin_lock_irqsave+0x28/0x5c
> > > > [16306.365705]  [<ffffffff80247e22>] ? do_page_fault+0x272/0x29e
> > > > [16306.365715]  [<ffffffff802eab82>] ? sys_ioctl+0x4d/0x81
> > > > [16306.365726]  [<ffffffff8022af2b>] ? system_call_fastpath+0x16/0x=
1b
> > >
> > > Try the very latest alsa-driver-unstable snapshot.
> > > This bug should have been fixed, also possibly with CS420x parser
> > > bug, too.
> > >
> > >
> > > Takashi
> >
> > so dmesg knows the following:
> >
> > [18042.848549] HDA Intel 0000:00:08.0: PCI INT A -> Link[LAZA] -> GSI 23
> > (level, low) -> IRQ 23 [18042.848623] HDA Intel 0000:00:08.0: setting
> > latency timer to 64 [18043.007568] ALSA
> > /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/=
hd
> >a/hda_codec.c:3851: autoconfig: line_outs=3D1 (0xa/0x0/0x0/0x0/0x0)
> > [18043.007584] ALSA
> > /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/=
hd
> >a/hda_codec.c:3855:    speaker_outs=3D1 (0xb/0x0/0x0/0x0/0x0) [18043.007=
596]
> > ALSA
> > /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/=
hd
> >a/hda_codec.c:3859:    hp_outs=3D1 (0x9/0x0/0x0/0x0/0x0) [18043.007608] =
ALSA
> > /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/=
hd
> >a/hda_codec.c:3860:    mono: mono_out=3D0x0 [18043.007618] ALSA
> > /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/=
hd
> >a/hda_codec.c:3863:    dig-out=3D0x10/0x15 [18043.007628] ALSA
> > /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/=
hd
> >a/hda_codec.c:3871:    inputs: mic=3D0xd, fmic=3D0x0, line=3D0xc, fline=
=3D0x0,
> > cd=3D0x0, aux=3D0x0
> > [18043.007642] ALSA
> > /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/=
hd
> >a/hda_codec.c:3873:    dig-in=3D0x12 [18043.121187] ALSA
> > /home/nutz/tmp/alsa/alsa-driver-unstable/acore/control.c:337: control
> > 2:0:0:IEC958 Capture Switch:0 is already present [18043.121204]
> > hda_codec: cannot build controlsfor #0 (error -16)
> >
> >
> > and i don't have a mixer anymore ;)
>
> It's because your chip was uninitialized by BIOS or whatever, the
> another state you got sometimes.
>
> Now fixed in the driver to force to initialize pins.
> Try the latest tarball again.
>
>
> Takashi


TAKASHIIIIIIIIIIIII =3D)        =20
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

digital out is working... i tried the new snapshot (eventhough, as you said=
 my=20
subsystem is now again uninitialized)  and i got back the alsamixer-
capabilities;

i ran mplayer test.wav and started playing around with the mixer-controls.=
=20

when i reached IEC958 and turned it on, my out-jack began to glow red =3D) =
so=20
that works.   i rushed over to my dorm-partners speakersystem and plugged i=
t=20
in - voila that actually works! (i tried a DTS video with mplayer -vc hwdts=
 )

that is SO cool =3D)

however as you might've figured out, analog out is not working, yet ;(   i=
=20
tried the built-in speakers as well as the headphones (and of course all th=
e=20
devices from aplay -L again)

aplay -l      shows 2 devices now though:

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: Cirrus Analog [Cirrus Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: Cirrus Digital [Cirrus Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #1


should i try to reboot the machine to get back the other subsystem id? or i=
s=20
that irrelevant now?


thanks so much =3D)

andy



--nextPart1636627.aDY5FnnaJf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkpSBBgACgkQGIPRDsWq364pgACeMimCRZ5ArAaZ6PXOljXHIKT+
3rsAn24r5JwXlNSbK1DU9ALHFvCGF31U
=bJb/
-----END PGP SIGNATURE-----

--nextPart1636627.aDY5FnnaJf--

--===============7624743341075687587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7624743341075687587==--
