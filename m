From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: add AGC, MIC_BIAS
Date: Wed, 27 Jun 2012 12:25:23 +0100
Message-ID: <20120627112523.GE308@opensource.wolfsonmicro.com>
References: <4FE9B35B.9020002@aksignal.cz>
	<20120626131712.GT30406@opensource.wolfsonmicro.com>
	<4FEABABC.9040309@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5622512851503490940=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 709D41042E9
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 13:25:25 +0200 (CEST)
In-Reply-To: <4FEABABC.9040309@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prchal =?utf-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, peter.ujfalusi@ti.com, mr.swami.reddy@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============5622512851503490940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 09:48:12AM +0200, Prchal Ji=C5=99=C3=AD wrote:

Please fix your mailer to word wrap within paragraphs, I've reflowed
your text for legibility.

> Dne 26.6.2012 15:17, Mark Brown napsal(a):
> >On Tue, Jun 26, 2012 at 03:04:27PM +0200, Prchal Ji=C5=99=C3=AD wrote:

> >Please move everything out of the big array or if you insist on having
> >the array then use the indexes in the assignments.  Otherwise the code
> >is just error prone and hard to read.

> I just add some elements to big array.
> As I see in other codec drivers (e.g. wm9713) there are big arrays too.
> I think it's more readable to use symbolic names instead of indexes.

I'm saying it's even better not to use an enormous array at all and you
should fix that up rather than extend it (especially given that you're
using a different style to the existing controls).  Only a few old
drivers still use the magic array indexes.

> >>+	SOC_ENUM("Mic Bias", aic3x_enum[MIC_BIAS_ENUM]),

> >No, this should be platform data or done with a callback from the
> >machine driver.  It's very unlikely that it's sensible to vary at
> >runtime without coordination with other driver code.

> I don't know how, can you, please, suggest me. There are three levels of =
voltage.

There are numerous examples of platform data in the kernel...

> >>+	/* set to avoid artifacts on the audio output during power-on/off */
> >>+	snd_soc_write(codec, AIC3X_HEADSET_DETECT_CTRL_B, 0x80); /*ac-coupled=
*/
> >>+	snd_soc_write(codec, HPOUT_POP_REDUCTION, 0x4e); /* 10 + 4 ms, refere=
nce*/

> >>+	/* short circuit protection */
> >>+	snd_soc_write(codec, HPRCOM_CFG, 0x04);

> >This appears to be unrelated to the change.  What is it for?

> This sets default values and I think it would be nice to have
> defaultly reduced pops-up and short circuit protection.

So it is as I said totally unrelated to the rest of your change and
should be sent separately.  As covered in SubmittingPatches don't make
multiple unrelated changes in a single commit, it is especially bad if
you don't even mention some of them.

> >>  	/* DAC to Mono Line Out default volume and route to Output mixer */
> >>-	snd_soc_write(codec, DACL1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
> >>-	snd_soc_write(codec, DACR1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
> >>+	/* mix both channels with -6dB level */
> >>+	snd_soc_write(codec, DACL1_2_MONOLOPM_VOL, (DEFAULT_VOL + 12) | ROUTE=
_ON);
> >>+	snd_soc_write(codec, DACR1_2_MONOLOPM_VOL, (DEFAULT_VOL + 12) | ROUTE=
_ON);

> >This is also an unrelated change to the chip defaults (which we were
> >overriding anyway when we shouldn't be...).  Code like this should just
> >be removed completely.

> No, correct mixing two channels to one is 1/2 + 1/2. 1/2 =3D -6dB.

I'm not sure how that follows on from what I said?  To repeat, the code
you're changing shouldn't be here in the first place and what you're
doing is unrelated to the rest of your change.

> >>+	/* AGC to -10dB, 20 / 500ms, no clip stepping, noise gate -90dB, hyst=
eresis 3dB*/
> >>+	snd_soc_write(codec, LAGC_CTRL_A, 0x2f);
> >>+	snd_soc_write(codec, RAGC_CTRL_A, 0x2f);
> >>+	snd_soc_write(codec, LAGC_CTRL_C, 0xbe);
> >>+	snd_soc_write(codec, RAGC_CTRL_C, 0xbe);

> >Again, just use the chip defaults and let the user override.

> Originally the driver sets many defaults to hear playback, because
> after reset defaults won't hear anything and user need to set many
> switches and volumes. Maybe is not necessary to set AGC here.

All this code in the driver should be removed, the driver should leave
the device in the default state for the most part.

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6u2cAAoJEBus8iNuMP3dzbUP/1ncKqkxbtyB7WhY5LPxQUoS
kapbqBK+4tqIjXOQ/JdJufK5aRWhVBt2QlvwOaQYTnq0jc3jvhpPb5F7bRsX6hDl
bWG5T46dhchIW6v2TZDUzvruT4JBHATDayk1Xt4Sr8KFthv50poePOSILirNdRTO
n0SIuC2cX4+/AlHBpAdmE007bAYwp2Vpls2AZze2UMndQEkdvmYPHEAdWDAJnA2U
/4+ogbHUL5W8wDQ90RslpQc78Yn5btYcc1nSRJ8s6QS+f7OI+v7fttTB76l7lwyA
y42DaM9AWjsTAFTVScPGmr7aUMSWSAUuzQC7orqXbuZL+0MmvfIRqmmGFC+KN4nu
wmCKLjK/hfWQwBQ3Ekf5mhOuGrxC/9YCnT/A7wGt0VeEyFnJef5wPgkM+6PHaqCp
D0D9BEvTkK2XkChUIajLPjXnU7Ef6NJ7EPsYqa3ejZmgIx2HRQs1LOgnqYqraWhd
m8TiAZUwh7oBLmwPBoN6PRf4QfIVB5YA7ePR9u8ekcJlY3Mi/sE4XIOqANnrK1wB
vB/RrLOOik0URp0rntglE40z9ClbDeveG+Tm+zD0VbH+YewH074gEWQEPQgXq9mB
rR5rJAVOS+K7mP9hqNNYswjhLRuhnLtXELOLtRLNXilSa6rNU8cwcLwXPE6mtA2i
JVuHPQK6u07bmOgtDNXN
=Q9Dl
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--

--===============5622512851503490940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5622512851503490940==--
