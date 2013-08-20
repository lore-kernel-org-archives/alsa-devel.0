From: Nicole Otsuka <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v9 2/2] ASoC: fsl: Add S/PDIF machine driver
Date: Wed, 21 Aug 2013 00:54:55 +0800
Message-ID: <CAGoOwPQ_7F1-3AetKBF35pwO_-LNY6yUtx_r8Mn+HZia_WqyoA@mail.gmail.com>
References: <cover.1376972170.git.b42378@freescale.com>
 <ede222d17047e863da34a78069ceead2668bd5d2.1376972170.git.b42378@freescale.com>
 <52139680.1010800@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id C8A022651A9
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 18:54:55 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id 6so249151bkj.5
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 09:54:55 -0700 (PDT)
In-Reply-To: <52139680.1010800@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, linuxppc-dev@lists.ozlabs.org, s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Stephen,

I have a whole changelist in the cover letter (PATCH 0/2). Please take a
look at it.

And about the codec dummy things.. I do that only because the codec
driver's doc say so.

Thank you,
Nicolin


On Wed, Aug 21, 2013 at 12:17 AM, Stephen Warren <swarren@wwwdotorg.org>wrote:

> On 08/19/2013 10:32 PM, Nicolin Chen wrote:
> > This patch implements a device-tree-only machine driver for Freescale
> > i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> > fsl_spdif.c drivers.
> >
> > Signed-off-by: Nicolin Chen <b42378@freescale.com>
> > ---
> >  .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +++++
>
> What changed between v8 and v9?
>
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
> b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
>
> > +Optional properties:
> > +
> > +  - spdif-transmitter : The phandle of the spdif-transmitter dummy codec
> > +
> > +  - spdif-receiver : The phandle of the spdif-receiver dummy codec
> > +
> > +* Note: At least one of these two properties should be set in the DT
> binding.
>
> I still don't think "dummy CODEC" is an appropriate thing to have in DT.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
