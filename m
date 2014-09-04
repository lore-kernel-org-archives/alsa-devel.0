From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/9] ASoC: probe/remove and suspend/resume
 manual bias level transitions cleanup
Date: Thu, 4 Sep 2014 20:11:41 +0100
Message-ID: <20140904191141.GN29327@sirena.org.uk>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6693477079346236511=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 43058261A01
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 21:11:57 +0200 (CEST)
In-Reply-To: <1409852652-27939-1-git-send-email-lars@metafoo.de>
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


--===============6693477079346236511==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="klUO3blZLrAR18XW"
Content-Disposition: inline


--klUO3blZLrAR18XW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 04, 2014 at 07:44:03PM +0200, Lars-Peter Clausen wrote:
> The goal of this series is to allow to cut back the number of manual bias level
> transitions that drivers have to do.

Applied all, thanks.  Please word wrap *below* 80 columns.

--klUO3blZLrAR18XW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCLlpAAoJELSic+t+oim9USoP/0o4JsCEVOHImw6OPUe6g5Uv
2tPv/afR6OsjqahEzfOxEQ1Pb44rb2IDzYBbATLXZFPJ6ggen8UhIBdkUzU4C5ft
vjbbEIPGq4ccSI5colVf8fFc6mkJ2+JFeWYG/Zm0/N+Xb1mkpGYi2LQKDzKi8+1k
MJvEbNQcg43TkcE6x+j/enh3xwwv7mvwwmhTmElnKRUZSZ38cpu0KQ+G1OEKKlhy
tXLJUksxKh12g25CXY6xvGopOhMQV6ynaaVxsLQlKIgbshc/a2e0SPc29vtQyyWA
avKC/w0CQi+vmdy2DDjDG5RAWNtpZgWusOnB+wJDnruAYLa4+kUhgZFmikBaspWM
MVKnkLFJqkcSFUW1TWW7EZXbIYd9M9eahw8tN/RzlVXuR4DzuZ8TVyhf/tPlRj5R
KS2KJqINdrSFZJdXZMk4fs8JHJcnely9p2a/TeZxSEHx8WPxVVDT2b12hyjV5mMd
72xAy4KZ1znUBZD+feN93nrZvoRuyXAkLHf9o25k7RVZlmLRal5jVGbrLe4XhQZY
p304qGQCOxiSOBxs28pZyD4L3XYT7TPVbkAqiH+3udxfHnRR+sJjBjMFbadVWNw5
CXvVXWcOS1CWvwz7Lom/4p2JT2QcZZNMdUWmpUeIYAA5biw0e+JTlfUNbvGmdmPh
YVEufk/Ycuq677HbMP4o
=5Wak
-----END PGP SIGNATURE-----

--klUO3blZLrAR18XW--

--===============6693477079346236511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6693477079346236511==--
