From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: mcasp: don't override bclk divider
 if it was provided by the machine
Date: Wed, 16 Jul 2014 23:19:52 +0200
Message-ID: <53C6EC78.1010006@zonque.org>
References: <1405512281-8188-1-git-send-email-zonque@gmail.com>
 <20140716211820.GX17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6495229714063909552=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 72D1C2654BD
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 23:19:55 +0200 (CEST)
In-Reply-To: <20140716211820.GX17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6495229714063909552==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="km2ouIWK1mI24jSfXCMej0Wlsth9psGXP"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--km2ouIWK1mI24jSfXCMej0Wlsth9psGXP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/16/2014 11:18 PM, Mark Brown wrote:
> On Wed, Jul 16, 2014 at 02:04:41PM +0200, Daniel Mack wrote:
>> If a machine driver provides an BCLK divider to the McASP driver, skip=
 the
>> automatic calculation.
>=20
> Applied, thanks.  I had to merge with Peter's changes for the DMA but
> the resolution looked straightforward so hopefully it's OK - you
> probably want to check though.

Looking good, thanks!




--km2ouIWK1mI24jSfXCMej0Wlsth9psGXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTxux4AAoJELphMRr8Y1QklbwQALP9hK/fxqATF/pBxKmJvbFu
IWkUGroG0w8f+qZ3VzYjRHTHV05D8qluC1Fn50LiVl+ZvDXwKdHWxru01zXRrfrY
ThrpPqWZEM0zi2UDs+AHCQXsMS5p1+q5LIzzbg1kKbMGNRET8MXUJzuQ9c5guXtJ
MUohRodqcTtbqX7PMtu5cvbDUUxUksx4wZqlHi9ceFtqCMbK0joID8FiSc7RuTcp
6CsqRKb1agj4VkQaUexFPu67QqDyj+AN2XGbP69mxhtJwd1DsHcZIeJDvN/TyEsm
I2TI3wkpKImZLsoEFZnbfVkPjplBCyXXgpAtCL47Gxq82Q/4OFQSHVGZXO3Ue88+
ljoPljGf1FHgPVMxxLevDzgwPIHvg+cRQPXKs7TBh1q69P7/X9hs8+03Oq0nvRpS
Y9nSZpHhrXBzT5XjZdZ+fTCmFhHXzoN8E6H2ikdTgR9twV+0kQeWV4/iPkD/bwrH
R9BkOQoS99izihDstW/k1n/OZDKo26pDSZkSmmnyu0x8kCnz+ChomtS8QpP+VLM8
SO3OMLlPt3jLbq6W6eRWfmxFtg+bC2khQblIE9Cs7zB32mx5DSQ6dsSLjGnSs8fK
OqVkkbReJEzb0YqnlRkMEMt62iw2y560fYz/mflxj69/YjqVzJlWid8xrjYPXYzo
xblf7Sg3c3HXrfSewYLF
=nbMR
-----END PGP SIGNATURE-----

--km2ouIWK1mI24jSfXCMej0Wlsth9psGXP--

--===============6495229714063909552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6495229714063909552==--
