From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 17:11:49 +0000
Message-ID: <20120307171149.GS3107@opensource.wolfsonmicro.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
	<CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
	<20120307142447.GM3107@opensource.wolfsonmicro.com>
	<CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
	<20120307153944.GO3107@opensource.wolfsonmicro.com>
	<CAJDSjBhUvJTM5XXxpU3W0nc2PAWGpZ0ScSCWgr=WhNTGM075fA@mail.gmail.com>
	<20120307163456.GQ3107@opensource.wolfsonmicro.com>
	<CAJDSjBgM1pFmwS3NZHtv4EdLWN3aof4JJtjmgS+4fUx+jca2uQ@mail.gmail.com>
	<CAJDSjBjMJMBvJrjhwEqU3S+hKMD_E1MU3taJOPoxS+3QSo-r7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7098843446643969163=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81E5C1040FA
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 18:11:51 +0100 (CET)
In-Reply-To: <CAJDSjBjMJMBvJrjhwEqU3S+hKMD_E1MU3taJOPoxS+3QSo-r7g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin PAI <nitinmpai@gmail.com>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7098843446643969163==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80Ds8Z/hZmemMosa"
Content-Disposition: inline


--80Ds8Z/hZmemMosa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 10:34:21PM +0530, Nitin PAI wrote:

> >>Usually the driver does need to enforce some kind of
> >>limits (on input format and sample rate normally) even for a simple
> >>device with no software control otherwise the device can get driven
> >>out of spec.

> Agreed. This is more of a system integration problem then the machine
> driver problem.
> Most of these enforcements are already present in the machine driver.

Perhaps your BSP is doing things differently to mainline here; it's
vanishingly rare in mainline for machine drivers to enforce any limits
themselves.  Usually the CODEC and SoC drivers do this.

--80Ds8Z/hZmemMosa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV5aOAAoJEBus8iNuMP3dftEQAI/QkZbeWNIoBzCTW0cLtkmf
hFqsCVSEfhx0a62zoaZYU5bWskf4w2jY2n1OP/yNR98ozxLIlRfxGjFAqQTkivbn
9NOQwlfa+YgMxpPlcus4v//O63ldrOYg0qEJ647oWEu8qPhcgaMWEveINmhM0JmS
qROZoKp+UdcfXak8uHv/MW+VXtSLnYDXadb+2WSXokkv6roXwN23q92JMeqEaX4w
ar1x0BnmpWZgwgCCWsOdvP8EIcot+gE78Q6XyY/8WOnf9Ll7E92HmhQLK35Yg7Sy
XT3RwOfQHWsMvzRukO3g7iIonpYehSClKedbv5CtszbziHNuFwau8ROcO56gz6Ot
B7pZZbpezOA4aEHo6zr4H7C2W0b4eUg2Va5V5lL7Mb8qK8PsybsjNcp66wmYZRF5
qMnPP+l+9HAP5dxevOO5jQKyta1LHzimEcLLxqXqooIzzTnprPFG3gY5dMA0LQ4o
e3sNIEbSgq/PoCmCsxNz4kOvWyeT8TZe8ul/HSSvLN7s2KoZtKw1nMsgtMcqXq+t
TKxVJ6Q7edMtJQm6O9EnOq0tLwAkoxBHGZN76xoM4WOoMcwE6qID0rk+tTnjTDPt
7qMR/+4RlOQUHWzv1/yWgh4D/SD0LDM8wDtyVp48/rD7Vcc2R7OsdCClFaMjzv9u
5+GfOy0WKClAxU6sKQZT
=/AoN
-----END PGP SIGNATURE-----

--80Ds8Z/hZmemMosa--

--===============7098843446643969163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7098843446643969163==--
