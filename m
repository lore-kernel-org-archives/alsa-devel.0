From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
Date: Fri, 4 Jul 2008 21:49:27 +0100
Message-ID: <20080704204927.GC20719@sirena.org.uk>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B6D3124AD6
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 22:49:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080701235340.16923.48024.stgit@trillian.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 01, 2008 at 05:53:40PM -0600, Grant Likely wrote:

> +static ssize_t aic26_keyclick_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct aic26 *aic26 = dev_get_drvdata(dev);
> +	int val, amp, freq, len;
> +
> +	val = aic26_reg_read_cache(&aic26->codec, AIC26_REG_AUDIO_CTRL2);
> +	amp = (val >> 12) & 0x7;
> +	freq = (125 << ((val >> 8) & 0x7)) >> 1;
> +	len = 2 * (1 +((val >> 8) & 0xf));
> +
> +	return sprintf(buf, "amp=%x freq=%iHz len=%iclks\n", amp, freq, len);
> +}

It might be nice if these parameters were exposed as controls if they
can be configured, though obviously that's not essential.

> +	/* Tell the of_soc helper about this codec */
> +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> +				  spi->dev.archdata.of_node);

Does this need to be ifdefed out if of_snd_soc_register_codec() is not
in use or is the function stubbed out if it's not in use?  Stubbing it
out would be cleaner.
