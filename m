From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5-resend 2/7] ASoC: sirf: Add SiRF audio
 port driver is used by SiRF internal audio codec
Date: Wed, 12 Mar 2014 12:00:06 +0000
Message-ID: <20140312120006.GN28112@sirena.org.uk>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
 <1394008480-29135-3-git-send-email-rongjun.ying@csr.com>
 <20140306092007.GL13126@sirena.org.uk>
 <CAByv0RN0NBfaMA4TZgeB6f+MmTQ+CE6ztQ_DHXKZdTxQ7tkwQg@mail.gmail.com>
 <20140307014957.GR13126@sirena.org.uk>
 <CAByv0RNa6b5U_Y6=6h0zOEuRQ2RK4MNuTs64mPqo2wC6L=7XeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5045830925670815529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 693F5261696
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 13:00:26 +0100 (CET)
In-Reply-To: <CAByv0RNa6b5U_Y6=6h0zOEuRQ2RK4MNuTs64mPqo2wC6L=7XeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============5045830925670815529==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1IwM4cWWKwuinqX3"
Content-Disposition: inline


--1IwM4cWWKwuinqX3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 05:56:27PM +0800, RongJun Ying wrote:

> The I2S, internal audio codec and audio port share same register address space.
> Do you suggest that I write a MFD driver or write sirf-audio-core .c
> to share the regmap and register child audio devices (I2S, internal
> codec and port)?

You don't need to have a separate struct device for each ASoC function.

--1IwM4cWWKwuinqX3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIExDAAoJELSic+t+oim9RZ0P/AtWspZUiJqZfO/qElcO+jcF
7sRYTyU/OEgollQz+GdYh1Z5RZIWyWZYfZchpwD1ojFop2w9mvpdU2rmdatm7Wya
UZyqncaDnQIx/A52qv85Yptu/NlVhRcnIkSk1UEaogrDPaC3Ff7GRTaEZP8IEtCM
3MiOp3wrjS98DO+OS3M1Ay6q4XimM0iq2p0I5GA4STWlJyb/91CTBrtWTL9jiIR1
bU/OpLYGZjsH8fHhq8D3Hy2YJFI3O/2kVADpKxegKX3rNM7eVK3MtNatTWWibhsr
PxcGS+DJo6EdPhekENYAt3ryxdpcszio1u0S9pFmmh0bAq+u6Fx5m5ZNxr919MxC
GRESTX0GCESqjrWvdCH5zgOGtRKJWQNrO1ZFh56bh7yWDVWoTmjQKYAO1vtAvEXT
5L8mF6UL3EUA3r9DqlYd7knjQxOGzZ/omI0FFW0ZG6gn3nB6Feu7urtGlflwucDR
V6SBxBtThWJ9ewzwaht316InAAO6iCILgzTIp5IPNR99gaMzUdgc6u3uwU6RenIW
RE+eNY6SrWZxv+ewQCSJcaE6g9P3lzJnGvDyjsxm+VTGsiILaXU0dMoflFSElnkK
ASdJAUM1aZ+XCylltdGR2dAObTSnywftdHlDQJsZJimPjhPumbH0bZkhTj7CxDmE
+LTOl1YKPozXPtlPpb8W
=tLO8
-----END PGP SIGNATURE-----

--1IwM4cWWKwuinqX3--

--===============5045830925670815529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5045830925670815529==--
