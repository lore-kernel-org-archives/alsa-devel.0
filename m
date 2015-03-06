From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add suspend_pre and
 resume_post for Broadwell snd_soc_card
Date: Fri, 6 Mar 2015 20:17:50 +0000
Message-ID: <20150306201750.GC21293@sirena.org.uk>
References: <1425012869-11429-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7911278841198354314=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9511626607E
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 21:17:54 +0100 (CET)
In-Reply-To: <1425012869-11429-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7911278841198354314==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OegvuwtT7hTkfb5j"
Content-Disposition: inline


--OegvuwtT7hTkfb5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 27, 2015 at 12:54:29PM +0800, Jie Yang wrote:
> For broadwell machine, we need do some machine related setting before
> suspend and after resume, e.g. disable/enable jack detection, here
> adding snd_soc_card suspend_pre and resume_post for this task.

Applied, thanks.

--OegvuwtT7hTkfb5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gttAAoJECTWi3JdVIfQSkIH/3zH4w1AUJoPI9AgsSFINzDX
o35LDQ2h94wkZokJJG3klBE6zyIT4JZ2vBmkEiegyKbA9J6Bl5euXi4NV0RyQDUP
0Tvzynq9x/IOjN0yskxJOlaKh+6c+U0x2mhdNk6ZWqyk0UJSXd8xR6gWYY+Wg4UA
+jj+OxqctfgSuyeBtaTH5REaXQ2cEsYZqDFyfesc81VXRc5CgHcCP8sVO9pLq+JS
iATURu3pH+Fiw3S3It8neISXrcftzEcAF2W69AUr3XTfLnv3hGBIBc7umlQ6WUkZ
u7vGclRh9uH5jGyjixQ7G6uoXxcYlAhEo5ogYweLo20aj+h1i4iPhLKtSdZwSbo=
=Pvgw
-----END PGP SIGNATURE-----

--OegvuwtT7hTkfb5j--

--===============7911278841198354314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7911278841198354314==--
