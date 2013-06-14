From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: WM8962: Remove remaining direct
 register cache accesses
Date: Fri, 14 Jun 2013 10:18:53 +0100
Message-ID: <20130614091853.GD1403@sirena.org.uk>
References: <1371184490-2479-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0036230567354573894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 252EC261A6B
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 11:19:00 +0200 (CEST)
In-Reply-To: <1371184490-2479-1-git-send-email-b42378@freescale.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============0036230567354573894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MXXylufPoVaQ01lt"
Content-Disposition: inline


--MXXylufPoVaQ01lt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2013 at 12:34:50PM +0800, Nicolin Chen wrote:
> Also fix return values for headphone switch updates.

Applied, thanks.  I applied this as a bug fix so it needed some manual
fixup and merging - it was fairly simple but it'd be good to check it
all worked properly.

--MXXylufPoVaQ01lt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRut/6AAoJELSic+t+oim9HGUP/0ZZz4LWW8QrChUmcJamiqHg
pxf2319s+5dVEusg/kc7dh4kemSVhBfRXR4fEvUI3y/VoBmdhGy4TOUqrBWz0d7Z
DchQsY6RpQVZXGHSqkgh4W6pKMgPLMWY/c4Xhi1iSVWiw97I/90pkTWjBArcjsMs
06aoC6u3U1ZoeqyX3fkoCwT2BBqd5HZbQCXR4h4knrvI6/LDcUDLoacEPVzWCgL5
qgfVlNxZcb2xFc4O1Lo7RKy12ZbS1pyTznDbMuClP+aLpujsDgGgb2h8jOt5bgpK
BC4uN45Sk5CatGn47D8Wf6XftfX8SH+AlksEUFBdChDSHiibUOiN21g7GrN+3OXD
i2ImUTQpxLLoZ93JWgbHsnXNfCKB6eDoJg1jHIxNH2IIKpcPDmDMvXs5ClnluLzb
Z/G2NYIyYcVj5jnCzc2cF6xdNio3VADqvSwRN3BRuKq6nHLWqZfL0nDlwDFlT9CL
MmBE0RaQss6FY05WtrxoG7s2Wkxz8OCdVcIz49XjWm4AqGbafxUXHO1EfyYzOumU
L9K0UbNYbCIOBG7Z0SHUFpEKuM8yWLRrbNc1sU0YFFTL8lYsSrNtQiQnpxgoR02e
7Uw3Mr85E+SYX1JRiloU8jkB2wghTBJOLFEZHA/MnWAgcXxRQl69D7scT1q8bn0U
26QFTWGqqjl1sba75I6l
=Utf3
-----END PGP SIGNATURE-----

--MXXylufPoVaQ01lt--

--===============0036230567354573894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0036230567354573894==--
