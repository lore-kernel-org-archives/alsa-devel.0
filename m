From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: set initial runtime PM status
 to active for ACPI-enumerated ADSP
Date: Sat, 14 Feb 2015 13:49:56 +0900
Message-ID: <20150214044956.GG9110@finisterre.sirena.org.uk>
References: <4c86d19eb8db54ac57244ee77e873d5bc22c1b21.1423826462.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9163515982077103093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AA482604BB
 for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2015 05:50:54 +0100 (CET)
Received: from [211.36.158.81] (helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1YMUgt-0000g2-BH
 for alsa-devel@alsa-project.org; Sat, 14 Feb 2015 04:50:51 +0000
In-Reply-To: <4c86d19eb8db54ac57244ee77e873d5bc22c1b21.1423826462.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9163515982077103093==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2015 at 07:21:25PM +0800, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>=20
> The ADSP on Braswell/Baytrail is an ACPI device. This patch sets its init=
ial
> runtime PM status to active. Otherwise, its initial status is suspended a=
nd
> runtime_suspend ops will not be called after probe and thus cannot further
> trigger ACPI _PS3 (D3) method to put the device into low power D3cold sta=
te.

Applied, thanks.

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3tPzAAoJECTWi3JdVIfQ2UIH/0z1PwCqS9XsOBeeTtXhSbIs
mbB78ltA8l279o0deIhdxjCn6WUN6b4mO09HEup2mWRUpEVXlXEXMzQyJ3QKk8ui
+a7vYWse9ZEKmx+AyVunQdvZet1O3vLlX3n4HBaHF4fJ5ROwV1+P3J3W2X7ib5pN
Vm2RWcp/rHcibIbU20t+qXrimWL42a18bTzkF4rkklOq5gsxmOXzJGpzmnLrGade
ToejXa5Z6V1rdpFRzZHV9nRPsMOUV7kPrevfQ/Wj89V+bs0t/JUhwgnqkZuODJuZ
WfzH0UaS8ByqvmOz0TkXLRmSJDJ6gNWsGLmfFIi1yGNxdPJn80Ruq1GShFyJCEo=
=S25y
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--

--===============9163515982077103093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9163515982077103093==--
