From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Tue, 3 May 2016 17:20:00 +0800
Message-ID: <57286D40.6030002@nuvoton.com>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
 <20160502162715.GK6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FB3E26510C
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 11:20:05 +0200 (CEST)
In-Reply-To: <20160502162715.GK6292@sirena.org.uk>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 5/3/2016 12:27 AM, Mark Brown wrote:
> On Fri, Apr 29, 2016 at 04:15:17PM +0800, John Hsu wrote:
>
>   
>> @@ -614,8 +623,10 @@ int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
>>  		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
>>  		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
>>  
>> -	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
>> -		NAU8825_IRQ_HEADSET_COMPLETE_EN | NAU8825_IRQ_EJECT_EN, 0);
>> +	/* Change jack type detection interruption to non-clock architecture
>> +	 * for power saving less 1mW. Move these configuration about inter-
>> +	 * ruption at auto mode to auto irq setup function.
>> +	 */
>>  
>>     
>
> This comment is about the change you're making to the code rather than
> something that should be in the code.
>
>   
I see and remove it.
>> +	/* Clear all interruption status */
>> +	nau8825_int_status_clear_all(regmap);
>> +
>> +	/* Mask all interruptions except jack insertion interruption */
>> +	regmap_write(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0xfffe);
>>     
>
> So if any other interrupts occur then things will break...
>
>   
The codec only has headset output and its function works when headset is
connected. When headset is not connected, the driver only permit insertion
interruption to happen. After insertion, the internal clock of codec turns
on and all other interruptions just will be enabled. Without clock, the
codec can detect jack insertion only.
>> -	regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq);
>> +	if (regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq)) {
>> +		dev_err(nau8825->dev, "failed to clear interruption\n");
>> +		return IRQ_NONE;
>> +	}
>>     
>
> This is a read, not a write, and it's better to report the error code if
> the read failed.  This should probably be a separate patch.
>
>   
OK, that will be separated to other patch.
>>  static const struct regmap_config nau8825_regmap_config = {
>> -	.val_bits = 16,
>> -	.reg_bits = 16,
>> +	.val_bits = NAU8825_REG_DATA_LEN,
>> +	.reg_bits = NAU8825_REG_ADDR_LEN,
>>     
>
> This appears to be an unrelated change which it's not clear helps the
> reader, these defines only seem to be used in htis one place.
>
>   
We have to check every bits of irq status register value in funciton
nau8825_int_status_clear_all. The definition NAU8825_REG_DATA_LEN is used
in the function to setup the boundary of for loop. There is also register
value width here. Thus, I use the definition in it.

>> @@ -1134,7 +1244,26 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
>>  	struct regmap *regmap = nau8825->regmap;
>>  	int ret;
>>  
>> +	if (!nau8825_is_jack_inserted(nau8825->regmap) &&
>> +		clk_id != NAU8825_CLK_DIS) {
>> +		/* For power saving less 1mW, the jack type detection inter-
>> +		 * ruption changes to non-clock architecture. Therefore, the
>> +		 * clock should be disabled and not allowed to config any clock
>> +		 * when no headset connected.
>> +		 */
>> +		dev_warn(nau8825->dev, "Souldn't enable any clock when no headset connected\n");
>> +		return 0;
>> +	}
>>     
>
> This is ignoring the attempt to set up a clock but returning success
> which is going to break things, printing the warning is dubious (a
> system could be built without detection for example, or a speaker driver
> connected) but probably OK in itself but the fact that we don't tell the
> caller may make things worse.
>
>   
For clear expression, we should print error message and return error to
caller. Is it right?
>> +		nau8825_eject_jack(nau8825);
>> +		snd_soc_jack_report(nau8825->jack, 0, SND_JACK_HEADSET);
>> +	}
>> +	enable_irq(nau8825->irq);
>>     
>
> The interrupt is optional (that bug appears to be already present in the
> driver but should be fixed).
>   
If headset ejection happened when system suspend. After resume, the codec
won't detect the change and no report to the kernel. The application does
not aware the device change and still outputs stream to the headset device.
For the issue, the driver has to notice the application of ejection ever
happened in suspend. Let the application to change its device correctly.
