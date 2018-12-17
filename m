From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 17:39:30 +0000
Message-ID: <20181217173930.GF27909@sirena.org.uk>
References: <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <4b358258-d7ae-d82e-cd58-d4b9e3b6f148@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1239059672775917883=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 08A5C2678D5
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 18:39:31 +0100 (CET)
In-Reply-To: <4b358258-d7ae-d82e-cd58-d4b9e3b6f148@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Dimitris Papavasiliou <dpapavas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1239059672775917883==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 09:03:33AM -0600, Pierre-Louis Bossart wrote:

> I started prototyping a different approach where the codec driver passes =
the
> regmap information to the clock driver. What's missing in the patchset is
> the addition of a clock control in the machine driver, and logic added so
> that rate=A0 change can only be done in a hw_params if there was a comple=
te
> stop and reset on a DAPM_OFF event. compile-tested only for now.

> https://github.com/plbossart/sound/commits/hifiberry/clks

That looks a lot like the CODEC should be exporting a GPIO driver so the
machine driver doesn't actually need the regmap?  The only register
touched is _GPIO_CONTROL_1.

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwX31EACgkQJNaLcl1U
h9A+Ywf8C5PCWq4ipfVBo3/cpBrooKMsTRGbWeAW+Hsol2Zr41IcSQ/5V11O5Des
BgX3mpOGPfPDniIgIT/F5f6vAHJy1yiRcKvnnm6NptZrIfJlJuJLZVstA2glB4/N
bFpmp3iANg4j4AxZQNxcvFRUAHxMMwMWKxOvCOBmjyjbjrvS9ZkIMRqajcscTpv4
PIkNXPNlJUavrKFAe2dpx+ucOlElwxOk0m7f36+2C7a9EEu3bD8skhpAsymoUKNG
7CYjQgXJxQT2UspuQCXMmrPkN7sAU5Ii7ZVg2KUUNFFfVeaNQKYcRt1wLlCzELTQ
f6B6GXJ6gaQpwxbKzRN4xHTRe8e6GQ==
=HE9k
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--

--===============1239059672775917883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1239059672775917883==--
