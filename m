From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 082/102] ASoC: Add SOC_ENUM_SINGLE_CONST()
 and SOC_ENUM_DOUBLE_CONST() macros
Date: Fri, 21 Feb 2014 08:34:00 +0900
Message-ID: <20140220233400.GD12197@sirena.org.uk>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
 <1392724308-13375-2-git-send-email-tiwai@suse.de>
 <20140220023339.GR2669@sirena.org.uk>
 <s5heh2yxnuk.wl%tiwai@suse.de>
 <20140220090938.GA2669@sirena.org.uk>
 <s5hmwhlvnn8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7624723703877878987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10740265861
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 00:34:13 +0100 (CET)
In-Reply-To: <s5hmwhlvnn8.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7624723703877878987==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 03:56:11PM +0100, Takashi Iwai wrote:

> OK, but still a question is whether to split patches or not.
> By splitting patches, we'll break the build in between, so the
> bisection won't work well.  OTOH, a big single patch would be too
> big.  I myself am inclined to have split patches despite bisection
> breakage in this case.

I'd go with a single patch - if it's big and repetitive it's not going
to be that hard to review - but I think either way is probably OK in the
end so whatever you feel comfortable with.

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBpDlAAoJELSic+t+oim99UUP/101NQbEdxBAsXQWI3oauto+
eT3kiOr6a6k3yVLK1hCGBXwV1mvI4CPyKbUHmN0fOrTMlAIVyVHxwDO+vH+kZSIV
LjmJw1GmCvNtrLVDK6mzCLqtJfkHr8wsKqRiFW2ZaAUVeODknZxrLbY0hVXadjom
dw9gsFUhgbA7LqDK75DW8x9bcrm6JjDf16ihGNWA5uUpMaYrTI0mFI4jdeWx3Oye
jJa6XDDkgZzeiL2TOUI6sq20oFVnO0JUAokfF9C4xfTjd2O02eTx5vb6qGhMbVw6
AJwjtvVUfPCHqqvmRVn0zjW2Cb7VsZO4Nk7hts725vu6e2rn+zS0I+78WrFUDxis
cGlzWyZ0UEgb7IJhs48hiXP0hZjUUwXxDr/2aU1aHWobkJkz5660ser7GyAr7+tH
PysDCLn/BFfV644/24l7Tse7NPynM6Eh7PRRJ+tEeK+Lq+Q2eJ0c4gtZBwTHpRrU
QPssDo6NmyEl9g+AGMEgyy59Rl/PWGYmc5QO5gYS8x7OCi/BA9TtySeI6Co2KyOZ
elz0hFEXKhtaauMGturbQHPvsxzpYMZvtvoHMMiD4gEc3INfkooCxtxuQsjz62RS
0YymKID9QSQ25wWe/XfcKAY2fDJ6eSZ4cwBwforz3wle99RFljrNxKtqNVCj1Xni
Tp2JiBHgRBuhdQ5VuOcf
=iugv
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

--===============7624723703877878987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7624723703877878987==--
