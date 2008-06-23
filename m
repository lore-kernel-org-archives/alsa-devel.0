From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: JIVE: Add ASoC audio support
Date: Mon, 23 Jun 2008 13:14:46 +0100
Message-ID: <20080623121446.GB9318@sirena.org.uk>
References: <20080623115423.075998840@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7133310386C
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 14:14:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080623115423.075998840@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 23, 2008 at 12:54:23PM +0100, Ben Dooks wrote:

This looks mostly good - a few nits:

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.26-rc5-quilt2/sound/soc/s3c24xx/jive_wm8750.c	2008-06-12 11:07:04.000000000 +0100
> @@ -0,0 +1,266 @@
> +/* sound/soc/s3c24xx/jive_wm8705.c

Typo :)

> +static inline int codec_set_dai_fmt(struct snd_soc_codec_dai *dai,
> +				    unsigned int format)
> +{
> +	return dai->dai_ops.set_fmt(dai, format);
> +}

These functions are a good idea - the equivalents are already in ASoC v2
but haven't been backported into mainline yet - but they should be in
the ASoC core rather than in a machine driver.  Please either remove
them or integrate them into the core (obviously the latter would be nice
but the former is less work).

> +static const struct snd_kcontrol_new wm8750_jive_controls[] = {
> +
> +};

This (and the code to process it) could go since it's empty.

> +
> +	/* Add jive specific widgets */
> +	for (i = 0; i < ARRAY_SIZE(wm8750_dapm_widgets); i++) {
> +		snd_soc_dapm_new_control(codec, &wm8750_dapm_widgets[i]);
> +	}

These should all be updated to use the new bulk registration APIs (these
were added to the ASoC core this year, after the driver appears to have
been written).  Here the equivalent is snd_soc_dapm_new_controls().

> +	/* Set up jive specific audio path audio_map */
> +	for (i = 0; audio_map[i][0] != NULL; i++) {
> +		printk(KERN_INFO "mapping %s => %s\n", audio_map[i][0], audio_map[i][1]);
> +		snd_soc_dapm_connect_input(codec, audio_map[i][0], NULL,
> +					   audio_map[i][1]);
> +	}

Here it's snd_soc_dapm_add_routes().

> +static int __init jive_init(void)
> +{
> +	int ret;
> +
> +	printk("JIVE WM8750 Audio support\n");

This should have a KERN_INFO?
