From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH v2 2/2] drm/bridge: adv7511: restrict audio
 sample sizes
Date: Tue, 1 Aug 2017 13:24:03 +0100
Message-ID: <ce018632-0b7a-7e34-6a3d-c191155a17ae@linaro.org>
References: <20170731224944.9986-1-srinivas.kandagatla@linaro.org>
 <20170731224944.9986-3-srinivas.kandagatla@linaro.org>
 <7d700845-da72-5c40-31f9-c3faa7ca93a2@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7d700845-da72-5c40-31f9-c3faa7ca93a2@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: alsa-devel@alsa-project.org



On 01/08/17 09:42, Arnaud Pouliquen wrote:
> Hello Srinivas,
> 
> On 08/01/2017 12:49 AM, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> ADV7533 only supports audio samples word width from 16-24 bits.
>> This patch restricts the audio sample sizes to the supported ones,
>> so that sound card does not report wrong list of supported hwparms.
>>
>> Without this patch aplay would fail when playing a 32 bit audio.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
>> index 67469c26bae8..d01d0aa0eef7 100644
>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
>> @@ -214,6 +214,8 @@ static struct hdmi_codec_pdata codec_data = {
>>   	.ops = &adv7511_codec_ops,
>>   	.max_i2s_channels = 2,
>>   	.i2s = 1,
>> +	.formats = (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
>> +		    SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE),
>>   };
> 
> I'm not sure that this limitation is needed.
> I already used ADV7513 and i did not observe this limitation.
> 
> I had a look to ADV7533 data-sheet. it should support 32 and 64 bits I2S

ADV7511_REG_AUDIO_CFG3(0x14) register definition in datasheet and the 
code in this driver suggest that It only supports 16Bit and 24Bit samples.

> format bus, with 16 or 24 bits precision sample. So it should support
> SNDRV_PCM_FMTBIT_S32_LE and SNDRV_PCM_FMTBIT_S32_BE
> 
> As example, if you configure bus in Left justified format with 24 bits
> sample length, 32 bits application samples should be truncated to 24
> bits samples at ADV7533 I2S interface level (LSB dropped).
May be we can do that to make the user happy but isn't this just 
truncate the resolution to 24Bit then?

And it's a false indication that we are supporting 32bit samples.
Which am not very happy with.


> 
> Perhaps i missed something... but look like more an I2S bus
> configuration issue in your DT card description, that that a miss in the
> drivers.

Nothing to do with DT or other driver, adv7533 audio driver does not 
support 32 bit sample size which is why it would return -EINVAL from
adv7511_hdmi_hw_params().

This patch is fixing the loose ends, by which I mean the card would 
report the exact supported sample sizes to user rather than every thing 
in the I2S_FORMATS list.


Thanks,
srini

> 
> Regards
> Arnaud
>>   
>>   int adv7511_audio_init(struct device *dev, struct adv7511 *adv7511)
>>
