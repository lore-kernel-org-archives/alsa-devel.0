From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ARM: pxa: add support for Raumfeld DDX
Date: Wed, 16 Nov 2011 13:56:47 +0100
Message-ID: <4EC3B30F.60403@gmail.com>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
	<20111115141348.GG3077@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6EC07244CD
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 13:56:54 +0100 (CET)
Received: by bkat8 with SMTP id t8so477561bka.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 04:56:54 -0800 (PST)
In-Reply-To: <20111115141348.GG3077@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 11/15/2011 03:13 PM, Mark Brown wrote:
> On Mon, Nov 07, 2011 at 11:26:02AM +0100, Daniel Mack wrote:
> 
>>  arch/arm/mach-pxa/raumfeld.c |  119 +++++++++++++++++---
>>  sound/soc/pxa/Kconfig        |    2 +
>>  sound/soc/pxa/raumfeld.c     |  249 +++++++++++++++++++++++++++++++++++++++---
> 
> Is there any cross dependency between these bits? 

You're right - I assumed there are, but it seems that I was mistaken.
I'll split this up and re-submit, so it can go trhough appropriate channels.

> I honestly didn't
> notice the ASoC bit in here...

That's at least parially my fault, as something in my work flow crippled
the email addresses in the patch, so git send-email didn't actually put
you on Cc:.

>> index 33ebc46..e6db56a 100644
>> --- a/sound/soc/pxa/Kconfig
>> +++ b/sound/soc/pxa/Kconfig
>> @@ -152,6 +152,8 @@ config SND_SOC_RAUMFELD
>>  	select SND_PXA_SOC_SSP
>>  	select SND_SOC_CS4270
>>  	select SND_SOC_AK4104
>> +	select SND_SOC_STA32X
>> +	select SND_SOC_WM8782
> 
> Is this really a single driver?  Looking at the code it looks like
> there's little if any code sharing between the different machines, it'd
> help with maintainability to have multiple simple drivers.

Hmm. This new version of Raumfeld's hardware features a new ADC and DAC,
and the configuration to use is determined by looking at the system
revision. If this would be split into multiple smaller drivers, there
would be need for a 'master' to dispatch the possible options. I think
I'll do that once the next generation is about to land, and leave it as
it is for now. Ok for you?

> 
>> +	/* PXA DMA cannot do zero extend for 24bit samples,
>> +	* thus only 16bit (two samples packet into 32bit word)
>> +	* or 32bit samples are possible
>> +	*/
>> +	snd_pcm_hw_constraint_mask64(substream->runtime,
>> +				    SNDRV_PCM_HW_PARAM_FORMAT,
>> +				    SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE |
>> +				    SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_S32_BE);
> 
> If the PXA DMA controller can't do 24 bit audio it should be imposing
> this constraint.

Right. Will fix this in the CPU DAI.

>> +static void raumfeld_sta32x_shutdown(struct snd_pcm_substream *substream)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>> +
>> +	/* set freq to 0 to enable all possible codec sample rates */
>> +	snd_soc_dai_set_sysclk(codec_dai, 0, 0, 0);
>> +}
> 
> Are you sure this does the right thing with simultaneous playback and
> record?

Yes, this works fine. We use this code since awhile already.

>> +	fmt = SND_SOC_DAIFMT_I2S |
>> +	      SND_SOC_DAIFMT_NB_NF |
>> +	      SND_SOC_DAIFMT_CBS_CFS;
> 
> Set this using dai_fmt in hte machine driver.

Can you elaborate on this one? I couldn't find an example for this, sorry.


Daniel
