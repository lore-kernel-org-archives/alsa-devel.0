From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: [PATCH] ASoC: adau1701: Add 44.1 KHz to supported
	sample rates
Date: Wed, 11 Nov 2015 12:40:48 +0100
Message-ID: <56432940.4040306@gmail.com>
References: <1444907766-9892-1-git-send-email-pascal.huerst@gmail.com>
 <56260521.6080805@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 86A7A260415
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 12:40:50 +0100 (CET)
Received: by wmdw130 with SMTP id w130so109268788wmd.0
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 03:40:50 -0800 (PST)
In-Reply-To: <56260521.6080805@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 20.10.2015 11:10, Lars-Peter Clausen wrote:
> On 10/15/2015 01:16 PM, pascal.huerst@gmail.com wrote:
>> From: Pascal Huerst <pascal.huerst@gmail.com>
>>
>> According to the datasheet, this device does also support 44.1 KHz
>> as sample rate. This adds the necessary changes to support this.
>>
>> See Datasheet: Rev. B / page 39 / SR[1:0]
>>
>> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
> 
> Hm, right. The sample rates that part can run at depend on the external
> clock rate. It can run at ext_clk / 256, ext_clk / 128 or ext_clk / 64.
> Maybe we should just implement it like that.
> 
> Do you have support for switching the external clock at runtime on your
> platform?

Yes, I can switch th eclock at runtime.

>> ---
>>  sound/soc/codecs/adau1701.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
>> index de53c0d..8b3ba51 100644
>> --- a/sound/soc/codecs/adau1701.c
>> +++ b/sound/soc/codecs/adau1701.c
>> @@ -459,6 +459,7 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
>>  	case 96000:
>>  		val = ADAU1701_DSPCTRL_SR_96;
>>  		break;
>> +	case 44100:
>>  	case 48000:
>>  		val = ADAU1701_DSPCTRL_SR_48;
>>  		break;
>> @@ -623,8 +624,8 @@ static int adau1701_startup(struct snd_pcm_substream *substream,
>>  	return sigmadsp_restrict_params(adau1701->sigmadsp, substream);
>>  }
>>  
>> -#define ADAU1701_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
>> -	SNDRV_PCM_RATE_192000)
>> +#define ADAU1701_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
>> +	SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
>>  
>>  #define ADAU1701_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
>>  	SNDRV_PCM_FMTBIT_S24_LE)
>>
> 
