From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
	rt5645_enable_push_button_irq
Date: Thu, 16 Jul 2015 11:05:56 +0800
Message-ID: <CANMq1KAtbqmf-3gB+QKtbWMOK45tw6=3VTYyN1rkn12DaoDDdQ@mail.gmail.com>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
 <20150714095247.GN11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
 <CANMq1KB_qkH41AiBeMDX6oJVyeOMEi1Tgwoxt9jar0Upqb=L4A@mail.gmail.com>
 <20150715115644.GQ11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108ADD8@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A83A260524
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 05:05:58 +0200 (CEST)
Received: by oige126 with SMTP id e126so41992646oig.0
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 20:05:57 -0700 (PDT)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70108ADD8@RTITMBSV03.realtek.com.tw>
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

On Wed, Jul 15, 2015 at 9:03 PM, Bard Liao <bardliao@realtek.com> wrote:
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie@kernel.org]
>> Sent: Wednesday, July 15, 2015 7:57 PM
>> To: Nicolas Boichat
>> Cc: Bard Liao; Oder Chiou; Liam Girdwood; Jaroslav Kysela; Takashi Iwai;
>> alsa-devel@alsa-project.org; koro.chen@mediatek.com
>> Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
>> rt5645_enable_push_button_irq
>>
>> On Wed, Jul 15, 2015 at 07:50:50PM +0800, Nicolas Boichat wrote:
>>
>> > > Thanks for the review. I think what we need is something like
>> > > +               snd_soc_dapm_force_enable_pin(dapm, "ADC L
>> power");
>> > > +               snd_soc_dapm_force_enable_pin(dapm, "ADC R
>> power");
>> > > +               snd_soc_dapm_sync(dapm);
>> > > +               if (!codec->component.card->instantiated) {
>> > > +                       regmap_update_bits(rt5645->regmap,
>> RT5645_PWR_DIG1,
>> > > +                               RT5645_PWR_ADC_L_BIT |
>> RT5645_PWR_ADC_R_BIT,
>> > > +                               RT5645_PWR_ADC_L_BIT |
>> RT5645_PWR_ADC_R_BIT);
>> > > +               }
>>
>> > Just to make sure I understand... With the code above, the dapm state
>> > is consistent. However, DAPM will only set the regmap bits when the
>> > card is instantiated. So why do we still need to update the regmap? To
>> > make sure we do not miss an early jack/button event? Or would we still
>> > get jack irq if the pins are enabled a little later? (I guess we can
>> > live with missing a button event at that stage, but we need the jack
>> > state to be correct)
>>
>> I'm assuming it's something to do with early detection, I don't really know
>> though.
>>
>
> I think the problem is dapm won't update the bits if card is not
> instantiated. And those bits are necessary for the jack or button
> detect functions. Without these bits, we may not get irq properly.
> That's why we need to update those bits manually.

Understood: when !card->instantiated, snc_soc_dapm_sync is a noop.
However, state of the pins set by snd_soc_dapm_force_enable_pin are
still recorded.
Then, when the card is instantiated
(snd-core.c:snd_soc_instantiate_card), snd_soc_dapm_sync is called,
and the regmap bits get updated.

For the push button case, we can afford to wait until the card is
instantiated (we might lose very early button detection, probably not
a big deal...), so we do not need to change anything in
rt5645_enable_push_button_irq.

However, for the mic detection case, in the jack-in case, we need to
set these bits immediately, as the driver wants to report immediately
(e.g. after ~550ms) whether we detected a headset or just a headphone
(in rt5645_jack_detect).

But the jack-out case, and disabling "Mic Det Power" after jack type
detection, can probably wait until the card is instantiated.

Good thing is, this problem is now independent from the kernel panic
issue, so I'll send separate patches.
