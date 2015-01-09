From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Split hsw_pcm_data for
	playback and capture
Date: Fri, 9 Jan 2015 17:17:01 +0000
Message-ID: <20150109171701.GJ2634@sirena.org.uk>
References: <1420785396-15067-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1621614685662219047=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 58FB5260714
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 18:17:08 +0100 (CET)
In-Reply-To: <1420785396-15067-1-git-send-email-yang.jie@intel.com>
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


--===============1621614685662219047==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1G9XMrEf5BQ3xH49"
Content-Disposition: inline


--1G9XMrEf5BQ3xH49
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2015 at 02:36:36PM +0800, Jie Yang wrote:
> There may be 2 pcm streams for a same DAI at most, and these 2
> streams should have different hsw_pcm_data, e.g. they have
> different persistent data, so here we need split hsw_pcm_data
> for playback and capture, to make sure they won't be mixed
> and keep cleaned.

Applied, thanks.

--1G9XMrEf5BQ3xH49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsA0MAAoJECTWi3JdVIfQkDAH/01eYk1dbSiAY0FMP9/yVnFR
zl55sW/HcfXBN4kdCfWO8b36dy/M8K/jGWPh8M2O5i1dKUOsJJ7V9OOQOEZl8alp
Dkcvsj08+bzkPKpV3rEdVqg6B3HJpKAzDdJ0z23EiF6sT1Dr/nAgyiCgGIszdvF8
ohdCp9HrT/FY3cc4td4ZlRwnuQYebWikd3LHrENP/X7IP8DbsdzwiEU/RPxOWK+x
PkAPYAwgRKu9EyWk6XWo817FdMh01T8AE4y1j56tjaTDyvnkdSqOFv6qOB1mqIhr
yr8+eLhQyMN9SYMOzIANbRptbAjJRPXH8lbkB5rXdswgI0ne10+gFRgDig5rG2s=
=7w7r
-----END PGP SIGNATURE-----

--1G9XMrEf5BQ3xH49--

--===============1621614685662219047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1621614685662219047==--
