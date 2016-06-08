From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: Re: [alsa-devel] [PATCH v2 6/9] ASoC: mediatek: add mt2701 platform
 driver implementation.
Date: Wed, 8 Jun 2016 11:32:22 +0800
Message-ID: <1465356742.18601.7.camel@mtksdaap41>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
	 <1464929784-5489-7-git-send-email-garlic.tseng@mediatek.com>
	 <20160607163112.GD7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607163112.GD7510@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, tiwai@suse.de, linux-kernel@vger.kernel.org, koro.chen@mediatek.com, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-06-07 at 17:31 +0100, Mark Brown wrote:
> On Fri, Jun 03, 2016 at 12:56:21PM +0800, Garlic Tseng wrote:
> 
> > +	if (val < 0 || val > MT2701_I2S_NUM) {
> > +		dev_err(afe->dev, "%s, num not available, num %d, val %d\n",
> > +			__func__, num, val);
> > +		return -1;
> 
> Real error codes please.

OK I'll fix it.

> 
> > +static const struct snd_kcontrol_new mt2701_afe_multi_ch_out_asrc3[] = {
> > +	SOC_DAPM_SINGLE_AUTODISABLE("Multi ch asrc out3", PWR2_TOP_CON, 7, 1,
> > +				    1),
> > +};
> 
> On/off controls should end in Switch.

Do you means that the name should end in Switch? Something like "Multi
ch asrc out3 Switch" (or maybe a shorter one)

I'll fix it (if I don't misunderstand the comment)

Thanks!

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
