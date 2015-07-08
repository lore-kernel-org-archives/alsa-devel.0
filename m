From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Use card field to indicate
 whether a component is bound
Date: Wed, 8 Jul 2015 20:04:52 +0100
Message-ID: <20150708190452.GF11162@sirena.org.uk>
References: <1436381264-6924-1-git-send-email-lars@metafoo.de>
 <1436381264-6924-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8136929958962644256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C43C26512B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 21:05:00 +0200 (CEST)
In-Reply-To: <1436381264-6924-2-git-send-email-lars@metafoo.de>
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


--===============8136929958962644256==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YOUJ+9SC2P4ELYXZ"
Content-Disposition: inline


--YOUJ+9SC2P4ELYXZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 08:47:44PM +0200, Lars-Peter Clausen wrote:
> Use the card field of a component to indicate whether it is bound or not.
> This makes a certain sense given that the field contains the card the
> component is bound to and a component can only be bound to one card at a
> time. And it also requires to unset the card field when the component is
> unbound from the card.
>=20
> This makes the probded flag redundant and it can be removed.

Right, this is just a leftover from when we used to open code our own
deferred probing at this point.

--YOUJ+9SC2P4ELYXZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnXRTAAoJECTWi3JdVIfQbfwH/jS6qLv7Lif5NLTaQxHbWI5W
US9ThWNFFH9q/oaYz0E9Ex8Kmuaf1OPHCJKME+rBBEfs/oSL99fFuM+WsbUaGjy5
GFG1AD26YVfr6vOV0HcTU5/y9m6Os1+k0sHaE/J+wGcwVRB+CQFb/3az6LDPnLK0
nOabd/JPPHSjkLIQyw6Uwg4ceqVL6NSFr5Sdln84su9fwqxMVsxxAG3ry8nMQKXr
UUwzvX5sjAroR+psNs4JMgTlRM9pB8x3L9juUWYtwYxjuArxyzUoE3vUGPJDpYFS
MM4WOag48DeFvW2pCjYaoky/XpS/zOpVeLyhXXG24kz+oY/YnMljNNpJhXCwM+k=
=rf16
-----END PGP SIGNATURE-----

--YOUJ+9SC2P4ELYXZ--

--===============8136929958962644256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8136929958962644256==--
