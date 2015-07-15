From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
	rt5645_enable_push_button_irq
Date: Wed, 15 Jul 2015 19:50:50 +0800
Message-ID: <CANMq1KB_qkH41AiBeMDX6oJVyeOMEi1Tgwoxt9jar0Upqb=L4A@mail.gmail.com>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
 <20150714095247.GN11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AE00265A82
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:50:51 +0200 (CEST)
Received: by obre1 with SMTP id e1so24727755obr.1
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 04:50:50 -0700 (PDT)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 14, 2015 at 6:09 PM, Bard Liao <bardliao@realtek.com> wrote:
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie@kernel.org]
>> Sent: Tuesday, July 14, 2015 5:53 PM
>> To: Nicolas Boichat
>> Cc: Bard Liao; Oder Chiou; Liam Girdwood; Jaroslav Kysela; Takashi Iwai;
>> alsa-devel@alsa-project.org; koro.chen@mediatek.com
>> Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
>> rt5645_enable_push_button_irq
>>
>> On Tue, Jul 14, 2015 at 02:51:25PM +0800, Nicolas Boichat wrote:
>>
>> > +           if (codec->component.card->instantiated) {
>> > +                   snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
>> > +                   snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
>> > +                   snd_soc_dapm_sync(dapm);
>> > +           } else {
>> > +                   regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
>> > +                           RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
>> > +                           RT5645_PWR_ADC_L_BIT |
>> RT5645_PWR_ADC_R_BIT);
>> > +           }
>>
>> I don't understand why this isn't updating the DAPM state if the device is
>> not yet instantiated - this means that when the card instantiates the pins
>> will be turned off which presumably isn't what you want given the manual
>> register map futzing in the else case.  What's going on here?
>
> Thanks for the review. I think what we need is something like
> +               snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
> +               snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
> +               snd_soc_dapm_sync(dapm);
> +               if (!codec->component.card->instantiated) {
> +                       regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
> +                               RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
> +                               RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT);
> +               }

Just to make sure I understand... With the code above, the dapm state
is consistent. However, DAPM will only set the regmap bits when the
card is instantiated. So why do we still need to update the regmap? To
make sure we do not miss an early jack/button event? Or would we still
get jack irq if the pins are enabled a little later? (I guess we can
live with missing a button event at that stage, but we need the jack
state to be correct)

Also, I'm going to update rt5645_irq_detection to do nothing if the
codec is not initialized yet (just like rt286.c does). That should be
ok as we call rt5645_irq from rt5645_set_jack_detect, after the codec
is ready, which will update the initial jack status, and setup the
DAPM pins. Does that sound ok?

Thanks!
