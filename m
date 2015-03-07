From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][ASoC]Add DT bindings for generic ASoC AC97
	CODEC driver
Date: Sat, 7 Mar 2015 16:31:02 +0000
Message-ID: <20150307163102.GR28806@sirena.org.uk>
References: <54F9F81E.8080105@maciej.szmigiero.name>
 <20150307105201.GB28806@sirena.org.uk>
 <54FB041D.8010102@maciej.szmigiero.name>
 <20150307143434.GL28806@sirena.org.uk>
 <54FB1A38.3080609@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0339559834578047397=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E84F92605D0
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 17:31:18 +0100 (CET)
In-Reply-To: <54FB1A38.3080609@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Mark Rutland <mark.rutland@arm.com>, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============0339559834578047397==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FWibJpkbnkY6rrXF"
Content-Disposition: inline


--FWibJpkbnkY6rrXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 07, 2015 at 04:33:12PM +0100, Maciej S. Szmigiero wrote:
> W dniu 07.03.2015 15:34, Mark Brown pisze:

> > That's true, and it's something it's easy to get away with with board
> > files, but that doesn't mean it's something we should be doing for
> > device tree where we're not just finding an expedient way to load things
> > but rather defining an ABI.

> Do you recommend then putting AC'97 bus/mixer attach in
> simple-card/fsl-asoc-card or controller driver instead?

It's tricky.  For the vast majority of AC'97 systems we probably want to
just do things from the bus controller but there are some funky AC'97
embedded systems out there which need quirks to varying degrees, and in
some cases the ASoC AC'97 drivers do a much better job on things like
power.  For those we'd need to do something different to just doing a
standard AC'97 instantiation but what exactly we do in a DT world (quirk
on machine compatible?) isn't clear.

If the platform you're working on isn't one that commonly got fancy
AC'97 subsystems then it's possibly best to just do the common case and
only worry about what to do about the complex case if anyone has a need.

--FWibJpkbnkY6rrXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+yfFAAoJECTWi3JdVIfQHqIH/igfGA1LZVoxjrr0WMlHv6oM
ydT3h9HMoWiZO9QVDVPqeKSiIgaNGI1N+uz9PVFPfAXPmFJlBTErau3Q+zADOBqB
kf+GIik/dQ/FG8iF5BV6/JTRPy2kSEb2C6Nge3pl/pYI3BfNRiAgjtblNVQa3MXL
flbqLMN+KOu2J9VKthRJjLSrdHDhvKp/VvnsVus34qYIyc57xinLNQNF73e9GOjl
Sf0q5fUIRHsws5adpssN4BKLd4fHzdphmcnBKonGu/FOP2xj/hjpGceaKlTWzk5c
47E9ZIcps7oR7VHC3QGb5YuZfFfoCI3u/d6bsGF4FvW5HQxV6pBUAAubrSWxyDs=
=qCQf
-----END PGP SIGNATURE-----

--FWibJpkbnkY6rrXF--

--===============0339559834578047397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0339559834578047397==--
