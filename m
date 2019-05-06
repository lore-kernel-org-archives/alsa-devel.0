From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH] ASoC: codec: hdac_hdmi: no checking
 monitor in hw_params
Date: Mon, 6 May 2019 08:46:34 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19528350C9@SHSMSX103.ccr.corp.intel.com>
References: <1557125960-29353-1-git-send-email-libin.yang@intel.com>
 <320b97c1-ed3c-6c56-0829-c00d2e475278@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C76D2F8962A
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 10:46:39 +0200 (CEST)
In-Reply-To: <320b97c1-ed3c-6c56-0829-c00d2e475278@perex.cz>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "Wang, Rander" <rander.wang@intel.com>, Hui Wang <hui.wang@canonical.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Add Mengdong, Hui, Rander

Hi Jaroslav,

>-----Original Message-----
>From: Jaroslav Kysela [mailto:perex@perex.cz]
>Sent: Monday, May 6, 2019 4:20 PM
>To: Yang, Libin <libin.yang@intel.com>; alsa-devel@alsa-project.org
>Cc: tiwai@suse.de; pierre-louis.bossart@linux.intel.com; broonie@kernel.org;
>subhransu.s.prusty@intel.com; samreen.nilofer@intel.com
>Subject: Re: [alsa-devel] [RFC PATCH] ASoC: codec: hdac_hdmi: no checking
>monitor in hw_params
>
>Dne 06. 05. 19 v 8:59 libin.yang@intel.com napsal(a):
>> From: Libin Yang <libin.yang@intel.com>
>>
>> This patch move the check of monitor from hw_params to trigger callback.
>>
>> The original code will check the monitor presence in hw_params. If the
>> monitor doesn't exist, hw_params will return -ENODEV. Mostly this is OK.
>>
>> However, pulseaudio will check the pcm devices when kernel is booting up.
>> It will try to open, set hw_params, prepare such pcm devices. We can't
>> guarantee that the monitor will be connected when kernel is booting up.
>> Especially, hdac_hdmi will export 3 pcms at most. It's hard to say
>> users will connect 3 monitors to the HDMI/DP ports. This will cause
>> pulseaudio fail in parsing the pcm devices because the driver will
>> return -ENODEV in hw_params.
>>
>> This patch tries to move the check of monitor presence into trigger
>> callback. This can "trick" the pulseaudio the pcm is ready.
>>
>> This bug is found when we try to enable HDMI detection in
>> gnome-sound-setting for ASoC hdac_hdmi. After we enable the hdmi in
>> UCM, pulseaudio will try to parse the hdmi pcm devices. It will cause
>> failure if there are no monitors connected.
>
>I don't like this solution much. PA should use the Jack control to add the
>devices dynamically and avoid probing when the Jack control is false.

Before we decided to use UCM, we did some investigation on Jack controls.
And we found we need do much more changes in driver to support Jack
Controls. 

Regards,
Libin

>
>						Jaroslav
>
>>
>> Signed-off-by: Libin Yang <libin.yang@intel.com>
>> ---
>>  sound/soc/codecs/hdac_hdmi.c | 44
>> +++++++++++++++++++++++++++++++-------------
>>  1 file changed, 31 insertions(+), 13 deletions(-)
>>
>> diff --git a/sound/soc/codecs/hdac_hdmi.c
>> b/sound/soc/codecs/hdac_hdmi.c index 4de1fbf..f482e09 100644
>> --- a/sound/soc/codecs/hdac_hdmi.c
>> +++ b/sound/soc/codecs/hdac_hdmi.c
>> @@ -455,24 +455,11 @@ static int hdac_hdmi_set_hw_params(struct
>snd_pcm_substream *substream,
>>  	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)  {
>>  	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
>> -	struct hdac_device *hdev = hdmi->hdev;
>>  	struct hdac_hdmi_dai_port_map *dai_map;
>> -	struct hdac_hdmi_port *port;
>>  	struct hdac_hdmi_pcm *pcm;
>>  	int format;
>>
>>  	dai_map = &hdmi->dai_map[dai->id];
>> -	port = dai_map->port;
>> -
>> -	if (!port)
>> -		return -ENODEV;
>> -
>> -	if ((!port->eld.monitor_present) || (!port->eld.eld_valid)) {
>> -		dev_err(&hdev->dev,
>> -			"device is not configured for this pin:port%d:%d\n",
>> -					port->pin->nid, port->id);
>> -		return -ENODEV;
>> -	}
>>
>>  	format = snd_hdac_calc_stream_format(params_rate(hparams),
>>  			params_channels(hparams),
>params_format(hparams), @@ -630,6
>> +617,36 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream
>*substream,
>>  		dai_map->port = NULL;
>>  }
>>
>> +static int hdac_hdmi_pcm_trigger(struct snd_pcm_substream *substream,
>int cmd,
>> +				 struct snd_soc_dai *dai)
>> +{
>> +	struct hdac_hdmi_port *port;
>> +	struct hdac_hdmi_dai_port_map *dai_map;
>> +	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
>> +	struct hdac_device *hdev = hdmi->hdev;
>> +
>> +	/*
>> +	 * When start, if there is no monitor,
>> +	 * It should not start audio.
>> +	 */
>> +	if (cmd == SNDRV_PCM_TRIGGER_START) {
>> +		dai_map = &hdmi->dai_map[dai->id];
>> +		port = dai_map->port;
>> +
>> +		if (!port)
>> +			return -ENODEV;
>> +
>> +		if ((!port->eld.monitor_present) || (!port->eld.eld_valid)) {
>> +			dev_err(&hdev->dev,
>> +				"device is not configured for this
>pin:port%d:%d\n",
>> +				port->pin->nid, port->id);
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int
>>  hdac_hdmi_query_cvt_params(struct hdac_device *hdev, struct
>> hdac_hdmi_cvt *cvt)  { @@ -1389,6 +1406,7 @@ static const struct
>> snd_soc_dai_ops hdmi_dai_ops = {
>>  	.startup = hdac_hdmi_pcm_open,
>>  	.shutdown = hdac_hdmi_pcm_close,
>>  	.hw_params = hdac_hdmi_set_hw_params,
>> +	.trigger = hdac_hdmi_pcm_trigger,
>>  	.set_tdm_slot = hdac_hdmi_set_tdm_slot,  };
>>
>>
>
>
>--
>Jaroslav Kysela <perex@perex.cz>
>Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
