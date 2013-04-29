From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: compress: fix the states to check
	for allowing read
Date: Mon, 29 Apr 2013 12:07:14 +0100
Message-ID: <20130429110714.GF5019@opensource.wolfsonmicro.com>
References: <1367136322-24531-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1173160098922360298=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 52B8C2619F1
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 13:07:22 +0200 (CEST)
In-Reply-To: <1367136322-24531-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1173160098922360298==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf72EjeiW3qFOybB"
Content-Disposition: inline


--Hf72EjeiW3qFOybB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 28, 2013 at 01:35:22PM +0530, Vinod Koul wrote:
> for reading compressed data, we need to allow when we are paused, draining or
> stopped.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> +	/* read is allowed when stream is running, paused, draining and setup
> +	 * (yes setup is state which we transistion to after stop, so if user
> +	 * wants to read data after stop we allow that
> +	 */

but I think there's a ) missing in here!

--Hf72EjeiW3qFOybB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRflRbAAoJELSic+t+oim9MKwP/jBxLZJorblHWsoJ4Ogn+2q/
ouGy+l0M1NgSk5oGZmF8wiIo+xtoWYv0FfBvkoAf+bulNHP+x+x3kOIs62DV/OyF
tAElICOB19dFrgE1aHbgazytT0bS86H3AIDroxf3KEl9az4i2f9dfgZOsfpYmHIQ
UpJTWsvK34q4S0sdglGLPLIo5YCMTpCa5KqU6dGHLmGgEWGXLPOc6mGDi4WcDIiE
VifQ1DkvnRYKf5OdEsLGl1AjDmAJ6Xb7cUNYW3d33m+epm0sPXozxo/B6TcOLeOJ
bI81SZxUbSTD+C9e8SCC62N8Tru0Wr2++2DsSWf+kVebeN2wQ68kpUcHFmvMfanF
pitzgkN87sDkD+fCNc59kEvj7qx18Yw0y/cokvGQMjJ8snClGoaqmt7mc51R3NdT
NscHNBvlXnGkwgTtaACEZeu9ctR4WDDqN/8j50lz6yyGdkXVekJrTPcDnXen/DMH
0gH4ZJCxD2ChKUlnuVOU4b6rdwxRH60EVnbeG25lzz3ERvuxfnyCrHfxm6QXHNWD
O/XUUd4IHjJbqHO5LOJSBEhUQKOwq++k74WeBUbdwG4ZayvDahQrq59i1fbe9F/p
2iW+YPVmtnfalTlJETMW8VW2dIJrDMPv2l7N98g92whs0BTjegK6XOUUTrrMrVMD
pt/OHkBXJ9UuYn4/47qM
=U1iN
-----END PGP SIGNATURE-----

--Hf72EjeiW3qFOybB--

--===============1173160098922360298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1173160098922360298==--
