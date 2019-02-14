From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 Resend 09/13] ASoC: dmaengine: Remove
 unused SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Date: Thu, 14 Feb 2019 13:07:47 +0000
Message-ID: <20190214130747.GA11988@sirena.org.uk>
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
 <CGME20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4@epcas2p1.samsung.com>
 <20190214093747.2414-10-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2460610574824881953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 68C16267482
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 14:07:50 +0100 (CET)
In-Reply-To: <20190214093747.2414-10-s.nawrocki@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2460610574824881953==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 10:37:43AM +0100, Sylwester Nawrocki wrote:

>  	u32 maxburst;
>  	unsigned int slave_id;
>  	void *filter_data;
> -	const char *chan_name;
>  	unsigned int fifo_size;
>  	unsigned int flags;

This fails to build:

  CC      sound/core/pcm_dmaengine.o
sound/arm/pxa2xx-pcm-lib.c: In function =E2=80=98pxa2xx_pcm_open=E2=80=99:
sound/arm/pxa2xx-pcm-lib.c:128:22: error: =E2=80=98struct snd_dmaengine_dai=
_dma_data=E2=80=99 has no member named =E2=80=98chan_name=E2=80=99
            dma_params->chan_name));
                      ^~
sound/arm/pxa2xx-pcm-lib.c:129:1: warning: control reaches end of non-void =
function [-Wreturn-type]
 }
 ^

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxlaCIACgkQJNaLcl1U
h9C3Ogf+ItY9J2JK6iL/Ha7cdN8hos0W9+d+WQgO6+Ob+qZZuwzFrS2/jrbmscCy
yMNv2lC5pp9xYmySzGrcrgLyun6nen2Kqmfw9q4fQ7x6KmPmLj7SpncYhi3CcSSz
gGz0C8mqZRZ0LATJrw4Ya4QQ3WTyj1KjwYJdX/YCM7u/KJKR/LVnRVm5KRtVnLwB
L593wWH/0eqPGU3wEoy2JEeE242cvk6egv/tpqagk5cn0n7p0TnXSBqNbl/Rf6KK
EYaj3Bjn2cbVlcaIqoYzugtk5i9QpvMwGAw9ZJEUFqwgl7G380tJSCAgEetH1Pae
zsqOgtBdebYQiN+z4iVaY4sVwGPH5g==
=H9WS
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--===============2460610574824881953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2460610574824881953==--
