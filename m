From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 16:05:50 -0700
Message-ID: <20151029230549.GC44369@Asurada-CZ80>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
 <20151027201101.GA9527@Asurada-CZ80>
 <563085E5.1030401@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B06426584A
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 00:05:55 +0100 (CET)
Received: by oiad129 with SMTP id d129so49847843oia.0
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 16:05:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <563085E5.1030401@tekno-soft.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Caleb Crome <caleb@crome.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2015 at 09:23:01AM +0100, Roberto Fichera wrote:
> On 10/27/2015 09:11 PM, Nicolin Chen wrote:
> > On Tue, Oct 27, 2015 at 08:13:44AM +0100, Markus Pargmann wrote:
> >
> >>> So, the dma priority doesn't seem to be the issue.  It's now set in
> >>> the device tree, and strangely it's set to priority 0 (the highest)
> >>> along with the UARTS.  priority 0 is just the highest in the device
> >>> tree -- it gets remapped to priority 3 in the sdma driver.  the DT
> >>> exposes only 3 levels of DMA priority, low, medium, and high.  I
> >>> created a new level that maps to DMA priroity 7 (the highest in the
> >>> hardware), but still got the problem.
> >>>
> >>> So, still something unknown causing dma to miss samples.  must be in
> >>> the dma ISR I would assume.  I guess it's time to look into that.
> >> Cc Nicolin, Fabio, Shawn
> >>
> >> Perhaps you have an idea about this?
> > Off the top of my head:
> >
> > 1) Enable TUE0, TUE1, ROE0, ROE1 to see if there is any IRQ trigged.
> 
> I'm my case I was never able to see an interrupt triggered when setting both RDMAE and TDMAE
> bits in the SIER register.

Your problem may not involve with hardware FIFO underrun at all
so it's quite normal for you to have no IRQ in my opinion.
