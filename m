From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Add the HWEQ for the
 customized speaker output
Date: Wed, 21 Oct 2015 11:35:19 +0100
Message-ID: <20151021103519.GL32054@sirena.org.uk>
References: <1445410711-28828-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7465132619169827955=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C481260622
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 12:35:24 +0200 (CEST)
In-Reply-To: <1445410711-28828-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7465132619169827955==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVQB43uFympFEer4"
Content-Disposition: inline


--EVQB43uFympFEer4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 21, 2015 at 02:58:31PM +0800, Oder Chiou wrote:
> The patch adds the HWEQ function for the customized speaker output that is
> in order to the customer's requirement. The customer can enable the HWEQ in
> the platform data, and set the parameters of the HWEQ in the ALSA binary
> control byte-by-byte.

> +struct rt5645_eq_param_s {
> +	unsigned short reg;
> +	unsigned short val;
> +};

As I said in reply to your earlier version just now this seems like a
really strange way of configuring things - we'd need to understand why
this is a good format for doing the configuration.

--EVQB43uFympFEer4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJ2pmAAoJECTWi3JdVIfQPNIH/AwX3GbXBP4cWElBi6iPg/Jq
fA2kCrkRNnHWFu06otVk/Qqi3Y63F4G7QHg4SRA+a0+dczR2/bc/fqKelKjHP4w/
YOloVyNGRQ0C80Rsi3Mtwn8MqOEzx5L30J9STop2tMH1gaOFgPViY3MTbRA5mNI4
FqzV5JlKJtsCqVmSy9MH4K+otPmdq5ha00E84Q3EE+4DOSatPAU4oqkRNFvNTT7h
htpSZx3YH7aUsSr+qyGpJTtRoelSobtIRKx3zQugxGljQ5QwVhxyXZx+3Uv1Ry+K
I9MZB3xb3UneZbWmeJtmNYs3lLXpGd4Qd+LXBxIbaTQso1rzuCPmzRTFjlFo6KU=
=m0nf
-----END PGP SIGNATURE-----

--EVQB43uFympFEer4--

--===============7465132619169827955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7465132619169827955==--
