From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Audio support for Simtec Hermes
Date: Fri, 7 Aug 2009 11:19:33 +0100
Message-ID: <20090807101932.GC639@sirena.org.uk>
References: <20090806230200.627626438@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 557F61038E1
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 12:19:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090806230200.627626438@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 07, 2009 at 12:02:00AM +0100, Ben Dooks wrote:

> +
> +	/* Speaker is connected to LINEOUT{LN,LP,RN,RP} */
> +};

Missing routes?  The comment should at least be a bit clearer about why
they're not there.

> +	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
> +	snd_soc_dapm_enable_pin(codec, "Line In");
> +	snd_soc_dapm_enable_pin(codec, "Line Out");
> +	snd_soc_dapm_enable_pin(codec, "Mic Jack");

This is not required since pins are enabled by default but it's OK to
leave this here for documentation.

> +static struct aic3x_setup_data codec_setup = {
> +	.i2c_bus	= 0,
> +	.i2c_already	= 1,
> +};
> +

This patch should have been submitted after your previous patch to the
CODEC driver since it depends on it.

> +static int __devinit simtec_audio_hermes_probe(struct platform_device *pd)
> +{
> +	dev_info(&pd->dev, "probing....\n");
> +	return simtec_audio_core_probe(pd, &simtec_snd_devdata_aic33);
> +}

Please remove the printk() here.
