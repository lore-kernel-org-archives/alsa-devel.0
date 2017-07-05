From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: hdmi_codec_priv includes
 snd_kcontrol_new
Date: Wed, 5 Jul 2017 11:29:43 +0200
Message-ID: <6a520509-962d-fc8a-45f6-512fde8034df@st.com>
References: <87eftvmhir.wl%kuninori.morimoto.gx@renesas.com>
 <s5hh8yrb7jr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8198A266E2C
 for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2017 11:29:47 +0200 (CEST)
In-Reply-To: <s5hh8yrb7jr.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "Jon Medhurst (Tixy)" <tixy@linaro.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>, PhilippZabel <p.zabel@pengutronix.de>, Colin Ian King <colin.king@canonical.com>, Vincent ABRIOU <vincent.abriou@st.com>
List-Id: alsa-devel@alsa-project.org



On 07/05/2017 10:40 AM, Takashi Iwai wrote:
> On Wed, 05 Jul 2017 10:15:35 +0200,
> Kuninori Morimoto wrote:
>>
>>
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> Current hdmi-codec driver is using hdmi_controls for "ELD" control.
>> But, hdmi-codec driver might be used from many HDMIs. In such case,
>> they will use same "ELD" name and kernel will indicate below error.
>>
>> 	xxx: control x:x:x:ELD:x is already present
>>
>> hdmi_controls will be registered in soc_probe_component(), and we can
>> replace it by component driver probe function.
>>
>> This patch registers current hdmi_controls in new hdmi_probe().
>> If hdmi-codec is used from only 1 device, it will use "ELD" as control name
>> (We can keep compatibility).
>> If hdmi-codec is used from many devices, it will use "ELD.x" as control name.
> 
> The de facto standard way as HD-audio does is to pass the device
> number of each ELD control as same as the corresponding PCM stream
> number.
> 
> 
> thanks,
> 
> Takashi
> 
In theory, hdmi_codec_pcm_new already does the job.
snd_pcm_add_chmap_ctls instantiates the controls using PCM device ID. So
you should observe (with amixer) 2 controls with same name but not same
device ID.

Regards
Arnaud

>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>  sound/soc/codecs/hdmi-codec.c | 60 +++++++++++++++++++++++++++++++++----------
>>  1 file changed, 46 insertions(+), 14 deletions(-)
>>
>> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
>> index 22ed0dc..5835a90 100644
>> --- a/sound/soc/codecs/hdmi-codec.c
>> +++ b/sound/soc/codecs/hdmi-codec.c
>> @@ -276,6 +276,7 @@ struct hdmi_codec_cea_spk_alloc {
>>  	  .mask = FL | FR | LFE | FC | RL | RR | FLC | FRC },
>>  };
>>  
>> +#define ELD_NAME_SIZE	8
>>  struct hdmi_codec_priv {
>>  	struct hdmi_codec_pdata hcd;
>>  	struct snd_soc_dai_driver *daidrv;
>> @@ -284,7 +285,10 @@ struct hdmi_codec_priv {
>>  	struct snd_pcm_substream *current_stream;
>>  	uint8_t eld[MAX_ELD_BYTES];
>>  	struct snd_pcm_chmap *chmap_info;
>> +	struct snd_kcontrol_new control;
>>  	unsigned int chmap_idx;
>> +	int id;
>> +	char eld_name[ELD_NAME_SIZE];
>>  };
>>  
>>  static const struct snd_soc_dapm_widget hdmi_widgets[] = {
>> @@ -399,18 +403,6 @@ static int hdmi_codec_chmap_ctl_get(struct snd_kcontrol *kcontrol,
>>  	return 0;
>>  }
>>  
>> -
>> -static const struct snd_kcontrol_new hdmi_controls[] = {
>> -	{
>> -		.access = SNDRV_CTL_ELEM_ACCESS_READ |
>> -			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
>> -		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
>> -		.name = "ELD",
>> -		.info = hdmi_eld_ctl_info,
>> -		.get = hdmi_eld_ctl_get,
>> -	},
>> -};
>> -
>>  static int hdmi_codec_new_stream(struct snd_pcm_substream *substream,
>>  				 struct snd_soc_dai *dai)
>>  {
>> @@ -718,6 +710,45 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
>>  	.pcm_new = hdmi_codec_pcm_new,
>>  };
>>  
>> +static int hdmi_last_id = 0;
>> +static int hdmi_probe(struct snd_soc_component *component)
>> +{
>> +	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
>> +	static struct snd_soc_component *component_1st = NULL;
>> +	char *name = "ELD";
>> +
>> +	/*
>> +	 * It will use "ELD"   if hdmi_codec was used from only 1 device.
>> +	 * It will use "ELD.x" if hdmi_codec was used from many devices.
>> +	 * Then, first "ELD" will be replaced to "ELD.0"
>> +	 */
>> +	snprintf(hcp->eld_name, ELD_NAME_SIZE, "ELD.%d", hcp->id);
>> +
>> +	if (hcp->id == 0)
>> +		component_1st = component;
>> +
>> +	if (hdmi_last_id > 1) {
>> +		name = hcp->eld_name;
>> +
>> +		if (component_1st) {
>> +			struct hdmi_codec_priv *hcp_1st;
>> +
>> +			/* replaced 1st "ELD" to "ELD.0" */
>> +			hcp_1st = snd_soc_component_get_drvdata(component_1st);
>> +			hcp_1st->control.name = hcp_1st->eld_name;
>> +		}
>> +	}
>> +
>> +	hcp->control.access	= SNDRV_CTL_ELEM_ACCESS_READ |
>> +				  SNDRV_CTL_ELEM_ACCESS_VOLATILE;
>> +	hcp->control.iface	= SNDRV_CTL_ELEM_IFACE_PCM;
>> +	hcp->control.name	= name;
>> +	hcp->control.info	= hdmi_eld_ctl_info;
>> +	hcp->control.get	= hdmi_eld_ctl_get;
>> +
>> +	return snd_soc_add_component_controls(component, &hcp->control, 1);
>> +}
>> +
>>  static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
>>  				 struct device_node *endpoint)
>>  {
>> @@ -732,8 +763,7 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
>>  
>>  static struct snd_soc_codec_driver hdmi_codec = {
>>  	.component_driver = {
>> -		.controls		= hdmi_controls,
>> -		.num_controls		= ARRAY_SIZE(hdmi_controls),
>> +		.probe			= hdmi_probe,
>>  		.dapm_widgets		= hdmi_widgets,
>>  		.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
>>  		.dapm_routes		= hdmi_routes,
>> @@ -768,6 +798,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
>>  	if (!hcp)
>>  		return -ENOMEM;
>>  
>> +	hcp->id = hdmi_last_id;
>>  	hcp->hcd = *hcd;
>>  	mutex_init(&hcp->current_stream_lock);
>>  
>> @@ -795,6 +826,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	dev_set_drvdata(dev, hcp);
>> +	hdmi_last_id++;
>>  	return 0;
>>  }
>>  
>> -- 
>> 1.9.1
>>
>>
