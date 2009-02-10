From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH] ALSA: hda - Bind new ecs mobo id
	(1019:2950) to model=ecs202
Date: Tue, 10 Feb 2009 15:31:22 -0200
Message-ID: <200902101531.23521.herton@mandriva.com.br>
References: <200902081950.34449.herton@mandriva.com.br>
	<200902091704.45960.herton@mandriva.com.br>
	<s5hskmnbebo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id EDC35103863
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 18:31:15 +0100 (CET)
In-Reply-To: <s5hskmnbebo.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Em Segunda-feira 09 Fevereiro 2009, =E0s 17:27:55, Takashi Iwai escreveu:
> At Mon, 9 Feb 2009 17:04:44 -0200,
> Herton Ronaldo Krzesinski wrote:
> > =

> > Em Segunda-feira 09 Fevereiro 2009, =E0s 14:42:55, Takashi Iwai escreve=
u:
> > > At Mon, 09 Feb 2009 08:32:58 +0100,
> > >
> > > I wrote:
> > > > At Sun, 8 Feb 2009 19:50:34 -0200,
> > > >
> > > > Herton Ronaldo Krzesinski wrote:
> > > > > This adds a new sound quirk entry (model=3Decs202) for an ecs =

motherboard
> > > > > with IDT STAC9221 codec (1019:2950).
> > > > >
> > > > > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> > > >
> > > > Applied.  Thanks.
> > >
> > > BTW, I changed the quirk listing and introduced new macros
> > > SND_PCI_QUIRK_MASK() and SND_PCI_QUIRK_VENDOR().
> > > The latter is what it was with subdevice =3D 0, and the former is an
> > > entry with bitmask to match.  This should simplify the list in
> > > future.
> > >
> > > The topic/hda branch already includes this change:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > > topic/hda
> > =

> > This is nice. I saw now another cleanup that can be done, what about th=
is?
> > (default to STAC_HP_DV5 looks a good thing to be done):
> =

> Yes, I originally thought of these HP series.  But, 103c:361a is HP
> mini 1000, and this seems to be working better with hp-m4 model.
> So, we should be a bit careful about this change.
> =

> The alsa-info of that device is found in
> 	https://bugzilla.novell.com/show_bug.cgi?id=3D467381

>From my understanding the STAC_HP_DV5 only exists to enable gpio0 by defaul=
t, =

while STAC_HP_M4 will besides enabling it (passing the "if (spec->board_con=
fig =

> STAC_92HD71BXX_REF)" check), will also do extra setup. I don't know if =

enabling gpio0 with dir=3D1 by default will introduce some bug with some =

machine, but the idea is that all HP laptops with these codecs looks to nee=
d =

gpio0 enabled; even if some of them needs hp-m4 because of extra setup need=
ed =

(besides gpio initialization), hp-dv5 would be safe for them as both enable =

gpio the same way. But I agree we should take care in case initializing gpi=
o0 =

by default can introduce bugs with another unlisted hp laptops.

> =

> =

> thanks,
> =

> Takashi
> =

> > [PATCH] ALSA: hda - Cleanup quirk list for HP dv laptops with =

stac92hd71bxx
> > =

> > Cleanup with SND_PCI_QUIRK_MASK entries for model=3Dhp-dv5.
> > =

> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> > ---
> >  sound/pci/hda/patch_sigmatel.c |   12 +++++-------
> >  1 files changed, 5 insertions(+), 7 deletions(-)
> > =

> > diff --git a/sound/pci/hda/patch_sigmatel.c =

b/sound/pci/hda/patch_sigmatel.c
> > index ddb10bb..0f8a27f 100644
> > --- a/sound/pci/hda/patch_sigmatel.c
> > +++ b/sound/pci/hda/patch_sigmatel.c
> > @@ -1812,16 +1812,14 @@ static struct snd_pci_quirk =

stac92hd71bxx_cfg_tbl[] =3D {
> >  		      "HP dv5", STAC_HP_M4),
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f4,
> >  		      "HP dv7", STAC_HP_M4),
> > -	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f7,
> > -		      "HP dv4", STAC_HP_DV5),
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fc,
> >  		      "HP dv7", STAC_HP_M4),
> > -	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3600,
> > -		      "HP dv5", STAC_HP_DV5),
> > -	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3603,
> > -		      "HP dv5", STAC_HP_DV5),
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x361a,
> > -				"unknown HP", STAC_HP_M4),
> > +		      "unknown HP", STAC_HP_M4),
> > +	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x3000,
> > +			   "HP dv laptop series", STAC_HP_DV5),
> > +	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x3600,
> > +			   "HP dv laptop series", STAC_HP_DV5),
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,
> >  				"unknown Dell", STAC_DELL_M4_1),
> >  	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0234,
> > -- =

> > 1.6.1.3
> > =

> > >
> > >
> > > Takashi

--
[]'s
Herton
