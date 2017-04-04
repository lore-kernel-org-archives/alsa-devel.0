From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [RFC][PATCH] ASoC: soc-core: verify Sound Card
 normality
Date: Tue, 4 Apr 2017 13:42:52 +0100
Message-ID: <20170404124252.zyty3chncs72nhg5@sirena.org.uk>
References: <87vaqsajo0.wl%kuninori.morimoto.gx@renesas.com>
 <20170330215334.zwashvjerpfnkk3u@sirena.org.uk>
 <s5hefxdhop9.wl-tiwai@suse.de>
 <878tninh21.wl%kuninori.morimoto.gx@renesas.com>
 <s5hk272dmcv.wl-tiwai@suse.de>
 <87fuhpnbnu.wl%kuninori.morimoto.gx@renesas.com>
 <s5h60il28fd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ojjt72b7z3akkk3e"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h60il28fd.wl-tiwai@suse.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--ojjt72b7z3akkk3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2017 at 10:37:42AM +0200, Takashi Iwai wrote:

> Ah, I see that snd_soc_unregister_card() has the check of
> card->instantiated, so it should be fine to call multiple times.

Yeah, we'd run into that often enough that it's worth handling nicely.

--ojjt72b7z3akkk3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljjlMsACgkQJNaLcl1U
h9CWGQf/fqL4Q4YT/S0g7io1ahR0nxtm37ALhMi3WKP3WZ78+x/ucxK6RyG7UOHz
prgbqUeoehWZkmT1Aif9+U0ZPCwRnrGeFYVLQRY1bF8H9UFFjJMTz6KYtWa35AEW
iJPcmxyuqrQw70+KnYZ6C5xFOXcjCB39M7PO45K8/W/ihdYaHuYXj8hOcErmuEGw
ZTXru54C79usedy6yR+SoKCe/JEgFRNx0MKgQxddj7i39NV9CBHxwdiYAVmvY0sB
tMgpbr6oN2fnD8C09I9g/Ro71Q0EmyCjdT+zmeB8haJF38G25KxsvHR8vTjzkXJP
iYFU++WGJBFjkTci7JpGFZbbbK68pg==
=KlIR
-----END PGP SIGNATURE-----

--ojjt72b7z3akkk3e--
