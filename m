From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tpa61xx: add back chip name to the
	controls
Date: Tue, 17 Oct 2017 11:14:24 +0100
Message-ID: <20171017101424.7e2bofvuenvfjlns@sirena.co.uk>
References: <20171017095729.6032-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2816049985336939062=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CA274266F4E
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 12:14:25 +0200 (CEST)
In-Reply-To: <20171017095729.6032-1-l.stach@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de, patchwork-lst@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============2816049985336939062==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtaecmcfy5sz7htr"
Content-Disposition: inline


--qtaecmcfy5sz7htr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 17, 2017 at 11:57:29AM +0200, Lucas Stach wrote:
> Commit cb7e62256e99( ASoC: tpa6130a2: Register component) removed the chip
> name from the controls, which causes issues as the TPA61xx is not a
> standalone codec, but a headphone amplifier, which may be connected to the
> line out of a codec which already exposes a "Headphone Playback Volume"
> control. In that case we end up with duplicate controls, causing the
> the probe of the soundcard to be aborted.

In this case the intention is that the machine driver should add a
prefix via name_prefix in a struct snd_soc_codec_conf.

--qtaecmcfy5sz7htr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnl1/8ACgkQJNaLcl1U
h9BOkAf/X5pQlJnSDZOphkVnAY9Wc3KdnO2JNn5pBGNpHHFHhq79lRfxrYKQq0V/
Q6ArBLqA7XsBdaIQPxjjZmRTdaaoxYmBxSVU7U5OyZA5WnIWB3aISyNHX/NNU/j8
Ye5wmTqQU0h5B5t4ueqvs+6p9J7TwTXFk7mWxp3qolp2+xneq4m0YPm1az5XvFpb
HZHKSHOsUl++6DJfkGi/kuKwYyTuAslrTAi2jMfm+HAeZpz421Tb1GgFqu5ltXVE
a2hLXV20sFUf7k2IsM6ZFSIJj0VI1whu7IAfPdWpm6612Wrv9U0yboTRnkjyd/yo
9ocw2yoZbaP7HV0JE2ccmrkl8SeOQQ==
=tmMd
-----END PGP SIGNATURE-----

--qtaecmcfy5sz7htr--

--===============2816049985336939062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2816049985336939062==--
