From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 08/10] ASoC: dt-bindings: Document
 fcomb_mode property
Date: Thu, 25 Jul 2019 10:39:19 -0700
Message-ID: <20190725173918.GD31961@Asurada-Nvidia.nvidia.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-9-daniel.baluta@nxp.com>
 <20190724232209.GC6859@Asurada-Nvidia.nvidia.com>
 <CAEnQRZBW7LNZ7=c_h_ef4ZDcbFzEt61h4VAJSLo2Fb80kBqtpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BA62F8015A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 19:38:37 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id y15so23111634pfn.5
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 10:38:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEnQRZBW7LNZ7=c_h_ef4ZDcbFzEt61h4VAJSLo2Fb80kBqtpw@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, linuxppc-dev@lists.ozlabs.org, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 09:02:22AM +0300, Daniel Baluta wrote:
> On Thu, Jul 25, 2019 at 2:22 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Mon, Jul 22, 2019 at 03:48:31PM +0300, Daniel Baluta wrote:
> > > This allows combining multiple-data-line FIFOs into a
> > > single-data-line FIFO.
> > >
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++++
> >
> > This should be sent to devicetree mail-list also.
> >
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > > index 59f4d965a5fb..ca27afd840ba 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > > @@ -54,6 +54,10 @@ Optional properties:
> > >                         represents first data line, bit 1 represents second
> > >                         data line and so on. Data line is enabled if
> > >                         corresponding bit is set to 1.
> > > +  - fsl,fcomb_mode   : list of two integers (first for RX, second for TX)
> > > +                       representing FIFO combine mode. Possible values for
> > > +                       combined mode are: 0 - disabled, 1 - Rx/Tx from shift
> > > +                       registers, 2 - Rx/Tx by software, 3 - both.
> >
> > Looks like a software configuration to me, instead of a device
> > property. Is this configurable by user case, or hard-coded by
> > SoC/hardware design?
> 
> Indeed this is a software configuration and configurable by user case.
> Will think of a another way to specify it.

Yea, it needs to be put somewhere else other than devicetree.

Not sure sysfs is a good approach for ASoC components or can
be done via amixer control.
