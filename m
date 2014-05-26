From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add api for dapm kcontrol
	configiuration
Date: Mon, 26 May 2014 16:05:07 +0100
Message-ID: <20140526150507.GQ22111@sirena.org.uk>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0240973074824463755=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D0532652B7
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 17:05:40 +0200 (CEST)
In-Reply-To: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0240973074824463755==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hVel+ndfTAVlA9HE"
Content-Disposition: inline


--hVel+ndfTAVlA9HE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2014 at 05:38:55PM +0530, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>=20
> For DSPs we need to set and get the value for snd_kcontrol. This is curre=
ntly
> done by dapm_kcontrol_set/get_value, so create a wrapper
> snd_soc_dapm_kcontrol_get/set_value APIs to let drivers use this

Can you provide any more detail on this than just simply stating that
this is needed for DSPs - why do DSPs need it, what are they going to do
with it?

>  }
> +unsigned int snd_soc_dapm_kcontrol_get_value(

Missing blank line.

> +	const struct snd_kcontrol *kcontrol)
> +{
> +	dapm_kcontrol_get_value(kcontrol);
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_get_value);

This function has a return value but no return statement, I'm surprised
the compiler didn't tell you this.  To be honest I'm not sure why
dapm_kcontrol_get_value() wasn't just exported, the wrapper isn't adding
much and the function name is already so long that snd_soc_ isn't going
to hurt.

--hVel+ndfTAVlA9HE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg1ggAAoJELSic+t+oim9ejYP/RnWJc8MRGX2HKtxwYY0x8LL
x0fHyymccTc7xkLUSuhm1Q/NtVLRacP/NrckOb/YxZvVeMPdqCsCQqA8DTQvtw3w
1VMSe2QKcsK3ZaadPwgYRNZt1pNlk1CsfMufXAEef2OILxe4hcy4PLeE9yDb8xK4
B3z08AoFPZorbwvjEPA6EtLOP8VWckbu1gLl7VobB70xJmowfQvMCTrzZy2cAgcQ
D4L32AgLcwot0DIC6XNcxdE8Q2N+08pmNnc1kzOg7DOAKpipyxT0dYSvetDNc4xi
aMzg83ZSiuLbjevkGXsXxsJrKj1gUk3TeQwxo5RQpzeWyaoOf7r1Erhr4WxvsuOu
L6g2oavSPCGsBksnOYZIgc7f95JlranJTkS8d4oTe2pW1JCoLFljs1qL9iFxGSWt
zb+9pFBcNN6fBNKviFNfBOnyN9sBYj9tYI3f+VId1nUJgCtEai8UOS/KS8kN44Eg
voqZfLbXUl9+d97OyETxZfuH4SbMgWJhcXFx5lqYpYAggro4t3o2R9ys1sR7v55h
UH2SVOxjt2T7IxHium4hWlxoOkR+uC1ydguD0LhMQSSWyYtzSH00gOSX+eNyZmQZ
t76MNdmGzS4Uifdo5yfMK/GXDkjW9XGU6P8fTON1eHYFY/Pm2eXC/cmo5f+oZ2Pm
45fZlFF4Gi5BToZnAPug
=5AiU
-----END PGP SIGNATURE-----

--hVel+ndfTAVlA9HE--

--===============0240973074824463755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0240973074824463755==--
