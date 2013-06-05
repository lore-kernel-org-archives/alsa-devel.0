From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: WM8962: Create default platform
	data structure
Date: Wed, 5 Jun 2013 13:25:11 +0100
Message-ID: <20130605122511.GB31367@sirena.org.uk>
References: <cover.1370433363.git.b42378@freescale.com>
 <4e85e3a9b5dfdc04899958424eb53a9cfd0f4ace.1370433363.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7404799932870561316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E358265373
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:25:15 +0200 (CEST)
In-Reply-To: <4e85e3a9b5dfdc04899958424eb53a9cfd0f4ace.1370433363.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, rob.herring@calxeda.com, grant.likely@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============7404799932870561316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hIhQBbMWEy++B+zM"
Content-Disposition: inline


--hIhQBbMWEy++B+zM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2013 at 08:12:55PM +0800, Nicolin Chen wrote:

>  struct wm8962_priv {
> +	struct wm8962_pdata *pdata;

More idiomatic style for this is to just embed a copy of the platform
data struct in the private data then copy any driver model platform data
on top of it.  This simplifies usage as now the driver can assume that
there is platform data available at all times.

--hIhQBbMWEy++B+zM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRry4kAAoJELSic+t+oim98uQP/3oHABuH8a6Yxe3hqm8rm9gO
C2gqIgvCFG4An/0PSnWfxvOLwo8k+nMpVBIFQhZzOBkbPBgxIQ0QVBe/Rt2meg6+
Ng+hQVg/ONlg57j/ha1LpwXeZnm4iNqjCCSJiZzlkWaq5giwnRhegbBII3e7ycmg
5rxVefnGtWvGCS0Y9S8E0DbGlnjfcC/Om2e9jbriy3j3YZoBAh9FsRRTyOvAPJKM
D8p1boB094r6hdSOSm3u2raRbYBdWCopBHArxnFKCgsYnv9DmoNmeqZaGNhDM39G
pCwqeqWuord5WliWMdNES08QVzYgJeU+VCKwXpwKRVp1XC8CuLxX5Sfo6t0HSPEu
CUPK/CwbiNQ81BYKH7kojC2YuR69o7hhyvEa/P6+ayZnDoBJE0Amx4Awz3uM4Nrp
appMAt5dW/VuIe0Dn7RJZ8a9K165jyKTWyF9W1mbO6i5s2qQhZ1X+rWsZtATkYte
S2fBkxnTt60Pg4Ag1rxz5MG1eLFAq6Pc0JU+i82Ur+FBHbt10dU+mAuFonwzEcrh
SsgkghcbGSfkF42eAXhap2jymoAohEUT0dyKQ9qVY7Eoa5QBmfwSXQ4XDQGyJWGM
bIANF1uXvmnt9R8ic1KgDtKi1T3GoHZILHQyDBSDlULWzb/5qhRuFB1+cQLL5owa
6b0Az/vLX86RZKFBJltD
=YY91
-----END PGP SIGNATURE-----

--hIhQBbMWEy++B+zM--

--===============7404799932870561316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7404799932870561316==--
