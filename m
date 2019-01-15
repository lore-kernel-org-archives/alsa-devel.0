From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH] ASoC: pcm512x: Implement the
 set_bclk_ratio interface
Date: Tue, 15 Jan 2019 08:08:43 +0000
Message-ID: <0a5918e1-aaf1-2b22-0f2a-4aaa62d1cd3e@axentia.se>
References: <900a4f74-9312-58d8-a5b3-035305fe184e@gmail.com>
 <4b8ce92c-9239-3a8a-f061-eb114050bd3a@axentia.se>
 <7486f4cb-10c9-26ce-83d8-cb346e33e379@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70099.outbound.protection.outlook.com [40.107.7.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DD862667F5
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 09:08:46 +0100 (CET)
In-Reply-To: <7486f4cb-10c9-26ce-83d8-cb346e33e379@linux.intel.com>
Content-Language: en-US
Content-ID: <241DAC96037759408A5A8A37C050FB5D@eurprd02.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Dimitris Papavasiliou <dpapavas@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2019-01-14 18:36, Pierre-Louis Bossart wrote:
> 
>>>   
>>>   		mck_rate = sck_rate;
>>>   	} else {
>>> @@ -1383,6 +1389,16 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>>   	return 0;
>>>   }
>>>   
>>> +static int pcm512x_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
>>> +{
>>> +	struct snd_soc_component *component = dai->component;
>>> +	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
>>> +
>>> +	pcm512x->bclk_ratio = ratio;
>> You should perhaps check if (ratio >= 1 && ratio <= 256) prior to
>> accepting a divider that can't be programmed? But maybe that's enforced
>> somewhere else? And perhaps the sanity check should be even stricter?
> Yes it should be stricter with a power of two only. I tried really hard 
> to make this codec work with ratios of 50 (and a 19.2 MHz mclk) on an Up 
> board and it's just not possible, probably not supported by hardware.

Disallowing anything but powers of two just because 50 doesn't work seems
pretty wild. According to docs I think 48 should work just fine.

Section 8.3.2 Audio Data Interface page 16.
http://www.ti.com/lit/ds/symlink/pcm5142.pdf

Or?

Cheers,
Peter
