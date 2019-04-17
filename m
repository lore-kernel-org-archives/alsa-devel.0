From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v2] ASoC: codec: hdac_hdmi add device_link
 to card device
Date: Wed, 17 Apr 2019 01:12:09 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195281AF5A@SHSMSX103.ccr.corp.intel.com>
References: <1555161492-9143-1-git-send-email-libin.yang@intel.com>
 <s5hpnpm5jv1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A86FEF89614
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2019 03:12:14 +0200 (CEST)
In-Reply-To: <s5hpnpm5jv1.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Tuesday, April 16, 2019 6:24 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org; pierre-
>louis.bossart@linux.intel.com
>Subject: Re: [alsa-devel] [PATCH v2] ASoC: codec: hdac_hdmi add device_link
>to card device
>
>On Sat, 13 Apr 2019 15:18:12 +0200,
>libin.yang@intel.com wrote:
>>
>> From: Libin Yang <libin.yang@intel.com>
>>
>> In resume from S3, HDAC HDMI codec driver dapm event callback may be
>> operated before HDMI codec driver turns on the display audio power
>> domain because of the contest between display driver and hdmi codec
>driver.
>>
>> This patch adds the device_link between soc card device (consumer) and
>> hdmi codec device (supplier) to make sure the sequence is always correct.
>>
>> Signed-off-by: Libin Yang <libin.yang@intel.com>
>
>Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks for the review.

>
>Is it an issue that has been present for older released kernels?
>If so, it deserves for Cc-to-stable.

It is for all released kernels, and the rates of reproduce are different. It's
graphics driver related.

Regards,
Libin

>
>
>thanks,
>
>Takashi
>
>> ---
>>  sound/soc/codecs/hdac_hdmi.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/sound/soc/codecs/hdac_hdmi.c
>> b/sound/soc/codecs/hdac_hdmi.c index 5eeb0fe..4de1fbf 100644
>> --- a/sound/soc/codecs/hdac_hdmi.c
>> +++ b/sound/soc/codecs/hdac_hdmi.c
>> @@ -1855,6 +1855,17 @@ static int hdmi_codec_probe(struct
>snd_soc_component *component)
>>  	hdmi->card = dapm->card->snd_card;
>>
>>  	/*
>> +	 * Setup a device_link between card device and HDMI codec device.
>> +	 * The card device is the consumer and the HDMI codec device is
>> +	 * the supplier. With this setting, we can make sure that the audio
>> +	 * domain in display power will be always turned on before operating
>> +	 * on the HDMI audio codec registers.
>> +	 * Let's use the flag DL_FLAG_AUTOREMOVE_CONSUMER. This can
>make
>> +	 * sure the device link is freed when the machine driver is removed.
>> +	 */
>> +	device_link_add(component->card->dev, &hdev->dev,
>DL_FLAG_RPM_ACTIVE |
>> +			DL_FLAG_AUTOREMOVE_CONSUMER);
>> +	/*
>>  	 * hdac_device core already sets the state to active and calls
>>  	 * get_noresume. So enable runtime and set the device to suspend.
>>  	 */
>> --
>> 2.7.4
>>
