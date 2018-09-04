From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off
	setting
Date: Tue, 4 Sep 2018 15:41:59 +0100
Message-ID: <20180904144159.GC12993@sirena.org.uk>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
 <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3479877297299373407=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CAA3C2678DD
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 16:42:01 +0200 (CEST)
In-Reply-To: <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============3479877297299373407==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 08:55:06AM -0500, Andrew F. Davis wrote:
> On 09/03/2018 06:26 AM, Mark Brown wrote:

> > If we really want to pay attention to something setting this up we'd
> > need to completely remove the widget - what the code is doing at the
> > minute is setting the voltage that the bias will go to when enabled,
> > there's still a widget for turning it on and off.  There's some chance
> > that this will break existing boards.

> Turning on bias is controlled separately, automatically in user-space in
> many cases, not based on the board. The DT needs to have a way to state
> that 0v is the needed bias on this board, without this you can not set
> 0v bias and 2v is chosen by default (which is IMHO should be 0v but that
> would change existing behavior so I won't touch that).

Surely turning on MICBIAS at 0V is equivalent to leaving the bias off?

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOmbcACgkQJNaLcl1U
h9BlLQf9Hx/u2QF/ksuOmtcn83rVcnqhADne0vQ++eSoUjlL7mIhKFrPJUuZd6Mp
J1GvAuP1MThcX+k+fZ9JzYNdzoq3fkciPR+IiLqIBwhHQN4kBqHrFtn+4DyBwijt
Z3HTRwCptBOXoP8Sok8IJfbQPSv4eA7LwjNR+KPyu9nNCcyl4xfg/3xC9+sIdWTi
FbVOlWYANa2cInTE7TVX7X6gAC019dGxPt2n42ssnWFmGH9iViWweWsaLzgdD/eS
MPCfLi5wIZjf5zdKq4IM0mYdwlnaOx6SjUz2iXOY/u6P6E53BUCdE4GEPZnWQK33
BZlSGaInys8bVfeFeeqBUIYeQfQ74A==
=/xOH
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--

--===============3479877297299373407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3479877297299373407==--
