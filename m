From: Andreas =?iso-8859-1?q?N=FC=DFlein?= <nutz@unfoog.de>
Subject: Re: No sound with nVidia Corporation MCP79 High
	Definition Audio (rev b1) (Macbook Pro 5, 5)
Date: Fri, 3 Jul 2009 13:25:06 +0200
Message-ID: <200907031325.06421.nutz@unfoog.de>
References: <4A493A56.1050504@gmail.com> <200907021937.43936.nutz@unfoog.de>
	<s5htz1uconc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SqeTKF8dLn3q4hm"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.unfoog.de (dom0kun.ath.cx [78.46.99.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 87F1724843
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 13:25:07 +0200 (CEST)
In-Reply-To: <s5htz1uconc.wl%tiwai@suse.de>
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

--Boundary-00=_SqeTKF8dLn3q4hm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 03 July 2009 07:37:59 you wrote:
> At Thu, 2 Jul 2009 19:37:43 +0200,
>
> Andreas N=FC=DFlein wrote:
> > On Thursday 02 July 2009 15:15:34 you wrote:
> > > At Thu, 2 Jul 2009 12:54:47 +0200,
> > >
> > > Andreas N=FC=DFlein wrote:
> > > > but i can't get any sound eventhough all channels are unmuted and
> > > > turned up to 100.
> > > >
> > > > i also aplay -Dfoo file.wav again, where foo =3D
> > > > default,front,surround40,.... , but i always get: aplay: main:608:
> > > > audio open error: Invalid argument
> > >
> > > The error is strange.  Did you build with --enable-dynamic-minors
> > > configure option?
> > >
> > > Otherwise the codec registers look OK.
> >
> > hmmm.. well whenever i really build this manually ( ./configure --with-
> > cards=3Dhda-intel && make && sudo make install)  i can't load the modul=
es,
> > because i get:
> > [ 1526.091642] snd: Unknown symbol unregister_sound_special
> > [ 1526.092374] snd: Unknown symbol register_sound_special_device
>

so i finally figured out, the problem with "Unknown symbol=20
unregister_sound_special":  the ebuild always used "--without-oss". as soon=
 as=20
i applied that to my manual ./configure i was able to load the modules. how=
ever=20
now dmesg throws some errors - i attached them to this mail. i'm a little=20
confused why there's still my build-dir in the errors,=20


--Boundary-00=_SqeTKF8dLn3q4hm
Content-Type: text/plain;
  charset="UTF-8";
  name="dmesg_tail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_tail.txt"

[30518.015451] HDA Intel 0000:00:08.0: PCI INT A -> Link[LAZA] -> GSI 23 (level, low) -> IRQ 23
[30518.015513] HDA Intel 0000:00:08.0: setting latency timer to 64
[30518.176350] ALSA /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3844: autoconfig: line_outs=1 (0xa/0x0/0x0/0x0/0x0)
[30518.176366] ALSA /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3848:    speaker_outs=1 (0xb/0x0/0x0/0x0/0x0)
[30518.176379] ALSA /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3852:    hp_outs=1 (0x9/0x0/0x0/0x0/0x0)
[30518.176391] ALSA /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3853:    mono: mono_out=0x0
[30518.176401] ALSA /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3856:    dig-out=0x10/0x15
[30518.176411] ALSA /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3864:    inputs: mic=0xd, fmic=0x0, line=0xc, fline=0x0, cd=0x0, aux=0x0
[30518.176425] ALSA /home/nutz/tmp/alsa/alsa-driver-unstable/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3866:    dig-in=0x12
[30518.479301] ALSA /home/nutz/tmp/alsa/alsa-driver-unstable/acore/pcm_native.c:2056: snd_pcm_hw_constraints_complete failed
[30518.479750] ALSA /home/nutz/tmp/alsa/alsa-driver-unstable/acore/pcm_native.c:2056: snd_pcm_hw_constraints_complete failed

--Boundary-00=_SqeTKF8dLn3q4hm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_SqeTKF8dLn3q4hm--
