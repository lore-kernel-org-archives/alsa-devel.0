From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: codecs: tas5086: fix
	documentation
Date: Mon, 24 Jun 2013 17:05:51 +0100
Message-ID: <20130624160551.GU27646@sirena.org.uk>
References: <1372083932-4318-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6523751584428289189=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 72F92261B00
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 18:05:55 +0200 (CEST)
In-Reply-To: <1372083932-4318-1-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6523751584428289189==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O2qoDrRdTxptnP8M"
Content-Disposition: inline


--O2qoDrRdTxptnP8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2013 at 04:25:28PM +0200, Daniel Mack wrote:
> The property 'ti,charge-period' must be given in nanoseconds, not
> microseconds.

Applied al, thanks.  Though specifying this in nanoseconds does seem
absurdly high resolution...

Not sure where the "codecs: " in the subject line came from either.

--O2qoDrRdTxptnP8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyG5cAAoJELSic+t+oim9Q5oP+weviOrbLK0noU4SYWoaFbDb
70bR5Xh0cel89IlnExqSTOVSMpn6OCiDslsn06s5/MSs5M8ol7/j8pNAF1b2Fu0A
fWLmIWjNx/tZBaoPJ9kw3f3HBvytsvHaJm+D+kQ72Gm/6jakQMeBhj0v6eWT7tAQ
Onlc+3JI8n5zOt2958Yqrq/SaSL249s+zy9ICDMwhnA/+9ooRNPTI116uPWYpR2h
v8cLpV2sqvYYWRoxhe8N3VmKXfRhuu/RuKIPX9U4Ls7eTwbpMhjAzUUUNnyv/12R
Qkf7/8ZIOuYoRwIRgQQ+h5X+dCPz2Fh1F8T5nzrBDenxphAAqLgyZGQlHYkF7g7C
0JBt9NJ42AtaawWJrL/IYXUSt0kHyDe1H0GiafhJMGoNKHuwAgGJGj6dSJ8A3Fn2
SBjrt0oFNvETD2jxf6naWKLYNGfcAAGVziRvAoaoc2f5ng9mtFTT+00zm+yNVtnL
tg2ubUxhXu8aK01ilOwBL8MhMN17bZWFXCCHAHZkGppP52jRZ1Fyo9wQMsRnjQ37
0YZFwwtMGnEKnVsEizlbNYpV4IjycLQ9Wvn4j7x3SnoIlDx3pqch0ZIH6WyNbjG3
aYexGAFhjGle+M2cj1RfW7Ii2HG7EseeJ8yEmlV+6ik0zbDVljGw6iyBl7/eUDFe
me7u/ELuwvL9zN5fCinD
=jwQJ
-----END PGP SIGNATURE-----

--O2qoDrRdTxptnP8M--

--===============6523751584428289189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6523751584428289189==--
