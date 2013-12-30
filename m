From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/19] ASoC: samsung: Don't set unused
 struct snd_pcm_hardware fields
Date: Mon, 30 Dec 2013 13:57:39 +0000
Message-ID: <20131230135739.GF31886@sirena.org.uk>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-14-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4590752830575555286=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C6722261B2A
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2013 14:57:42 +0100 (CET)
In-Reply-To: <1387545625-19240-14-git-send-email-lars@metafoo.de>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4590752830575555286==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6u7lpXof/8C/+w+8"
Content-Disposition: inline


--6u7lpXof/8C/+w+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:20:20PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--6u7lpXof/8C/+w+8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXvQAAoJELSic+t+oim9Pi0P+gOo9l7NTXgaFWoVz75X+9Cq
WxbZ0W3pvJHEDnI+Xg+DaFTYupJgksJ9yNF5BkVEtLHsRbFz8/jN2YqtbAFqEaEJ
UUNfzS1gK+1WrqjXByxhE/RUCR7JzCuItmDA3h6jRFkDaLzqSTPcow0MX84GAvXd
W/tlECaQrsRraG/mDhXWIamF1rxR6or5EUiQNzzLzXqWEAbrqFqvaPxk2klWYgdT
h1Wb7sTtIQolNJJ560QGAC1KtB/P94Onn7xB0icLtF/YbFVCFBY/6piT5uAb8nAq
a4Iri+tZt2BPPvXsltwH90eOm/bt6y0ExNebipGad60StSsWRfuUL3pr2ekltO/T
vQTdohpk9QCuUPTNYyvHJA8trca11QC1WSUR87vWbuOMX4HdJny4lngjbYZ8Xvvx
QF6TbeePgxNNA2SepQPpBdXYgyNYrhvzFToKrskso9mw+ssJcDm6Z5XteNRDdut5
dgRkhs8X1mqhY77deKNlo3Hc+4BbZVuUArRxACh4q+ebWYAU+xJoGGB538/98Qhx
2Un4KfAE++9o6XmAuOCTv9EENXV7AF/XTzvJgINu6Cs5PRpHNh9rkDF16L9R5DjA
LHdNd51xmeudRix+v2UcttWGhxBJtn6wAMLpxd1kZNNQRQKk9FI0wnx64lQP6rry
fnU0yrLSBa5Ac4gYrpZS
=fAYj
-----END PGP SIGNATURE-----

--6u7lpXof/8C/+w+8--

--===============4590752830575555286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4590752830575555286==--
