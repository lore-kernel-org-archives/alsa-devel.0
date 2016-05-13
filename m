From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm8985: add support for WM8758
Date: Fri, 13 May 2016 12:26:19 +0100
Message-ID: <20160513112619.GF22038@sirena.org.uk>
References: <1463068477-18421-1-git-send-email-petr@barix.com>
 <1463068477-18421-3-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1519439750906034261=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC739260447
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 13:26:44 +0200 (CEST)
In-Reply-To: <1463068477-18421-3-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: plamen@barix.com, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1519439750906034261==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2016 at 05:54:37PM +0200, Petr Kulhavy wrote:

> +static const struct snd_kcontrol_new wm8758_snd_controls[] = {
> +	SOC_SINGLE("Digital Loopback Switch", WM8985_COMPANDING_CONTROL,
> +		0, 1, 0),

>  static const struct snd_kcontrol_new wm8985_snd_controls[] = {
>  	SOC_SINGLE("Digital Loopback Switch", WM8985_COMPANDING_CONTROL,
>  		0, 1, 0),

Rather than completely duplicating the set of controls it is better to
have one table with all the shared controls and then extra tables for
those that are device specific that are registered in probe, that way
we only define things once.  The wm8904 driver provides an example of
doing this sort of thing.

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNbnaAAoJECTWi3JdVIfQpTIH/iH9AMeWJtH+jsULkHFUwuCA
CW/fkVH0N6hLcG6O7HRjotPR2Kmy1WQNf9RIkXoLSYzVqCHUCR51Dha+M1x9Ytfr
7kz6Fkll+LwjT7DIEvLZtrAfVVIXtqCxAPhN6lL3lDpnn7//zL5B8M9ql1xGFfvm
ncelQnWlWko8g6RlI4apfY7K+ruINkJdzO8FSLsRRtC3AJWf0Pj12l31kZOZ8Yxt
xA+HJiYm/24n/ayugh7QUgcfbYbefI86Ob05StMtQHK6prJ1vZtXjYsZbajLDYWo
kaDgSkEzFnzeY5d9/ZVcWoy/O8Ptxf+MfVx1bh2kV0BM80ycruDH9OO22kxj50E=
=lIvA
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--

--===============1519439750906034261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1519439750906034261==--
