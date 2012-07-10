From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: tegra+alc5632: Swap MICBIAS1 and
 MIC1 dapm widgets
Date: Tue, 10 Jul 2012 14:51:52 +0100
Message-ID: <20120710135152.GF9409@opensource.wolfsonmicro.com>
References: <b561a188ff2521d81b282edd45ded4b2c7133468.1341668123.git.marvin24@gmx.de>
	<20120709164441.GJ3934@opensource.wolfsonmicro.com>
	<1341901029.151674687@f219.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6717986037882749109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A06832433E
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 15:51:53 +0200 (CEST)
In-Reply-To: <1341901029.151674687@f219.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrey Danin <danindrey@mail.ru>
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>, Marc Dietrich <marvin24@gmx.de>
List-Id: alsa-devel@alsa-project.org


--===============6717986037882749109==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2012 at 10:17:09AM +0400, Andrey Danin wrote:
> Mon, 9 Jul 2012 17:44:41 +0100 =D0=BE=D1=82 Mark Brown <broonie@opensourc=
e.wolfsonmicro.com>:
> > On Sat, Jul 07, 2012 at 03:36:29PM +0200, Marc Dietrich wrote:

Please fix your mailer to word wrap within paragraph.

> >  > MICBIAS1 is an internal widget. If MICBIAS1 is connected to the board
> >  > driver instead of the MIC1 ASoC core, it enables widgets even if the
> >  > capture stream isn't active.

> >  What exactly is MICBIAS1 then? It sounds horribly named...

> According to alc5632 documentation alc5632 has one physical pin named
> MICBIAS (MIC BIAS Voltage Output).  MICBIAS1 is declared as
> SND_SOC_DAPM_SUPPLY. It describes "MICBIAS1 Power" bit in power
> management register.  Should "MICBIAS1/2" be renamed to "MICBIAS1/2
> Power" ?

Sounds like it might be plausible, and whatever controls the external
MICBIAS pin probably ought to be renamed to MICBIAS.

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/DNxAAoJEBus8iNuMP3dSMoP/38K6NsHO4f3RVbvFdSevyqU
x9bN39I6qn7nk51ePhqoMeJfXiLBjLktHQunstAXweartDVZ3hy5iJNBa1XJg553
YmG0eU7/Gt0OdfYGnP7E8JqPeWzMsckx+y9ylEi+NseUuzncWnrgmGXHklO3FuQD
c8dPeImzW804BG6cls1msNzbNRhA6bGLJll9O7fKCc6Mze55NcYazmPFHwbsF8Rb
zskCxkbPmHaSnUid4ka7tsidCGZBun9o3ip0yx2tFohqhTQNUrAntuD4n8Ej4MKM
nS/t0CCRFYU2i5n+8m0T0DZwSB4voPhaFM5G4vPhtQ5OvdS+y6dAEqC7sOP0dgQC
nH8F/fsuSy5cdTu5b49pd9ay0thXRprgBPaUmiNdkbvFdCuuFYBqz7FkrJ7n+6AV
cavpJxcTQWIfAjudF4mxnP3zqYVUUNz1A0ZRRvu5G7dAKILEeYPBccMvYMsFsPeU
p/uVpb2aaHv8dDLintFKW3cvvarzp+x+Pt18HYpNoUXdXK2U2WiQ+JO19bLn/0FN
bRZESk+x5phjJdzFJy1IHgq1LP3NutatvSZh5wade3AwGh+0D5RPDdnbaOM+AoJz
5D1vhIpk4d+rO2NtIzi4gpb+xQ+uPn7Gthr9vaTosCIk0JwwJ2Le/EBsFOU0LTdf
LM0QuKwN5W1wymdiW4UI
=rVMO
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--

--===============6717986037882749109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6717986037882749109==--
