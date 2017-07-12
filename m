From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: Support the DSP recording
 continuously after the hotwording triggered
Date: Wed, 12 Jul 2017 11:54:34 +0100
Message-ID: <20170712105434.m3vpt6patlz25szd@sirena.org.uk>
References: <1499339685-3112-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1628317191824927213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59FBF266EF1
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 12:54:43 +0200 (CEST)
In-Reply-To: <1499339685-3112-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1628317191824927213==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cxj5zn37kxuwzkd3"
Content-Disposition: inline


--cxj5zn37kxuwzkd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2017 at 07:14:45PM +0800, Oder Chiou wrote:

> +		remain_data = (cur_wp >= rt5514_dsp->buf_rp) ?
> +			(cur_wp - rt5514_dsp->buf_rp) :
> +			((rt5514_dsp->buf_limit - rt5514_dsp->buf_rp) +
> +			(cur_wp - rt5514_dsp->buf_base));

Please write this using a normal if statement, it'd be much easier to
read.

> +static irqreturn_t rt5514_spi_irq(int irq, void *data)
> +{
> +	struct rt5514_dsp *rt5514_dsp = data;
> +
> +	schedule_work(&rt5514_dsp->start_work);
> +
> +	return IRQ_HANDLED;
> +}

Why not just use a threaded interrupt handler for the start_work?
That'd get you into process context.

Otherwise this looks basically fine.

--cxj5zn37kxuwzkd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlll/+kACgkQJNaLcl1U
h9CMlAf/dgB96CD9wUPq5hjkmnBAC7Gx/hm9coay6+VQGOn3yjSUPtckHip6oa5x
/AysBWY/Cocy6ASjvX/8FKsKxsN9l765RJU+DBpLA0W85C+L+0BkFgQ+g9I1vcAl
7MF4IWQBG56tIZ4GVd8H20w4ncvz2I8k5wUWk1Rpe5EwmOM1iuc7RDaOVUEEeNJn
o/9rg7ijGIOoKLHz584lpzySEZqd8RNlo+2dDeI9jBgaxnqYOUNNBdkpbS8Xz63F
Na7q7Z6f3PauxiHiPtAm//1aQOa4B8Kf56QnJSUv8M1Yif8ZnrFcPXNZiJqerlv3
47Vh5f94EK5x9w7Y3xQhlQMJTXav6Q==
=4GUQ
-----END PGP SIGNATURE-----

--cxj5zn37kxuwzkd3--

--===============1628317191824927213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1628317191824927213==--
