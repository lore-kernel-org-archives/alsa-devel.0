From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] Binding: atmel-wm8904: add option to
	choose clock
Date: Thu, 16 Jan 2014 11:03:03 +0000
Message-ID: <20140116110303.GN15567@sirena.org.uk>
References: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
 <1389669956-2304-4-git-send-email-voice.shen@atmel.com>
 <20140115115417.GA9558@ns203013.ovh.net> <52D736E0.90207@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6908932230470904412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A7D22608E8
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 12:03:23 +0100 (CET)
In-Reply-To: <52D736E0.90207@atmel.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6908932230470904412==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JjsO4Ft8DCMnlCnY"
Content-Disposition: inline


--JjsO4Ft8DCMnlCnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 09:33:20AM +0800, Bo Shen wrote:
> On 01/15/2014 07:54 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:

> >>  Optional properties:
> >>    - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
> >>+  - clk_from_rk_pin: according to hardware design, clk privide on rk pin
> >							  provide

> >	?? no example?

> If this patch set is acceptable. The sama5 audio will use it (I will
> send patch after this patch set). Do I still need to put the example
> in the binding document?

It doesn't seem terribly worthwhile to have the example include every
boolean property, it's not like people should find it hard to work out
how to use them.

--JjsO4Ft8DCMnlCnY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS17xkAAoJELSic+t+oim9NXsP/2iHK/usFtT3j305+tbZ8Fq6
XLveQXN/1X0buz1qcxK+2Ty6DMQZKA2DhH+uL9i4HmdOXmIBclFNpuQt1j2Gf4FX
CN6x9WT+IG6XkFYtOMRnYaiMOq0Y9zGp/kMh0jGfO9e1KpZk6h8tIrP6uAxTeRJU
ZNVPtCuoCQs2XMVV0heG8qWX8u+CzOgPz4wOapHHQJjDV9vMB3FLckn8Z5RnSklL
0t0e01O/utDwvBndZlpc6TGR/viS6HzgpMufqaZQMPmqBMSR0Z/V1AKaZKjmHBjK
OQ88+uJWCUII1bCxIEOXhB62Qap81pKKuUmKLyRs/8NMKiqqfkdRllmPotj8S5b3
zT9PGfygBfgAThUbw3kcePEcTXawtH5Jg6Q6gNUIyNnSItIRnied9P+7vdz7mgjm
3GkG1omF4IhYdPxfUAqQZtGeiud+RTmo7bPyglJMGE91jm9Y5W4TGHNLDtMGxaX+
pnJr2BMClYY5jgSZYAuDaipP0BslIVtDYXqYIN6tn76sOEczY7fSEOITj5E2433D
qGXk9bwwMkkD42BxJ8CgmwqjmczAd/FsAGe1SfYDcGBdUxaPldkF3laxbgPphh6O
FdxN9f24o1DPo+TlSbGKI5MLTb49V4j+7aV3cr0peFeKnn1e8LgeeOSIhk/dV6FN
QCx6WBMHuc3IxUEPrSKU
=ueZP
-----END PGP SIGNATURE-----

--JjsO4Ft8DCMnlCnY--

--===============6908932230470904412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6908932230470904412==--
