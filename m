From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Fix missing free_irq
Date: Wed, 8 Jul 2015 12:14:37 +0100
Message-ID: <20150708111437.GQ11162@sirena.org.uk>
References: <1436343951-3482-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fuid1o0BiVNrPGA3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436343951-3482-1-git-send-email-koro.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, bardliao@realtek.com, oder_chiou@realtek.com
List-Id: alsa-devel@alsa-project.org


--fuid1o0BiVNrPGA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2015 at 04:25:50PM +0800, Koro Chen wrote:

> The driver does not free irq if snd_soc_register_codec fails.
> It does not return error when request irq failed, either.
> Fix this by using devm_request_threaded_irq(), and returns when error.

Unfortunately this isn't safe...

> -	if (i2c->irq)
> -		free_irq(i2c->irq, rt5645);
> -
>  	cancel_delayed_work_sync(&rt5645->jack_detect_work);

This work item is queued up by the interrupt handler so we need to
unregister the interrupt before we cancel any pending work otherwise
it's possible that the interrupt may fire after we cancelled the work.

--fuid1o0BiVNrPGA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnQYcAAoJECTWi3JdVIfQhB0H/icd/tZA906AXEXSTJ+nL3JB
8E62zwz6jzoRV5rp5rQ74RL4cDKDjEUT8JftlLErd4yztYyGWf0HihWutumhaDGK
lBZWxWOWvEVK2MWenAagYWTQCroPY/sTQTv0owry3oTjFSs1D9OZWToduhB/TIaD
jQfJLGwNh2dY0lvi76zXJzWtLVNotDHOU5QCv/UE4jjeKKv+Z9hPrZ9WCQVk6Sde
VFyFg/7nKJb2tqwhuNEs+f6QKS12fY6ZDTeyoewZwTe42MX8ak2prvxmgESDsSbG
ecNC/rtkP112YJwP6gQWkhfHQc9vxxsw5EsBGqxcjTmbwZeFM2x0gDEMo4fsvfs=
=i8DX
-----END PGP SIGNATURE-----

--fuid1o0BiVNrPGA3--
