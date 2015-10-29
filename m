From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 10:19:37 -0700
Message-ID: <20151029171936.GA3492@Asurada-CZ80>
References: <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
 <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 271932606A7
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 18:19:43 +0100 (CET)
Received: by pasz6 with SMTP id z6so46340590pas.2
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 10:19:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2015 at 06:44:12AM -0700, Caleb Crome wrote:
> > Reported by user space? Are you saying that's an ALSA underrun in
> > the user space, not a hardware underrun reported by the IRQ in the
> > driver? They are quite different. ALSA underrun comes from the DMA
> > buffer gets underrun while the other one results from FIFO feeding
> > efficiency. For ALSA underrun, enlarging the playback period size
> > and period number will ease the problem:
 
> Sometimes they happen at the same time.  So, I run aplay, and all is

The 'they' is indicating ALSA underrun + hardware underrun or ALSA
underrun + channel slip? It's not quite logical for a channel slip
resulting from an ALSA underrun as it should restart by calling the
trigger() functions in DAI drivers IIRC.

> fine.  Then the user space app will underrun, and then I look at the
> scope, and the channels have slipped.  So somehow the start/restart
> after the underrun is not always perfect I guess.

> Is there any mechanism for the DMA fifo underruns to be reported back
> to user space?  There certainly should be, because the consequences

No. The release from Freescale official tree has a reset procedure
applied to ESAI underrun but not SSI but I guess you may want to
refer to that.

> are catastrophic, yet the user space app goes on as if everything is
> just great.  Much, much worse than the underrun that is reported (i.e.
> a skip in audio is bad but sometimes tolerable.  A channel slip is
> permanent and absolutely intolerable).
