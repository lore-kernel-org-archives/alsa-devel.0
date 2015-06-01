From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2 7/9] ASoC: Codec: Add sti platform codec
Date: Mon, 1 Jun 2015 19:41:54 +0200
Message-ID: <556C9962.4040508@st.com>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-8-git-send-email-arnaud.pouliquen@st.com>
 <20150525130124.GS21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 47EBC260654
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 19:41:58 +0200 (CEST)
In-Reply-To: <20150525130124.GS21391@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 05/25/2015 03:01 PM, Mark Brown wrote:
>> +static int  stih407_sas_dac_supply(struct snd_soc_dapm_widget *w,
>> +				   struct snd_kcontrol *kcontrol, int event) {
>> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
>> +	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
>> +	struct sti_dac_audio *dac = &drvdata->dac;
>> +	int ret = 0;
>> +
>> +	switch (event) {
>> +	case SND_SOC_DAPM_PRE_PMU:
>> +		/* Enable analog */
>> +		ret = regmap_field_write(dac->field[STIH407_DAC_STANDBY_ANA],
>> +					 0);
>> +		/* Disable standby */
>> +		if (!ret)
>> +			ret = regmap_field_write(
>> +				dac->field[STIH407_DAC_STANDBY], 0);
>> +		break;
>
> These event functions all look very similar and I can't help but think
> that they look awfully like the sort of register write sequences that
> DAPM normally generates anyway.  Is there any great reason for not doing
> these by registering multiple widgets with routes between them rather
> than with custom code?
>
I need to respect the sequence for power up /power down. for sure I 
could manage it using 3 DAPMs with routes, but how to ensure sequence?
Moreover, i will need to implement a cpu dai DAPM to manage 
uniperipheral clock. This clock need to be enabled/disabled before/after 
DAC to avoid plop. So would prefer to manage the DAC sequence in a 
single function...

>> +static int sti_sas_hw_params(struct snd_pcm_substream *substream,
>> +			     struct snd_pcm_hw_params *params,
>> +			     struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +	int div;
>> +
>> +	div = sti_sas_dai_clk_div[dai->id];
>> +	if (cpu_dai->driver->ops->set_clkdiv)
>> +		return cpu_dai->driver->ops->set_clkdiv(cpu_dai,
>> +							SND_SOC_CLOCK_OUT, div);
>> +	dev_warn(codec->dev, "WARN: CPU DAI not support sysclk div");
>
> This is worrying, we shouldn't be peering inside the CPU DAI like this.
> I'd expect this to either be done autonomously by the CPU DAI or handled
> in a machine driver.
>
I think i misunderstand your remark in V1...but i still not understand 
how you want that i implement it, if i can't neither use 
snd_soc_dai_set_clkdiv (except implement it in simple_card).
Please could you precise how you would like that i implement the feature?

I'm kind surprise that nobody else have this kind of setup. I know at 
least one codec that should need this kind of service: AK4628.
For this codec, depending on runtime frequency, a division value should 
be apply between MCLK and SCLK...
