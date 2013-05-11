From: Mark Brown <broonie@kernel.org>
Subject: Re: Debian patches for ALSA
Date: Sat, 11 May 2013 18:16:25 +0400
Message-ID: <20130511141625.GZ3200@sirena.org.uk>
References: <1368225163.24178.1.camel@penyagolosa.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0240805941887380895=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 43B02261A45
 for <alsa-devel@alsa-project.org>; Sat, 11 May 2013 16:16:36 +0200 (CEST)
In-Reply-To: <1368225163.24178.1.camel@penyagolosa.oskuro.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jordi Mallach <jordi@debian.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0240805941887380895==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1G2Bc0EDIhoSmEt"
Content-Disposition: inline


--k1G2Bc0EDIhoSmEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 11, 2013 at 12:32:43AM +0200, Jordi Mallach wrote:

> I'm going to outline all the individual patches below. The patch tracker
> has the patches just as I would send them upstream, but if you prefer
> git formatted patches, I can go ahead and do that too, if it makes your
> life easier.

That's the normal workflow for sending stuff and it makes it easy to
apply things.

> http://patch-tracker.debian.org/patch/series/view/alsa-tools/1.0.27-2/envy24control_config_dir.patch
>    This one is to be discussed. envy24control currently creates a
> visible directory in $HOME, which is quite unacceptable. This patch just
> moves the directory to a dotdir, but an upgrade path might need to be
> coded. I would just move the thing away.

Or just have it only create the .dir but check both names?

--k1G2Bc0EDIhoSmEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjlKwAAoJELSic+t+oim9iQ0P/2rpeDmWfFnY/iPncoqlXG+Y
nufOHU90qVDhav3VkjcgMrTvpNu96xdWSKYsfxP1LO+HDRfDmCSv+M+N2ZPFUzLA
YXwoH/kelwPxNnQcLWyVsNO46Vsf7+/Anqu74Awl9TVlpAhGlhXktNnpw/pCKCil
gOMTY00FiBm4J3YfTjwFKPYHCmbR1emgvfqgrVdFlGjinKM//TyBx0UD/o3Zow7Y
JMvR9eiguyaoJGUWuAYSvZ2faGhdpVXOkmJsg6rx1nv/pMZxYE0OtQwMnLGf4xf9
AYaboPoebg36l/s1RvNn64SipHeyHThqRS5kwuxgl/B60nQvIlQrhuvVh5AuFJqq
7PoOKeqUA+OhrFtwE1mDSV1z9W8FvrVKEssN7wdjmD67f2rXWccwOs7mMDGynonl
qX4EtmR1nXsq8DrBxe5rAtThk46rV8b7qXXnfFr/menu31cHWlsvKf0Qog8bJjd4
qzb/aFefhENX6l13LU5o9qjbyyleUfirgwKdeniIseVKdC0jDVHis+dm6YjMwNHA
N3n+sKhH/XN+x6539KOBpinSbz2G932EFPzD134D1u1Y8RU2SZ3nLc7CdmkAndvu
6hPELOIQyby0zk5OLfxhQSx9JqpYS3IGSEglUVI0kY9UGyGpe+UZIFLU4V70gJg2
Mn7AvwY0eRplQTL6oXYx
=wP5h
-----END PGP SIGNATURE-----

--k1G2Bc0EDIhoSmEt--

--===============0240805941887380895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0240805941887380895==--
