From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Wed, 8 May 2013 15:59:19 +0100
Message-ID: <20130508145919.GU7478@sirena.org.uk>
References: <1367610549-25542-1-git-send-email-festevam@gmail.com>
 <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
 <20130505101515.GT4945@sirena.org.uk>
 <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
 <20130506220650.GJ7478@sirena.org.uk>
 <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
 <20130508103150.GW7478@sirena.org.uk>
 <518A608E.8030802@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1727210425996900887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E64E62616C9
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 16:59:32 +0200 (CEST)
In-Reply-To: <518A608E.8030802@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Matt Sealey <matt@genesi-usa.com>, "troy.kisky" <troy.kisky@boundarydevices.com>, "zengzm.kernel" <zengzm.kernel@gmail.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1727210425996900887==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="95xjieIIiUQImiTX"
Content-Disposition: inline


--95xjieIIiUQImiTX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 07:26:22AM -0700, Eric Nelson wrote:

> An initial pass of writing all of the default register values with a
> sort of 'cache flush' appears to be the right thing.

> Then it doesn't even matter if the values match the datasheet, or if
> the spec changes over time. If the values are reasonable, the device
> will function properly.

No, it does matter - when we do things like cache syncs on resume the
core will suppress writes of registers which have their power on value
since either the register will have been reset to that value by power
loss or retained the value due to power being maintained.  This is a
useful win when resuming to audio activity, I2C is pretty slow.

--95xjieIIiUQImiTX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRimhEAAoJELSic+t+oim9vN8P/A5btCYlYmjblAodfwcyDWz1
u2Y3ogJPiNc49daQnuWb0Idqtg33SF9QaaaZ04fZP8zV5/ykoX7aSq3wO0HxM4z4
laQs13IBJOcgzTfaV6dL+ShlrxL/ZgM5k9W6aBwvg33i/26Y2DM0xGGM9lsU16az
vEKMkyZLm55vgaoqh/pA/N50nq8xq1mgaYmpwe+JyxCrNIypLeHCIt01WutgYFFD
9nndeXAy8jG4h1LOftqOLD9H/7P6LVBbWrtS7uQnwkkq9rqW119sQTDJbw0rZUWT
GwU/PERyW63hVBbx6E2Pg7QaO3kRQIOqJEEkFNwCjlnXu6aWzzGHCIcbnsq4AXXC
0T0fmLCh+wNetAALUqOZirvpKZM4SdLlVONqshpK18T2wkdb9aVkQCKgYtVqKuGr
7lV53ZTUq9LzS96n301hArVExgXDTs+A4O2WOL27J6e3SBtckrLyrhaiMPnZI0Fa
ucXkDcOLKG9b/ncjOXXobxXmTHh4Nc11KNYv9cjJR+mQoFV84OQsyxT5eWgWEWEu
U812IDNizFCfcSx3W31tzwpjLMZUDEVUqCYe4sCT7Qsc0UfrPPHQSwoEKZ8p2oma
1d15PJ7OdTVR9LsDTKcl5yAvj9U9AwRFp6A10UuZ9blizK/z+uCBWzMS1HUt8abW
dCJzxq5MKpEWkho8GFpD
=btJt
-----END PGP SIGNATURE-----

--95xjieIIiUQImiTX--

--===============1727210425996900887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1727210425996900887==--
