From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: Re: [alsa-devel] [PATCH v2 5/9] ASoC: mediatek: add structure
 define and clock control for 2701
Date: Wed, 8 Jun 2016 09:44:37 +0800
Message-ID: <1465350277.4197.2.camel@mtksdaap41>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
	 <1464929784-5489-6-git-send-email-garlic.tseng@mediatek.com>
	 <20160607161508.GC7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607161508.GC7510@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, koro.chen@mediatek.com, PC.Liao@mediatek.com, ir.lian@mediatek.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-06-07 at 17:15 +0100, Mark Brown wrote:
> On Fri, Jun 03, 2016 at 12:56:20PM +0800, Garlic Tseng wrote:
> 
> > +void mt2701_init_clock(struct mtk_base_afe *afe)
> > +{
> > +	struct mt2701_afe_private *afe_priv = afe->platform_priv;
> > +	int i = 0;
> > +
> > +	for (i = 0; i < MT2701_CLOCK_NUM; i++) {
> > +		afe_priv->clocks[i] = devm_clk_get(afe->dev, aud_clks[i]);
> > +		if (IS_ERR(aud_clks[i]))
> > +			dev_warn(afe->dev, "%s devm_clk_get %s fail\n",
> > +				 __func__, aud_clks[i]);
> > +	}
> > +}
> 
> This looks like we just ignore the error but I'm not seeing anything
> that stops us trying to use the clocks or handle deferred probe?

The probe for platform_driver should fail if the clock error occur.
I'll fix it. Thanks.
