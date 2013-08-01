From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/10] ASoC: dapm: Implement mixer input
	auto-disable
Date: Thu, 1 Aug 2013 11:48:00 +0100
Message-ID: <20130801104800.GO9858@sirena.org.uk>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
 <1375110845-8069-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8231248014296555326=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BD2B62602F2
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 12:48:04 +0200 (CEST)
In-Reply-To: <1375110845-8069-10-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8231248014296555326==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n4X4T9aR8SDBX+0N"
Content-Disposition: inline


--n4X4T9aR8SDBX+0N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2013 at 05:14:04PM +0200, Lars-Peter Clausen wrote:

> -	ucontrol->value.integer.value[0] =3D
> -		(snd_soc_read(codec, reg) >> shift) & mask;
> +	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
> +	if (dapm_kcontrol_is_powered(kcontrol))
> +		val =3D (snd_soc_read(codec, reg) >> shift) & mask;
> +	else
> +		val =3D dapm_kcontrol_get_value(kcontrol);
> +	mutex_unlock(&card->dapm_mutex);
> +

My first thought looking at this is that I would expect this to be
encapsulated in kcntrol_get_value(), though at the minute it's actually
only returning the virtual value which makes sense for the existing use. =
=20

Equally well I'd expect the value to always be a functioning cache of
the real value so I think what I'm really saying here is that I don't
think we should really be checking if the control is powered at all.  We
do need the I/O path but the power isn't the reason for it, the fact
that we have the value stashed locally is.

Another thing that's bothering me here is that this only works for mono
controls but many of the uses are stereo mutes and/or volumes.  We'd
need to add back the support for those.

--n4X4T9aR8SDBX+0N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+jzdAAoJELSic+t+oim91uQQAIzJxg7pTHacdzScHstwCEpR
BpBVvR/onGe/Nfk7ImOR959/GY/xuJSXyo+lNznEfSt15QFggGP4dwupSGGXY2Rd
gjpzB8mcveGc0tGItD1hTAoHs2PYBx4kQtvyO5QsB8PKA4fOC8C0+hjLZcrDRPsz
GbpchUIbOhf0wdtLkQQNbbng4kgTXLfTIUMLLLTQUL3d5zmgTXmcfIrTCWRjO9V0
61daJ1b9KeVMMTkOlh6bUpLx90+w2rFnS/dp50SlUAcXtsGQ0/BB/moNTIuzHiWv
7aWSb22E69FoKk8ezDVMeP34i8+I/I4nVrK7m95FV7tBDmMHtHv+cLxRJQzJz6/2
frtWuC2hcL80zYVp0qyPl9T87f3oSFk3zMIaqmtJFPK793+b/ATU/q0c/lGmNds3
xcgTFz77P5TLviw56VnHfIJqvh5b7kUBxUz0XxioRz7CAfPq/+wbIy6jT+RTGa4w
9pbCsbNSwHtmA2qF1o4bfGJicMi1rCqgYLEykRwuNywg1up83bQn90wen6SnsP2p
wV20YNrV7J+R6YSw8kut0GxPD3cFjeqmKZDs7XUpF50iBn7EqL+XEVkaLW+1xbaE
IWDckPXSJAj7LODwQEypzAsQMnyHkOOV8tT6zraPpATe8aD3T/iiFM8xgokGMfPi
yV2SAMwRIGlU8wTIaZQX
=vUp5
-----END PGP SIGNATURE-----

--n4X4T9aR8SDBX+0N--

--===============8231248014296555326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8231248014296555326==--
