From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: fsl_spdif: Add sysclk df support
 to derive txclk from sysclk
Date: Mon, 5 May 2014 12:28:04 -0700
Message-ID: <20140505192804.GO22111@sirena.org.uk>
References: <cover.1398853588.git.Guangyu.Chen@freescale.com>
 <15a2e0485d63bb885422a96c0603b2a5300bdb7e.1398853588.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2228025783811423650=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 16C3D261B11
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:57:15 +0200 (CEST)
In-Reply-To: <15a2e0485d63bb885422a96c0603b2a5300bdb7e.1398853588.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2228025783811423650==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xn9xNsWbHJd/50IB"
Content-Disposition: inline


--xn9xNsWbHJd/50IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 30, 2014 at 06:54:07PM +0800, Nicolin Chen wrote:
> The sysclk is one the clock sources that could be selected to derive
> tx clock. But the route for sysclk is a bit different that it does
> not only contain txclk df divider but also have an extra sysclk df.

Applied, thanks.

--xn9xNsWbHJd/50IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+ZAAAoJELSic+t+oim90IMP/R/AXiwZaFIOPBc6VmC9VeYz
uJ9a5so6qp330a9sNXQVlnCJX4g6c8J+yiuD3PJPAlL6k1bS1ohsrhafpMPujHMM
5tQjLCro9S2G8qZlNsECxjaD3glFl0TLXDJwkXBDx0GVu7JA9A05DoQaxPapp+np
Fu3URM9FMUovHIpQm+9yxiXydSvTQuYuxPsohvknbKyd3Os+C33smsJ+JhfTCt/A
14n5QHm2WCYzH6wHf3waZYagkH/mAAI5M9J0fZND8wCSl3T8iHtwacZ7RUgoEj2J
/S4g1rHFk8soR3clVn3MdaNuHVlDXfhCVEPVXCGpQd3Gar3IFxZ1gGoOwNwsT3Gs
mZ8tkdhC4tWqm5f3aI5pBYc5XjhuxkhgSym6M2ZFeR4ItW1vniUiRNqzPRdRlvbT
edgt8xGOqx4hYdY8kzDN+b37vD9XXMsp6jafulbJbXPhLYj3wioKIQ0FBx7YnuqA
WiJZE67+1kS4IJcQLSG92MkH80ZrBX7s3kJUEdMJHgiaHyvUMp+t/IBducQIfMZQ
JauYY4HKqteuMo+3nk8GuRSOADP/3FjQsSrV1KblYCt6TdD2+TU3paMhXuC14WcG
6pe7pT6H3I2kE12bLxedlOSLjXXzznzibQRd3PKcncVyxpw6SsTxce9Ju0/0sRAv
Dyt29fTU5V6MolLLtkyE
=b3pb
-----END PGP SIGNATURE-----

--xn9xNsWbHJd/50IB--

--===============2228025783811423650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2228025783811423650==--
