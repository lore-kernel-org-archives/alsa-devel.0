From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v2] ASoC: AK4671: add ak4671 codec driver
Date: Mon, 07 Sep 2009 19:41:58 +0900
Message-ID: <4AA4E376.6000000@samsung.com>
References: <4AA47AE4.9080803@samsung.com>
	<20090907102312.GC29898@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A6D1103822
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 12:42:01 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KPL00AG4KDYOE@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 07 Sep 2009 19:41:58 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KPL00K5QKDYDP@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 07 Sep 2009 19:41:58 +0900 (KST)
In-reply-to: <20090907102312.GC29898@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On 9/7/2009 7:23 PM, Mark Brown wrote:
> On Mon, Sep 07, 2009 at 12:15:48PM +0900, Joonyoung Shim wrote:
> 
>> +static int ak4671_pll_event(struct snd_soc_dapm_widget *w,
>> +		struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	struct snd_soc_codec *codec = w->codec;
>> +	u8 reg;
>> +
>> +	switch (event) {
>> +	case SND_SOC_DAPM_PRE_PMU:
>> +		reg = snd_soc_read(codec, AK4671_PLL_MODE_SELECT1);
>> +		reg |= AK4671_PMPLL;
>> +		snd_soc_write(codec, AK4671_PLL_MODE_SELECT1, reg);
>> +		/* pll lock time: max 40ms */
>> +		mdelay(40);
>> +		break;
>> +	case SND_SOC_DAPM_POST_PMD:
>> +		reg = snd_soc_read(codec, AK4671_PLL_MODE_SELECT1);
>> +		reg &= ~AK4671_PMPLL;
>> +		snd_soc_write(codec, AK4671_PLL_MODE_SELECT1, reg);
>> +		break;
>> +	}
> 
> I think you need some reference counting or a supply widget here since
> this event is there for all the DACs and ADCs:
> 
>> +	/* DAC */
>> +	SND_SOC_DAPM_DAC_E("DAC Left", "Left HiFi Playback",
>> +			AK4671_AD_DA_POWER_MANAGEMENT, 6, 0, ak4671_pll_event,
>> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>> +	SND_SOC_DAPM_DAC_E("DAC Right", "Right HiFi Playback",
>> +			AK4671_AD_DA_POWER_MANAGEMENT, 7, 0, ak4671_pll_event,
>> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>> +
>> +	/* ADC */
>> +	SND_SOC_DAPM_ADC_E("ADC Left", "Left HiFi Capture",
>> +			AK4671_AD_DA_POWER_MANAGEMENT, 4, 0, ak4671_pll_event,
>> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>> +	SND_SOC_DAPM_ADC_E("ADC Right", "Right HiFi Capture",
>> +			AK4671_AD_DA_POWER_MANAGEMENT, 5, 0, ak4671_pll_event,
>> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> 
> This shouldn't be a problem if they all go on or off at once (except for
> the extra latency from waiting for the PLL to go on) but unless I'm
> missing something if capture and playback are stopped independantly I'd
> expect that the PLL will get shut down when the first one happens,
> causing problems for the still active stream.
> 

OK. I was not far-sighted enough to think of that. I will do additional 
try to handle it.

Thanks.
