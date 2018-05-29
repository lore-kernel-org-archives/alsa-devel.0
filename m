From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: add support for
 clock divider setup
Date: Tue, 29 May 2018 12:35:09 +0100
Message-ID: <20180529113509.GE23509@sirena.org.uk>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-4-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5657300869022295805=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BD7526766E
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 13:35:11 +0200 (CEST)
In-Reply-To: <20180528193503.18905-4-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============5657300869022295805==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 28, 2018 at 09:35:03PM +0200, Daniel Mack wrote:
> Add support to call into snd_soc_dai_set_clkdiv() for both CPU and codec
> DAIs from simple-card's hw_params().

> This allows platforms to set hardware-specific values without providing an
> own machine driver.

Why do we have anything that actually needs this?  The devices with a
set_clkdiv() operation are pretty legacy at this point and most of them
should just be figuring out the dividers for themselves anyway.

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsNOu0ACgkQJNaLcl1U
h9CVCgf+NQElOfAf8cdIW/qUG99D+6vxo8t8oRpBRFJxQ3YjgR9aAZyPGdoLM1+E
ORRFb5+kZ7AEauK8fddqgfM8tgyI0VWvXfk8B5syzipuVjOKAaL8RZM4qS/8ty0F
5mvfxUiOg85Lxn18agn65bHH9blPxg2TYemoRkmgArTVgvvkxm4rNRn65Iztdh/n
hdiuxVSYpEd6FRYqOqLJoOLD5sbwSwlAJdBE1XkIvr8J5ngNfwMq5yZFTlxHWRCs
Ieu5D3zVDPPIVHx6nG1S8c8sOMnqf+qO1hOki7QYubPz06ZenpaWqSzmOk/Wz04Y
XFORsFlp6vpa2HQDXUCuhXWFQvWCLw==
=TcME
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--

--===============5657300869022295805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5657300869022295805==--
