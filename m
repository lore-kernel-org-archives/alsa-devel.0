From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] ASoC: cs47l15: Add codec driver for
 Cirrus Logic CS47L15
Date: Thu, 25 Jul 2019 14:10:09 +0100
Message-ID: <20190725131009.GZ54126@ediswmail.ad.cirrus.com>
References: <20190725123152.28179-1-ckeepax@opensource.cirrus.com>
 <20190725124732.GA4213@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9C71F8015A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 15:10:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190725124732.GA4213@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 01:47:33PM +0100, Mark Brown wrote:
> On Thu, Jul 25, 2019 at 01:31:51PM +0100, Charles Keepax wrote:
> 
> >  	select SND_SOC_CS47L24 if MFD_CS47L24
> > +	select SND_SOC_CS47L15 if MFD_CS47L15
> >  	select SND_SOC_CS47L35 if MFD_CS47L35
> 
> The Makefile and Kconfig sorting is a bit off.  Please send a followup
> fixing this.
> 

Can do.

> > +static irqreturn_t cs47l15_adsp2_irq(int irq, void *data)
> > +{
> > +	struct cs47l15 *cs47l15 = data;
> > +	struct madera_priv *priv = &cs47l15->core;
> > +	struct madera *madera = priv->madera;
> > +	int ret;
> > +
> > +	ret = wm_adsp_compr_handle_irq(&priv->adsp[0]);
> > +	if (ret == -ENODEV) {
> > +		dev_err(madera->dev, "Spurious compressed data IRQ\n");
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t cs47l15_dsp_bus_error(int irq, void *data)
> > +{
> > +	struct wm_adsp *dsp = (struct wm_adsp *)data;
> > +
> > +	return wm_adsp2_bus_error(dsp);
> > +}
> 
> Noticeable difference in pattern between these two interrupt helpers
> (and makes me wonder why we need the wrappers at all).

Yeah there doesn't seem to be any need for the wrappers.

I will respin the series and fixup these two issues.

Thanks,
Charles
