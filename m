From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: fix interrupt fails and
 unstable after resume
Date: Wed, 30 Mar 2016 17:35:15 +0800
Message-ID: <56FB9DD3.9050503@nuvoton.com>
References: <1458619048-28405-1-git-send-email-KCHSU0@nuvoton.com>
 <CAOV7ByJ_=Mvn6PqR8w5HMJea5LwHqJOd0LPncgHO=6fqfn1-XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 405892665ED
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 11:35:19 +0200 (CEST)
In-Reply-To: <CAOV7ByJ_=Mvn6PqR8w5HMJea5LwHqJOd0LPncgHO=6fqfn1-XA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, Mark Brown <broonie@kernel.org>, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 3/26/2016 8:08 AM, Ben Zhang wrote:
> On Mon, Mar 21, 2016 at 8:57 PM, John Hsu <KCHSU0@nuvoton.com> wrote:
>   
>> Modify power management function to sync behavior with set bias function.
>> And codec needs to config interrupt setting again to recover interrupt.
>>
>> Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
>> ---
>>  sound/soc/codecs/nau8825.c | 70 ++++++++++++++++++++++++++++------------------
>>  1 file changed, 43 insertions(+), 27 deletions(-)
>>
>> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
>> index 106c391..b8af46b 100644
>> --- a/sound/soc/codecs/nau8825.c
>> +++ b/sound/soc/codecs/nau8825.c
>> @@ -1204,6 +1204,42 @@ static int nau8825_set_sysclk(struct snd_soc_codec *codec, int clk_id,
>>         return nau8825_configure_sysclk(nau8825, clk_id, freq);
>>  }
>>
>> +static void nau8825_configure_interrupt(struct nau8825 *nau8825)
>> +{
>> +       struct regmap *regmap = nau8825->regmap;
>> +
>> +       /* IRQ Output Enable */
>> +       regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
>> +               NAU8825_IRQ_OUTPUT_EN, NAU8825_IRQ_OUTPUT_EN);
>> +
>> +       /* Enable internal VCO needed for interruptions */
>> +       nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
>>     
>
> It seems more flexible to let ASoC machine drivers manage
> the sysclk with snd_soc_dai_set_sysclk, instead of force
> switching to the internal VCO clock at resume. Some platforms
> may have external clock available all the time. If a platform
> doesn't supply clock to the codec when there is no active
> playback/capture, but wants jack detection interrupt, the
> machine driver should explicitly request the internal VCO clock.
>
>   
When system bootup or resume, there is usually no clock in system.
It is better to provide the internal clock if codec needs it for the 
interrupt.
I agree that will be flexible if machine driver can control it.
>> +
>> +       /* Enable ADC needed for interrupts
>> +        * It is the same as force_enable_pin("ADC") we do later
>> +        */
>> +       regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
>> +               NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
>>     
>
> The register values for the above irq/clock/adc configurations
> are saved and restored by regcache, so we don't need to set
> them explicitly at every resume.
>
>   
>> +
>> +       /* Chip needs one FSCLK cycle in order to generate interrupts,
>> +        * as we cannot guarantee one will be provided by the system. Turning
>> +        * master mode on then off enables us to generate that FSCLK cycle
>> +        * with a minimum of contention on the clock bus.
>> +        */
>> +       regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
>> +               NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
>> +       regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
>> +               NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
>> +}
>> +
>> +static void nau8825_resume_setup(struct nau8825 *nau8825)
>> +{
>> +       struct regmap *regmap = nau8825->regmap;
>> +
>> +       nau8825_configure_interrupt(nau8825);
>> +       nau8825_restart_jack_detection(regmap);
>> +}
>> +
>>  static int nau8825_set_bias_level(struct snd_soc_codec *codec,
>>                                    enum snd_soc_bias_level level)
>>  {
>> @@ -1233,6 +1269,8 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
>>                                         "Failed to sync cache: %d\n", ret);
>>                                 return ret;
>>                         }
>> +                       if (nau8825->irq)
>> +                               nau8825_resume_setup(nau8825);
>>                 }
>>
>>                 break;
>> @@ -1346,29 +1384,9 @@ static int nau8825_read_device_properties(struct device *dev,
>>
>>  static int nau8825_setup_irq(struct nau8825 *nau8825)
>>  {
>> -       struct regmap *regmap = nau8825->regmap;
>>         int ret;
>>
>> -       /* IRQ Output Enable */
>> -       regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
>> -               NAU8825_IRQ_OUTPUT_EN, NAU8825_IRQ_OUTPUT_EN);
>> -
>> -       /* Enable internal VCO needed for interruptions */
>> -       nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
>> -
>> -       /* Enable ADC needed for interrupts */
>> -       regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
>> -               NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
>> -
>> -       /* Chip needs one FSCLK cycle in order to generate interrupts,
>> -        * as we cannot guarantee one will be provided by the system. Turning
>> -        * master mode on then off enables us to generate that FSCLK cycle
>> -        * with a minimum of contention on the clock bus.
>> -        */
>> -       regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
>> -               NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_MASTER);
>> -       regmap_update_bits(regmap, NAU8825_REG_I2S_PCM_CTRL2,
>> -               NAU8825_I2S_MS_MASK, NAU8825_I2S_MS_SLAVE);
>> +       nau8825_configure_interrupt(nau8825);
>>
>>         ret = devm_request_threaded_irq(nau8825->dev, nau8825->irq, NULL,
>>                 nau8825_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> @@ -1440,24 +1458,22 @@ static int nau8825_i2c_remove(struct i2c_client *client)
>>  #ifdef CONFIG_PM_SLEEP
>>  static int nau8825_suspend(struct device *dev)
>>  {
>> -       struct i2c_client *client = to_i2c_client(dev);
>>         struct nau8825 *nau8825 = dev_get_drvdata(dev);
>> +       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(nau8825->dapm);
>>
>> -       disable_irq(client->irq);
>> +       disable_irq(nau8825->irq);
>> +       snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
>>     
>
> Shouldn't have to force bias off. When there is no force
> enabled ADC/DACs, dapm_power_widgets will power
> the codec off at suspend:
>
> "SAR" can be changed to a dapm supply or micbias widget.
> "DDACR" will be fixed by
> "ASoC: nau8825: change output power for interrupt"
>
>   
The SAR is force enabled when mic detected. It shouldn't be powered down
when suspend. But I think change to supply is a good idea because that
will make codec bias level work normally not always keep bias on.

I think it is necessary to force to set bias off because we need do
something in  bias off case in set bias function. The function
shouldn't affect codec power because power decision is made
by widget connect status or some condition.
>>         regcache_cache_only(nau8825->regmap, true);
>> -       regcache_mark_dirty(nau8825->regmap);
>>
>>         return 0;
>>  }
>>
>>  static int nau8825_resume(struct device *dev)
>>  {
>> -       struct i2c_client *client = to_i2c_client(dev);
>>         struct nau8825 *nau8825 = dev_get_drvdata(dev);
>>
>>         regcache_cache_only(nau8825->regmap, false);
>> -       regcache_sync(nau8825->regmap);
>> -       enable_irq(client->irq);
>> +       enable_irq(nau8825->irq);
>>     
>
> The dev_pm_ops.resume races against nau8825_set_bias_level
> and nau8825_resume_setup. It may be better to use the
> snd_soc_codec_driver.resume so that ASoC core can sync
> everything correctly.
>
>   
Yes, it should be.
>>         return 0;
>>  }
>> --
>> 2.6.4
>>
>>     
>
> Hi John,
>
> I've uploaded "ASoC: nau8825: Fix jack detection across suspend"
> which fixes jack detection and the issues mentioned above.
>
> Thanks,
> Ben
> .
>
>   
I see. Thank you for remind.
