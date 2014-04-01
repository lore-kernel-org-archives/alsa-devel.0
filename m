From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Fail codec probe if we fail to
	add controls
Date: Tue, 1 Apr 2014 17:03:11 +0100
Message-ID: <20140401160311.GZ2269@sirena.org.uk>
References: <20140401125933.GA25844@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6714342514218705222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57DBE265463
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 18:03:24 +0200 (CEST)
In-Reply-To: <20140401125933.GA25844@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6714342514218705222==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ljc4DTHj+3GjP/mD"
Content-Disposition: inline


--Ljc4DTHj+3GjP/mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2014 at 01:59:33PM +0100, Nariman Poushin wrote:
> Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>

Applied, but:

Applying: ASoC: core: Fail codec probe if we fail to add controls
/home/broonie/git/linux/.git/rebase-apply/patch:19: space before tab in
indent.
					  	driver->num_dapm_widgets);
/home/broonie/git/linux/.git/rebase-apply/patch:20: trailing whitespace.
	=09
please run checkpatch.

--Ljc4DTHj+3GjP/mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOuM8AAoJELSic+t+oim9+hwP/jGEOpUu4CzDXPpVK9jR6qKK
MfmGF7eFiDFArcBSijEgOVe4DC6A2SPGMNV6EmH1T519vnb3pwVRy2VfrXcwyLD0
6/eLeiypduVdVqtVO7hkpP5+HkJKn5zpyiqpO92soKhZMIehhod8V4rgYlKS/O4W
PdlhPkM5IVn++TwvjQSf8NltEnz5hA6Ui0s6PxgoI6cY/oGoNFNd1OTWrkRdHdUk
MV7srpR7f7Q7CKnmsNRQKjmWPgDoBRUWtTpVu+YSygY3XL5d4fLG0s4EiZKqX9Ji
5cFqBDf36wSz6SwCS3H8Lw2Wl1rFkpscUuJ9yhquvtwvufULm52iQchT7ecq79gM
yBiBII4yYgyGm+/e8IrgN49zhqVkK3LzYAoLnN5rFRmNRDiksNCp6StbDQArE54X
8xngdrhuoKXdUOsNu28iALAcqvOgBERrq286yZ1lO7ZSZ/88SKBnl9hlO/WP0dWU
jZS3CqINY6InOs3YKbEZdIH+rLvJ16sRA8QzPL9sdYwRhcYW8PPQaTSoxwK68Dnf
PXBsVEflXkVTzJP1J8KFkIKWyyaf67X3eu2H1ryWzXtLehMXBtib8n1XuZBJdOm5
looCUyTBYmPkamKcNia8GaYF6kQfl7UIEjd4p/ZPodSHKRklGClDM/vlPphufWb3
NCc78PTmwJ9FhkPTU64d
=CsLB
-----END PGP SIGNATURE-----

--Ljc4DTHj+3GjP/mD--

--===============6714342514218705222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6714342514218705222==--
