From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/13] ASoC: AMD: Manage ACP 2.x SRAM banks power
Date: Fri, 18 Dec 2015 12:08:33 +0000
Message-ID: <20151218120833.GB5727@sirena.org.uk>
References: <1449272440-8735-1-git-send-email-alexander.deucher@amd.com>
 <1449272440-8735-13-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1274747567=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1449272440-8735-13-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1274747567==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="er3ccdgDRx8g9EQQ"
Content-Disposition: inline


--er3ccdgDRx8g9EQQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 04, 2015 at 06:40:40PM -0500, Alex Deucher wrote:

> +void acp_turnonoff_lower_sram_bank(void __iomem *acp_mmio, u16 bank,
> +					bool turnon)

Can we have a name like acp_set_lower_sram_bank_state() or something to
make the boolean a bit more obvious please?  You could probably also
combine this with the equivalent function for the upper bank and select
based on the value which registers to work with, that'd be much clearer
on the user side.

> +	/* If ACP_MEM_SHUT_DOWN_STS_LO is 0xFFFFFFFF, then
> +	 * shutdown sequence is complete.
> +	 */
> +	 while (acp_reg_read(acp_mmio,
> +				      mmACP_MEM_SHUT_DOWN_STS_LO)
> +				      != 0xFFFFFFFF)
> +		cpu_relax();

Strange intentation for the continuation lines (usually you'd align with
the '(' for the matching level) and this needs a timeout for safety.

--er3ccdgDRx8g9EQQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWc/dBAAoJECTWi3JdVIfQ8DcH/0q7hGyCBSO+Et2Q1ovDNt8K
TDotrIdeya4G9QGtplFkeA5ORGd9S7OgYK4sFBI5+HigDuhEZHdS0viyBu/YrOFu
FdKAgd//QkVLdOwn2hNZrNWRf0zNiguzPiGxdOIZYklUdlYaVX2YhgeygfD0+fuM
7K0jFwvuIESogkVLRwFMDSGabeGOrK4/PoRqU0di57/CpJ3/dmOUSNfTuadrQ+Yp
LuLLNTTQmOsOF75U+1bH7vdpFJEmiQxr9ePI6beo7oM8nDZ78Cl6+QMZHcuDhXSR
nNoVzSLx/iulUXntnsyEiJjSqDHVuWmzc+ze1RD3S5kApfhZl15h83KslgM4HsM=
=bQry
-----END PGP SIGNATURE-----

--er3ccdgDRx8g9EQQ--

--===============1274747567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1274747567==--
