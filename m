From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/12] ASoC: dapm: Cleanups and speed-ups
Date: Wed, 22 Oct 2014 12:36:34 +0100
Message-ID: <20141022113634.GX2344@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5177040713472261206=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BC6E26517E
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 13:36:49 +0200 (CEST)
In-Reply-To: <1413826604-3212-1-git-send-email-lars@metafoo.de>
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


--===============5177040713472261206==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0btr6/5+bhBdui6J"
Content-Disposition: inline


--0btr6/5+bhBdui6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2014 at 07:36:32PM +0200, Lars-Peter Clausen wrote:

> Changing a single control on a 5 input mixer while the system is idle:

>           Power  Path  Neighbour
> Before:   2      25    32
> After~1:  2      12    30
> After:    2       1     2

> Cumulative numbers for switching the audio profile which changes 7 contro=
ls
> while the system is idle:

>           Power  Path  Neighbour
> Before:   16     141   188
> After~1:  16      80   170
> After:    16       7    23

This series is all basically OK, a couple of small comments one of which
was very near the start of the series or I'd have applied more. =20

Just as a general comment the numbers you're showing here are all for
very small use cases and while they do show an order of magnitude
improvement if they do scale out (it looks like this is mostly linear or
constant factor gains but some of those are scale with the total number of
widgets or paths which can be interesting) since that makes things much
more exciting.  It's also good (though not at all essential) to show the
benchmarks on individual commits since this both keeps them around and
helps people trying to solve performance problems in production find
relevant upstream optimisations to backport.

--0btr6/5+bhBdui6J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR5bBAAoJECTWi3JdVIfQd9IH/2RJ60y3tUalau/HR2sjdOXK
RXvVtPoBBJin7ziQa0P9AUBDNobZWotxx9QZZLrV3LcE7rYDSAY1spsK3Lhznc3n
iWN1oz5WiUm6mg1dlQ3MBHFqWHTVEjkSqQNihrAPja/yU0B6A6NdNwGoMtrls1/+
L1AzjRZUIW/jJZ+HnqXObGn4ClPkwrosK7b/L5COYxGPpyKMJid9W2xMuaWGB5vt
kEb7q/3XHg0uLXNf6RiDZ9hr8n3FvsNb1D4nUGFca/u8PbeFG9R1qR5zuwtWUOOq
WHIFIdVqnKqQ7CvpeNwdWAZ/gmTSm38Gq7GizLlFWxBGZ8aidTSFB8mWyzSuFBY=
=ot7o
-----END PGP SIGNATURE-----

--0btr6/5+bhBdui6J--

--===============5177040713472261206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5177040713472261206==--
