From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Add support Voice DAI
Date: Fri, 10 Apr 2009 11:03:42 +0900
Message-ID: <49DEA8FE.8010700@samsung.com>
References: <49DDFE1D.3090009@samsung.com>
	<20090409140654.GC18152@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id E17241037F5
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Apr 2009 04:03:56 +0200 (CEST)
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KHV00MS04E654@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 10 Apr 2009 11:03:42 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KHV00FSF4E6AC@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 10 Apr 2009 11:03:42 +0900 (KST)
In-reply-to: <20090409140654.GC18152@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, kyungmin.park@samsung.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

On 4/9/2009 11:06 PM, Mark Brown wrote:
> On Thu, Apr 09, 2009 at 10:54:37PM +0900, Joonyoung Shim wrote:
> 
>> The PCM voice interface has two modes
>> - PCM mode1 : This uses the rising edge of the clock signal
>> - PCM mode2 : This uses the falling edge of the clock signal
> 
>> PCM mode1 and mode2 have a look of DSP_A and DSP_B, so we used DSP_A and
>> DSP_B.
> 
> That sounds wrong - the difference between modes A and B is an extra
> cycle on BCLK after LRP, not the polarity of the signal.  I'd expect
> that it should be one or the other of these modes with the option to
> invert BCLK.

Oh, i see. I will use "DAI hardware signal inversions" defines.

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
>> +
>> +	return 0;
>> +}
> 
> It's probably worth a comment here telling users that they'll need to
> call set_sysclk() in their init() function rather than hw_params() -
> otherwise this might get called before the clock is set up.

It seems better that i remove startup function and add set_sysclk function,
and inform supporting only 26MHz system master clock through comment. 
i think it is not important where set_sysclk() is called, the voice PCM
interface needs just 26MHz system master clock.

> 
>> +		/* change rate and set CODECPDZ */
>> +		twl4030_codec_enable(codec, 0);
>> +		twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
>> +		twl4030_codec_enable(codec, 1);
> 
> Hrm.  This codec_enable() call looks fishy - what's the effect if the
> other DAI is running when the voice DAI is configured?  Though there may
> be no way round this...

Frankly, i don't know whether this codec_enable() is called. The existing
the HIFI DAI calls this codec_enable().
If this call is unnecessary i think it seems better to remove it.

> 
>> +struct snd_soc_dai twl4030_dai[] = {
>> +{	.name = "twl4030",
> 
> The { should ideally be on a line by itself (for both DAIs).


Ok, i will fix it.

Thanks for you review.
