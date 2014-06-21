From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 10/11] ASoC: dapm: Remove DAI DAPM
	context
Date: Sat, 21 Jun 2014 21:36:19 +0100
Message-ID: <20140621203619.GE22657@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2304308669983553899=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50866265478
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:36:47 +0200 (CEST)
In-Reply-To: <1402935191-18398-11-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2304308669983553899==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:10PM +0200, Lars-Peter Clausen wrote:
> The DAI DAPM context was added in commit be09ad90 ("ASoC: core: Add platform DAI
> widget mapping") and the only user was removed again in commit ae10e7e8f ("ASoC:
> core: Only add platform DAI widgets once."). Now that we have a per component
> DAPM context it is unlikely that we'll need the DAI DAPM context again.

Applied, thanks.

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpezAAAoJELSic+t+oim9JUsP/1WuL8kpe69C4L1KmnHZWC21
Kgb1XztvaULtwzOij+c/IOYo+4TIiuF4lzdE9pr5f3AnYwahyCr2pStT7OS1MFWU
tmzlHFj4WZedw9N3ADAasXf5+1/6TIpH6kDK5fhTCdbNQKA2EWrmJv4t02uZBUX3
gABWi5iikjYVb2Nehk8sYAHihjB3bd0/eyqRj1CccROb7Qa/OtSxEEa9MiXjwZ0f
pKj1VP+iRBSIKQadicmZdhHq66eWaoW7a22/nsCAi7uxiPn2sG+yWIHwhDR1WTUS
Dz3oKXbsSavpwrRQHw8ID2uKAsFHTi2WNQSz3/HfUTYcapMSuxIh9qgkykPbTPLd
zczi7LL0uvYxnwkQGA43bZaAvUXTvK7Infv+P2YvcE5U6na5anm2VQHwnB/XYFpn
kHY7I6GQLbiMLDvAsQxrcfZBWGcu7C19EqRnlHMm84eG560G/U06KZflVPvFNw+a
mk36UqFfGbP58C5J672jYnX8uD3ZdTcNIsuoKktvssdiCn5jCsaeLUY55yVFrcnF
Ou65UHpeiDhMmUiPnXDI4GSHq0Dnq5GNVX7wg5JQUdBsympul64P6dsgXVrR9yX9
zjRbzFqvKw/GaxY1G3A8BBEjNE1mhfZXHNxoY9iWENBi/zRqoQe5lL0xXB57nkOY
uT5Lff1QWf4xgnu7h2jP
=e4bJ
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--

--===============2304308669983553899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2304308669983553899==--
