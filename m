From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: add api for dapm kcontrol
	configiuration
Date: Mon, 26 May 2014 21:48:13 +0530
Message-ID: <20140526161813.GF21128@intel.com>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
 <20140526150507.GQ22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1198735514738261264=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 58A662619E6
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 18:34:45 +0200 (CEST)
In-Reply-To: <20140526150507.GQ22111@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1198735514738261264==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2014 at 04:05:07PM +0100, Mark Brown wrote:
> On Mon, May 26, 2014 at 05:38:55PM +0530, Vinod Koul wrote:
> > From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> >=20
> > For DSPs we need to set and get the value for snd_kcontrol. This is cur=
rently
> > done by dapm_kcontrol_set/get_value, so create a wrapper
> > snd_soc_dapm_kcontrol_get/set_value APIs to let drivers use this
>=20
> Can you provide any more detail on this than just simply stating that
> this is needed for DSPs - why do DSPs need it, what are they going to do
> with it?
Well,... planning to provide a patch too :)

For our DSPs we have mixers and we need to send messages to DSP on mixer en=
able
and disable by DAPM. So this fn helps us to get the value of widget and pas=
s on
to the DSP.

The usage will be in my comming series for our DSP model using DAPM and DPC=
M.

>=20
> >  }
> > +unsigned int snd_soc_dapm_kcontrol_get_value(
>=20
> Missing blank line.
>=20
> > +	const struct snd_kcontrol *kcontrol)
> > +{
> > +	dapm_kcontrol_get_value(kcontrol);
> > +}
> > +EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_get_value);
>=20
> This function has a return value but no return statement, I'm surprised
> the compiler didn't tell you this.  To be honest I'm not sure why
> dapm_kcontrol_get_value() wasn't just exported, the wrapper isn't adding
> much and the function name is already so long that snd_soc_ isn't going
> to hurt.
Looks like patch got mangled, I will fix it up.

And agree to both your and Lar's comment that we dont need a wrapper so will
export the current funtion.

Thanks
--=20
~Vinod

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTg2lFAAoJEHwUBw8lI4NHs4kP/jvWXcF9hV9/gdNjOMfnmRaX
137zu1qFeRFjZqqVseX4mXMzjQiqg/Vs7U2Hx9c5s8Eor6cOW5ZUrVH4YjnCZCC/
VTO0nU1FBSizy1sjWqE/VkbY28lShriqIkKM56M4DCMTKhK4a9ZkiV6NQamTwOjo
7CPOohnad6T+xraeCKuija2Tvx5mYYMlWXUV2q8573JhWYCm4AZTxL66XnoixidY
sGHv13BImhLCHPTmPFKIDQ97pfS+AHaf0kZIdAZ79ReYzh9TtJ/tsGCcSVGnLadv
XJySD3JtTCTc8gcKnj62n8WNUm+zjGvjIjnhtjIp5f825GX+BMRFe88ZOKPbuOFb
Qd8P9XOoL9fKlSHfFkAipWzBsNYgMtXqVry6UnTcfNvxrwWZKh/tdxUkIhSv7E9+
cgXF7mzs0hSJZ6COhaMJb8XkFxjhz6dI7RkbdpjlmQzMwuBe8dV/H9zVgEIC/FLb
MXbhNYrdKd36Ighig6T+VFvKcxud9YGqE2pYq8M48zb2oDV7pSmYK3Q0h3t9bc9G
z/SyMWYwZEXO/WhA6IJJJ4PB0VK8is7VnFLyfF/awc/LiIzLwNhM5I0UTyvUz8BW
dC7X0dX5L5FOrCrnD+otWyJpcmwv1MrrXvMnvqHLSnIWP7utshRa9shWeJVKwq1j
/xT0ah7qPpaYOH3M69it
=ekFy
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--

--===============1198735514738261264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1198735514738261264==--
