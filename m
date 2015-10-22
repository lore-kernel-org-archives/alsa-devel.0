From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] drm/amd: add ACP driver support
Date: Fri, 23 Oct 2015 00:15:01 +0900
Message-ID: <20151022151501.GT8232@sirena.org.uk>
References: <1444320760-21936-1-git-send-email-alexander.deucher@amd.com>
 <1444320760-21936-7-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0591458867=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1444320760-21936-7-git-send-email-alexander.deucher@amd.com>
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


--===============0591458867==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k8r0khnpBuGu0wUi"
Content-Disposition: inline


--k8r0khnpBuGu0wUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 08, 2015 at 12:12:39PM -0400, Alex Deucher wrote:

> +config DRM_AMD_ACP
> +       bool "Enable ACP IP support"
> +       default y
> +       depends on MFD_CORE
> +       help
> +	Choose this option to enable ACP IP support for AMD SOCs.

Why does this depend on rather than select MFD_CORE (as all other users
do)?  Since MFD_CORE has no help text and hence is not directly user
selectable the above means the user won't be able to enable this driver
unless they happen to enable something else which uses MFD which doesn't
seem ideal.

--k8r0khnpBuGu0wUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKP10AAoJECTWi3JdVIfQ0skH/03tWiXGHJQ9cuFGOBABAf5G
ql9Vx95IsRS7FdvaBRj0apzpOAuK40DRObGNTGo6XJVwrKNxb+TqnC/ODeNHZrdX
72afvwV+qBzGobP2jr8pEOfykK3eC+KG6xlgfDNyDOWOLcFHu8GailbfkzZWDgyu
eNyAsmW9Bs+zebRow9FQWsqU9UOxYeNlX3aIwa4jly1AFAOQSky2paCE+khSG2ND
vNYqx3HWsOYEeTdLvg8UMtgiQB7XJecIkdpwd38SwAgWOu9n3q7K+F011rfGZv2Q
nEqj1nMjLDRW8ImsyrPvBpnHsZn3EVJcbrkGPXtwrJ98xd5bmW70MMWKK8rrKJE=
=ceh8
-----END PGP SIGNATURE-----

--k8r0khnpBuGu0wUi--

--===============0591458867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0591458867==--
