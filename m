From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI
	driver
Date: Thu, 3 Jan 2019 12:25:33 -0600
Message-ID: <CAL_JsqLcBjRBV_zOoMGGB9gFVgk=4LSx80sFam1-9neDVjAYfQ@mail.gmail.com>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
 <1546531006.14398.83.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id CA6F8267BC7
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 19:25:47 +0100 (CET)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EEB4221872
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 18:25:45 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id y78so20163114qka.12
 for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2019 10:25:45 -0800 (PST)
In-Reply-To: <1546531006.14398.83.camel@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 3, 2019 at 9:59 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Hi Nicolin,
>
> Thank you for your feedback, same here - just back from vacation.
>
> On Jo, 2018-12-27 at 01:24 +0800, Nicolin Chen wrote:
> > Hi Viorel,
> >
> > Sorry for the late response, having been on a long vacation.
> >
> > The code looks pretty clean. Just some small concerns/questions
> > below.
> >
> > On Wed, Dec 19, 2018 at 12:30 AM Viorel Suman <viorel.suman@nxp.com>
> > wrote:
> > >
> > >
> > > This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
> > > The Audio Mixer is a on-chip functional module that allows mixing
> > > of
> > > two audio streams into a single audio stream.
> > >
> > > Audio Mixer datasheet is available here:
> > > https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
> > >
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > > ---
> > >  .../devicetree/bindings/sound/fsl,amix.txt         |  45 ++
> > >  sound/soc/fsl/Kconfig                              |   7 +
> > >  sound/soc/fsl/Makefile                             |   3 +
> > >  sound/soc/fsl/fsl_amix.c                           | 554
> > > +++++++++++++++++++++
> > >  sound/soc/fsl/fsl_amix.h                           | 101 ++++
> > I aimn't against the naming here, but it seems to be AUDMIX in RM?
> >
> > Would it be better to align with that? It's your decision though.
>
> To me "AUDMIX" sounds more like some RTL high level integration module,
> I would prefer to keep it as it is if there is no strong reason to
> rename it.

At least for compatible string names, matching what's in the RM or RTL
is more appropriate. Where does "AMIX" come from?

Rob
