From: Mihai =?UTF-8?B?RG9uyJt1?= <mihai.dontu@gmail.com>
Subject: Re: Audio crackles with 4.1-rc1
Date: Wed, 10 Jun 2015 13:41:35 +0300
Message-ID: <20150610134135.327e2bdc@mdontu-l.dsd.bitdefender.biz>
References: <s5hpp6ov1wv.wl-tiwai@suse.de>
	<s5ha8xsuxe3.wl-tiwai@suse.de>
	<20150429112859.GY10148@earth.li>
	<s5h4mnzgne6.wl-tiwai@suse.de>
	<20150430150131.GA10148@earth.li>
	<s5hd22l7dgo.wl-tiwai@suse.de>
	<20150502150513.GF10148@earth.li>
	<s5hk2w514aj.wl-tiwai@suse.de>
	<20150519161911.GD28070@earth.li>
	<s5hr3qctryf.wl-tiwai@suse.de>
	<20150519215310.GF28070@earth.li>
	<s5hd21vu9k7.wl-tiwai@suse.de>
	<20150610131755.0b906783@mdontu-l.dsd.bitdefender.biz>
	<s5h4mmfooaq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4mmfooaq.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan McDowell <noodles@earth.li>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Jun 2015 12:22:53 +0200 Takashi Iwai wrote:
> At Wed, 10 Jun 2015 13:17:55 +0300, Mihai Don=C8=9Bu wrote:
> > On Wed, 20 May 2015 07:01:12 +0200 Takashi Iwai wrote:
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Subject: [PATCH] ALSA: hda - Disable widget power-saving for ALC2=
92 & co
> > >=20
> > > We've got reports that ALC3226 (a Dell variant of ALC292) gives c=
lick
> > > noises at transition from D3 to D0 when the widget power-saving i=
s
> > > enabled.  Further debugging session showed that avoiding it isn't
> > > trivial, unfortunately, since paths are basically activated
> > > dynamically while the pins have been already enabled.
> > >=20
> > > This patch disables the widget power-saving for such codecs.
> > >=20
> > > Reported-by: Jonathan McDowell <noodles@earth.li>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  sound/pci/hda/patch_realtek.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_=
realtek.c
> > > index 2e246fe495f6..31f8f13be907 100644
> > > --- a/sound/pci/hda/patch_realtek.c
> > > +++ b/sound/pci/hda/patch_realtek.c
> > > @@ -5623,7 +5623,8 @@ static int patch_alc269(struct hda_codec *c=
odec)
> > > =20
> > >  	spec =3D codec->spec;
> > >  	spec->gen.shared_mic_vref_pin =3D 0x18;
> > > -	codec->power_save_node =3D 1;
> > > +	if (codec->core.vendor_id !=3D 0x10ec0292)
> > > +		codec->power_save_node =3D 1;
> > > =20
> > >  	snd_hda_pick_fixup(codec, alc269_fixup_models,
> > >  		       alc269_fixup_tbl, alc269_fixups);
> >=20
> > I'm on 4.1-rc7 which appears to contain this patch, however, I stil=
l
> > get the audio artifacts (crackles) when I boot my laptop (Latitude
> > E7440):
> >=20
> > [    1.058839] snd_hda_codec_realtek hdaudioC1D0: autoconfig for AL=
C3226: line_outs=3D1 (0x16/0x0/0x0/0x0/0x0) type:line
> > [    1.058843] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D=
1 (0x14/0x0/0x0/0x0/0x0)
> > [    1.058846] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0=
x15/0x0/0x0/0x0/0x0)
> > [    1.058849] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=
=3D0x0
> > [    1.058851] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> > [    1.058855] snd_hda_codec_realtek hdaudioC1D0:      Dock Mic=3D0=
x19
> > [    1.058859] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=3D=
0x1a
> > [    1.058862] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=
=3D0x12
> >=20
> > 4.0.4 was fine.
>=20
> Does it happen only once at boot (i.e. at power up), or happens alway=
s
> at runtime PM?  If it's a once-off boot thing, the patch shouldn't
> have much effect.  Something else, very subtle thing, e.g. the order
> of verb execution, might cause this kind of problem.

Only at power up. I've also suspend-resumed twice and can confirm it's
OK.

There's a _very_ brief click at suspend (when the power is cut), but it
looks like a plain circuitry thing. I probably didn't notice it before
because I wasn't looking for it.

--=20
Mihai Don=C8=9Bu
