From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3 v2] ASoC: tas5086: add regulator
	consumer support
Date: Fri, 28 Mar 2014 11:52:43 +0000
Message-ID: <20140328115243.GE30768@sirena.org.uk>
References: <1395952936-10670-1-git-send-email-zonque@gmail.com>
 <1395952936-10670-3-git-send-email-zonque@gmail.com>
 <20140328113521.GA30768@sirena.org.uk> <53355F99.4010306@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6408402533928076642=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9EA82654B3
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 12:53:01 +0100 (CET)
In-Reply-To: <53355F99.4010306@gmail.com>
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


--===============6408402533928076642==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4YaMMRm3dfitt/ta"
Content-Disposition: inline


--4YaMMRm3dfitt/ta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 12:40:09PM +0100, Daniel Mack wrote:
> On 03/28/2014 12:35 PM, Mark Brown wrote:

> > It'd be better style to enable the regulators during probe to read the
> > ID register rather than deferring.

> I had it that way, but that meant I had to introduce device-level pm
> functions in parallel to the soc-level ones, in order to really bring
> down the supply in suspend, even in setups where the codec is not
> actually used.

> Nevermind, I can change it back. Will resend the patches for tas5086 and
> ak4104.

The ususal thing is to power on and off during the probe (though this is
mainly for devices which actively manage the regualtor at runtime rather
than just leaving the regulator on while the sound card is active.

--4YaMMRm3dfitt/ta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNWKIAAoJELSic+t+oim92x0QAJ12Y5Lc0GBuuNNHFHpkYvVv
D8PuVUhD1+Rp+xTRsytlI35U9K201xzuOnW6w5NFu+/ObQMPsabCOe2Ttq77kEwu
mSTFbXQoqbpYl2hwU36452/n+QcA9IwhxHYHU95riURjImS8zt6lr3OvEWCdKU7E
rueM7dNHTfdb9AZdau3omnOpqkSXep0VOkFRgCTTzPn7eWNM+gZ4YhXqFq3Baxo3
5cikwY+rpdJRaCPBL+o6YKnKpqduaUNtG0JDrS8bHJQ7xFp4KRGR6m/BysToHiX4
voe4FUepHGPFrSpb7oxmaBf3V0xgxUxRSFH6L1ne925/d46JcLJWLpzhaC0YiDUX
XPHSQGTzYwameoBnpxHhD1jLZXySTSsDh/sVZow19gm4j62Osyt/j89mxsT3lxIe
hA8hIieSvsUjHwcr4lF9iB1zaVrb4vnx+5qbZPaAAKIDDUlXjR+4ZDm5yvon5B5U
VUOcTGydkA8llbFXyVfsMml//pg1q1my1tnAKfWDZDJqCxV4fQ4RupYI2kZnqHg8
8NDCSWc1zZTZc56Tuc281lqouPG7gavT5SHXWYbZKb+db6hlKEKmMikUy9Cy2Sh6
jowon+Va+dqgodSShB88tGz/c/s0gnEhi1hcgyZeYDOAvgLjckg+bdXRfSPxzMle
57r73gk/e3ZghFx7SMDW
=uE7G
-----END PGP SIGNATURE-----

--4YaMMRm3dfitt/ta--

--===============6408402533928076642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6408402533928076642==--
