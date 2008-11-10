From: chri <chripell@gmail.com>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Mon, 10 Nov 2008 20:04:49 +0100
Message-ID: <cabda6420811101104l823d519i8dca6feac86cfa@mail.gmail.com>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D12F2436E
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 20:04:50 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so935008eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 11:04:49 -0800 (PST)
In-Reply-To: <20081110133451.GD12804@sirena.org.uk>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, zdevai@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Nov 10, 2008 at 2:34 PM, Mark Brown <broonie@sirena.org.uk> wrote:
>
> Ideally this should be submitted as multiple patches - at least one for
> the codec and one for the board, probably also one for the l3 interface.
>

ack

>
> Please generate patches against current git - the topic/asoc branch of:
>

ack.

> You should also add this to SND_SOC_ALL_CODECS.  There's a bunch of
> other things like this that have changed between 2.6.27 and the current
> code - for example, the bias level configuration.
>

ack.

>
> There doesn't seem to be much benefit to adding a subdirectory for two
> source files here.
>

ack

>
> Please use the standard pr_debug() macro rather than defining custom
> ones.
>

ack. I was tempted to use pr_debug (and even better dev_dbg) but I
went for the old printk method for uniformity with the rest of the
drivers.

>
> These should be inline functions for type safety.
>

ack

>
> That should probably print the error unconditionally.
>

ack

>> +     switch (uda1341->sysclk / params_rate(params)) {
>
>> +     default:
>> +             return -EINVAL;
>> +             break;
>> +     }
>
> No need for the break here.  It's probably best to log an explicit error
> saying why the failure occurred - otherwise it'll be a bit obscure to
> users what's going on.  A similar comment applies to the other error
> cases.
>

ack

>> +static int uda1341_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>> +                               int clk_id, unsigned int freq, int dir)
>> +{
>
>> +     /* Anything between 256fs*8Khz and 512fs*48Khz should be acceptable
>> +     we'll error out on set_hw_params if it's not OK */
>
> This implies rather more flexibility than actually exists - hw_params()
> requires an exact multiplier here.  You should probably add a note
> explaining that it's up to the machine driver to make sure that the rate
> is OK.
>

ack

>
> There's a typo here.  Also, this and many of the other control names
> don't fit in with the ALSA control name spec so won't be displayed
> correctly by applications.  For example, these should be "Volume" rather
> than "gain", and "switch" should be "Switch".  There's documentation of
> the standard
> names in:
>
>        Documentation/sound/alsa/ControlNames.txt
>

ack. I have to admit that I didn't check the names. I will read this
document and do the changes accordingly

>> +SOC_SINGLE("DAC Gain switch", UDA1341_STATUS1, 6, 1, 0),
>> +SOC_SINGLE("ADC Gain switch", UDA1341_STATUS1, 5, 1, 0),
>
> What exactly do these controls do?  "Gain switch" sounds wrong - I'd not
> expect the gain to be a boolean.
>

they turn on/off an amplifier with 6db gain in the record and playback
respectively.

>> +     pd = (struct uda1341_platform_data *) codec->control_data;
>> +     if (pd->power)
>> +             pd->power(0);
>
> I'd expect that dapm_event() (which is now called set_bias_level())
> would be handling the power callback too.
>

ack

>> +struct snd_soc_codec_device soc_codec_dev_uda1341 = {
>> +     .probe =        uda1341_soc_probe,
>> +     .remove =       uda1341_soc_remove,
>> +#if defined(CONFIG_PM)
>> +     .suspend =      uda1341_soc_suspend,
>> +     .resume =       uda1341_soc_resume,
>> +#endif /* CONFIG_PM */
>
> The standard idiom for this is to have an else defining the functions to
> NULL pointers above and then no ifdef here.
>

ack

>> +     void (*power) (int);
>
> I'd really expect to see this being passed an argument specifying what
> it's interacting with.
>

ack

>> -
>> +
>>  config SND_S3C24XX_SOC_NEO1973_WM8753
>>       tristate "SoC I2S Audio support for NEO1973 - WM8753"
>>       depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA01
>
> Random whitespace change here...
>

ack, sorry for that

>
>> +static int s3c24xx_uda1341_hw_params(struct snd_pcm_substream *substream,
>> +                                       struct snd_pcm_hw_params *params)
>> +{
>
> I can follow this function but it'd be nice to see more comments in
> here.  It looks like you could clarify it by iterating over a table of
> possible clock sources rather than writing each out in code.
>

unfortunately the 2 clock sources are handled differently: PCLK can be
divided, MPLL_in no. So I don't see much convenience in using a
(complicated) table


> It also looks like this should be imposing constraints which prevent the
> configuration of different rates for the DAC and ADC - several existing
> codec drivers like the wm8903 provide examples of doing this.
>

ack

>> +     ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, clk_source , clk,
>> +                                             SND_SOC_CLOCK_IN);
>> +     if (ret < 0)
>> +             return ret;
>
> You want to run this through scripts/checkpatch.pl.
>

I already did it

>> +static void setdat(struct uda1341_platform_data *p, int v)
>> +{
>> +     s3c2410_gpio_setpin(s3c24xx_uda1341_l3_pins->l3_data, v > 0);
>> +     s3c2410_gpio_cfgpin(s3c24xx_uda1341_l3_pins->l3_data,
>> +                         S3C2410_GPIO_OUTPUT);
>> +}
>
> Is there any reason for setting the pins to output mode each time?  It
> looks like you could just configure the mode once at startup and then
> only set the pin status here.

no, I'll clean this up too.

>
>> +static void s3c24xx_uda1341_power(int en)
>> +{
>> +     if (s3c24xx_uda1341_l3_pins->power)
>> +             s3c24xx_uda1341_l3_pins->power(en);
>> +}
>
> This feels like it ought to be initialised conditionally rather than
> having the check for the pin it.
>

It's not clear to me what you mean here.

>> +     ret = platform_device_add(s3c24xx_uda1341_snd_device);
>
>> +     xtal = clk_get(NULL, "xtal");
>> +     pclk = clk_get(NULL, "pclk");
>
> This should be done in the init function for the device and should
> really check the return value in case it can't get the clock for some
> reason.  Ideally there'd be a dev there, but I'd need to check if the
> s3c24xx stuff does that.
>

I'll looka at some other s3c24xx clock user and do the changes.

Thanks,

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
