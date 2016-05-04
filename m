From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Allow the SAI driver to
	turn on SAI_MCLK
Date: Wed, 4 May 2016 00:07:01 -0700
Message-ID: <20160504070700.GA12216@Asurada>
References: <1462324173-10976-1-git-send-email-festevam@gmail.com>
 <20160504014432.GA30210@Asurada-Nvidia>
 <CAOMZO5AkctauuaR1DTKexBo4wL=aZL_JLi4nudeZXHTRRo0QMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ADB6260515
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 09:07:11 +0200 (CEST)
Received: by mail-pa0-f41.google.com with SMTP id iv1so20782828pac.2
 for <alsa-devel@alsa-project.org>; Wed, 04 May 2016 00:07:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AkctauuaR1DTKexBo4wL=aZL_JLi4nudeZXHTRRo0QMQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2016 at 11:01:15PM -0300, Fabio Estevam wrote:
> On Tue, May 3, 2016 at 10:44 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> 
> > The field names are literally saying "direction" instead of gating
> > or enabling. So it would make more sense to me that they may also
> 
> Looking in the MX6UL Referece Manual we have the following description
> for these bits:
> 
> 0 - "...output driver is disabled..."
> 
> 1 - "...output driver is enabled..."
> 
> That's why I preferred using 'enabled' in the property name.

I found out the mail from Zidan regarding the same GPR bit:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/096401.html

According to his reply, this bit also controls the clock source of MCLK2
for the SAI. Each SAI has 3 MCLKs, but first disregarding MCLK3:

When this bit gets set, the MCLK1 and MCLK2 of the corresponding SAI are
both getting clock from CCM, and in the meantime outputting the clock via
the PAD to external Codec chips. In this case, MCLK1 and MCLK2 have same
clock rate, nothing special for bit clock dividing.

When this bit gets clear, MCLK1 of the corresponding is still getting its
clock from CCM while MCLK2 switches its source from CCM to the PAD. In this
case, MCLK1 and MCLK2 can have different clock rates so as to support two
sample rate groups: 44.1KHz and 48Khz.

So, beside gating the clock output, it's more likely a clock MUX for MCLK2
of each SAI to switch between CCM and external input.

Because DT property will be hard to change once we define it. I think it
would be better to confirm this first before patching it (with Zidan or
i.MX IC team). But the driver part, whether putting it to probe() or to
set_dai_sysclk(), doesn't matter to me since we can change/improve it
later as long as it follows the correct binding.

Thanks
Nicolin

> 
> I removed Zidan's email from Cc as his email address is no longer valid.
> 
> >> +     if (of_find_property(np, "fsl,sai-enable-mclk", NULL)) {
> >
> > It would safer to have a compatible check here beside mentioning in
> > the DT binding doc.
> 
> In this case I need to add a { .compatible = "fsl,imx6ul-sai", }, entry.
> 
> I can do that.
> 
> > How about:
> >                 regmap_update_bits(gpr, IOMUXC_GPR1,
> >                                    IMX6UL_GPR1_SAIx_MCLK_DIR(index),
> >                                    IMX6UL_GPR1_SAIx_MCLK_DIR(index));
> 
> That's a good idea.
> 
> Will send a v2 tomorrow.
> 
> Thanks
