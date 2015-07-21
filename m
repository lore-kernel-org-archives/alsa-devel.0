From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Don't add prefix to widget
 stream name
Date: Tue, 21 Jul 2015 16:58:04 +0100
Message-ID: <20150721155804.GV11162@sirena.org.uk>
References: <1437472295-5524-1-git-send-email-lars@metafoo.de>
 <1437486892.30798.14.camel@mtksdaap41>
 <55AE5D0A.7030800@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0385984042364205570=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B513260560
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 17:58:14 +0200 (CEST)
In-Reply-To: <55AE5D0A.7030800@metafoo.de>
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
Cc: Koro Chen <koro.chen@mediatek.com>, alsa-devel@alsa-project.org, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0385984042364205570==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+dV+xilh7QQozWTa"
Content-Disposition: inline


--+dV+xilh7QQozWTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 21, 2015 at 04:54:02PM +0200, Lars-Peter Clausen wrote:
> On 07/21/2015 03:54 PM, Koro Chen wrote:

> >I think your solution looks reasonable.
> >However, just curious, why didn't we use strstr(dai_w->name, w->sname)
> >in the first place?

> It's probably just an oversight when the code was developed initially.

I'm pretty sure there's no specific reason behind it.

--+dV+xilh7QQozWTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVrmwLAAoJECTWi3JdVIfQH7cH/2NxzDsHqmDUHyjufsxN1WcB
0TBgPuqIZjV4aUOL+MJH9b/SOW/RY9NVj7cUDWQ9X2YqIc2HSfrPmAYo+Z5dmBQ1
3xEx1uyBbeJplGu6h7d29Qz2aDFYWmKWOd5Haoke8dXNkdN5gTk5PxfOVQvh0D0P
hKDe7Xsip+DxmTfifzsTgx1/S8lV3NKlsl0Zm7pBEX1x8AYIsvM8+Rk7bfhjb4i1
35V9MhpB0NVdKZTSz861BqGLsl7eTmkU1DxqzAezS0RjPgd11x+7DX0l/53KPHrl
RNuqvDuBMQYSX+6QOqUVnn1qFuVAzj3RBISOzldZRRpOrel+3ILCCavYn4pc+P4=
=HDPk
-----END PGP SIGNATURE-----

--+dV+xilh7QQozWTa--

--===============0385984042364205570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0385984042364205570==--
