From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] alsa: ASoC: Add JZ4740 codec driver
Date: Sun, 20 Jun 2010 14:11:53 +0100
Message-ID: <20100620131153.GA2405@opensource.wolfsonmicro.com>
References: <1276924111-11158-21-git-send-email-lars@metafoo.de>
	<1276958993-9012-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7031B24153
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jun 2010 15:11:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1276958993-9012-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 19, 2010 at 04:49:53PM +0200, Lars-Peter Clausen wrote:

This looks good, just one thing:

> +#ifdef CONFIG_PM_SLEEP
> +
> +static int jz4740_codec_suspend(struct device *dev)
> +{
> +	struct jz4740_codec *jz4740_codec = dev_get_drvdata(dev);
> +	return jz4740_codec_set_bias_level(&jz4740_codec->codec,
> +		SND_SOC_BIAS_OFF);
> +}

You've got these set up on the CODEC platform device rather than the
ASoC CODEC.  This means that the suspend and resume will happen out of
sequence with the rest of the ASoC suspend and resume which could result
in poor performance or bugs if the device is suspended while the core
still thinks it's active.  For example, ASoC will use DAPM to shut down
the CODEC and it's possible that the CODEC could be suspended (and
generate an audible noise) while an external amplifier is still powered,
worsening the problem.
