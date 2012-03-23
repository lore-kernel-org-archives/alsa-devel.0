From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 1/8] sound:asoc: Add support for STA529
 Audio Codec
Date: Fri, 23 Mar 2012 09:30:38 +0530
Message-ID: <4F6BF566.8070908@st.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<a5a4d4490442b863f6ef916f74f068e2303b382b.1332242166.git.rajeev-dlh.kumar@st.com>
	<4F68C4F2.5000805@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
	[207.126.144.125])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ACFA24340
	for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2012 05:01:55 +0100 (CET)
In-Reply-To: <4F68C4F2.5000805@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, spear-devel <spear-devel@list.st.com>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Lars,

On 3/20/2012 11:27 PM, Lars-Peter Clausen wrote:
> On 03/20/2012 12:33 PM, Rajeev Kumar wrote:
>> +static const char *interface_mode_text[] = { "slave", "master"};
>
> Master/slave mode should be configured using the set_dai_fmt callback.
>
You mean to say with the help of clock direction. I think you can do it 
in either way.
By this,  I am giving full control to user for the selection.

>> +
>> +static struct snd_soc_dai_ops sta529_dai_ops = {
>
> const
>

Ok,

>> +	.hw_params	=	sta529_hw_params,
>> +	.set_fmt	=	sta529_set_dai_fmt,
>> +	.digital_mute	=	sta529_mute,
>> +};
>> +
>> +/* power down chip */
>> +static int sta529_remove(struct snd_soc_codec *codec)
>> +{
>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sta529_suspend(struct snd_soc_codec *codec, pm_message_t state)
>
> The suspend callback doesn't take the state parameter anymore.
>

Oops,

>> +{
>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sta529_resume(struct snd_soc_codec *codec)
>> +{
>> +	snd_soc_cache_sync(codec);
>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> +	sta529_set_bias_level(codec, codec->dapm.suspend_bias_level);
>> +
>> +	return 0;
>> +}
>> +
>> +struct snd_soc_codec_driver soc_codec_dev_sta529 = {
>
> A better name is be sta520_codec_driver

Ok,

> [...]
>> +
>> +static int sta529_i2c_remove(struct i2c_client *client)
> __devexit
>> +{
>> +	snd_soc_unregister_codec(&client->dev);
>> +	kfree(i2c_get_clientdata(client));
>> +	return 0;
>> +}
> river");

This comment is not clear to me , please explain.

Best Regards
Rajeev

>> +MODULE_AUTHOR("Rajeev Kumar<rajeev-dlh.kumar@st.com>");
>> +MODULE_LICENSE("GPL");
>
> .
>
