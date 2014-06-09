From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5677 CODEC driver
Date: Mon, 9 Jun 2014 05:22:57 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694371336@RTITMBSV03.realtek.com.tw>
References: <1401107553-314-1-git-send-email-oder_chiou@realtek.com>
 <20140601191913.GP5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id EA6452655AB
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 07:23:03 +0200 (CEST)
In-Reply-To: <20140601191913.GP5099@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> > +static int rt5677_set_micbias1_event(struct snd_soc_dapm_widget *w,
> > +	struct snd_kcontrol *kcontrol, int event) {
> > +	struct snd_soc_codec *codec = w->codec;
> > +	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
> > +
> > +	switch (event) {
> > +	case SND_SOC_DAPM_POST_PMU:
> > +		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG2,
> > +			RT5677_PWR_CLK_MB1 | RT5677_PWR_PP_MB1 |
> > +			RT5677_PWR_CLK_MB, RT5677_PWR_CLK_MB1 |
> > +			RT5677_PWR_PP_MB1 | RT5677_PWR_CLK_MB);
> 
> What does this do - I note we never undo this?
> 

We will add a PMD case for this event, thanks.
