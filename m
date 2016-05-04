From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Allow the SAI driver to
	turn on SAI_MCLK
Date: Wed, 4 May 2016 09:17:11 -0300
Message-ID: <CAOMZO5CX5t4H5qVpB+e6tbEGgPR+nStArKuEtk+D0QapyzfOGA@mail.gmail.com>
References: <1462324173-10976-1-git-send-email-festevam@gmail.com>
 <20160504014432.GA30210@Asurada-Nvidia>
 <CAOMZO5AkctauuaR1DTKexBo4wL=aZL_JLi4nudeZXHTRRo0QMQ@mail.gmail.com>
 <20160504070700.GA12216@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C154262607
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 14:17:12 +0200 (CEST)
Received: by mail-io0-f169.google.com with SMTP id d62so51642027iof.2
 for <alsa-devel@alsa-project.org>; Wed, 04 May 2016 05:17:12 -0700 (PDT)
In-Reply-To: <20160504070700.GA12216@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Wed, May 4, 2016 at 4:07 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> I found out the mail from Zidan regarding the same GPR bit:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/096401.html
>
> According to his reply, this bit also controls the clock source of MCLK2
> for the SAI. Each SAI has 3 MCLKs, but first disregarding MCLK3:
>
> When this bit gets set, the MCLK1 and MCLK2 of the corresponding SAI are
> both getting clock from CCM, and in the meantime outputting the clock via
> the PAD to external Codec chips. In this case, MCLK1 and MCLK2 have same
> clock rate, nothing special for bit clock dividing.
>
> When this bit gets clear, MCLK1 of the corresponding is still getting its
> clock from CCM while MCLK2 switches its source from CCM to the PAD. In this
> case, MCLK1 and MCLK2 can have different clock rates so as to support two
> sample rate groups: 44.1KHz and 48Khz.
>
> So, beside gating the clock output, it's more likely a clock MUX for MCLK2
> of each SAI to switch between CCM and external input.

At imx6ul.dtsi the mclk2 and mclk3 are just dummy clocks.

> Because DT property will be hard to change once we define it. I think it
> would be better to confirm this first before patching it (with Zidan or
> i.MX IC team). But the driver part, whether putting it to probe() or to
> set_dai_sysclk(), doesn't matter to me since we can change/improve it
> later as long as it follows the correct binding.

Also tried Zidan's NXP email and it also bounced, so not able to contact him.

Also don't have any contact with the audio folks in the i.MX IC team.

This binding is all about setting IMX6UL_GPR1_SAIx_MCLK_DIR or not.

So this is a very simple case:

IMX6UL_GPR1_SAIx_MCLK_DIR = 0 (this is the current behaviour)

IMX6UL_GPR1_SAIx_MCLK_DIR = 1 (this is what this patch allows)

I cannot see why this proposed binding would possibly break things or
would need a change in the future.

It's only purpose is to simply set IMX6UL_GPR1_SAIx_MCLK_DIR.

Regards,

Fabio Estevam
