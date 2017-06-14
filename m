From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm: adv7511_audio: Add .get_dai_id callback to map port
 number to dai id
Date: Wed, 14 Jun 2017 01:05:43 +0100
Message-ID: <20170614000543.l636aslxdt5xd32f@sirena.org.uk>
References: <1497391189-9301-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imqmthsa6oa6gswh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497391189-9301-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Archit Taneja <architt@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>, Lars-Peter Clausen <lars@metafoo.de>, Linux-ALSA <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--imqmthsa6oa6gswh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2017 at 02:59:49PM -0700, John Stultz wrote:
> ALSA SoC needs to know connected DAI ID for probing. Using
> the new audio-card-graph approach, ports/endpoints are used
> to describe how the links are connected. Unfortunately, since

Unless someone objects in the next week or so I intend to apply this.

--imqmthsa6oa6gswh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllAfdYACgkQJNaLcl1U
h9CFgwf/agj2rFHluPNpLD2/JOvNmUsimyBME8fsnspwrIQabJ9IURM2KH42fyxU
vrCvsIKt8Et1Mc39Ns9hWG9DC3ijPvcDCk7JAu4ncCu1Oxlh0U+qljY7XdIt+ORd
KRZcS7UPjHpdKSKGCwRQGTA4vTlh+haThLBQIrOuuqP0Ktba3cVlCMNSimH+4ljh
EaAVsk3SUZXDVf9j23zOLvOHANZdvozfBgmb5HF6apUFQQKVilI15PE1jBzAxUHl
Sr6N+W3tAaAP6YWp2e9tJqqIsVOfsGRoCIPdrl9VwPW2PXwwP/Mcv66ioT5wksun
ccuDS3e/Q01iEvENthLWCrfbLPPZ8g==
=dEWV
-----END PGP SIGNATURE-----

--imqmthsa6oa6gswh--
