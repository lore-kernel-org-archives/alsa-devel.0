From: TonTon <tonton@bdefracte.org>
Subject: Re:
 =?iso-8859-1?q?snd=5Fhda=5Fintel_and_Asus_F3Jv_probl?=
 =?iso-8859-1?q?em_on_2=2E6=2E19?=
Date: Thu, 21 Dec 2006 23:00:06 +0100
Message-ID: <200612212300.06635.tonton@bdefracte.org>
References: <200612012211.03655.tonton@bdefracte.org>
	<loom.20061220T200527-691@post.gmane.org>
	<s5hbqlxryek.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hbqlxryek.wl%tiwai@suse.de>
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

Le jeudi 21 d=E9cembre 2006 17:45, Takashi Iwai a =E9crit=A0:
> At Wed, 20 Dec 2006 19:26:55 +0000 (UTC),
>
> TonTon wrote:
> > Takashi Iwai <tiwai <at> suse.de> writes:
> > > At Fri, 1 Dec 2006 22:11:03 +0100,
> > >
> > > TonTon wrote:
> > >> ...
> > >
> > > Thanks for your report.  It's fixed on HG repo.
> >
> > Thanks for he correction.
> >
> > > > So the module crash on load on my laptop.
> > > > A simple fix can be to test if pointer is NULL, but I 'm not sure
> > > > what it implies. The fix makes the module work (with sound), but I
> > > > can't test with a mic (I guess it is related)
> > >
> > > I guess it's a Conexant codec?  If yes, Tobin is working on this stuff
> > > recently.
> >
> > In fact it is a Realtek ALC660 reported in /proc/asound/card0/codec#0.
>
> OK then it's a totally different one.
>
> > With lastest hg it gives :
> > hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
> > ALSA /home/tonton/src/alsa/alsa-driver/pci/hda/hda_codec.c:2175:
> > autoconfig: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
> > ALSA /home/tonton/src/alsa/alsa-driver/pci/hda/hda_codec.c:2179:
> > speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> > ALSA /home/tonton/src/alsa/alsa-driver/pci/hda/hda_codec.c:2183:   =

> > hp_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
> > ALSA /home/tonton/src/alsa/alsa-driver/pci/hda/hda_codec.c:2191:   =

> > inputs: mic=3D0x18, fmic=3D0x19, line=3D0x0, fline=3D0x0, cd=3D0x1c, au=
x=3D0x0
> > hda_codec: num_steps =3D 0 for NID=3D0x8
> >
> > Alsamiser doesn't start :
> > alsamixer: function snd_mixer_load failed: Invalid argument
> > hda_codec: num_steps =3D 0 for NID=3D0x15
> >
> > Then I tried to force it in alc861_cfg_tbl adding SND_PCI_QUIRK(0x1043,
> > 0x1339, "ASUS", ALC660_3ST), in patch_realtek.c), but it doesn't work.
> > dmesg :
> > hda_codec: num_steps =3D 0 for NID=3D0x15
> > hda_codec: num_steps =3D 0 for NID=3D0x15
> > hda_codec: num_steps =3D 0 for NID=3D0x15
> > hda_codec: num_steps =3D 0 for NID=3D0x8
>
> Did you try other values?  You don't have to change the code but
> simply pass model=3Dxxx module option at loading.  I guess asus-laptop
> would match with your hardware.
> See ALSA-Configuration.txt for the available option values.
>
In fact I tried all values, and no one works. I will try other versions to =

find why I get no sound at all (default config with alsa kernel 2.6.19 =

version was working, but only with one control in mixer)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
