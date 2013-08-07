From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Wed, 7 Aug 2013 10:36:29 +0100
Message-ID: <20130807093629.GU6427@sirena.org.uk>
References: <1121E117AD4ECE49880A389A396215BB935C692E40@rtitmbs7.realtek.com.tw>
 <5200C369.6050607@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E62@rtitmbs7.realtek.com.tw>
 <5200CD0D.7030007@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E81@rtitmbs7.realtek.com.tw>
 <5200DE78.5060409@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692F72@rtitmbs7.realtek.com.tw>
 <5201FB09.1080105@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692FD9@rtitmbs7.realtek.com.tw>
 <520204BB.9080603@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3408534524847980047=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FD66261B35
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 11:36:34 +0200 (CEST)
In-Reply-To: <520204BB.9080603@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3408534524847980047==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V4yrq4dHtCqH+JvC"
Content-Disposition: inline


--V4yrq4dHtCqH+JvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2013 at 10:26:35AM +0200, Lars-Peter Clausen wrote:

> That isn't really supported right now. If muting and unmuting the control is
> such a complex sequence maybe it is better to stay with you previous
> solution, without autodisable.

Adding an event callback shouldn't be hard?

--V4yrq4dHtCqH+JvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAhUaAAoJELSic+t+oim9WsQQAJBZ7Gp1suJgGMXRdrqQvIwu
ughCfmBZ9bco+wTRyIDZq01UAdRkO5QqSF/KLA/WkhhaOkqUuahLnRHnj0raHRgI
9jRfpbuyOO31203YMpyvwnHoejV4sWjbOlSnatY4rGQ7T4HuwaffxW755Sc0WOGb
MdqP4YWDP+Ffc1VmugTrFzxwNCtjYfNdU1uwJ78JOLXo1ilPNiHaejq9ft78eJgl
PbZYi8p4FSBlSzjG91fb04Ts4O4UXJSMWBepu5v90RRQFArVonydBhoFYnT/QvFn
Lf4igTxSdmgKea0OMfFjNz7fNkchOylayNeKB6/0bVfKgjRfpvz1leJAI4jBeeIi
FCaY+sQLctqwUzTpruDDPrgP4QTIsT/d1XlN5C9hrHIe4YzzI7lHshfgFnDYjtn8
/IqK7Vo3iMTpWaFku80NUldNUODXJXSMzohvpQaZuLWIXfxlibEhXgnT7n6FJn/M
8cDB66+BscyUo5gwRnRRVk8g/1GnM1OsNsw8F3H+hOP/iw3RZNyhK+hsJlTVdy2o
I9CkWtVxPIePxUdnfzkjbl8lC19oBBfljbuhktfvM4YTXpS5lnn6N0ULaWuJIp/z
H4S52ySvF84Mu6kvjESInnr91hEoDEX2VkNfBs9xfy6UF0c1NvSD2ZLKnqzGOZ/7
wDIGfMQDDqb2DoDwLtrF
=02K+
-----END PGP SIGNATURE-----

--V4yrq4dHtCqH+JvC--

--===============3408534524847980047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3408534524847980047==--
