From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dapm: Don't mark MICBIAS widgets
 as auto non-connected
Date: Mon, 22 Dec 2014 12:45:11 +0000
Message-ID: <20141222124511.GL17800@sirena.org.uk>
References: <1419156344-25472-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389030850949147743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8C1E26052D
 for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2014 13:45:35 +0100 (CET)
In-Reply-To: <1419156344-25472-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============0389030850949147743==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L1EIGrW/+75u5Nmw"
Content-Disposition: inline


--L1EIGrW/+75u5Nmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 21, 2014 at 11:05:43AM +0100, Lars-Peter Clausen wrote:
> The connected flag of a widget only affects widgets that are either a source
> or a sink. The MICBIAS widget is a simple pass-through widget though and
> hence its behavior is the same regardless of whether the connected flag is
> set or not.

Applied both, thanks.

--L1EIGrW/+75u5Nmw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmBJXAAoJECTWi3JdVIfQSksH/2SuFmBDqS+ibcWYub7sOxc9
Iw429DVNgb8MqmXO/2PMr3s70zw/uQVKALnBU7rcxFjHfrH7j2fWxfxHaYaoSpZw
jXB4FMo7sC9uJWCYFaRFtyuLAwhVyLIR38Tp/cirCTDo5lO+7Q+H+614KovlCU/N
Ajc2apSt7Ag9+qQSJPDUM+ELgRHp+l6ciGpCc3EwGPnCjognVV5QOaSp4/U4ieui
fl6QCZ8xfkcO4rhjVOTnTsil+Yo2VRYpKCIDjWkO8xQeLEfWCtiLs1HtXph3eYHi
0ikfo8bY7qXHdRu5udnPg43Wxyuu/4yhare1j2+17FcIOY4NXqMNaFu+As4wexQ=
=Kj4A
-----END PGP SIGNATURE-----

--L1EIGrW/+75u5Nmw--

--===============0389030850949147743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0389030850949147743==--
