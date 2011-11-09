From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6] ASoC:Add support for cs42l73 codec
Date: Wed, 9 Nov 2011 23:43:19 +0000
Message-ID: <20111109234318.GB5010@opensource.wolfsonmicro.com>
References: <1320854713-8261-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8406F2438C
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 00:43:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1320854713-8261-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, joe@nucleusys.com, ramesh.babu@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 09, 2011 at 10:05:13AM -0600, Brian Austin wrote:
> Signed-off-by:Brian Austin <brian.austin@cirrus.com>
> Signed-off-by:Georgi Vlaev <joe@nucleusys.com>
> 
> This patch adds support for Cirrus Logic CS42L73
> low power stereo codec

Changelogs and signoffs are supposed to go in the other order.

> +static const char * const charge_pump_freq_text[] = {
> +	"0", "1", "2", "3", "4",
> +	"5", "6", "7", "8", "9",
> +	"10", "11", "12", "13", "14", "15" };

> +static const struct soc_enum charge_pump_enum =
> +	SOC_ENUM_SINGLE(CS42L73_CPFCHC, 4,
> +		ARRAY_SIZE(charge_pump_freq_text), charge_pump_freq_text);

Is there no meaningful text you can use here?  I'd expect there must be
as I've no idea how anyone should figure out what to set here, but if
not then making it an enum isn't really worthwhile, just use SOC_SINGLE.  

> +static int cs42l73_probe(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +	unsigned int devid = 0;
> +	struct cs42l73_private *cs42l73 = snd_soc_codec_get_drvdata(codec);
> +
> +	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);

It'd be better to move this to using SND_SOC_REGMAP and pushing the
cache down into the register map API with the basic device presence
verification done in the I2C probe but that's not essential yet.

> +	if (ret != 0) {
> +		printk(KERN_ERR "%s: can't add i2c driver\n", __func__);

pr_err().
