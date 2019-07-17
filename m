From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: add i.MX8M support
Date: Wed, 17 Jul 2019 18:06:01 +0300
Message-ID: <CAEnQRZB96Q4stM4JsJskMhdH-7ktbc-QxPeibNOLHEXghtS-1w@mail.gmail.com>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-4-l.stach@pengutronix.de>
 <CAEnQRZCCTwMJKQnvP2mSQPcKNwtoAaMdXmQt_H+CGro=zVLsNA@mail.gmail.com>
 <1563374027.2676.18.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76A78F800C2
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 17:06:14 +0200 (CEST)
Received: by mail-wm1-x342.google.com with SMTP id v19so22547859wmj.5
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 08:06:14 -0700 (PDT)
In-Reply-To: <1563374027.2676.18.camel@pengutronix.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Angus Ainslie <angus@akkea.ca>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 17, 2019 at 5:33 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Daniel,
>
> Am Mittwoch, den 17.07.2019, 17:16 +0300 schrieb Daniel Baluta:
> > > On Wed, Jul 17, 2019 at 1:59 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > The SAI block on the i.MX8M moved the register layout, as 2 version
> > > registers were added at the start of the register map. We deal with
> > > this by moving the start of the regmap, so both register layouts
> > > look the same to accesses going through the regmap.
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >
> > This is a little bit tricky. We need the verid register in order
> > to differentiate IPs which can support 1:1 ratio for bclk:mclk
>
> And this patch doesn't prevent this usage. If needed we can just read
> the verid via a plain readl on the base mapping in the probe function
> and cache it in struct fsl_sai. This seems way less intrusive than
> carrying a register offset through all of the regmap accessors and
> validation functions. I simply haven't implemented it in this patch, as
> I had no need for it right now.

I must admit this is a very clever idea! Anyhow, I'm having some concerns
because unfortunately not all registers were shifted by 8 bytes.

See: imx6sx [1] (page 3575)  and imx8X [2] (page 5512) RMs.

We have something like this:

i.mx6 SX:

00: TCSR
04: TCR1
08: TCR2
0C: TCR3
....
60: TMR
80: RCSR

i.mx 8X

00: VERID
04: PARAM
08: TCSR
0C: TCR1
...
60: TMR
88: RCSR

[1] https://cache.nxp.com/secured/assets/documents/en/reference-manual/IMX6SXRM.pdf?__gda__=1563382650_d60ad6189b2431a35a0757ffc87cfb3f&fileExt=.pdf
[2] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
