From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: qcom: change PTR_ERR argument
Date: Mon, 14 Sep 2015 19:04:25 +0100
Message-ID: <20150914180425.GB12027@sirena.org.uk>
References: <1440957911-7687-1-git-send-email-Julia.Lawall@lip6.fr>
 <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9130511510968503994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A7E2605FF
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2015 20:04:38 +0200 (CEST)
In-Reply-To: <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9130511510968503994==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N5b0NsBGdE2hIyw+"
Content-Disposition: inline


--N5b0NsBGdE2hIyw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2015 at 08:05:10PM +0200, Julia Lawall wrote:
> Apply PTR_ERR to the value that was recently assigned.
>=20
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)

I have no idea what's going on with this stuff without spending more
time than it looks like should need, there's a moderately big thread and
some patches posted in the middle of it.  Can you repost whatever the
current state is please?

--N5b0NsBGdE2hIyw+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9wwoAAoJECTWi3JdVIfQmj0H/3lruYh3O9vUoAvbLXz6pz64
BC05jzlUO0BqyTEMtUIf8fysl0AJMpQwUW+z1BzrERsdYuJnA/LhsVdK65AkRbmj
5xuZM+QXBjbCwH9k0rUJLOE36XtUY4PT9l2NG06NGc/esmuzfEUFAq9VWSrh0Vv/
otwUkz4Tlb4kLjGTlzQW8u6RzKRBQfLaYxyTVcI7a+4q4lYnlcOm5JObkuEy7WKl
/4yUYDg4sL5xjDHgHOlxYeTwwFsQN1kTcVgu+jjZ3K6OKWbt2NY6f39BPBwSL/FP
1h6uqeEjS5yKv9YqVN3UpmM2GUY3YgR4xOncSl5QydX53kMmMDrdQBbLJt9gkK8=
=qkwL
-----END PGP SIGNATURE-----

--N5b0NsBGdE2hIyw+--

--===============9130511510968503994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9130511510968503994==--
