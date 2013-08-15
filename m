From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
Date: Thu, 15 Aug 2013 14:39:25 +0100
Message-ID: <20130815133925.GA30073@sirena.org.uk>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
 <20130815103358.GY2401@sirena.org.uk> <520CB2B3.9050804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6588407713700381276=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BE2FE261ABC
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 15:39:28 +0200 (CEST)
In-Reply-To: <520CB2B3.9050804@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, eric.y.miao@gmail.com, arnd@arndb.de, s.neumann@raumfeld.com, haojian.zhuang@linaro.org, rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6588407713700381276==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2013 at 12:51:31PM +0200, Daniel Mack wrote:

> Hmm, and you don't like the approach either of having upstream ports and
> assign users to it via phandles?

I don't know what that means, sorry.

> Also note that the last patch in that series ("ASoC: pxa: add DT
> bindings for pxa2xx-pcm") can be omitted, as Lars pointed out. I'll have
> to care for a proper solution at some point.

I applied it since we were already adding a dummy device for the DAI.  I
can revert it if this work without that.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSDNoBAAoJELSic+t+oim9dyYP/i4KLJnhq3I8yIy8xOJvwjIM
pIPhZZmCL3n3lZf7Rpsoc5gX1rECS4UBEmNu9IO2mQFrH3ldI/JsVuhbDyqnkw8h
PY+EDsQ5K8IgEmlHrjClfIlnbAkfenp24+U3YACEfrgi35yEPrFYJL1U6wFQ/KVQ
8hgkmcvy+EnmDFiAgDfaKNewE13pFe3hDmkwmNcad4dYaoagZjH+aIKfVcDoPavb
L0k2mqDw12gozt4nxXEQAWv4Aho7hvTWh8RTOKp8YUdDfg5LHZFtlm6NViH6jvCH
1+5dx8wq77iUMVu1T/7HeYC8SANa+6yA6bUoK58i16rmLmtA+TLKGCddpkv84mF8
D19WALVcnnCGuY9M8IPigt98AbtY+tovhXSN9usCe/nrCPJPX5cCBLJtdc1sCLIZ
1596y+z34ajRt1FkcvZQKG5f7uRxGRUzWri1N6GEbq7JqYUl3jAFpcADCX5Bty4e
GvaE4gULKirBi5+GQ301Zftf801NvjxhzZb7HU6Sw6Z1YV+v9Pj6J/XDOwbfg/aX
Xf5wt+MHTDOAiGM/UH4Ya1C4tRwm/29WH5bvRrrqM1haNhzXyP3973QZvqC2UHq2
gRzwZCoiT00lC55MjHGAlOS6R5vwyub/rsLArcxYi0s2rjoliIimY2N2Imakhma6
v5Gi3bcRx8YDoAPIFvoS
=bEo/
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============6588407713700381276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6588407713700381276==--
