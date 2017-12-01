From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 16/19] ASoC: tlv320aic31xx: Add short
 circuit detection support
Date: Fri, 1 Dec 2017 15:57:25 +0000
Message-ID: <20171201155725.lrl35nig53fnwkac@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-17-afd@ti.com>
 <20171201133930.xzfjjj6wzkbtk6c4@sirena.org.uk>
 <4d956cbc-829c-0d81-2980-aa2a79f36660@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0605129875888982721=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 59D61267CE0
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 16:57:29 +0100 (CET)
In-Reply-To: <4d956cbc-829c-0d81-2980-aa2a79f36660@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============0605129875888982721==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l6zkak2yzm4pzuza"
Content-Disposition: inline


--l6zkak2yzm4pzuza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2017 at 09:32:12AM -0600, Andrew F. Davis wrote:
> On 12/01/2017 07:39 AM, Mark Brown wrote:

> > Is the interrupt only available on GPIO1?

> Some devices can route this to GPIO2 IIRC.

> I'm not sure how that would be supported, I think we would need to add
> interrupt names to DT so users could specify which gpio they wired their
> IRQ lines to.

> interrupt = <&host 23>;
> interrupt-name = "gpio2";

> or similar?

You could also use pinctrl an require the user to mux the interrupt in
whatever fashion makes sense for their device.

--l6zkak2yzm4pzuza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohe+QACgkQJNaLcl1U
h9BrhQf7BrQpPTJXtZyXaj4jn5OF4IgiJPthG36nOe/oJqpDS2c+wBMPcl1ZUk/C
Zsi5ssXyyTAPhAUkkFvHLkNiywQ4QU01rkvFqKYHH2SgREwd/a0T5MveyJkzn2lu
8KnOd60bW8B3Q50hkwzbpzVhHQat1NZxEDiark5GSppQZoreXiPLRVgSzP9NtiPn
cJ7EQ/GmODMHcNCFoZZU2nlcvMRJ1oHZqAkySwF63hXWUN9up/jCW99t/5AySOlB
jiVB2zbNjkk2VSEhD5Z/G++aHii7xeQF1NraMHgIv6S+aWwUwanWQ0C0XsW4PbWC
FFRO94L5JOa7XDwPOShAVXCTVUiqWw==
=EPU7
-----END PGP SIGNATURE-----

--l6zkak2yzm4pzuza--

--===============0605129875888982721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0605129875888982721==--
