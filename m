From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: add i.MX8M support
Date: Thu, 18 Jul 2019 11:35:37 +0300
Message-ID: <CAEnQRZDZ11LSK62qCYq9VuDRBtWrbgbooDFa6A7DV=Z2ftTq-g@mail.gmail.com>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-4-l.stach@pengutronix.de>
 <CAEnQRZCCTwMJKQnvP2mSQPcKNwtoAaMdXmQt_H+CGro=zVLsNA@mail.gmail.com>
 <1563374027.2676.18.camel@pengutronix.de>
 <CAEnQRZB96Q4stM4JsJskMhdH-7ktbc-QxPeibNOLHEXghtS-1w@mail.gmail.com>
 <ee809845f1a5fd5af3f73b35eaa79314@akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 092E4F800C0
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 10:35:49 +0200 (CEST)
Received: by mail-wr1-x444.google.com with SMTP id x1so12690598wrr.9
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 01:35:49 -0700 (PDT)
In-Reply-To: <ee809845f1a5fd5af3f73b35eaa79314@akkea.ca>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Angus Ainslie <angus@akkea.ca>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 17, 2019 at 6:15 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> On 2019-07-17 09:06, Daniel Baluta wrote:
> > On Wed, Jul 17, 2019 at 5:33 PM Lucas Stach <l.stach@pengutronix.de>
> > wrote:
> >>
> >> Hi Daniel,
> >>
> >> Am Mittwoch, den 17.07.2019, 17:16 +0300 schrieb Daniel Baluta:
> >> > > On Wed, Jul 17, 2019 at 1:59 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> >> > >
> >> > > The SAI block on the i.MX8M moved the register layout, as 2 version
> >> > > registers were added at the start of the register map. We deal with
> >> > > this by moving the start of the regmap, so both register layouts
> >> > > look the same to accesses going through the regmap.
> >> > >
> >> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >> >
> >> > This is a little bit tricky. We need the verid register in order
> >> > to differentiate IPs which can support 1:1 ratio for bclk:mclk
> >>
> >> And this patch doesn't prevent this usage. If needed we can just read
> >> the verid via a plain readl on the base mapping in the probe function
> >> and cache it in struct fsl_sai. This seems way less intrusive than
> >> carrying a register offset through all of the regmap accessors and
> >> validation functions. I simply haven't implemented it in this patch,
> >> as
> >> I had no need for it right now.
> >
> > I must admit this is a very clever idea! Anyhow, I'm having some
> > concerns
> > because unfortunately not all registers were shifted by 8 bytes.
> >
> > See: imx6sx [1] (page 3575)  and imx8X [2] (page 5512) RMs.
> >
> > We have something like this:
> >
> > i.mx6 SX:
> >
> > 00: TCSR
> > 04: TCR1
> > 08: TCR2
> > 0C: TCR3
> > ....
> > 60: TMR
> > 80: RCSR
> >
> > i.mx 8X
> >
> > 00: VERID
> > 04: PARAM
> > 08: TCSR
> > 0C: TCR1
> > ...
> > 60: TMR
> > 88: RCSR
> >
>
> We could split it into an upper and a lower regmap. Only the lower would
> need the version register offset.

That would work but will be unnecessary complicated. Let me send the
imx8M support
as we implemented in our tree by Friday.

It has the disadvantage that we've wrapped all shifted register with a
macro but I don't
see other solution.
