From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/15] ASoC: adav80x: Update locking around use of DAPM
 pin API
Date: Tue, 18 Feb 2014 09:33:14 +0900
Message-ID: <20140218003314.GI2669@sirena.org.uk>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392655903-24537-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hABqaeELJqnDDeDE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392655903-24537-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--hABqaeELJqnDDeDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 04:51:31PM +0000, Charles Keepax wrote:

> +		mutex_lock(&codec->dapm.card->dapm_mutex);
> +

I think this needs a helper that just takes the CODEC as an argument and
does the lookup - a static inline in the header would be fine.  The big
long dereference is ugly for something people should be doing and will
be annoying if we want to refactor in the future.

--hABqaeELJqnDDeDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAqpHAAoJELSic+t+oim9f7cP/A/l5GJI56RIzLHhEjsshm9z
sM43q50IqJj8DW5l3qvLLH3L7op59Gc/otCUSs5uy7Wf6OY5vcq39WqYZSMyK1rf
Z5/WO7xMr9xu0q2PAmJ225dNMEy1Cf0VF97x6kg1AEn+nIQv+HtfoENvnAItVF88
axQmzinlS229NevS4owSsnk48Q2VlwQQiyDp3zfUpQAiKJ/2i2Ylag8pX/nvOsFa
VvN205dJwJ1ccXaBNRh8VKfjApR49r+EpkyyWhwGPTn/fZslXsVvLlQR0COs0EuK
zdo1XsjadyZx+WmnhsX79qBzsbktu9Ec26fghG1d7B7tXm/+0RhsOjPtuazIe9tL
qbaIGmS1okP0ik8Nuy/t4IsAAoSOdvAZYQA8FzQklKOUgqZkU7cQ4xuEwmUyM5i+
SIPWU8jrhw1SJTw82UNJ8vqyoGfaMiIXgAo9N9TfB9wLFLLzuGSyer0ycBavkFxw
CjCzRaVtzg9YUQ5Na6KlR4bLrKTHCX0EuLDrZosnXC8WRa9euBNs412RCjpklSMS
JHbH1SnJqwLnzjXguVGKAbbKejF3ckbeowIJEuu+3twVESkk1ImkpgId1G6FhzDY
UKi842h7MQIosdfkP1aoTYFag308uqI+PYjzCit9qMoys7KACuoFptSKeLTznFAF
VTooSOnW/03FFib6GnOk
=8eDt
-----END PGP SIGNATURE-----

--hABqaeELJqnDDeDE--
