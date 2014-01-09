From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: ad1836: Use params_width()
 rather than explicit memory format
Date: Thu, 9 Jan 2014 14:00:08 +0000
Message-ID: <20140109140008.GS31886@sirena.org.uk>
References: <1389207089-23741-1-git-send-email-broonie@kernel.org>
 <52CE798F.3040201@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2745298240277795148=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7374B261AB2
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:00:17 +0100 (CET)
In-Reply-To: <52CE798F.3040201@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2745298240277795148==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OTWLqIJUDNi0OpDw"
Content-Disposition: inline


--OTWLqIJUDNi0OpDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 11:27:27AM +0100, Lars-Peter Clausen wrote:
> On 01/08/2014 07:51 PM, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> It would have been nice to have a least a small explanation why this is a
> better approach. It might not be immediately obvious to somebody reading the
> log later on.

OTOH it does get rather tiresome with repetitive changes - even where
there's some notes generally the thing to do is look at the patch
implementing the new API to figure out why it's better (not that this is
much help here yet).

--OTWLqIJUDNi0OpDw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzqtlAAoJELSic+t+oim91yAP/RGk/4BstkgoTjFp6fD0ikzy
VW/JI+ir1rZmZ4gAB0a+UNrbLIaIuBcyt+4NpTkhJCrsJRy8gPABCyZqChwZqEmE
B649vUyz3YTj/qMH8Pns/4rGudf4bSt6WoZkyHwTtfH2Ld10RB1QFOohaKVWViSJ
WJtb6uG5UiHkBJvp2EQ3IqLaBH5nqKMPA/OLHw0HBxUzr/QPz2cZwaY+WG1Itl5n
vZigASnlMXrrLF2236PWvQgNFMX3FeCXqUftRbK6N48iztwESAWIVjZmqqjVEoSl
6SQiwDCw51Vgkp+eXxa1n49Wdi/VEdeTNGhQ2E+z7tVELNsX4myOSBR6kHXvdE2C
WgmQhB8JjXOPvItXt9k0R94dIxoKKAki2AsCmlH8jUe9mfisBoFoUfnH2vSj0PRS
/2L0Tepia3aLUTrhQ/Xky6eTdz16kRZBo+wyOqkoTshuhjKHebbOwOIYxJA+HJav
db88KSnNY+w2L3rjZosZANT0epEDHl7A3tIdfkGzWqdXnoZn22y0tmDmR4KNMW17
HWmGwMmb2Yn9cBd7QV1CEdGnBPtOEvo9Q1QN+NqEieKJlmpFnTseU6whyOxAPU/5
2yjBCy6T2VkQRE9SaPF2HUHexXtCYT+eTjXkz9TkvsnXjKv5cFfdTzh3QMIex2gy
9BXnhCNP5FOr7Gv79Lr8
=jyrh
-----END PGP SIGNATURE-----

--OTWLqIJUDNi0OpDw--

--===============2745298240277795148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2745298240277795148==--
