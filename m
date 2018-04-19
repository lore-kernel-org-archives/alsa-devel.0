From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: [PATCH v2 3/5] ASoC: mt6797: add mt6797 platform
	driver
Date: Thu, 19 Apr 2018 09:51:13 +0800
Message-ID: <1524102673.3290.8.camel@mtksdaap41>
References: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
 <20180416003252.4177-4-kaichieh.chuang@mediatek.com>
 <20180418164626.GH10061@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DA8526767A
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 03:51:19 +0200 (CEST)
In-Reply-To: <20180418164626.GH10061@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-04-18 at 17:46 +0100, Mark Brown wrote:
Wants to clarify on few comments, others will be updated in next patch.

> > +		/* turn of mute function */
> > +		dl_src2_con0 |= (0x03 << 11);
> 
> Is there any reason for not implementing this as a mute_stream()
> callback?  That'll keep the DAI muted during startup and before teardown
> which will do the most to avoid any noise making it into the output.

We used to avoid the pop sound from user space by closing hw path from outside to inside.
The control here is just to avoid the state is leaved in muted state.
I'll take a look at the mute_stream() though.

> > +static irqreturn_t mt6797_afe_irq_handler(int irq_id, void *dev)
> > +{
> > +	struct mtk_base_afe *afe = dev;
> > +	struct mtk_base_afe_irq *irq;
> > +	unsigned int status;
> > +	unsigned int mcu_en;
> > +	int ret;
> > +	int i;
> > +
> > +	/* get irq that is sent to MCU */
> > +	regmap_read(afe->regmap, AFE_IRQ_MCU_EN, &mcu_en);
> 
> ...
> 
> > +	/* clear irq */
> > +	regmap_write(afe->regmap,
> > +		     AFE_IRQ_MCU_CLR,
> > +		     status & AFE_IRQ_STATUS_BITS);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> This unconditionally returns IRQ_HANDLED even if we didn't get an
> interrupt - it's better to return IRQ_NONE unless we actually handled
> something since that is more robust if something goes wrong, it lets the
> IRQ core shut up interrupts that get latched on and works with shared
> interrupts if any future designs do that.

this IRQ num is not shared with other module, it's only for audio.
We error handle by clearing the all the irq status again, when
interrupts is sent but status not matched. we consider this handled?

I'm concerned if returing IRQ_NONE, will i no longer be able
to receive irq from this irq line?
Thanks
