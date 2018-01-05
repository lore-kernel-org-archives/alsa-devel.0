From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 07/14] regmap: Add SoundWire bus support
Date: Fri, 5 Jan 2018 17:04:21 +0000
Message-ID: <20180105170421.GE9076@sirena.org.uk>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
 <1513230585-13882-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0571545994529736738=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AF27267A53
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 18:04:39 +0100 (CET)
In-Reply-To: <1513230585-13882-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============0571545994529736738==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2017 at 11:19:38AM +0530, Vinod Koul wrote:

> +	/* SoundWire register address are contiguous */
> +	if (config->reg_stride != 0)
> +		return -ENOTSUPP;

That doesn't mean the chip hasn't decided not to use half the addresses
for some reason - this isn't something the bus should be enforcing.

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpPsBQACgkQJNaLcl1U
h9DymAf9H9BswmVGnWVbwhLsgeHnq2C6hRADzGVfZ3GvRVtP6lcB6xVp7CQHaFfI
m1EK1DTyd+Wl+kET0fSZbWCYsv1/LnoOcpk4AmhC8ySfBGRMjuNa8264Pmhdfuwx
HuEI9WqY/sBlFMBAAcTPbjhDYTrw6NevkRlKfihhVGNfaUnb3Yfd4/YRmcYQcmPM
2f2Rs5Azpxi2RAlQhSz8egvawuWaBF1FzBZTNphVQIB73wZAJby8ASMDtVrgLtwM
ZqpzPSXJR7lrDZ8m3GLVvzuZoZ0u1Oh9848tMHqxtFvYePkJA0a9M25OgfR3VC3m
n8PSmsV9a2ot7HsDGlD0AW7vW8XSdA==
=WfPd
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--

--===============0571545994529736738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0571545994529736738==--
