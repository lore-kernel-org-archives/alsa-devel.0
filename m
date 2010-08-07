From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: new ADAU1761 codec driver
Date: Sat, 7 Aug 2010 23:16:41 +0100
Message-ID: <B3F28327-BBE5-489F-B077-C865B0F21332@opensource.wolfsonmicro.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-5-git-send-email-vapier@gentoo.org>
	(sfid-20100807_212838_895463_DF757BE0)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 783D7103806
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 00:16:21 +0200 (CEST)
In-Reply-To: <1281212905-12957-5-git-send-email-vapier@gentoo.org>
	(sfid-20100807_212838_895463_DF757BE0)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On 7 Aug 2010, at 21:28, Mike Frysinger <vapier@gentoo.org> wrote:

> +config SND_SOC_ADAU1761
> +	tristate
> +	select SIGMA
> +

What is SIGMA?

> +#define CAP_MIC  1
> +#define CAP_LINE 2
> +#define CAPTURE_SOURCE_NUMBER 2
> +#define ADAU1761_DIG_MIC 0

So, it looks like there's an awful lot of similarity between this and some of the other drivers. I'm going to skip a lot of repetitive comments but please assume that points which can be applied to this driver do apply.

> +static const struct snd_kcontrol_new adau1761_right_mixer_controls[] = {
> +SOC_DAPM_SINGLE("LineRight Bypass Switch", ADAU_PLBLOVR-ADAU_FIRSTREG, 1, 1, 0),
> +SOC_DAPM_SINGLE("HPRight Bypass Switch", ADAU_PLBHPVR-ADAU_FIRSTREG, 1, 1, 0),
> +};

Remember that the name of the mixer will be prepended to these - you can probably drop the Rights.

> +	snd_soc_write(codec, ADAU_DSP_RUN, 0x0);
> +	reg = snd_soc_read(codec, ADAU_CLKCTRL);
> +	snd_soc_write(codec, ADAU_CLKCTRL, reg & ~0x1);

I suspect the DSP power may warrant being managed via DAPM.

> +static ssize_t adau1371_dsp_load(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct snd_soc_device *socdev = dev_get_drvdata(dev);
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +	int ret = 0;
> +
> +	ret = adau1761_setprogram(codec);
> +	if (ret)
> +		return ret;
> +	else
> +		return count;
> +}
> +static DEVICE_ATTR(dsp, 0644, NULL, adau1371_dsp_load);

This looks redundant - it doesn't offer any opportunity to configure the firmware to download and you're already (as one one would expect) automatically downloading the firmware. If this is being exposed at all it should be via debugfs.

The permissions also look wrong given that you don't have a read function.
