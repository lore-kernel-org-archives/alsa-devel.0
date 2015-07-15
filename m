From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
 rt5645_enable_push_button_irq
Date: Wed, 15 Jul 2015 09:05:30 +0800
Message-ID: <20150715010530.GA10273@google.com>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
 <20150714095247.GN11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
 <20150714102833.GP11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 98C1826571B
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 03:05:37 +0200 (CEST)
Received: by pdbep18 with SMTP id ep18so15197097pdb.1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 18:05:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150714102833.GP11162@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 14, 2015 at 6:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 14, 2015 at 10:09:44AM +0000, Bard Liao wrote:
>
>> Thanks for the review. I think what we need is something like
>> +             snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
>> +             snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
>> +             snd_soc_dapm_sync(dapm);
>> +             if (!codec->component.card->instantiated) {
>> +                     regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
>> +                             RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
>> +                             RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT);
>> +             }
>
> Yes, that's more what I'd expect.  You could probably just do the regmap
> update unconditionally since it shouldn't make any difference but it's a
> bit neater this way.

rt5645_enable_push_button_irq (where this code is added), is only called
from rt5645_jack_detect, where this kind of pattern is currently common:

if (codec->component.card->instantiated)
	snd_soc_dapm_force_enable_pin(dapm, ...)
else
	regmap_update_bits(...)

Not saying this is right, but if we fix this one we should fix them all.

The problem that I'm trying to solve with this series, is that rt5645->codec
might still be null when rt5645_jack_detect and rt5645_enable_push_button_irq
are first called, so in some cases we do not have a valid dapm pointer yet,
and the test above is modified in 3/3 of the series...

If you look at patch 3/3 of the series, I do something like this, early in
the function:
+       struct snd_soc_dapm_context *dapm = NULL;
+
+       if (rt5645->codec && rt5645->codec->component.card->instantiated) {
+               dapm = snd_soc_codec_get_dapm(rt5645->codec);
+       }

and then use this pattern:

if (dapm)
	snd_soc_dapm_force_enable_pin(dapm, ...)
else
	regmap_update_bits(...)

If guess something like this might be preferable:
if (rt5645->codec) {
	dapm = snd_soc_codec_get_dapm(rt5645->codec);
}

and then:

if (dapm)
	snd_soc_dapm_force_enable_pin(dapm, ...)

regmap_update_bits(...)

Does that make sense?

Is there a better way to communicate my intent in this series? Maybe
patch 1/3 should convert everyhing to this pattern:
snd_soc_dapm_force_enable_pin(dapm, ...)
regmap_update_bits(...)

And then 3/3 would add the if (dapm) tests?

Thanks for the feedback.
