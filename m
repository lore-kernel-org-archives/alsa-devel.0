From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 1/2] sound: asoc: Adding support for
	SPEAr13XX ASoC driver
Date: Mon, 21 Mar 2011 16:59:30 +0530
Message-ID: <4D87369A.5030809@st.com>
References: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110317150539.GF31411@opensource.wolfsonmicro.com>
	<4D830768.3040208@st.com>
	<20110318114317.GB14017@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 836FD24422
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 12:32:48 +0100 (CET)
In-Reply-To: <20110318114317.GB14017@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On 3/18/2011 5:13 PM, Mark Brown wrote:
> On Fri, Mar 18, 2011 at 12:49:04PM +0530, rajeev wrote:
>> On 3/17/2011 8:35 PM, Mark Brown wrote:
>>> On Thu, Mar 17, 2011 at 04:53:35PM +0530, Rajeev Kumar wrote:
> 
>>>> +static int spear13xx_i2s_hw_params(struct snd_pcm_substream *substream,
>>>> +		struct snd_pcm_hw_params *params,
>>>> +		struct snd_soc_dai *dai)
>>>> +{
>>>> +	struct spear13xx_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
>>>> +	u32 channel;
> 
>>>> +	channel = params_channels(params);
> 
>>>> +	dev->mode = channel;
> 
>>> Having channel here isn't doing a lot...
> 
>> I was actually planning to expand this routine in future.
>> Should I remove it from the current version?
> 
> It's not too important either way.
>
OK I will remove this function 
 
>>> These constraints don't agree with each other - the rate limits claim to
>>> support 48kHz only, the rates setting tells a different story.
> 
>> At present I checked STA529(codec) only with 48Khz,I need to check with other data rates also.
> 
> It's fine to expand later but you should make sure that if you want to
> say the device currently only works at 48kHz all the constraints say
> that - the issue is the inconsistency.
> 
Ok I will check with rate minimum and rate maximum and update it accordingly.

>>> Rather than passing the channel count through from the I2S driver you
>>> could just get it directly here.
> 
>> Are you talking about this "struct spear13xx_runtime_data *prtd = runtime->private_data"
>> Could you please elaborate little bit more.
> 
> Yes, you're passing through data that doesn't need to be passed through
> since the DMA driver gets a hw_params() call too.
> .
>
Keeping a copy of substream in struct spear13xx_runtime_data as implementation is base on tasklet.Need to extract
this  prtd->substream before dma submit. 

Best Regards
Rajeev
