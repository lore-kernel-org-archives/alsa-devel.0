From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: da7218: Add bindings
 documentation for DA7218 audio codec
Date: Sat, 21 Nov 2015 12:52:52 +0000
Message-ID: <20151121125252.GD26072@sirena.org.uk>
References: <cover.1447941395.git.Adam.Thomson.Opensource@diasemi.com>
 <add67c0ebac7a516d3cf515fea10a08b7cabadbc.1447941395.git.Adam.Thomson.Opensource@diasemi.com>
 <20151120155351.GA13917@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6360125759100229767=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B471260586
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 13:53:34 +0100 (CET)
In-Reply-To: <20151120155351.GA13917@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Kumar Gala <galak@codeaurora.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============6360125759100229767==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2015 at 09:53:51AM -0600, Rob Herring wrote:
> On Thu, Nov 19, 2015 at 01:59:34PM +0000, Adam Thomson wrote:

> > +- VDD-supply: VDD power supply for the device
> > +- VDDMIC-supply: VDDMIC power supply for the device
> > +- VDDIO-supply: VDDIO power supply for the device

> These should be lower case (that is documented in ePAPR BTW :)).

Does that actually make a meaningful difference to anything?  Things end
up this way because the strings we use to request the supplies end up in
the property names, we've also got a few other things like representing
microvolts as uV which just look very wrong when written all lowercase.
We could work around it for the supply names by force lowercasing the
name if we don't find the property with the passed name (to avoid
breaking existing users) though.

There's a bunch of stuff in ePAPR that we're ignoring, and a bunch of
other stuff that has no real value like the class naming stuff.

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUGkkAAoJECTWi3JdVIfQWl4H/RDSgXh229dQZWfcM1mECnYd
mNcVzURkDN0x8WUFoX6jfF/C2bufqzz7TimMAsH8zF7C1gHLALx/gtvieGPPYmN/
wTjt4qtcipvNB5+rKjiNvEzukSvXvl1Gx31zqTbGnAoDK/v481OvzRGjhQiuU6/T
njfmYFm/aNYV65/xPnXoiTm/zB9Q9szRPIPV70kvq7Mpsp/z30j/VOyMxxES3jxa
+bATZq0qZq4i/GS7a57o7GJ3Si0DLS89MWy+fdVH+8AhUpiq7tgatCG0cNRr64Wu
ErdEFS4XPDs9BJWEe9ua+i81yfor2NB1MBfIrmzn85XoOs/yyYdwsXzW81xhFr4=
=MShk
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--

--===============6360125759100229767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6360125759100229767==--
