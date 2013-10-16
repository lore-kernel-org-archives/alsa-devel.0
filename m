From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: cs4271: Include linux/of.h header
Date: Wed, 16 Oct 2013 18:59:28 +0100
Message-ID: <20131016175928.GP2443@sirena.org.uk>
References: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2566073782323173929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D76F52651E6
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 19:59:30 +0200 (CEST)
In-Reply-To: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2566073782323173929==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JdGtmvFn7I9toFvM"
Content-Disposition: inline


--JdGtmvFn7I9toFvM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 05:23:56PM +0530, Sachin Kamat wrote:
> 'of_match_ptr' is defined in linux/of.h. Include it explicitly.

I'll apply these but they're really on the borderline of what's worth
applying, it's a very minor change with no practical impact and there's
nothing considering if the inclusion of the header is just by accident
or if OF is something that is part of the API being offered.

What would make patches like this much easier to apply would be if they
were combined with further changes which removed the implicit include -
that would answer the above question and would help cut down on
rebuilds.

--JdGtmvFn7I9toFvM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXtP9AAoJELSic+t+oim9ZmAP/1Af5WgXzTmioxwPLMFJ5KQW
karDraGJM+Ldrj46tn/dDfJXJ+kJnlEeovwCe7ciWHdoWqPdcar2k72ET/IVgbiG
wXLD1OtEFZ6Vi4fLcdsK6GAVNqIdoYFiyuKEhkqTwbpp98h3yZUdCeMt+tICtKM3
6Ojjw1daZuNnRosYyBCjUZj9nmJLx/hvwru+HuEsJ2RcsD8rrAGfFtr6sPcbmzPM
vTtObCckXo2Cg30rqS7IV4EElqWOxIcN2COYJeM2W4gv3iF19/6g7oAhLxCGEB+L
b7hlwBJ/NXNS2vFmyNR+aVT5HOcb8XNkhmo++CmnNL2ewA1YOVMV+IpBcsE0E9Vh
4QhbXL/V9sEt6Nsjm9FOjogyNYPK6q0lhs+R/YLDXAMPSoq1gfJM05ZluEe8sHV9
hOSt6VbKpExHXIo9vQ9MXPZmAZbUUlkZzUVgMJo6505Ex+Bup70eMre44m9dPHTJ
D1vXHAAKKt94dYLrB0ZaApmD8fLDmh2vHbKClAUVNsz6rurPkzRAZ+tetFFSFgR2
yEEpgXtNeS4B8NSzWn7o7l/Zd5Qjluk+fx5+iN39PepTQe/TUoYr75sIYFrV8Q5l
Vp+PkKb9ojvO8M5NaLQDldj4/N/zs5XSJ6FmO+V1/Iz69XPWav3NhAk9hsAaSqW0
XqXfou4WhU7DKM092Vdk
=p3nm
-----END PGP SIGNATURE-----

--JdGtmvFn7I9toFvM--

--===============2566073782323173929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2566073782323173929==--
