From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/11] ASoC: amd: add ACP3x PCM platform driver
Date: Tue, 13 Nov 2018 11:41:22 -0800
Message-ID: <20181113194122.GL2089@sirena.org.uk>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1542000903-19020-5-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gmhhrsDozM2n+uz5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542000903-19020-5-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Alexander.Deucher@amd.com, Vishnuvardhanrao.Ravulapati@amd.com, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sanju R Mehta <sanju.mehta@amd.com>, open list <linux-kernel@vger.kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--gmhhrsDozM2n+uz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 11:04:55AM +0530, Vijendar Mukunda wrote:

> +static struct snd_pcm_ops acp3x_dma_ops = {
> +	.open = NULL,
> +	.close = NULL,
> +	.ioctl = NULL,
> +	.hw_params = NULL,
> +	.hw_free = NULL,
> +	.pointer = NULL,
> +	.mmap = NULL,
> +};
> +
> +struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
> +	.hw_params = NULL,
> +	.trigger   = NULL,
> +	.set_fmt = NULL,
> +};

Having these empty ops sets is really surprising - I see they do get
added later on, but there's no sign that this will happen here and
assigning NULL explicitly is generally bad.  It'd be better to just
leave these empty here so they don't look like a bug when doing review.

--gmhhrsDozM2n+uz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrKN4ACgkQJNaLcl1U
h9Dhnwf/TTWRh5Jg+uDQ7fBuAKdvKhqWhYGLO3MFidokeN7ewqDQC65WTGHr08yd
rhHtg5hHdU2ffxbyZECzXFM0GKNmSWGHjmRTPIUIu8qAGWivUuTd0D3372JMIZeq
jD5Qs6scAC1ei8o4ijrgN9CzMuPaGroL2LKk1Gk1gm9Z+GidiwWEhnVBhcCgXpSk
z6h4dmCgWjXUdZAxg+U0eS8dehWVASbEUggyzMJk77kr9HCYM0oYUWSILZ1Ab8cY
hFTsFWuEKMSSGGRvnMn2BwcyBiY2fyi+ilmTJSHkOKPu9QM3DOzWTEiMKa+AjMpz
W7C3KvHyiTo9RZgbrBPG60rAuGGDxQ==
=pVFt
-----END PGP SIGNATURE-----

--gmhhrsDozM2n+uz5--
