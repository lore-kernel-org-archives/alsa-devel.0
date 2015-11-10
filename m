From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: damp: Reset dapm wcache after
 freeing damp widgets
Date: Tue, 10 Nov 2015 18:53:08 +0000
Message-ID: <20151110185308.GK12392@sirena.org.uk>
References: <1447171962-15736-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4519893087748283794=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A9AC726053D
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 19:53:16 +0100 (CET)
In-Reply-To: <1447171962-15736-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lars@metafoo.de, balbi@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4519893087748283794==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F55Y67F01HNW3AgB"
Content-Disposition: inline


--F55Y67F01HNW3AgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2015 at 06:12:42PM +0200, Jyri Sarha wrote:
> If there is anything in damp->path_source_cache or
> damp->path_sink_cache, it can not be valid after the widgets have been
> freed. Without this patch a repeated remove and load of a machine
> driver may cause NULL pointer reference in dapm_wcache_lookup() when a
> freed widget, not belonging to any list, is haunting in the wcache.

Please try to check the spelling in your subject lines!

--F55Y67F01HNW3AgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWQj0TAAoJECTWi3JdVIfQ9cgH/i1fMd1t+b9AMmQeClvIFrtm
aJJgYSEz4Y68gSvEZB+Alyo3WSLelM8eYUaePxWNVaK9nrQYEFkTViI4fnlQLZVn
5jUkrkc2P0mUM4RBosdDVkG81fNqg5WtT1D8wWBD1axCflvsZs7wB6NeHwuruPCw
+Skl6wPbt8sjq/hhtvL/Gm77FCtEviPdkxymKgSIhQPaudQ0vIpygTMTQy7fVUxN
eHxLCX5Vj53TAv7XC/jeSxcGgRCVV6DaCILoSbc4LSJ7cV4vL4w/VHv8hFhp++G8
4C7QWni+6GFFU/C3OvukYM39u6AAfZmdwL1o9HAYPFxI1Ci6ZFF7k3Fg5M50IS0=
=eXqx
-----END PGP SIGNATURE-----

--F55Y67F01HNW3AgB--

--===============4519893087748283794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4519893087748283794==--
