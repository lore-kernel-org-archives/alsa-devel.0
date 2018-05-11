From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/19] ASoC: Intel: bytcr_rt5640: Use
 device properties for setting up dmic
Date: Fri, 11 May 2018 11:25:15 +0900
Message-ID: <20180511022515.GH949@sirena.org.uk>
References: <20180508153604.23711-1-hdegoede@redhat.com>
 <20180508153604.23711-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2336450564628913279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F22F267790
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 04:25:33 +0200 (CEST)
In-Reply-To: <20180508153604.23711-11-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2336450564628913279==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2018 at 05:35:55PM +0200, Hans de Goede wrote:
> Use device-properties for setting up the dmic, based on the
> BYT_RT5640_MAP() value, instead of using the codec specific
> rt5640_dmic_enable() function for this.  This also removes the need
> for the BYT_RT5640_DMIC_EN quirk, which was always set together with
> a MAP() quirk of DMIC1_MAP or DMIC2_MAP.

This doesn't apply against current code, please check and resend.

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr0/wsACgkQJNaLcl1U
h9DNLQf/cMOAdclCsdBoc6dT0maRqegyEJVRXFFnzVpRkwIAPfhsng5MpCIi7/Ch
Rl9oFYdHYlUogFR+b8emnC8xfxrkEJhhoUwBmyrluuWRr1mCVJt2ggdgF1z1NT5k
BPJgfiTB6AsuXV4Q4C+XnXKUkRJkBX2cjI5QChvEdj4rXo3Zv15HIbso3SMoq9FA
kru3kyUO+vheXUGu8O/5fXhfWlj4kDCPrp/ED4uCf9vXWKlDP2me7qDj2RBq44qD
J4sUeM6ofOTPWleAP9G6AKcozIG62XvYFrifN58qYGe0HCi+1zXOuHg1OGxAeYdP
zYmTnXYi79P6/mncwuRsVp3yxLFO5A==
=agwx
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--

--===============2336450564628913279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2336450564628913279==--
