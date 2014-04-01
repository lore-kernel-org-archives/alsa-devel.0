From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: max98090: add an of_match table
Date: Tue, 1 Apr 2014 12:46:31 +0100
Message-ID: <20140401114631.GP2269@sirena.org.uk>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
 <1396291098-13796-3-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5029675290184086024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 44E65265328
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 13:46:42 +0200 (CEST)
In-Reply-To: <1396291098-13796-3-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5029675290184086024==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2hpmsZ6F8OXGVmCg"
Content-Disposition: inline


--2hpmsZ6F8OXGVmCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 12:38:18PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Add a device tree match table. This serves to make the driver's support
> of device tree more explicit. Perhaps the fallback for DT matching to
> using the i2c_device_id table will go away one day, since it fails in
> face of devices from different vendors with the same name.

Applied, thanks.

--2hpmsZ6F8OXGVmCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOqcUAAoJELSic+t+oim9RFIP/j4yfLllO+lQUs4KS0ii999C
aQ9fhKscbXiY9WgYH9KtGTC/+EdCKvBJ/+tq8ow72qmrT/cylUqOeR+D6wv5QfcB
PrjLMmHOH38baerwZzFRYUFYsoEpuU5ajhLJh2i9tQnwimeYEuwl+dAYLwFfg8qc
BeqTwYMPKhl/AT8hRXck/JTlTBWhQfXeDJWJlDQcfshAyXkk1XAYqu7yAX1L9W55
TEhdw20JaviA6Y5kYwYaxwPZwxQkE5BJyob9o/d6W3xayZSgCUYAFdmB4sQO6hEs
gwbjMnpWupd+9WMWmTq6wFuAjfAb4ArT38Skaudw0k1vC+lvEWaiSR1JRX87AUCZ
0u9eGbUvtAuyt5OHFeUaMiSnarV6FE8Fj5Vl8eMBuTf+K8A+Ot+aeZtE0+++/oUl
cr6S7XLoKnL50cD/e1NRZ73LEeg2QAWrk2CIkrgY7V7B13GA9rYECkP2jVbfujk+
p6CjESIzTx6jpSVshbNoqbyrpOIVJcY+1TszhffrALhM/7SA5LiWqOYvqEz+lBsl
EdOfXykQdg1trryGq2mR/If0tSoYwAkeaWPRqWp+EmugajSiosJqBW1C3XLgtCON
2ir05nzlPKP827qUB48AVYS+JaxJwXqCuc5rWhZmT5v9wxtFUdmgj56UswH+3S+h
BpZpRL27414PQCak4QPh
=Q3jC
-----END PGP SIGNATURE-----

--2hpmsZ6F8OXGVmCg--

--===============5029675290184086024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5029675290184086024==--
