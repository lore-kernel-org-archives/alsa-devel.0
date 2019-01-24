From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: pcm512x: Implement the
	set_bclk_ratio interface
Date: Thu, 24 Jan 2019 18:59:19 +0000
Message-ID: <20190124185919.GI5641@sirena.org.uk>
References: <900a4f74-9312-58d8-a5b3-035305fe184e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6049985686902967805=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 469DE2674A9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 19:59:22 +0100 (CET)
In-Reply-To: <900a4f74-9312-58d8-a5b3-035305fe184e@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org


--===============6049985686902967805==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Content-Disposition: inline


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 13, 2019 at 10:16:21PM +0200, Dimitris Papavasiliou wrote:

> Some boards, such as the HiFiBerry DAC+ Pro, use a pair of external
> oscillators, to generate 44.1 or 48kHz multiples and are forced to
> resort to hacks[1] in order to support 24-bit data without ending up
> with fractional dividers.  This patch allows the machine driver to use
> 32-bit frames for 24-bit data to avoid such issues.

This seems fine to me.  I think when I accepted the patch for setting
bclk ratio that there was hardware which specified the ratio directly as
part of the configuration but it seems that this was not the case; on
the other hand this seems like a reasonable use for it. =20

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxKCwYACgkQJNaLcl1U
h9DFVAf/UAxsurG7q0L3mS6w/aee9hLq2RSNXePNxRXbA4PnnHcCecTnzOcuu2kX
AwSXRIE94o32KPYorCjEkFFlfYAXUg8/IHK6A1f4fKoOQ8vhTVd0N47eSwSuXn/p
Monww0YAIwncDeX/Lqbfb51jNwsRguqPYL09axjKpSB/+1bOLTYLJw7Y5jXwsdat
sTf8E6NDMTcpbLKy2da0EuMcmAKoUGegD/Lm/cSb33Rz/2+w2vi0u6T62b7xGW2n
GZ3e81V8I0Nc+NSmAMeTcoARANDy6iT2jppPnR+VkmlG4523v+cUY1afzdFr0pEW
P2UKtmSppq3ZjUfDZndFAq4QD3k9Bw==
=b/Yu
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--

--===============6049985686902967805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6049985686902967805==--
