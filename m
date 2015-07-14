From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
	rt5645_enable_push_button_irq
Date: Tue, 14 Jul 2015 10:09:44 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
 <20150714095247.GN11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 70BFA260459
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 12:09:53 +0200 (CEST)
In-Reply-To: <20150714095247.GN11162@sirena.org.uk>
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
> Sent: Tuesday, July 14, 2015 5:53 PM
> To: Nicolas Boichat
> Cc: Bard Liao; Oder Chiou; Liam Girdwood; Jaroslav Kysela; Takashi Iwai;
> alsa-devel@alsa-project.org; koro.chen@mediatek.com
> Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
> rt5645_enable_push_button_irq
> 
> On Tue, Jul 14, 2015 at 02:51:25PM +0800, Nicolas Boichat wrote:
> 
> > +		if (codec->component.card->instantiated) {
> > +			snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
> > +			snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
> > +			snd_soc_dapm_sync(dapm);
> > +		} else {
> > +			regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
> > +				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
> > +				RT5645_PWR_ADC_L_BIT |
> RT5645_PWR_ADC_R_BIT);
> > +		}
> 
> I don't understand why this isn't updating the DAPM state if the device is
> not yet instantiated - this means that when the card instantiates the pins
> will be turned off which presumably isn't what you want given the manual
> register map futzing in the else case.  What's going on here?

Thanks for the review. I think what we need is something like
+		snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
+		snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
+		snd_soc_dapm_sync(dapm);
+		if (!codec->component.card->instantiated) {
+			regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
+				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
+				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT);
+		}

> 
> ------Please consider the environment before printing this e-mail.
