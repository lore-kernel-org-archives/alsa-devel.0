From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
	diagnostic routine
Date: Tue, 30 Jul 2019 13:41:58 +0100
Message-ID: <20190730124158.GH54126@ediswmail.ad.cirrus.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 579EBF80214
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 14:42:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190730120937.16271-4-thomas.preston@codethink.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Marco Felsch <m.felsch@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Annaliese McDermond <nh6z@nh6z.net>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2019 at 01:09:37PM +0100, Thomas Preston wrote:
> Add a debugfs device node which initiates the turn-on diagnostic routine
> feature of the TDA7802 amplifier. The four status registers (one per
> channel) are returned.
> 
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> ---
> Changes since v1:
> - Rename speaker-test to (turn-on) diagnostics
> - Move turn-on diagnostic to debugfs as there is no standard ALSA
>   interface for this kind of routine.
> 
>  sound/soc/codecs/tda7802.c | 186 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 185 insertions(+), 1 deletion(-)
> 
> +static int tda7802_bulk_update(struct regmap *map, struct reg_update *update,
> +		size_t update_count)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < update_count; i++) {
> +		err = regmap_update_bits(map, update[i].reg, update[i].mask,
> +				update[i].val);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return i;
> +}

This could probably be removed using regmap_multi_reg_write.

> +static int tda7802_probe(struct snd_soc_component *component)
> +{
> +	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
> +	struct device *dev = &tda7802->i2c->dev;
> +	int err;
> +
> +	tda7802->debugfs = debugfs_create_dir(dev_name(dev), NULL);
> +	if (IS_ERR_OR_NULL(tda7802->debugfs)) {
> +		dev_info(dev,
> +			"Failed to create debugfs node, err %ld\n",
> +			PTR_ERR(tda7802->debugfs));
> +		return 0;
> +	}
> +
> +	mutex_init(&tda7802->diagnostic_mutex);
> +	err = debugfs_create_file("diagnostic", 0444, tda7802->debugfs, tda7802,
> +			&tda7802_diagnostic_fops);
> +	if (err < 0) {
> +		dev_err(dev,
> +			"debugfs: Failed to create diagnostic node, err %d\n",
> +			err);
> +		goto cleanup_diagnostic;
> +	}

You shouldn't be failing the driver probe if debugfs fails, it
should be purely optional.

Thanks,
Charles
