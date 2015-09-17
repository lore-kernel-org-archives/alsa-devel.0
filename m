From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: fsl-asoc-card: add AC'97 support"
 to the asoc tree
Date: Thu, 17 Sep 2015 11:37:09 +0100
Message-ID: <20150917103709.GA12027@sirena.org.uk>
References: <E1ZcItt-0007vf-Ba@finisterre>
 <20150917074148.GA62898@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8137915529421334105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3795D261ADC
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 12:37:20 +0200 (CEST)
In-Reply-To: <20150917074148.GA62898@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Maciej Szmigiero <mail@maciej.szmigiero.name>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8137915529421334105==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Efvj0OqvPr19h3JK"
Content-Disposition: inline


--Efvj0OqvPr19h3JK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2015 at 12:41:49AM -0700, Nicolin Chen wrote:

> This patch breaks my previous function:
> [    2.020415] wm8962 3-001a: customer id 0 revision D
> [    2.076388] fsl-asoc-card sound: failed to find codec platform device
> [    2.086166] fsl-asoc-card: probe of sound failed with error -22

> It's actually weird that I didn't see the patch in my mailbox at all
> (I searched for it in my Gmail just now) as I found that Maciej put
> me in the CC list: http://www.spinics.net/lists/kernel/msg2066060.html

> Is it possible for you to revert it provisionally?

OK, done.

--Efvj0OqvPr19h3JK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+pfUAAoJECTWi3JdVIfQXCIH/jW054e+8SEIwjhks5EG5EeT
qLu8ltoG7kJnnALbFyLFgYLT+FGYjCTo/tAKKOs4P85vCEyiIQXxXJWVwf2T5xjv
wYQMkv54cD0NCYzWH+jl6zHKwpvsOc/Byhp6IDoKewlTlD/V2Pfsxpxqu02o1FP3
jh0OfOoMNbIw4nfCgUpZHzKQPTGR7gX/6NtQC6hneSs13y85IRrnKzN7aDxbScb1
db5khgtjmfc0BI6lv7P2L0SBqAWuhJvX6wSuSUtNop7icI5VcfR62WF+5EY7fr4g
oZQmNJCwdfK3MxFyfwiyvhHae4M69BpmxVRlrdulw9h96O0y54zFDFQULCM9KO4=
=SeM3
-----END PGP SIGNATURE-----

--Efvj0OqvPr19h3JK--

--===============8137915529421334105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8137915529421334105==--
