From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: Re: [PATCH v5 6/9] ASoC: mediatek: add mt2701 platform
 driver implementation.
Date: Thu, 30 Jun 2016 21:39:41 +0800
Message-ID: <1467293981.17087.18.camel@mtksdaap41>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-7-git-send-email-garlic.tseng@mediatek.com>
 <20160629191322.GT6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 010682651DB
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 15:40:04 +0200 (CEST)
In-Reply-To: <20160629191322.GT6247@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, tiwai@suse.de, koro.chen@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-06-29 at 20:13 +0100, Mark Brown wrote:
> On Fri, Jun 17, 2016 at 03:43:57PM +0800, Garlic Tseng wrote:
> 
> > +static int mt2701_afe_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id,
> > +				     int div)
> > +{
> 
> Why are we adding a set_clkdiv() operation?  I would expect the driver
> to be able to figure things out automatically.
> 
> > +	case DIV_ID_MCLK_TO_BCK:
> > +		afe_priv->i2s_path[i2s_num].div_mclk_to_bck = div;
> > +		break;
> > +	case DIV_ID_BCK_TO_LRCK:
> > +		afe_priv->i2s_path[i2s_num].div_bck_to_lrck = div;
> > +		break;
> 
> Especially in the case where we're configuring LRCLK, that's trivial
> when we know the sample rate which we have to know anyway.

Oh... actually I want to say 'div_mclk_over_bck' and 'div_bck_over_lrck'
I'll fix the naming if we decide to reserve the set_clkdiv() operation.

For div_bck_over_lrck, yes we only support bck = 64fs now so I'll remove
it. Maybe in the future we'll allow bck = 32fs for some board and I'll
send patch on that time.

For div_mclk_over_bck, mt2635 can offer 128fs and 256fs mclk to codec,
and it depends on the board so I tend to let machine driver configure
it. However, maybe changing it to div_mclk_over_lrck will be better.
I'll do the change.

BTW, some patch is applied for the patchset so I need not to send the
new version but send another patchset, right?


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
