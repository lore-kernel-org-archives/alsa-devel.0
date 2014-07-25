From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU
 DAI and platform drivers
Date: Fri, 25 Jul 2014 16:42:50 +0800
Message-ID: <20140725084249.GB29564@MrMyself>
References: <cover.1406271541.git.nicoleotsuka@gmail.com>
 <69b75ae4b0335cd3c9bedad67f57aaba13c0048c.1406271541.git.nicoleotsuka@gmail.com>
 <53D208A9.3040903@gmail.com> <20140725075755.GA29564@MrMyself>
 <53D2189E.4030108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 by alsa0.perex.cz (Postfix) with ESMTP id AFEA72610D2
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 10:47:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53D2189E.4030108@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com, lgirdwood@gmail.com, robh+dt@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org, galak@codeaurora.org, grant.likely@linaro.org, tklauser@distanz.ch, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 25, 2014 at 02:13:10PM +0530, Varka Bhadram wrote:
> On 07/25/2014 01:27 PM, Nicolin Chen wrote:
> >>>+	if (IS_ERR(asrc_priv->regmap)) {
> >>>+		dev_err(&pdev->dev, "failed to init regmap\n");
> >>>+		return PTR_ERR(asrc_priv->regmap);
> >>>+	}
> >>>+
> >>>+	irq = platform_get_irq(pdev, 0);
> >>>+	if (irq < 0) {
> >>>+		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
> >>>+		return irq;
> >>>+	}
> >>>+
> >>>+	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
> >>>+			       asrc_priv->name, asrc_priv);
> >>same...
> >Sorry I don't see any problem with this devm_request_irq()...
> 
> Ohhh... This is the problem with my email client... Sorry...

No problem. I appreciate your carefulness :)

Thank you,
Nicolin
