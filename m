From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
Date: Thu, 15 Aug 2013 15:01:06 +0100
Message-ID: <20130815140106.GB30073@sirena.org.uk>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
 <20130815103358.GY2401@sirena.org.uk> <520CB2B3.9050804@gmail.com>
 <20130815133925.GA30073@sirena.org.uk> <520CDAF2.7010101@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1381744965511908672=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E170C261AC7
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 16:01:09 +0200 (CEST)
In-Reply-To: <520CDAF2.7010101@gmail.com>
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


--===============1381744965511908672==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2013 at 03:43:14PM +0200, Daniel Mack wrote:

> And users, in that case, a ssp DAI, just reference a port like so:

>         ssp_dai0: ssp_dai@0 {
>                 compatible = "mrvl,pxa-ssp-dai";
>                 port = <&ssp0>;
>         };

> Is that something we can live with?

The issue here is that in hardware terms this DAI is just the same thing
as the SSP port that's being referenced so it'd be more natural for the
sound card to just reference the SSP it's using directly rather than
have this DAI sitting in the middle as a proxy.

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSDN8fAAoJELSic+t+oim9QI4P/AzZ5S3fSPmqK82SYtNEGviR
r+bbrm6EefReenFntiYHM5s6EBSTOJ39Hxvt8FZBMUK3FMllbYyHhlMZkjKfx/q0
kzwdRDEhWxV1+ePZPC4gz0xfk5l6v0ShJ+bi7Dh4V7YLwXqmephgsaEw+7+0rjLo
GA1If9+1Xrby9Xniwpx5JSOGFu0FARGtE4d5/fm8Iu/L1VoI3u9Oh/wJdB7xA+jC
0gP9JRwMJmEdcMA30jVknZyC/v2ia2UesPXJbrvIfep6aXIzxssxhlL8Vnfad9lk
ZNZihupKLjaXqoIy2o/IvxEAkQWwyf1b/pmBaZ2Zqhb2F44WfuZfGxCzw7Clt+dQ
TE9DnXXJk+L3A1L3emFkwmpYTyREYPCKg9nKLbJFANUO0J/yl6nhkCIcR+wXE6lC
CdM3U3vHYz4vUE+NG2Y69g/TAghxpx2lQdv0YTFbUZnQFiDP1PvMzxfT5d4N8vTk
8WH8StzXqMEq3805F454uGy9npxh5OO2t+rBD+PkEtizT3zOyBJ1yNek3WqFbVKa
DuC1m9JF12ccb46wdTFZ08877GfAp9Mt08qRo7JTVYLomZdYj+Rb/E8jB4TMAWc9
Fs+ROx44aaGhe9ppkMMbalAtxrwPxKOLgbQLi2WmYT90NXsCPOgqAIKOqQ7U+81O
37IRDVkgJkuGJ06zo2fo
=HMhq
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

--===============1381744965511908672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1381744965511908672==--
