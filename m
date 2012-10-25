From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about move atmel audio part to DT support
Date: Thu, 25 Oct 2012 17:40:08 +0100
Message-ID: <20121025164008.GQ18814@opensource.wolfsonmicro.com>
References: <5080F54F.4000600@atmel.com>
 <50810CC8.4050009@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6906792682529286330=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 865AA264F47
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2012 18:40:10 +0200 (CEST)
In-Reply-To: <50810CC8.4050009@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, "Lin, JM" <JM.Lin@atmel.com>, "Ferre,
 Nicolas" <Nicolas.FERRE@atmel.com>, linux-sound@vger.kernel.org, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6906792682529286330==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A7FgPGrDEcSmmdo/"
Content-Disposition: inline


--A7FgPGrDEcSmmdo/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2012 at 04:18:16PM +0800, Bo Shen wrote:

> Cc:
>    linux-arm-kernel mailing list
>    devicetree-discuss mailing list
>    alsa-devel mailing list
>    linux-sound mailing list

Better to resend for things like this rather than double quote.

>=20
> >   Atmel audio part has three platform device:
> >     -> atmel ssc: ssc library (different SOC has different number)
> >     -> atmel ssc dai: dai for audio
> >     -> atmel pcm: for pdc or dma transfer (now only support pdc, dma
> >support will add soon)

> >  In DT support kernel, I don't find any similar case. So, if I want to
> >keep ssc as library, and use dai to register pcm. Then the dts file will
> >like:

I'm not seeing anything at all unusual about the above situation - it'd
help if you could explain what you think is complex here?

--A7FgPGrDEcSmmdo/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiWtgAAoJELSic+t+oim9cQIP/2KKIZXj/UlFaxqHvQXX8ni7
8Rkt7/swlvMOFTv18AoUU8rrtZsgtizt9/A8+39qS4433viLCQNUPIHk89e1DqbI
ch0J2uX5JuNjbR9xjiTjkpAOfiUX8Ap7GiJFhxnhj9uXFuoXCjsw0ZdQ3T5KUW8N
7HnMFkQhFX7OrHhKHxGaYLhd8lzd54OIsTg0wRGtbRn78UJRq1MNdxNAXruSYHuo
BuUavv4CJls+4cuYaMX6TU9vWkRQjvBGBT2WMz6oWABP7XvCsG98Q1sxxTvG/5p+
r4F5mIxxT4ENEn6gpHRwP5GrP4U+a+3ZAXmgFaC60aLESJIjw+lqaiPeJ692CcSx
3JJ7Rgn90Ee90uPL8Et98t2q7FQziU3fwawjwjbMzOHAhB+QVnbKYB51YUDYgGGE
h6VsbsjkjPJ4veuyQZqo5Suk5Xne+VY66psyp7PqsqNRAZZFEXDe4yB5KyHV5gc1
2XX1GDMGZxl0jB4E//jtb1AGv8AaJxLNMei+3X412BssGEjmIQOW4yqSNw527JYY
p/bG/QmYiRCahWR/mJIo07NEHB+tyLHxxwMIGwBVzD4PrB4EqAOt/XRLdKoE9L0K
hYVKyrBQIKBenE9PB45OB7cU925VqWOFDlMtSUBtgReo38Vd/FYN1lqYRSuCS3Jg
NpPio8b9dPTN2jaeutrE
=8PsA
-----END PGP SIGNATURE-----

--A7FgPGrDEcSmmdo/--

--===============6906792682529286330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6906792682529286330==--
