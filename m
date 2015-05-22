From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: zx: Add ZTE zx296702 pcm
	support
Date: Fri, 22 May 2015 13:07:03 +0100
Message-ID: <20150522120703.GH21391@sirena.org.uk>
References: <1430915885-30656-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8329046617393638339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC54265B5B
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:08:16 +0200 (CEST)
In-Reply-To: <1430915885-30656-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, lgirdwood@gmail.com, zte-lt@lists.linaro.org
List-Id: alsa-devel@alsa-project.org


--===============8329046617393638339==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2015 at 08:38:03PM +0800, Jun Nie wrote:

> +static const struct snd_pcm_hardware snd_zx_hardware = {
> +	.info			= SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID |
> +				  SNDRV_PCM_INFO_INTERLEAVED |
> +				  SNDRV_PCM_INFO_PAUSE |
> +				  SNDRV_PCM_INFO_RESUME |
> +				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
> +	.period_bytes_min	= 32,
> +	.period_bytes_max	= 16 * 1024,
> +	.periods_min		= 2,
> +	.periods_max		= 32,
> +	.buffer_bytes_max       = 64 * 1024,
> +};

As I said last time I'm not sure why you are manually defining these -
the capabilities of the DMA controller should be being enumerated from
the DMA controller driver.  See dmaengine_pcm_set_runtime_hwparams().

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXxvnAAoJECTWi3JdVIfQmu4H/jmPnnfQiV5HyiMTcnYaZQrs
CyaE2ennx0uaxVvJSS1hCwoW8eyg/3Z22h1UHjdNEKRtz2Fmd7uaop0hmwUrOOpa
T5skHIYlycZaC38PM4yrYfUwhl+r7CkyXfRn9g9DgdauzKM0iLZk3q5WcjKN82xp
kEoQmhNwDfquEpfmCAr7SvY+wLQQFz4MQHKpH23/yurMsiuZe2IYpBv5uiHYs+FD
IZ+Uh4Kk+HLt5t3d2GSLGZAYVBvfZkahCTsK4daL5SZYyJbAuz3uGIS2TFRgDYS6
DQy0iA7X8U3RUVdj05+50+9HnnyeUflG8fNGdf40x9EAXyAUViX5Gd9+jiFKbuU=
=wf6b
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

--===============8329046617393638339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8329046617393638339==--
