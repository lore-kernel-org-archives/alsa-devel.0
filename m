From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Wed, 16 Jun 2010 08:33:12 +0300
Message-ID: <201006160833.12197.peter.ujfalusi@nokia.com>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<201006151642.32385.peter.ujfalusi@nokia.com>
	<20100615135322.GG14510@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id BD8352414A
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 07:33:41 +0200 (CEST)
In-Reply-To: <20100615135322.GG14510@rakim.wolfsonmicro.main>
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
Cc: ext Stuart Longland <redhatter@gentoo.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 15 June 2010 16:53:23 ext Mark Brown wrote:
> On Tue, Jun 15, 2010 at 04:42:32PM +0300, Peter Ujfalusi wrote:
> > On Tuesday 15 June 2010 08:11:10 ext Stuart Longland wrote:
> > > Okay, I've had a close inspection of how the SOC_DOUBLE_R_SX_TLV
> > > widgets are implemented.  I couldn't find where in the git trees the
> > > control had been added, I wound up applying this patch myself in my
> > > tree... it apparently got applied in the official trees, but I cannot
> > > find it.
> > =

> > I'm not really sure what the SOC_DOUBLE_R_SX_TLV is for...
> =

> It's for value ranges which have normal unsigned integer mapping but
> where the zero point is not at the lowest value so you need to wrap
> around.  Which isn't actually what Stuart is looking for...

I found the CS42L51 datasheet, and now it is clear what the _SX is doing.

> > But would a simple SOC_DOUBLE_R_TLV enough for the aic3204 codec?
> > I have not looked at the datasheet (if it is available), but I'll try to
> > find it.
> > Well looking at the _2r_sx functions in soc-core.c does not really clea=
rs
> > the intention, but at least I can see several things in the
> > snd_soc_put_volsw_2r_sx
> =

> ...and this won't work since Stuart is looking for something that does
> signed values which I don't think we have already, the standard stuff
> all wants unsigned quantities.

Yeah, the aic3204 needs signed values.
There is this _s8 things, which does signed, but never used, nor really che=
cked =

it.

> > - instead of updating the bits, it rewrites the register, which I think
> > will erase bits, which it should not touch.
> =

> It's just open coding the update bits so there's no actual problem here.

It might be so that I have overlooked something, but...
If the register has:
bit #    Function
0 .. 6 : Gain
7      : Mute

Let say that the mute is set to one, and the user modifies the gain, than i=
n the =

function:

int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
			struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =3D
		(struct soc_mixer_control *)kcontrol->private_value;
	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
	unsigned int mask =3D (1<<mc->shift)-1;

/*
 * mc->shift is 7, whiche means seven bits for the gain bit array
 * mask =3D=3D 0x7f (b0111 1111): it only covers the gain area
 */

	int min =3D mc->min;
	int ret;
	unsigned int val, valr, oval, ovalr;

	val =3D ((ucontrol->value.integer.value[0]+min) & 0xff);
	val &=3D mask;
	valr =3D ((ucontrol->value.integer.value[1]+min) & 0xff);
	valr &=3D mask;

/*
 * Here we make sure that the coming new value has only bits set withing the
 * gain area, so we have b0xxx xxxx for the val, and valr
 */

	oval =3D snd_soc_read(codec, mc->reg) & mask;
	ovalr =3D snd_soc_read(codec, mc->rreg) & mask;

/*
 * We read the content of the register, and taking only the bits, which is
 * within the gain area: b0xxx xxxx
 */
	ret =3D 0;
	if (oval !=3D val) {

/* Only update, if the gain in the chip is different than the new one */

		ret =3D snd_soc_write(codec, mc->reg, val);

/*
 * Write the val to the chip.
 * Now, if the mute was set before it is going to be cleared, since the cod=
e has
 * masked it out, the val only contains the updated bits for the gain part,=
 the
 * rest is 0.
 * So if the user changes the volume, the mute bit is going to be erased. =

 */

		if (ret < 0)
			return 0;
		ret =3D 1;
	}
	if (ovalr !=3D valr) {
		ret =3D snd_soc_write(codec, mc->rreg, valr);
		if (ret < 0)
			return 0;
		ret =3D 1;
	}

	return 0;
}

Have I missed something?

-- =

P=E9ter
