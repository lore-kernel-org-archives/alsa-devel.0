From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V3 1/3] ASoC: fsl_esai: spba clock is
 needed by esai device
Date: Wed, 25 Nov 2015 10:02:32 +0800
Message-ID: <20151125020229.GA26087@shlinux2>
References: <cover.1448348336.git.shengjiu.wang@freescale.com>
 <37808c01df126622c41c2d413fddf838dc2aa71d.1448348336.git.shengjiu.wang@freescale.com>
 <20151124232130.GA3400@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0114.outbound.protection.outlook.com [207.46.100.114])
 by alsa0.perex.cz (Postfix) with ESMTP id E5557261586
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 03:05:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151124232130.GA3400@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com, timur@tabi.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, broonie@kernel.org, galak@codeaurora.org, tiwai@suse.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 05:21:30PM -0600, Rob Herring wrote:
> On Tue, Nov 24, 2015 at 03:03:28PM +0800, Shengjiu Wang wrote:
> > ESAI need to enable the spba clock, when sdma is using share peripheral
> > script. In this case, there is two spba master port is used, if don't
> > enable the clock, the spba bus will have arbitration issue, which may
> > cause read/write wrong data from/to ESAI registers.
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,esai.txt |  5 +++++
> 
> Acked-by: Rob Herring <robh@kernel.org>

Hi Mark, Rob

   Just a reminder. There is V4 for this patch set. I think the "Acked-by:" is
for the V4. Thanks.

best regards
wang shengjiu

> 
> >  sound/soc/fsl/fsl_esai.c                             | 13 +++++++++++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> > index d3b6b5f..cd3ee5d 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> > @@ -27,6 +27,11 @@ Required properties:
> >  			  derive HCK, SCK and FS.
> >  	"fsys"		  The system clock derived from ahb clock used to
> >  			  derive HCK, SCK and FS.
> > +	"spba"		  The spba clock is required when ESAI is placed as a
> > +			  bus slave of the Shared Peripheral Bus and when two
> > +			  or more bus masters (CPU, DMA or DSP) try to access
> > +			  it. This property is optional depending on the SoC
> > +			  design.
> >  
> >    - fsl,fifo-depth	: The number of elements in the transmit and receive
> >  			  FIFOs. This number is the maximum allowed value for
> > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> > index 504e731..4d7589c 100644
> > --- a/sound/soc/fsl/fsl_esai.c
> > +++ b/sound/soc/fsl/fsl_esai.c
> > @@ -35,6 +35,7 @@
> >   * @coreclk: clock source to access register
> >   * @extalclk: esai clock source to derive HCK, SCK and FS
> >   * @fsysclk: system clock source to derive HCK, SCK and FS
> > + * @spbaclk: SPBA clock (optional, depending on SoC design)
> >   * @fifo_depth: depth of tx/rx FIFO
> >   * @slot_width: width of each DAI slot
> >   * @slots: number of slots
> > @@ -54,6 +55,7 @@ struct fsl_esai {
> >  	struct clk *coreclk;
> >  	struct clk *extalclk;
> >  	struct clk *fsysclk;
> > +	struct clk *spbaclk;
> >  	u32 fifo_depth;
> >  	u32 slot_width;
> >  	u32 slots;
> > @@ -469,6 +471,9 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
> >  	ret = clk_prepare_enable(esai_priv->coreclk);
> >  	if (ret)
> >  		return ret;
> > +	ret = clk_prepare_enable(esai_priv->spbaclk);
> > +	if (ret)
> > +		goto err_spbaclk;
> >  	if (!IS_ERR(esai_priv->extalclk)) {
> >  		ret = clk_prepare_enable(esai_priv->extalclk);
> >  		if (ret)
> > @@ -499,6 +504,8 @@ err_fsysclk:
> >  	if (!IS_ERR(esai_priv->extalclk))
> >  		clk_disable_unprepare(esai_priv->extalclk);
> >  err_extalck:
> > +	clk_disable_unprepare(esai_priv->spbaclk);
> > +err_spbaclk:
> >  	clk_disable_unprepare(esai_priv->coreclk);
> >  
> >  	return ret;
> > @@ -564,6 +571,7 @@ static void fsl_esai_shutdown(struct snd_pcm_substream *substream,
> >  		clk_disable_unprepare(esai_priv->fsysclk);
> >  	if (!IS_ERR(esai_priv->extalclk))
> >  		clk_disable_unprepare(esai_priv->extalclk);
> > +	clk_disable_unprepare(esai_priv->spbaclk);
> >  	clk_disable_unprepare(esai_priv->coreclk);
> >  }
> >  
> > @@ -819,6 +827,11 @@ static int fsl_esai_probe(struct platform_device *pdev)
> >  		dev_warn(&pdev->dev, "failed to get fsys clock: %ld\n",
> >  				PTR_ERR(esai_priv->fsysclk));
> >  
> > +	esai_priv->spbaclk = devm_clk_get(&pdev->dev, "spba");
> > +	if (IS_ERR(esai_priv->spbaclk))
> > +		dev_warn(&pdev->dev, "failed to get spba clock: %ld\n",
> > +				PTR_ERR(esai_priv->spbaclk));
> > +
> >  	irq = platform_get_irq(pdev, 0);
> >  	if (irq < 0) {
> >  		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
> > -- 
> > 1.9.1
> > 
