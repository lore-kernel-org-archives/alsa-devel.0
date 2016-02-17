From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rt298: clear IRQ at the
	beginning of rt298_irq
Date: Wed, 17 Feb 2016 13:20:11 +0000
Message-ID: <20160217132011.GQ7544@sirena.org.uk>
References: <1455613956-14287-1-git-send-email-bardliao@realtek.com>
 <1455613956-14287-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8552255521839929448=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E27B2668E1
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 14:20:22 +0100 (CET)
In-Reply-To: <1455613956-14287-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, ramesh.babu@intel.com, john.lin@realtek.com, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8552255521839929448==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wg9FEZT+WCTrEXgJ"
Content-Disposition: inline


--wg9FEZT+WCTrEXgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 05:12:35PM +0800, Bard Liao wrote:

> The IRQ pin will go from high to low when the irq bit is clear.
> To let the IRQ pin go low as early as possible, move the clear
> irq bit function to the beginning of irq handler.

Why is this a benefit?  We're going to mask the interrupt as long as the
interrupt handler is running anyway.

--wg9FEZT+WCTrEXgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxHOKAAoJECTWi3JdVIfQf7EH/0g3TWe0B9USh3iisA8+ua3H
MsokGKsSJCMjQjJ1FtCIx2jZ7AeqOT3rfbwEA2rIE/QDJlrCyZPYWRHLUkWfvLrD
72/aNvz5TkAg3BzY3OzeqDf7twzA29D61KprpV7a/zod+B6G5BENUVcLO+6O0kEj
nw7+P5rKu7V8vE9km5hRmxp8FQzH/vC04seJ65+MpT4rFmfdFKpUiD5uJnRaT50Q
FShATle9IqT3/YW0gBMRZjL39FmBy7Ck+5obcy/mfNUrlFnFnGdTmxHotAqjGlN7
O0K1jh2/TB2/9fzD88iFqPxaJCdtZR/hCcLo3qk89xpq2LouGsAezBhOYB8omqM=
=Dx7Z
-----END PGP SIGNATURE-----

--wg9FEZT+WCTrEXgJ--

--===============8552255521839929448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8552255521839929448==--
