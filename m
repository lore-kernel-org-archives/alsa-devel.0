From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: core: Do not print an actual
 error when deferring probe
Date: Thu, 19 May 2016 11:34:53 +0100
Message-ID: <20160519103453.GC8206@sirena.org.uk>
References: <1463578889-13709-1-git-send-email-alexander.stein@systec-electronic.com>
 <20160518172019.GS8104@sirena.org.uk>
 <s5hr3czyxea.wl-tiwai@suse.de> <2608815.76PS7RUNga@ws-stein>
 <s5hinyazggk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4530767131254297581=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8401C2674A0
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2016 12:35:08 +0200 (CEST)
In-Reply-To: <s5hinyazggk.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org


--===============4530767131254297581==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 19, 2016 at 08:53:31AM +0200, Takashi Iwai wrote:
> Alexander Stein wrote:
> > On Wednesday 18 May 2016 21:33:01, Takashi Iwai wrote:

> > > dev_notice() lowers the log level to somewhat between info and
> > > warning, and it looks like a sensible choice to me.

> > You want me to change the subject to be more clear?

> If the patch can go in, yes.  The changelog text should be also
> clearer why it's needed and what it gives, too.

There's also the problem with it just squashing all errors, not just
probe deferral.  I really would prefer to see at least some attempt to
push this into a central helper rather than just open coding hacks in
every single user though, that's the thing here.  We want a simple and
consistent way of handling this, going round and doing something custom
at every single caller is going to result in inconsistent behaviour and
means that it's harder to deploy and new and better solutions.

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPZbLAAoJECTWi3JdVIfQiMAH/iBfhycB9CfVngCmTEBxEFYf
2bCDIqQRhcnuVgbGM2QLwoib9jYll4u/+WsUpInm5gOkbAZFEuc52uszq3MKBvEP
KefHTQIuXkgkNMZVfysLX/e1yXjkeaUJNwaUGJctYHKHX2pVTI3kOfxZ2e7Mt/8F
TYoxvbL6IzrYvvdGoWNM/JX6D1EbEKfvKwYqv2SqrmSxghhdA3wttlaMr0JYmxgY
429/m4XNNj2hiK/t3GVE3qp79UqUVGYC/pg0bddvN35axlR/yxK92Kr9xLvUvd4F
LDNIyRhk9ym8TMI+i5uo7v6q7f/OT5nk0g3A2rsHOqQS9pi4fzdTbY63FRhXBp0=
=IC1B
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

--===============4530767131254297581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4530767131254297581==--
