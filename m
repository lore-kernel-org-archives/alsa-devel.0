From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: tlv320aic3x: Fix
 snd_soc_dapm_put_volsw_aic3x callback
Date: Tue, 27 May 2014 12:02:59 +0100
Message-ID: <20140527110259.GM12304@sirena.org.uk>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3726373642617351673=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B46122619E9
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 13:03:16 +0200 (CEST)
In-Reply-To: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3726373642617351673==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RNUxo9UfwfPnf+lP"
Content-Disposition: inline


--RNUxo9UfwfPnf+lP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2014 at 01:53:04PM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> Commit "cf7c1de20c576 ASoC: dapm: Move 'value' field from widget to
> control" changed the way how the 'value' has been stored for a widget.
> This resulted issues with codec drivers needing and using custom dapm put
> callbacks to handle the hw underneath, like the tlv320aic3x driver.
> Since the driver is not updated following the mentioned commit it is most=
ly
> broken when we try to change Left/Righ PGA mixers:

Applied both, thanks.

--RNUxo9UfwfPnf+lP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThHDgAAoJELSic+t+oim9gjIP/2zctQF7KS+/2s/v2iJmZecW
mEp3kDh3S2mORfQ0pwjPtpeJMgfC2/MivXQuUzkviuwVBGuVTBHnqDlCArBA1Cxi
aZqWS7242gCVYA4jugHGmDIFl6QllMzw2pva90vOWLScBIoDVkWVB6chHlHuZdmS
qwOFg+Se0gkLY35Ua83EgZ/O6a5NoFJLpkWB/rMnV7V1IHIU9Mx7VAhgqeM5ToJ/
1aaZgzOXHXFYXQorK49XdxInaTic3Z1HMNjJvvzJuJFLi0sgF5Xgb+30JuFV8Ufa
BYpf4CxS+KlyAStnHaG0x7QHB0Y972MYW73vfOIfULfGfLawccvJZ6ubYHhod5Ov
L3+7XX/+WsWw2WxXs6ALm0r7Q7j1C8To9jhHFhvLE87lGAIAPmYZz38RhN0V9dr1
Ulcsrk0Ofc6RGVjXXfZA+N9NYe9m3nsBRQzD2zEM3eQPek1NtAZ6f6EvDN10C5/O
rTFaYqIGxSeub4koD7neA+TzbhO+YfT+6oGsjDrZsyThDlw88Xlf69bpKPEESm7D
DecPItmFdrXrQmgvMpy6pE+CHQFPC81K6HMaKK3VLik30YuF7OTArGQf25ITZ44r
c1VNBWIVYsRBV94ZymfR4KiUS2KqyaV6qcHQ1FJvtv4F7NWIEzmJk8ZNrRkbAaAC
YncIUDOhIDDgrgek7cdF
=zMff
-----END PGP SIGNATURE-----

--RNUxo9UfwfPnf+lP--

--===============3726373642617351673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3726373642617351673==--
