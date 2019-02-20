From: <Codrin.Ciubotariu@microchip.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix
	energysense SLEEP bit
Date: Wed, 20 Feb 2019 10:56:55 +0000
Message-ID: <a1e133fe-2fdf-db02-4fe2-6b5e259191b7@microchip.com>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
 <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
 <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa1.microchip.iphmx.com (esa1.microchip.iphmx.com
 [68.232.147.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4ED52F80758
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 11:56:59 +0100 (CET)
In-Reply-To: <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
Content-Language: en-US
Content-ID: <755D4C5D3444694889594766D0FAD874@namprd11.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: afd@ti.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org

On 19.02.2019 19:06, Andrew F. Davis wrote:
> On 2/19/19 10:29 AM, Codrin.Ciubotariu@microchip.com wrote:
>> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>>
>> The ADCs are sleeping when the SLEEP bit is set and running when it's
>> cleared, so the bit should be inverted.
>> Tested on pcm1863.
>>
> 
> Did this work for you before? Strange it would if reversed, I wonder if
> the SLEEP bit is really doing anything here. Can investigate later, for
> this patch:

The SLEEP bit seems to work. At least STATE from register 114 says the 
IP is sleeping. Without this change, if pcm1863 is used as master, I can 
see BCK and LRCK generated while no sound is played. Once I start an 
audio stream, the clocks stop.

Thank you for your ACK. I would really appreciate if you could also test 
it on your side.

Best regards,
Codrin

> 
> Acked-by: Andrew F. Davis <afd@ti.com>
> 
>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> ---
>>
>> Changes in v2:
>>   - none;
>>
>>   sound/soc/codecs/pcm186x.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
>> index c36a391fec8a..c5fcc632f670 100644
>> --- a/sound/soc/codecs/pcm186x.c
>> +++ b/sound/soc/codecs/pcm186x.c
>> @@ -158,7 +158,7 @@ static const struct snd_soc_dapm_widget pcm1863_dapm_widgets[] = {
>>   	 * Put the codec into SLEEP mode when not in use, allowing the
>>   	 * Energysense mechanism to operate.
>>   	 */
>> -	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  0),
>> +	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  1),
>>   };
>>   
>>   static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
>> @@ -184,8 +184,8 @@ static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
>>   	 * Put the codec into SLEEP mode when not in use, allowing the
>>   	 * Energysense mechanism to operate.
>>   	 */
>> -	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
>> -	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
>> +	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  1),
>> +	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  1),
>>   };
>>   
>>   static const struct snd_soc_dapm_route pcm1863_dapm_routes[] = {
>>
