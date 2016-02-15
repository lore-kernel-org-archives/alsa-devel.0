From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC v2 3/6] ASoC: core: add code to complete dai
 init after pcm creation
Date: Mon, 15 Feb 2016 11:39:13 +0100
Message-ID: <56C1AAD1.1040609@st.com>
References: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
 <1453484912-24547-4-git-send-email-arnaud.pouliquen@st.com>
 <56B4723B.4000505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 6F98A261480
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 11:39:20 +0100 (CET)
In-Reply-To: <56B4723B.4000505@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org



On 02/05/2016 10:58 AM, Jyri Sarha wrote:
> On 01/22/16 19:48, Arnaud Pouliquen wrote:
>> Some Controls defined in DAI need to be associated to PCM device (e.g. IEC60958).
>>
>> This allows to perform post initialization in DAI after PCM device creation.
>>
> 
> Sorry for my late reaction to this series (I was on vacation)...
Same issue for me last week ;-)

> 
> I do not follow why you need this? The rest of the codecs create their 
> mixer elements in static struct snd_soc_codec_driver's probe-callback. I 
> can not see why it could not be used with hdmi-codec (then again I have 
> not tried it).
Some controls like 'IEC958 Playback Default' can need to be indexed on
the PCM device. As example on my board i have a SPDIF and a HDMI out.
Both handle IEC60958. Today, there is not way (or as said, i miss
something) to get PCM device information at DAI level to be able to
index on PCM device.
Aim of this patch is to allow to perform post DAI initialization on PCM
device creation, with PCM runtime information.

> 
> I'll try to test the patches that affects my Beaglebone-black hdmia 
> audio series anyway, I just need to rebase my branch in order to apply 
> this patch. For some reason "ASoc: hdmi-codec: add IEC control." did not 
> apply out of the box either...
> 
> Best regards,
> Jyri
> 
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>   include/sound/soc-dai.h |  7 +++++++
>>   sound/soc/soc-core.c    | 14 ++++++++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>> index 964b7de..6969c83 100644
>> --- a/include/sound/soc-dai.h
>> +++ b/include/sound/soc-dai.h
>> @@ -205,6 +205,13 @@ struct snd_soc_dai_ops {
>>   	 */
>>   	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
>>   		struct snd_soc_dai *);
>> +
>> +	/*
>> +	 * function called by soc_probe_link_dais to post initialize DAI
>> +	 * after pcm device creation.
>> +	 * As example, can be used to link a controls to the pcm device
>> +	 */
>> +	int (*pcm_new)(struct snd_soc_pcm_runtime *, struct snd_soc_dai *);
>>   };
>>
>>   /*
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 790ee2b..cf1d312 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -1587,6 +1587,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>>   {
>>   	struct snd_soc_dai_link *dai_link = rtd->dai_link;
>>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +	const struct snd_soc_dai_ops *ops;
>>   	int i, ret;
>>
>>   	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
>> @@ -1662,6 +1663,19 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>>   		}
>>   	}
>>
>> +	for (i = 0; i < rtd->num_codecs; i++) {
>> +		ops = rtd->codec_dais[i]->driver->ops;
>> +		if (ops->pcm_new)
>> +			ret = ops->pcm_new(rtd, rtd->codec_dais[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	ops = cpu_dai->driver->ops;
>> +	if (ops->pcm_new)
>> +		ret = ops->pcm_new(rtd, rtd->codec_dais[i]);
>> +	if (ret)
>> +		return ret;
>> +
>>   	return 0;
>>   }
>>
>>
> 
