From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Add support Voice DAI
Date: Mon, 20 Apr 2009 14:31:03 +0900
Message-ID: <49EC0897.5060007@samsung.com>
References: <49DDFE1D.3090009@samsung.com>
	<200904141007.52528.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id D6CBF24418
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 07:31:50 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KID00K62WNROF@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 20 Apr 2009 14:31:03 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KID004U6WNRYW@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 20 Apr 2009 14:31:03 +0900 (KST)
In-reply-to: <200904141007.52528.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 4/14/2009 4:07 PM, Peter Ujfalusi wrote:
> On Thursday 09 April 2009 16:54:37 ext Joonyoung Shim wrote:
>> Add Voice DAI to support the PCM voice interface of the twl4030 codec.
>>
>> The PCM voice interface can be used with 8-kHz(voice narrowband) or 16-kHz
>> (voice wideband) sampling rates, and 16bits, and mono RX and mono TX or
>> stereo TX.
>>
>> If the system master clock is not 26MHz, the voice PCM interface is not
>> available.
>>
>> The PCM voice interface has two modes
>> - PCM mode1 : This uses the rising edge of the clock signal
>> - PCM mode2 : This uses the falling edge of the clock signal
>>
>> PCM mode1 and mode2 have a look of DSP_A and DSP_B, so we used DSP_A and
>> DSP_B.
> 
> Both of the PCM mode1 and mode2 is actually DSP_A, but the FS polarity is 
> inverted and also the data is shifted/sampled on the opposite edge of the 
> bitclock.

So, I will use that the PCM mode1 is SND_SOC_DAIFMT_IB_NF and PCM mode2 is
SND_SOC_DAIFMT_NB_IF. Is this right?

> 
>> +static int twl4030_voice_startup(struct snd_pcm_substream *substream,
>> +				struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_device *socdev = rtd->socdev;
>> +	struct snd_soc_codec *codec = socdev->card->codec;
>> +	u8 infreq;
>> +
>> +	/* If the system master clock is not 26MHz, the voice PCM interface is
>> +	 * not avilable.
>> +	 */
>> +	infreq = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL)
>> +		& TWL4030_APLL_INFREQ;
>> +
>> +	if (infreq != TWL4030_APLL_INFREQ_26000KHZ)
>> +		return -EPERM;
> 
> Would it be feasible to add a check here against the CODEC_MODE:OPT_MODE and 
> if the codec is not in Option2 mode, than return with error?

Ok, it's good, i will add.
Thanks.

> 
> 
