From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Mon, 8 Aug 2016 16:18:13 +0100
Message-ID: <20160808151813.GH10383@sirena.org.uk>
References: <1466152834-29615-1-git-send-email-KCHSU0@nuvoton.com>
 <20160627171546.GE17217@sirena.org.uk>
 <5775E4C7.5010303@nuvoton.com>
 <20160701100423.GM6247@sirena.org.uk> <5779D93B.80106@nuvoton.com>
 <20160805120804.GV10383@sirena.org.uk>
 <57A7EE1A.1040307@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2590651397596868771=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5C8F266E19
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 17:18:22 +0200 (CEST)
In-Reply-To: <57A7EE1A.1040307@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2590651397596868771==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wZwWzkkm73dI25u3"
Content-Disposition: inline


--wZwWzkkm73dI25u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2016 at 10:27:38AM +0800, John Hsu wrote:
> On 8/5/2016 8:08 PM, Mark Brown wrote:

> > What does the read actually look like on this device?

> The data read from codec by the IIC bus is as the following.
> 0 0 0 0 0 0 0 D8 ACK D7 D6 D5 D4 D3 D2 D1 D0
> The bottom 9 bits are the real register value. The nau8810_reg_read
> in driver is made by the formate.

So there's really only one read "register"?  If that's the case I'd
just open code the read and not bother with regmap, it's probably more
trouble than it's worth.  There are other 7x9 CODECs that do the same
thing.

--wZwWzkkm73dI25u3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqKK0AAoJECTWi3JdVIfQNjcH/R3PPsJdSTVO6J50AaE7B02t
tH9DHqNgNMCiyQ8F78CK9NipGqPXKE2wpruGmBcHlJRKNyVYWEIrxXzfpPVyQ06v
UXyZ+0pM5KtVzG56V6ESyYE3fTR66+XcycgrgzcvOLT2gBN/oB+r7ipdeeYSLIr5
loo1tNko92O0KCBopuEqTOpvW4M8t/5f2f5OGm15f75oMM1dU3qRPJu0eQeihFfn
lrHTkjD+T6ofnRYFRLnOHLo3Wg3k5YOMiZSdyecHbCDr8N0tI4tzX1RO9p14wwmK
TWOenQE+uQK3ojv1cQtjICaQDuP3Rf5e8J+i9AbUh3exoK7ljEobk55je7S9c+Q=
=+rtD
-----END PGP SIGNATURE-----

--wZwWzkkm73dI25u3--

--===============2590651397596868771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2590651397596868771==--
