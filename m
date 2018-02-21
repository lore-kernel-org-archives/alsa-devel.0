From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/11] ASoC: rt5651: Remove
 is_sys_clk_from_pll, it has ordering issues
Date: Wed, 21 Feb 2018 11:18:21 +0000
Message-ID: <20180221111821.GA8334@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8036425363764790071=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 977A0267549
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 12:18:27 +0100 (CET)
In-Reply-To: <20180220221511.22861-2-hdegoede@redhat.com>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============8036425363764790071==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2018 at 11:15:02PM +0100, Hans de Goede wrote:

> TL;DR: The PLL1-supply must always be powered up when PLL1 is the sysclk
> source and we can simply set the RT5651_PWR_PLL bit when selecting PLL1.

Only if jack detection is enabled, if jack detection is not in use for
some reason then the PLL isn't required and should be powered off - this
is normally handled by having the jack detection code force enable
things.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNVXkACgkQJNaLcl1U
h9BtXAgAgnc3nstEB6lTX6XP6ohOsGGQ2nYJuRMWUNF5HzhSoKaHs/4Nkr20rtZo
1roZ7yf/YHrbzCxL63MWmKUa5Sdfk3TnriNGAwaN1wB79oI+3XUz/v5VnYTiPk8u
xKfgV973ev1SPzpYCbgdNHT4iVmSQMQwJ+juPzihnl7ievSXYeEeHCstX/iMnmxA
rYOTPRnS9Tx7wN5pTkzX4gCTwBWmfPtPRTccrvJeIp7FgdQ3nEXUi7+Yg+VBtsmw
aDZ0K3udc0F48kFFB72IV9w4ElWVnySPzbjSixIEd5UCdLkCRM1GL7uNjSdnn7M9
HPF4Gqif2AMi8DMXLxzBUomKnfNdeg==
=9HRo
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============8036425363764790071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8036425363764790071==--
