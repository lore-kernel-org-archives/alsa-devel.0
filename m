From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_spdif: Fix clock source for
 rxclk rate measurement
Date: Mon, 28 Apr 2014 10:54:13 +0800
Message-ID: <20140428025410.GA27191@MrMyself>
References: <cover.1398427055.git.Guangyu.Chen@freescale.com>
 <cbeb07fbdadd7bf72f74224d5ad12c9706376c95.1398427055.git.Guangyu.Chen@freescale.com>
 <20140425161015.GQ12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C25526087D
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 04:54:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140425161015.GQ12304@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2014 at 05:10:15PM +0100, Mark Brown wrote:
> On Fri, Apr 25, 2014 at 07:58:19PM +0800, Nicolin Chen wrote:
> 
> > +	/* Get system clock for rx clock rate calculation */
> > +	sprintf(tmp, "rxtx%d", SPDIF_CLK_SRC_SYSCLK);
> > +	spdif_priv->sysclk = devm_clk_get(&pdev->dev, tmp);
> > +	if (IS_ERR(spdif_priv->sysclk)) {
> > +		dev_err(&pdev->dev, "no sys clock (%s) in devicetree\n", tmp);
> > +		return PTR_ERR(spdif_priv->sysclk);
> > +	}
> > +
> 
> Why is this not just a fixed string - it seems like the clock name is a
> constant anyway?

For current version, yes, it always ties system clock to rxtx5. I was just
considering if further version changes the sysclk route to another source,
the driver will simply diversify this id here for different versions.

I'll later send a v2 for it to fix the name. And you can decide which one
would be better based on what I've just explained.

Thank you,
Nicolin
