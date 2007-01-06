From: TonTon <tonton@bdefracte.org>
Subject: Re:
 =?iso-8859-1?q?snd=5Fhda=5Fintel_and_Asus_F3Jv_probl?=
 =?iso-8859-1?q?em_on_2=2E6=2E19?=
Date: Sat, 6 Jan 2007 15:58:58 +0100
Message-ID: <200701061558.58965.tonton@bdefracte.org>
References: <200612012211.03655.tonton@bdefracte.org>
	<s5hbqlxryek.wl%tiwai@suse.de>
	<200612212300.06635.tonton@bdefracte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612212300.06635.tonton@bdefracte.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Le jeudi 21 d=E9cembre 2006 23:00, TonTon a =E9crit=A0:
> Le jeudi 21 d=E9cembre 2006 17:45, Takashi Iwai a =E9crit=A0:
> > At Wed, 20 Dec 2006 19:26:55 +0000 (UTC),
> >
> > TonTon wrote:
> > > Takashi Iwai <tiwai <at> suse.de> writes:
> > > > At Fri, 1 Dec 2006 22:11:03 +0100,
> > > >
> > > > TonTon wrote:
> > > >> ...
> > > >
> > > > Thanks for your report.  It's fixed on HG repo.
> > >
> > > Thanks for he correction.
> > >
> > > > > So the module crash on load on my laptop.
> > > > > A simple fix can be to test if pointer is NULL, but I 'm not sure
> > > > > what it implies. The fix makes the module work (with sound), but I
> > > > > can't test with a mic (I guess it is related)
> > > >
> > > > I guess it's a Conexant codec?  If yes, Tobin is working on this
> > > > stuff recently.
> > >
> > > In fact it is a Realtek ALC660 reported in /proc/asound/card0/codec#0.
> >
> > OK then it's a totally different one.
> >
> > > With lastest hg it gives :
> > > hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
> > > ALSA /home/tonton/src/alsa/alsa-driver/pci/hda/hda_codec.c:2175:
> > > autoconfig: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
> > > ALSA /home/tonton/src/alsa/alsa-driver/pci/hda/hda_codec.c:2179:
> > > speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> > > ALSA /home/tonton/src/alsa/alsa-driver/pci/hda/hda_codec.c:2183:
> > > hp_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
> > > ALSA /home/tonton/src/alsa/alsa-driver/pci/hda/hda_codec.c:2191:
> > > inputs: mic=3D0x18, fmic=3D0x19, line=3D0x0, fline=3D0x0, cd=3D0x1c, =
aux=3D0x0
> > > hda_codec: num_steps =3D 0 for NID=3D0x8
> > >
> > > Alsamiser doesn't start :
> > > alsamixer: function snd_mixer_load failed: Invalid argument
> > > hda_codec: num_steps =3D 0 for NID=3D0x15
> > >
> > > Then I tried to force it in alc861_cfg_tbl adding SND_PCI_QUIRK(0x104=
3,
> > > 0x1339, "ASUS", ALC660_3ST), in patch_realtek.c), but it doesn't work.
> > > dmesg :
> > > hda_codec: num_steps =3D 0 for NID=3D0x15
> > > hda_codec: num_steps =3D 0 for NID=3D0x15
> > > hda_codec: num_steps =3D 0 for NID=3D0x15
> > > hda_codec: num_steps =3D 0 for NID=3D0x8
> >
> > Did you try other values?  You don't have to change the code but
> > simply pass model=3Dxxx module option at loading.  I guess asus-laptop
> > would match with your hardware.
> > See ALSA-Configuration.txt for the available option values.
>
> In fact I tried all values, and no one works. I will try other versions to
> find why I get no sound at all (default config with alsa kernel 2.6.19
> version was working, but only with one control in mixer)

Finally no combination works. I make further investigation with model =

asus-laptop, but I think the problem is related to num_steps reported for =

many mixer controls (even if it was working in kernel alsa version).
So no way to launch alsamixer to control volume.

I join /proc/asound/card0/codec#0 for information :

Codec: Realtek ALC660
Address: 0
Vendor Id: 0x10ec0660
Subsystem Id: 0x10430000
Revision Id: 0x100001
Default PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=3D0x09, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x89 0x89]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] =

[0x80 0x80]
  Connection: 6
     0x18 0x19 0x1a 0x1b 0x1c 0x1d
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081003c: IN OUT HP EAPD Detect
  Pin Default 0x99030110: [Fixed] Line Out at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0810034: IN OUT EAPD Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0834: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0e
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0834: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081734: IN OUT Detect
  Pin Default 0x01a1183f: [Jack] Mic at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0e
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173c: IN OUT HP Detect
  Pin Default 0x99a30130: [Fixed] Mic at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
  Pin-ctls: 0x20: IN
  Connection: 2
     0x0c* 0x0f
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0834: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0d
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173c: IN OUT HP Detect
  Pin Default 0x0121101f: [Jack] HP Out at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
  Connection: 2
     0x0c* 0x0f
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x99330132: [Fixed] CD at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x99430120: [Fixed] SPDIF Out at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] =

[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x26 [Vendor Defined Widget] wcaps 0xf00000: Mono


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
