From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Tue, 27 Oct 2015 13:11:02 -0700
Message-ID: <20151027201101.GA9527@Asurada-CZ80>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A2B926061B
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 21:11:09 +0100 (CET)
Received: by pasz6 with SMTP id z6so231736519pas.2
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 13:11:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151027071344.GC25728@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 27, 2015 at 08:13:44AM +0100, Markus Pargmann wrote:

> > So, the dma priority doesn't seem to be the issue.  It's now set in
> > the device tree, and strangely it's set to priority 0 (the highest)
> > along with the UARTS.  priority 0 is just the highest in the device
> > tree -- it gets remapped to priority 3 in the sdma driver.  the DT
> > exposes only 3 levels of DMA priority, low, medium, and high.  I
> > created a new level that maps to DMA priroity 7 (the highest in the
> > hardware), but still got the problem.
> > 
> > So, still something unknown causing dma to miss samples.  must be in
> > the dma ISR I would assume.  I guess it's time to look into that.

> Cc Nicolin, Fabio, Shawn
> 
> Perhaps you have an idea about this?

Off the top of my head:

1) Enable TUE0, TUE1, ROE0, ROE1 to see if there is any IRQ trigged.

2) Set the watermarks for both TX and RX to 8 while using burst sizes
   of 6. It'd be nicer to provisionally set these numbers using hard
   code than your current change depending on fifo_depth as it might
   be an odd value.

3) Try to enlarge the ALSA period size in the asound.conf or passing
   parameters when you do the playback/capture so that the number of
   interrupts from SDMA may reduce.

You may also see if the reproducibility is somehow reduced or not.

Nicolin
