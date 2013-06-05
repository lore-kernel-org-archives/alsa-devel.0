From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 5 Jun 2013 18:02:13 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB8A8945AF7D@rtitmbs7.realtek.com.tw>
References: <1369983899-13580-1-git-send-email-bardliao@realtek.com>,
 <51AE6166.1020809@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AF15261A42
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 12:02:22 +0200 (CEST)
In-Reply-To: <51AE6166.1020809@wwwdotorg.org>
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
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> On 05/31/2013 01:04 AM, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > * Use regmap_range_cfg to replace index read/write function.
> > * Remove I2S3 related code since there is no I2S3 in ALC5640.
> > * Remove Voice DSP related code since there is no Voice DSP in ALC5640.
> > * Remove MICBIAS2 since there is no MICBIAS2 in ALC5640.
> > * Change DMIC1/2 CLK to DMIC1/2 Power since it is for enable/disable DMIC1/2
> > * Modify some texts for consistent coding style.
> > * Merge sto adc l/r mux since it shares the same control bits.
> > * Other minor changes.
>
> > +static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
>
> > +     /* Input Lines */
> > +     SND_SOC_DAPM_INPUT("DMIC1"),
> > +     SND_SOC_DAPM_INPUT("DMIC2"),
>
> Can you explain that more? In the spec for this part, I don't see any
> DMIC1/2 input pins. Instead, I think they're alternative uses for the
> IN1P/N pins, right?

Yes, DMIC1/2 are alternative uses for the IN1P/N pins.
If you connect it with a DMIC, it will work as a DMIC input.
There are DMIC1/2 component in ALC5640. 
You can see chapter 4.3 Digital Mixer Path in ALC5640 datasheet for reference.
If IN1P/N use as DMIC1/2, the audio path should go through DMIC1/DMIC2.

> In an earlier review, IIRC, Mark had asked you to implement platform
> data to configure whether the microphones were single-ended or not. I
> don't see that in this patch.

Ok, I will implement the microphones type configuration in my patch.
I thought it will be add in the DT patch.

>
> Finally, I really would prefer if you could implement the support for
> the LDO1_EN GPIO via platform data. Getting that right requires a bit of
> knowledge of how set_bias_level() is supposed to work on this CODEC, and
> I think Realtek have the best information to get that right. I'll
> certainly send a patch to implement this all by device tree after that.

I will do that also, if I have question I will ask you.
Thanks.

>
> Anyway, I'll go test this patch and see if it works for me on my HW.
> 
> ------Please consider the environment before printing this e-mail.
