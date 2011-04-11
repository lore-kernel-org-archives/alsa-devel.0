From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 1/5] sound: asoc: Adding support for
	STA529 Audio Codec
Date: Mon, 11 Apr 2011 07:56:22 -0700
Message-ID: <20110411145621.GA26769@opensource.wolfsonmicro.com>
References: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 794C5244E4
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 19:46:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 11, 2011 at 11:00:00AM +0530, Rajeev Kumar wrote:

> +static const char *op_mode_text[] = { "slave", "master"};

What is op_mode?  This sounds like it should be configured by
set_dai_fmt()...

> +static const struct snd_kcontrol_new sta529_new_snd_controls[] = {
> +	SOC_ENUM("pwm select", pwm_src_enum),
> +	SOC_ENUM("mode select", mode_src_enum),
> +};

ALSA control names are idiomatically things like "PWM Select" with
capitalisation.

> +	/*store the label for powers down audio subsystem for suspend.This is
> +	 ** used by soc core layer*/
> +	codec->bias_level = level;

The formatting of this comment isn't terribly idiomatic.

> +static int sta529_probe(struct snd_soc_codec *codec)
> +{
> +	struct sta529 *sta529 = snd_soc_codec_get_drvdata(codec);
> +	int ret;
> +
> +	codec->hw_write = (hw_write_t)i2c_master_send;
> +	codec->hw_read = NULL;
> +	ret = snd_soc_codec_set_cache_io(codec, 8, 8, sta529->control_type);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}

You shouldn't need to be assigning the I/O functions if you set the
control type.  If the device only supports I2C that can just be hard
coded.

> +static int sta529_resume(struct snd_soc_codec *codec)
> +{
> +	int i;
> +	u8 data[2];
> +	u8 *cache = codec->reg_cache;
> +
> +	for (i = 0; i < ARRAY_SIZE(sta529_reg); i++) {
> +		data[0] = i;
> +		data[1] = cache[i];
> +		codec->hw_write(codec->control_data, data, 2);
> +	}

It looks like you can use the standard cache sync implementation here?
snd_soc_cache_sync().
