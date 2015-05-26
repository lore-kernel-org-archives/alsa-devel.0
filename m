From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [RFC 3/5] ASoC: Add GPIO based jack device
Date: Mon, 25 May 2015 23:20:50 -0700
Message-ID: <CAEUnVG67E0c8QdrgJ9iKuRR+HDVYa02Kg+tK7dyQBwSxCTytZw@mail.gmail.com>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <1432332563-15447-4-git-send-email-dgreid@chromium.org>
 <20150525121120.GJ21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f53.google.com (mail-vn0-f53.google.com
 [209.85.216.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 397F526065A
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 08:21:13 +0200 (CEST)
Received: by vnbf7 with SMTP id f7so6324927vnb.13
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 23:21:12 -0700 (PDT)
In-Reply-To: <20150525121120.GJ21391@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Xing Zheng <zhengxing@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2015 at 5:11 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 22, 2015 at 03:09:21PM -0700, Dylan Reid wrote:
>
>> Add a jack device that allows for separate headphone and mic detect
>> GPIOs.  This device will be used as an aux device and will registered
>> the jack with the card at init time.
>
> This looks basically fine, a couple of things below but they're
> nitpicks.

Thanks for taking a look Mark, and thanks for catching those things.
I'll send an updated version of just this patch on top of your
topic/gpio-jack branch tomorrow morning pacific time.

>
>> +- gpio-audio-jack,debounce-times     : Debounce time for each sw-det-gpio
>> +                                       entry.
>
> specified in...?

That is important info, added.

>
>> +config SND_SOC_GPIO_AUDIO_JACK
>> +        tristate "GPIO based audio jack detection"
>> +
>
> This should surely depend on GPIOLIB || COMPILE_TEST.

indeed, added.

>
>> +     gpio_names = devm_kzalloc(dev, sizeof(*gpio_names) * priv->gpio_count,
>> +                               GFP_KERNEL);
>
> We have devm_kcalloc() (not that it makes a huge difference but may as
> well be clear about the intent).

Good call, done.

>
>> +     if (!gpio_names)
>> +             return -ENOMEM;
>> +     gpio_report = devm_kzalloc(dev, sizeof(*gpio_report) * priv->gpio_count,
>> +                                GFP_KERNEL);
>
> Blank lines between blocks please.

Added.

>
>> +     snd_soc_card_jack_new(component->card, jack_name, report_mask,
>> +                           &priv->jack, NULL, 0);
>
> Ignoring the return value here (not likely to fail but...).

handled.

>
>> +static void gpio_audio_component_remove(struct snd_soc_component *component)
>> +{
>> +     struct gpio_audio_jack *priv = container_of(component->driver,
>> +                     struct gpio_audio_jack, component_drv);
>> +     int i;
>> +
>> +     for (i = 0; i < priv->gpio_count; i++) {
>> +             if (!IS_ERR(priv->gpios[i].desc))
>> +                     gpiod_put(priv->gpios[i].desc);
>> +     }
>
> I would have expected us to be acquiring and releasing the GPIOs in the
> platform device probe, not in the ASoC level probe - that way we handle
> deferred probe better.

That does work better, I moved all the gpio get/put to the device probe. Thanks.

>
>> +static int gpio_audio_jack_probe(struct platform_device *pdev)
>> +{
>> +     struct gpio_audio_jack *priv;
>> +
>> +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     dev_set_drvdata(&pdev->dev, priv);
>> +
>> +     priv->component_drv.probe = gpio_audio_component_probe;
>> +     priv->component_drv.remove = gpio_audio_component_remove;
>> +
>> +     return devm_snd_soc_register_component(&pdev->dev, &priv->component_drv,
>> +                                            NULL, 0);
>
> Why do we allocate a component driver structure per device?

I'm not sure how that happened.  I'll fix it =)

>
>> +static const struct of_device_id gpio_audio_of_match[] = {
>> +     { .compatible = "gpio-audio-jack", },
>
> linux,gpio-audio-jack possibly.  Not entirely sure what the current best
> practice is on that.

Changed.
