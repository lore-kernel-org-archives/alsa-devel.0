From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/8] ASoC: tlv320aic32x4: Convert table
 based control and DAPM setup
Date: Tue, 27 Aug 2013 15:35:58 +0100
Message-ID: <20130827143558.GO10783@sirena.org.uk>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
 <1377611461-3638-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389152061431510041=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E2D02651D8
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:36:05 +0200 (CEST)
In-Reply-To: <1377611461-3638-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org


--===============0389152061431510041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MdEjg5WkSuUg8x46"
Content-Disposition: inline


--MdEjg5WkSuUg8x46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 03:50:56PM +0200, Lars-Peter Clausen wrote:
> Let the core take care of instantiating the controls and DAPM widgets and
> routes, this makes the code a bit shorter.

Applied, thanks.

Please don't submit a bunch of unrelated patches as a series, submit
them separately.  It's a bit easier for review and will avoid later
patches getting ignored if there's problems early on.

--MdEjg5WkSuUg8x46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHLlLAAoJELSic+t+oim9Mv0P/Rh8uEXkJLgzwBvTsyBDIU9a
vovP7Ul3FWkRiEVvEVvMlc8p+Uq8m/Y9U0z8NxJ5sOazVwNXNs3xBE5YyFfal+pp
OBWI4RL4FV3FG3W0c7mUE5O7PLcoclxK9yo9jy9lRUp185q3X5HFrTlzAZ3khgun
FjWlRe95T55Jq/8q6drWg1paXjbykqoGZyV1rMVXM2fJArHRWpDSEBTwNP897Xnj
zko8DJFkjjR37YB2aC5bkT4LW8z+5bBC6zbhR0qDw74DIcHxLjfj4ce5sZomXE0A
gTwhjuuawPtGIat16NnCU/t3b1hjGMhyF2JQLfSeJ03Sw61ITXg8JCGkf9+FaGjL
QcRCiO/hObgsIvgcqbYvPanaBoqXIj9BJefxXm5xr1c8dX1Cf6wLnfja9DiK0Mbd
ibjMPPErCGDBUU0AAqGd8oHBq2Hf0VlbalioJ+vqEzs0lFC30RxrRLX1rwukN1sw
IjgLaa7O0KTWVXxvKWE2RLZ4mqjUrctzT8skhqZEZrIGGCo/0w0lBGnYN2w0GBTn
xu/RjMCoXECx695H3xE3Gri72I1dklhWr+iSg1GO+CigI8RixcTQsmpDh4XgVlHm
RLgYQZG2ZvV9cmIII6V5XpX+eIWZsiXDhvUU15ODisc3hZTwyk3X0yVGSznlpZ9l
NO+nCJOWEXhVm7cROH2d
=WOFS
-----END PGP SIGNATURE-----

--MdEjg5WkSuUg8x46--

--===============0389152061431510041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0389152061431510041==--
