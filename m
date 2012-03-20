From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/8] sound:asoc: Add support for STA529
 Audio Codec
Date: Tue, 20 Mar 2012 18:57:06 +0100
Message-ID: <4F68C4F2.5000805@metafoo.de>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<a5a4d4490442b863f6ef916f74f068e2303b382b.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-008.synserver.de (smtp-out-008.synserver.de
	[212.40.185.8]) by alsa0.perex.cz (Postfix) with ESMTP id 529AD24386
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 18:54:56 +0100 (CET)
In-Reply-To: <a5a4d4490442b863f6ef916f74f068e2303b382b.1332242166.git.rajeev-dlh.kumar@st.com>
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
Cc: alsa-devel@alsa-project.org, spear-devel@list.st.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 03/20/2012 12:33 PM, Rajeev Kumar wrote:
> +static const char *interface_mode_text[] = { "slave", "master"};

Master/slave mode should be configured using the set_dai_fmt callback.

> +
> +static struct snd_soc_dai_ops sta529_dai_ops = {

const

> +	.hw_params	=	sta529_hw_params,
> +	.set_fmt	=	sta529_set_dai_fmt,
> +	.digital_mute	=	sta529_mute,
> +};
> +
> +/* power down chip */
> +static int sta529_remove(struct snd_soc_codec *codec)
> +{
> +	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	return 0;
> +}
> +
> +static int sta529_suspend(struct snd_soc_codec *codec, pm_message_t state)

The suspend callback doesn't take the state parameter anymore.

> +{
> +	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	return 0;
> +}
> +
> +static int sta529_resume(struct snd_soc_codec *codec)
> +{
> +	snd_soc_cache_sync(codec);
> +	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	sta529_set_bias_level(codec, codec->dapm.suspend_bias_level);
> +
> +	return 0;
> +}
> +
> +struct snd_soc_codec_driver soc_codec_dev_sta529 = {

A better name is be sta520_codec_driver
[...]
> +
> +static int sta529_i2c_remove(struct i2c_client *client)
__devexit
> +{
> +	snd_soc_unregister_codec(&client->dev);
> +	kfree(i2c_get_clientdata(client));
> +	return 0;
> +}
river");
> +MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
> +MODULE_LICENSE("GPL");
