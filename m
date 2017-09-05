From: Sergej Sawazki <sergej@taudac.com>
Subject: Re: [PATCH 3/3] ASoC: wm8741: Set SR mode in
	hw_params()
Date: Tue, 5 Sep 2017 21:05:27 +0200
Message-ID: <ca28fded-69d9-0ede-0a50-ac72434f0713@taudac.com>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-4-git-send-email-sergej@taudac.com>
 <20170905162300.zrmwyz3niarqzcr4@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 63351266C6D
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 21:05:28 +0200 (CEST)
In-Reply-To: <20170905162300.zrmwyz3niarqzcr4@localhost.localdomain>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Am 05.09.2017 um 18:23 schrieb Charles Keepax:
> On Mon, Sep 04, 2017 at 09:34:13PM +0200, Sergej Sawazki wrote:
>> Set the ratio of MCLK/LRCLK in hw_params() instead of relying on the
>> auto-detection.
>>
>> The ratio of MCLK/LRCLK is known to the driver, there is no need to let
>> the device to detect it.
>>
> 
> But also no reason to not let it do so, are there some problems
> with the auto-detect?
> 

I haven't noticed any problems. But, as we know the ratio and the device 
provides an interface to set it, why don't we just do it?
Setting it feels right somehow, even if it is not absolutely necessary.

>> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
>> ---
>>   sound/soc/codecs/wm8741.c | 29 +++++++++++++++++++++--------
>>   1 file changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
>> index 7e8a7fe..534741b 100644
>> --- a/sound/soc/codecs/wm8741.c
>> +++ b/sound/soc/codecs/wm8741.c
>> @@ -198,7 +198,6 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
>>   	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
>>   	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1FC;
>>   	u16 mode = snd_soc_read(codec, WM8741_MODE_CONTROL_1) & 0x183;
>> -	int i;
>>   
>>   	/* The set of sample rates that can be supported depends on the
>>   	 * MCLK supplied to the CODEC - enforce this.
>> @@ -209,13 +208,27 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
>>   		return -EINVAL;
>>   	}
>>   
>> -	/* Find a supported LRCLK rate */
>> -	for (i = 0; i < wm8741->sysclk_constraints->count; i++) {
>> -		if (wm8741->sysclk_constraints->list[i] == params_rate(params))
>> -			break;
>> -	}
> 
> This looks like it should be in a separate patch, is removing
> this part of this patch? It feels like the constraints should
> have already been applied by startup so we should never be able
> to fail here in hw_params, is that why you are removing it?
> 

This for loop has been replaced by a switch statement. The switch is now 
checking if the LRCLK rate is supported with the supplied MCLK and sets 
the MCLK/LRCLK ratio if it is.

Thanks,
Sergej
