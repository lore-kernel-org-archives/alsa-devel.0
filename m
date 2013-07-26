From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8994: Add clock bindings to the
	device tree
Date: Fri, 26 Jul 2013 16:55:30 +0100
Message-ID: <20130726155530.GP9858@sirena.org.uk>
References: <1374762668-5037-1-git-send-email-broonie@kernel.org>
 <51F298C0.1090801@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4960514929499596339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 20AB6265795
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 17:55:38 +0200 (CEST)
In-Reply-To: <51F298C0.1090801@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, patches@opensource.wolfsonmicro.com, Rob Herring <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org


--===============4960514929499596339==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PL/1/I+J7REATLnn"
Content-Disposition: inline


--PL/1/I+J7REATLnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2013 at 09:41:52AM -0600, Stephen Warren wrote:
> On 07/25/2013 08:31 AM, Mark Brown wrote:

> > Due to the variable availability of the clock API there is no code in the
> > driver to use these at present, for the time being the machine drivers
> > will need to handle requesting clocks.

> Presumably before considering any/most CODEC bindings complete, we need
> to make a similar change?

Yeah, ideally.  I was going to go through the ones I know about at some
point.  On the other hand it's not really a big deal given how far off
we are being able to rely on the clock API and we still need to work out
what to do with hooking the audio buses in too.

--PL/1/I+J7REATLnn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8pvvAAoJELSic+t+oim9zG4QAJI6UyvaBNbcnfpk/hv1Ot4w
KOkO3QWYcAWKvDxOGLzfZys6MYRze//ElbpL+728u/mjgiiuqlIhQ3xM3y5dnOY9
rQxnwQdYC/mIShe6G46a6ROGTdTQ3O8SQQhE8fM8i8D5fLAk397S3i+ijGXv0crw
dGMEBvewE+HDqbTCNHl8WUn2uwQmTgNr4t4BlJVYOajjaeYAys/CkxWJG+kwhnrR
myOo/ijhkctDYtPauifL/yP8SjMdlAGxgMyAth/27E2xQgTwFd7prZ2HPkhAN7LI
TFODnLRy0BEuiiDmBx/RKOL1Ru1XrrhCNd2Kop6CQviL8VrcqtTdraceP0Cu+PCU
yMqVEUbwKBph24wKoe5YCuEJ2jxXn9e6N0bnlUug3xrOljfiV9E8ZwP/D8Y17l/a
d1sxpGaAKt4docqE/c39HXty7wDwsQu7VV5VrlawPRf71OgED71Hmjn3832cOqCC
Vst1+fH57kMsB778Z8Iw/xRX5AbAeFa6kKccEgGXBdM2xmyDm8bSiDBDRPZaElET
ulMzl2DK8D1MXYBMMs/C0qdSJ/dB/PjZNzXOHQEI761iI18swTl6pok2gOdlv6YP
ULPP6RdOHX3HqAMlgNn3cJ0Mx5Ewqtbf+vRqlETHme8FagMBxdsNZja9Zcp/JDcZ
L3zfWDuuvnPTe8Q0IQIq
=G5On
-----END PGP SIGNATURE-----

--PL/1/I+J7REATLnn--

--===============4960514929499596339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4960514929499596339==--
