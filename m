From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [PATCH 2/3] ASoC: Blackfin: add multi-channel
	supporting in Blackfin ASoC driver and AD1980 codec driver
Date: Tue, 21 Oct 2008 17:08:31 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA02E66236@chinexm1.ad.analog.com>
References: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
	<1224560173-8728-3-git-send-email-cooloney@kernel.org>
	<20081021083715.GA10841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id DAD992476E
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 11:06:47 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <20081021083715.GA10841@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>, Bryan Wu <cooloney@kernel.org>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

 

>-----Original Message-----
>From: Mark Brown [mailto:broonie@sirena.org.uk] 
>Sent: Tuesday, October 21, 2008 4:37 PM
>To: Bryan Wu
>Cc: alsa-devel@alsa-project.org; Cliff Cai
>Subject: Re: [PATCH 2/3] ASoC: Blackfin: add multi-channel 
>supporting in Blackfin ASoC driver and AD1980 codec driver
>
>On Tue, Oct 21, 2008 at 11:36:12AM +0800, Bryan Wu wrote:
>
>> +config SND_MULTICHAN_SUPPORT
>> +	bool "Enable Multichannel Support"
>> +	depends on SND_BF5XX_AC97
>> +	default n
>> +	help
>> +	  Say y if you want AC97 driver to support up to 5.1 
>channel audio.
>> +	  this mode will consume much more memory for DMA. 
>> +
>
>Should this be a user visible option or selected by the 
>machine drivers?

I think people want to enable this feature
Only If they really want it,since it will consume much more memory
To hold multi-channel data.
 
>To be honest, I'm surprised that the multi-channel support 
>can't only incur the extra memory consumpton when playing back 
>a multi-channel stream - I'd have expected the hardware to 
>work in the same way for a normal stereo stream even if 
>multi-channel support is built in.

Yes,hardware almost works in the same way as playing a stereo
stream,except
That it need to fill more data to DMA memory manually,since we just
simulate AC97
Controller using serial port.

>> -void bf5xx_ac97_to_pcm(const struct ac97_frame *src, __u32 *dst, \
>> +void bf5xx_ac97_to_pcm(const struct ac97_frame *src, __u16 *dst, \
>>  		size_t count)
>>  {
>
>Separately please submit a patch removing the needless 
>continuation character here.
>
>> diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c 
>> index 1397b8e..e22fbdf 100644
>> --- a/sound/soc/codecs/ad1980.c
>> +++ b/sound/soc/codecs/ad1980.c
>
>The codec driver changes should be submitted as a separate patch.
>They're good to go as-is.
>
