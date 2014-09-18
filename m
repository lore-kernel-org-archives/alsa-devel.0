From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re:
 =?iso-8859-1?q?No_sound_captured_with_SGTL5000_on_i?=
 =?iso-8859-1?q?=2EMX6_in_I=B2S_master_mode?=
Date: Thu, 18 Sep 2014 10:19:38 -0700
Message-ID: <20140918171931.GB6080@Asurada>
References: <CAL8zT=hSCpBZpqVGQ5uBdXJe25hqoNkmiPh_Ge3RCrGALkaoZg@mail.gmail.com>
 <CAOMZO5CReW7-8L7zx=z1TshwJSzcfGThCjws7fTfbZJKCnCZLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 611EF261ABB
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 19:19:44 +0200 (CEST)
Received: by mail-pd0-f176.google.com with SMTP id g10so1816088pdj.21
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 10:19:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5CReW7-8L7zx=z1TshwJSzcfGThCjws7fTfbZJKCnCZLg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Shengjiu Wang <shengjiu.wang@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2014 at 10:30:18AM -0300, Fabio Estevam wrote:
> > &iomuxc {
> >     pinctrl-names = "default";
> >     pinctrl-0 = <&pinctrl_hog>;
> >
> >     imx6qdl-vbx3 {
> >         pinctrl_audmux: audmuxgrp {
> >             fsl,pins = <
> >                 MX6QDLPAD_DISP0_DAT13__AUD5_RXFS        0x130b0
> >                 MX6QDL_PAD_DISP0_DAT14__AUD5_RXC        0x130b0
> >                 MX6QDL_PAD_DISP0_DAT19__AUD5_RXD        0x130b0

The other issue over here is you are using asynchronous mode of SSI,
while imx-sgtl5000 is using synchronous configurations for AUDMUX.

You can try it with fsl-asoc-card because it uses asynchronous mode
of AUDMUX, although I've not tested it with SSI in its asynchronous
mode as I only have a synchronous (SSI) environment.

> > &ssi1 {
> >     status = "okay";
> >     codec-handle = <&codec>;
> >     fsl,mode = "i2s-master";
> >     fsl,ssi-asynchronous; /* Not sure about it, but does not change anything */

The driver cares about it. If you look at the symmetric part carefully,
you would find some register configurations of SSI does depends on the
this property via symmetric check. For example:

	if (ssi_private->cpu_dai_drv.symmetric_rates) {
		/* Need to clear RXDIR when using SYNC mode */
		srcr &= ~CCSR_SSI_SRCR_RXDIR;
		scr |= CCSR_SSI_SCR_SYN;
	}

Nicolin
