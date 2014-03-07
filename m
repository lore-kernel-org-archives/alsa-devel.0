From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3] ASoC: davinci-evm: Add AM43xx-EPOS-EVM
	audio support
Date: Fri, 7 Mar 2014 14:45:27 +0200
Message-ID: <5319BF67.3060403@ti.com>
References: <5315DF41.1090302@metafoo.de>
 <1393947831-26116-1-git-send-email-jsarha@ti.com>
 <20140305014259.GR13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 09287265465
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 13:45:31 +0100 (CET)
In-Reply-To: <20140305014259.GR13126@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lars@metafoo.de, detheridge@ti.com
List-Id: alsa-devel@alsa-project.org

On 03/05/2014 03:42 AM, Mark Brown wrote:
> On Tue, Mar 04, 2014 at 05:43:51PM +0200, Jyri Sarha wrote:
>> Add machine driver support for AM43xx-ePOS-EVM and update associated
>> device tree binding document.
>
> Don't send new patches in replies to the middle of threads, that is just
> confusing and hard to follow.  Send a new series.
>
Ok, won't do that anymore.

>> +/* Logic for EVMs with an aic31xx */
>> +static int evm_aic31xx_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_soc_codec *codec = rtd->codec;
>> +	struct snd_soc_card *card = rtd->card;
>> +	struct snd_soc_dapm_context *dapm = &card->dapm;
>> +	struct device_node *np = card->dev->of_node;
>> +	int ret;
>> +
>> +	snd_soc_dapm_new_controls(dapm, aic31xx_dapm_widgets,
>> +				  ARRAY_SIZE(aic31xx_dapm_widgets));
>> +
>> +	if (np) {
>> +		ret = snd_soc_of_parse_audio_routing(codec->card,
>> +						     "ti,audio-routing");
>> +		if (ret)
>> +			return ret;
>> +	}
>
> Why not add the DAPM widget table to...
>
>> +	{
>> +		.compatible = "ti,am43xx-epos-evm-audio",
>> +		.data = &evm_dai_tlv320aic3111,
>> +	},
>
> ...the data here?
>
> Or alternatively should support for the widgets binding that was
> recently added by added to the kernel - that way the binding becomes
> more general and doesnn't need individual boards adding?  Indeed ideally
> the simple-card binding (which that was added for) could just be used
> for these boards.
>

I got am43x-epos-evm audio working on simple-card directly. I guess we 
can forget about this patch.

However, I think there is a problem with simple-card. It does not invert 
bitclock-master and frame-master values when converting them to CB[SM] 
and CF[SM] for cpu_dai as I think it should. I can get around it by 
setting the both cpu-dai and the codec as bclk and frame masters in the 
sound node. I volunteer to fix this if you agree.

Best regards,
Jyri
