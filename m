From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH] ASoc: wm8580: Add the wm8581 codec to the
	driver
Date: Thu, 20 Oct 2016 10:22:53 +1100
Message-ID: <b023d208-c97c-fd51-303e-a9480e51719c@flatmax.org>
References: <1476815075-12976-1-git-send-email-flatmax@flatmax.org>
 <20161019092227.GJ3207@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas06p.mx.bigpond.com (nskntmtas06p.mx.bigpond.com
 [61.9.168.152]) by alsa0.perex.cz (Postfix) with ESMTP id EC9D32665FC
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 01:22:58 +0200 (CEST)
In-Reply-To: <20161019092227.GJ3207@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org



On 19/10/16 20:22, Charles Keepax wrote:
> On Wed, Oct 19, 2016 at 05:24:35AM +1100, Matt Flax wrote:
>> This patch adds support for the wm8581 codec to the wm8580 driver.
>> The wm8581 codec hardware adds a fourth DAC and otherwise is
>> compatible with the wm8580 codec.
>>
>> of_device_id data is used to allow the driver to select the
>> suitable DAC count specified in the device tree codec selection.
>> The wm8580_driver_data struct is used to store the number of DACs.
>>
>> The snd_soc_dai_driver no longer lists the channels_max for the
>> playback substream. This variable is set during the i2c probe
>> from the of_device_id supplied wm8580_driver_data struct.
>>
>> With knowledge of the number of DACs in use, the DAC4 controls,
>> widgets and routes are added as required for DAC4.
>>
>> The device tree documentation for the wm8580 is altered to list
>> the wm8581 codec support, as is the Kconfig file.
>>
>> Signed-off-by: Matt Flax <flatmax@flatmax.org>
>> ---
> When doing a respin of a patch its usually considered good
> practice to do something like [PATCH v2] in the subject line,
> lets people clearly see that its a new version not a resend.
OK - I see that I should use in-reply-to with the message id next time.
>>   Documentation/devicetree/bindings/sound/wm8580.txt |  4 +-
>>   sound/soc/codecs/Kconfig                           |  2 +-
>>   sound/soc/codecs/wm8580.c                          | 98 ++++++++++++++++++++--
>>   3 files changed, 92 insertions(+), 12 deletions(-)
> <snip>
>> @@ -65,6 +68,8 @@
>>   #define WM8580_DIGITAL_ATTENUATION_DACR2     0x17
>>   #define WM8580_DIGITAL_ATTENUATION_DACL3     0x18
>>   #define WM8580_DIGITAL_ATTENUATION_DACR3     0x19
>> +#define WM8580_DIGITAL_ATTENUATION_DACL4     0x1A
>> +#define WM8580_DIGITAL_ATTENUATION_DACR4     0x1B
> Apologies my fault for still not being clear these two new
> defines would still be best called WM8581...
>
> <snip>
>> +static int wm8580_playback_startup(struct snd_pcm_substream *substream,
>> +			   struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
>> +
>> +	return snd_pcm_hw_constraint_single(substream->runtime,
>> +		SNDRV_PCM_HW_PARAM_CHANNELS, wm8580->drvdata->num_dacs * 2);
> Won't this limit us to exactly num_dacs * 2 channels? I would
> have expected a contraint_minmax, I haven't checked the core
> code but would be good to know you have tested smaller numbers
> of channels and they are working. Bearing in mind that some
> user-space applications will do things like pad out to the number
> of channels the hardware claims to require. For example for aplay
> I believe -v will show you if it does any conversion and
> --disable-channels will stop it attempting to convert the number
> of channels.
> Apart from those very small comments this all looks fine to me.
OK, I will use minmax to fix this problem ... I didn't see it at first, 
thanks for pointing it out.

Matt
>
> Thanks,
> Charles
