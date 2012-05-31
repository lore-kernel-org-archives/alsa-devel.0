From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: core: Add single controls with
 specified range of values
Date: Thu, 31 May 2012 13:07:39 +0100
Message-ID: <20120531120738.GC2666@opensource.wolfsonmicro.com>
References: <201205311027.q4VARIG5009001@sw-eng-lt-apt-vm1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1879774701180975742=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E0D772439F
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 14:07:40 +0200 (CEST)
In-Reply-To: <201205311027.q4VARIG5009001@sw-eng-lt-apt-vm1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson@diasemi.com>
Cc: alsa-devel@alsa-project.org, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============1879774701180975742==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 31, 2012 at 11:19:15AM +0100, Adam Thomson wrote:

> +#define SOC_SINGLE_RANGE_TLV(xname, xreg, xshift, xmin, xmax, tlv_array) \
> +{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
> +	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
> +		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\

This looks good but please also add an invert flag to this so we can
cope if the device does that, it's easier than having more macros to
choose from.

It'd be good to have a non-TLV version too, should just be a case of
adding a new macro (even if it's not normally used).

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPx14DAAoJEBus8iNuMP3dz7cP+wSIUEqy1lm4S8J0GH8b6cMW
WGU1nh/W6S56f4QsN9Dg5k9C/x+NDjAvlwYUg8eI5/7Ye99HDIeahReoW1pNnFqm
nXKG9pyfJh0OVzPsrfW6voiRzhWRnh2EytotJUpDHGShXpDmZmuwsw9ZZ6Wjy2wF
Js96q/MLvmhslb+42u5m4gQN+QJaArL1sVjHmZalA9aNdGNjpmEglPqQtlSVzX6X
vqJ3wPj0gpdcbL6P5AacniLQYj9fMDcVsnwKoLZX6uur5u4u6BpzsUuNW4IYC31p
NQKEsMV7SzMRfpA7c5sodgqey8L382aVzibt0u+SXncc1nUCCV2TqZPJMqSSS9cy
Thti7+xtkpPeR0PbwJEre3eHlH1hogdBzkbJKs/aYwlSrU/7HPdHGSGZZrudOwdB
p9z6a3HKvHi9mM6fUJKq32OuHoslMNDX1XPfzoSNijf0ofl2WgN72PDAw4bq3axW
t5NZ5O1ybPozCjmIQWAbc7b41Gzj+VQxyPdPiAGQsknVsne9k9DBC8lkQYJ0dCsZ
75BcGinr1d1v4buU/HJONGyGqi1Z+WjNsmAkQslZsyfdn2mJwW69Jm9QA7hic2k3
0MaRTOBGZLP/a51tFHXK8PWzx0oQQZ5fouKm+EvjA71o+rtiZHy99iy35x9rub1/
PLYQLuMj9um4RfAYyvrQ
=YYn8
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--

--===============1879774701180975742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1879774701180975742==--
