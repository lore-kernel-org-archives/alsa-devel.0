From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix audio crash due to
 negative address offset
Date: Tue, 22 Apr 2014 19:23:15 +0100
Message-ID: <20140422182315.GC12304@sirena.org.uk>
References: <1398173934-20095-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5267802840958290368=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B78B026171F
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 20:23:26 +0200 (CEST)
In-Reply-To: <1398173934-20095-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Wenkai Du <wenkai.du@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5267802840958290368==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eSrKas18a4xGVfR3"
Content-Disposition: inline


--eSrKas18a4xGVfR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2014 at 04:38:54PM +0300, Jarkko Nikula wrote:
> From: Wenkai Du <wenkai.du@intel.com>
>=20
> There were occasional ADSP crash during reboot testing:

Applied, thanks

--eSrKas18a4xGVfR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVrOQAAoJELSic+t+oim9ZcoP/00EXNI3pX0bd2ZWt+f0dN8m
/G7GWKcZurHWX3Trb8Ebb4pyLGkrvfx8b+DcBw0yjrtk87wx2cH1aFS51VHTv4fd
TMa+3QdqrFZuGDLRuQUUIbrrue6o/PM2nqMW/UqEXsnEiAucoH+qdhGCc7pUI6T+
Qi5qIdB2lqCUzFllJDiuB8NWs0scYGfxkx2pIRVY3Pzo2jyNP3kd/F6277+v8L57
Ga/y/baGZGB0x2fzxB1hP+/0PYyzvOwEhLKcW2aUxMOzQcFyUYh5Ids/3k/kvbz7
YDzpEHXxpzHtR511Ny1vdDh+zKFyGU1RijfhOZLJ3bSszwmZB7XZRg44CySyK1Pc
uGCZScG2zrmUnhk4d0ZhMZ7aI0TM7UQG2Uf7jgHOs0SyTsAuftRguxdz6hWNjCn1
3Q7N8ujYvZ6IsbGTGTbK9cQ148IdmsSoBxIk4oMDaOcnCjbSKh8bgvA38I8hEL6C
VNwHoVNkoz0CKIm3iQiNHK79qK3dWDR3J3/uyc5E3Zfbl+8Ib0H8xvaCCRAfYBdp
OMmswp525LVuGetnQG3MLnyZcwKj/DLXrtp/mOB3Y8EqAvJQVEMKAQdqfMJZrBL3
dPpgfnzRK2HCMa6+ACdeB3ZaccMvg5khE+Dhxn0y3YAZ6FyLiilViOAmrPyRrde0
XAZoAsCjrAYGVps+eFW3
=qajF
-----END PGP SIGNATURE-----

--eSrKas18a4xGVfR3--

--===============5267802840958290368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5267802840958290368==--
