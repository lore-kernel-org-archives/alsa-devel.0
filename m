From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: Power up the RC clock to
	make sure the speaker volume adjust properly
Date: Fri, 6 Nov 2015 02:52:36 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694FA2BE6@RTITMBSV03.realtek.com.tw>
References: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
 <20151105121230.GD18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id F1C30265887
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 03:52:41 +0100 (CET)
In-Reply-To: <20151105121230.GD18409@sirena.org.uk>
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
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> > +static int rt5645_spk_put_volsw(struct snd_kcontrol *kcontrol,
> > +		struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> > +	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
> > +	int ret;
> > +
> > +	cancel_delayed_work_sync(&rt5645->rcclock_work);
> > +
> > +	regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
> > +		RT5645_PWR_CLK25M_MASK, RT5645_PWR_CLK25M_PU);
> > +
> > +	ret = snd_soc_put_volsw(kcontrol, ucontrol);
> > +
> > +	queue_delayed_work(system_power_efficient_wq, &rt5645->rcclock_work,
> > +		msecs_to_jiffies(200));
> 
> A more idiomatic way of doing this is to just have the
> queue_delayed_work() - there's no need to cancel a work item before
> requeuing it, the workqueue code will do the right thing.  Can you
> please submit a followup patch cleaning that up?
> 
Thank you for the kind advice. The "cancel_delayed_work_sync" is essential
in case of the operation of kcontrol continuously. We want to make sure the
RC clock can be powered up at least 200ms after the speaker volume is
adjusted, so we add the "cancel_delayed_work_sync" on the top of the
function and requeue it, thanks.
