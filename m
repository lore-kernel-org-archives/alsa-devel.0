From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/9] ASoC: mediatek: implement mediatek
 common structure
Date: Tue, 7 Jun 2016 16:54:27 +0100
Message-ID: <20160607155427.GB7510@sirena.org.uk>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
 <1464929784-5489-3-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1391190690288775674=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A8242614E3
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 17:54:42 +0200 (CEST)
In-Reply-To: <1464929784-5489-3-git-send-email-garlic.tseng@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, tiwai@suse.de, linux-kernel@vger.kernel.org, koro.chen@mediatek.com, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1391190690288775674==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qjo19A2vmS5T5MQB"
Content-Disposition: inline


--Qjo19A2vmS5T5MQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 03, 2016 at 12:56:17PM +0800, Garlic Tseng wrote:

> +	/*enable agent*/

Lots of comments with missing spaces in them, there's quite a few
examples of that in here.

> +EXPORT_SYMBOL(mtk_afe_fe_startup);

All the ASoC and regmap APIs are _GPL(), you really shouldn't export new
interfaces based on them without it - the point with the _GPL() is that
non-GPL code shouldn't be able to use the APIs.

> +EXPORT_SYMBOL(mtk_afe_fe_hw_params);

Do you need to export the individual ops rather than just the ops
structure?

> +int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
> +		       struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_pcm_runtime * const runtime = substream->runtime;
> +	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
> +	struct mtk_base_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
> +	struct mtk_base_afe_irq *irqs = &afe->irqs[memif->irq_usage];
> +	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
> +	unsigned int counter = runtime->period_size;
> +	int fs;
> +
> +	dev_info(afe->dev, "%s %s cmd=%d\n", __func__, memif->data->name, cmd);

That's way too noisy, dev_dbg() at most.

> +static DEFINE_MUTEX(irqs_lock);
> +int mtk_dynamic_irq_acquire(struct mtk_base_afe *afe)
> +{
> +	int i;
> +
> +	mutex_lock(&irqs_lock);
> +	for (i = 0; i < afe->irqs_size; ++i) {

Why is the lock global and not part of the AFE struct?

> +void mtk_simple_isr(struct mtk_base_afe *afe, struct mtk_base_afe_memif *memif)
> +{
> +	snd_pcm_period_elapsed(memif->substream);
> +}
> +EXPORT_SYMBOL(mtk_simple_isr);

Is this really worth it over just calling _period_elapsed() directly?

--Qjo19A2vmS5T5MQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVu4xAAoJECTWi3JdVIfQTzMH/AwRT1sI+hMvFHCxzw9snseZ
YsSvQQ95uFZzw4ZbcyV7iWPuVWDtPoo49l6ZyF1pQmyd7FB7C8j4JNqfWLVfQlXU
tk7CkMGv0wjAvyHvNLyaOtWmZkmfXnpIeXjmYXQQBFmqT5pwpFKL00BtdtQGnAO1
y6jJNSqNejJtCm7CfqK4mcqPxw79M9izn4u+LPBS3GfxRSUXbPUwmZKBRVuPSlRu
LhJTFnYuURgo5ZGSwcPazJaTrkdDkkQkzhNzjJfjXAvWg8eiRdFZNprnkS+MzjVc
VlFIMoTN4ckNuBXwzwRMxyRgI/lbr6mcjfPuBO93c+DuAjt6QNy4Br6TNP8K3sM=
=OIhr
-----END PGP SIGNATURE-----

--Qjo19A2vmS5T5MQB--

--===============1391190690288775674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1391190690288775674==--
