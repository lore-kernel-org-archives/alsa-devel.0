From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/3][RFC] ASoC: Add Magician
	machine	support.
Date: Wed, 11 Mar 2009 22:25:03 +0000
Message-ID: <20090311222501.GA7536@sirena.org.uk>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-2-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C4E8424411
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 23:25:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236795420-12175-2-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 07:16:59PM +0100, Philipp Zabel wrote:

This is all good except you're missing updates for a few new APIs:

> +	/* NC codec pins */
> +	snd_soc_dapm_disable_pin(codec, "VOUTLHP");
> +	snd_soc_dapm_disable_pin(codec, "VOUTRHP");

snd_soc_dapm_nc_pin() (currently a synonym but hopefully in the future
it will gain support for things like masking out controls for that path
from the UI.

> +	/* Add magician specific controls */
> +	for (i = 0; i < ARRAY_SIZE(uda1380_magician_controls); i++) {
> +		err = snd_ctl_add(codec->card,
> +				  snd_soc_cnew(&uda1380_magician_controls[i],
> +						codec, NULL));
> +		if (err < 0)
> +			return err;
> +	}

snd_soc_add_controls()

> +	ret = gpio_request(EGPIO_MAGICIAN_CODEC_RESET, "CODEC_RESET");
> +	if (ret)
> +		goto err_request_reset;

Someone needs to write a bulk GPIO request API...  not an issue for
merging this patch, though.
