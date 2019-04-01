From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH V2] ASoC: hdac_hdmi: add device PM
 dependency
Date: Mon, 1 Apr 2019 13:43:41 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195280F260@SHSMSX103.ccr.corp.intel.com>
References: <1554094251-25910-1-git-send-email-libin.yang@intel.com>
 <8b5f72b4-9674-ecfe-5007-7098b5432a40@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73C7AF89610
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 15:43:47 +0200 (CEST)
In-Reply-To: <8b5f72b4-9674-ecfe-5007-7098b5432a40@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Monday, April 1, 2019 8:34 PM
>To: Yang, Libin <libin.yang@intel.com>; alsa-devel@alsa-project.org;
>tiwai@suse.de; broonie@kernel.org
>Subject: Re: [alsa-devel] [PATCH V2] ASoC: hdac_hdmi: add device PM
>dependency
>
>On 4/1/19 12:50 AM, libin.yang@intel.com wrote:
>> From: Libin Yang <libin.yang@intel.com>
>>
>> HDMI audio codec register operation depends on the display audio power
>> domain. The hdmi audio codec dapm event callback must be called after
>> display audio power is turned on.
>>
>> Add hdac_hdmi_device_link_add() in HDMI audio codec driver. The
>> customer audio driver, such as cAVS/SST and SOF audio driver, can call
>> the function to set the audio power dependency.
>>
>> Signed-off-by: Libin Yang <libin.yang@intel.com>
>> ---
>>   sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
>>   sound/soc/codecs/hdac_hdmi.h |  6 ++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/sound/soc/codecs/hdac_hdmi.c
>> b/sound/soc/codecs/hdac_hdmi.c index 5eeb0fe..c991407 100644
>> --- a/sound/soc/codecs/hdac_hdmi.c
>> +++ b/sound/soc/codecs/hdac_hdmi.c
>> @@ -1792,6 +1792,18 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai,
>int device,
>>   }
>>   EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);
>>
>> +struct device_link *
>> +hdac_hdmi_device_link_add(struct device *consumer,
>> +			  struct snd_soc_component *component,
>> +			  u32 flags)
>> +{
>> +	struct hdac_hdmi_priv *hdmi =
>snd_soc_component_get_drvdata(component);
>> +	struct hdac_device *hdev = hdmi->hdev;
>> +
>> +	return device_link_add(consumer, &hdev->dev, flags);
>
>Don't you need a matching device_link_free() to avoid a memory leak?

Right. Sorry for my poor patch and thanks for pointing it out. 
I will refine it and test tomorrow.

>
>Also what would be the expectations for the flags and do you really want the
>consumer to set them?

A consumer setting the flag will be more flexible. For the flag, I'm currently thinking
to use DL_FLAG_RPM_ACTIVE. Not sure if it is a good flag.

>
>And last, without a patch of the cAVS driver it's hard to see how this might be
>used.

I tried on SOF, it worked. I will check if I have a cAVS environment and will have
a test on cAVS.

Regards,
Libin

>
>> +}
>> +EXPORT_SYMBOL_GPL(hdac_hdmi_device_link_add);
>> +
>>   static void hdac_hdmi_present_sense_all_pins(struct hdac_device *hdev,
>>   			struct hdac_hdmi_priv *hdmi, bool detect_pin_caps)
>>   {
>> diff --git a/sound/soc/codecs/hdac_hdmi.h
>> b/sound/soc/codecs/hdac_hdmi.h index 4fa2fc9..9239c6b 100644
>> --- a/sound/soc/codecs/hdac_hdmi.h
>> +++ b/sound/soc/codecs/hdac_hdmi.h
>> @@ -7,4 +7,10 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int
>> pcm,
>>
>>   int hdac_hdmi_jack_port_init(struct snd_soc_component *component,
>>   			struct snd_soc_dapm_context *dapm);
>> +
>> +struct device_link *
>> +hdac_hdmi_device_link_add(struct device *consumer,
>> +			  struct snd_soc_component *component,
>> +			  u32 flags);
>> +
>>   #endif /* __HDAC_HDMI_H__ */
>>
