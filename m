From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
	rt5645_enable_push_button_irq
Date: Wed, 15 Jul 2015 13:03:14 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70108ADD8@RTITMBSV03.realtek.com.tw>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
 <20150714095247.GN11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
 <CANMq1KB_qkH41AiBeMDX6oJVyeOMEi1Tgwoxt9jar0Upqb=L4A@mail.gmail.com>
 <20150715115644.GQ11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B39B260499
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 15:03:21 +0200 (CEST)
In-Reply-To: <20150715115644.GQ11162@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, July 15, 2015 7:57 PM
> To: Nicolas Boichat
> Cc: Bard Liao; Oder Chiou; Liam Girdwood; Jaroslav Kysela; Takashi Iwai;
> alsa-devel@alsa-project.org; koro.chen@mediatek.com
> Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
> rt5645_enable_push_button_irq
> 
> On Wed, Jul 15, 2015 at 07:50:50PM +0800, Nicolas Boichat wrote:
> 
> > > Thanks for the review. I think what we need is something like
> > > +               snd_soc_dapm_force_enable_pin(dapm, "ADC L
> power");
> > > +               snd_soc_dapm_force_enable_pin(dapm, "ADC R
> power");
> > > +               snd_soc_dapm_sync(dapm);
> > > +               if (!codec->component.card->instantiated) {
> > > +                       regmap_update_bits(rt5645->regmap,
> RT5645_PWR_DIG1,
> > > +                               RT5645_PWR_ADC_L_BIT |
> RT5645_PWR_ADC_R_BIT,
> > > +                               RT5645_PWR_ADC_L_BIT |
> RT5645_PWR_ADC_R_BIT);
> > > +               }
> 
> > Just to make sure I understand... With the code above, the dapm state
> > is consistent. However, DAPM will only set the regmap bits when the
> > card is instantiated. So why do we still need to update the regmap? To
> > make sure we do not miss an early jack/button event? Or would we still
> > get jack irq if the pins are enabled a little later? (I guess we can
> > live with missing a button event at that stage, but we need the jack
> > state to be correct)
> 
> I'm assuming it's something to do with early detection, I don't really know
> though.
> 

I think the problem is dapm won't update the bits if card is not
instantiated. And those bits are necessary for the jack or button
detect functions. Without these bits, we may not get irq properly.
That's why we need to update those bits manually.

> 
> ------Please consider the environment before printing this e-mail.
