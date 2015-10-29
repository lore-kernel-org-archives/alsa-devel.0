From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 12:28:17 -0700
Message-ID: <20151029192816.GA43706@Asurada-CZ80>
References: <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
 <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id EDD5526170F
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 20:28:23 +0100 (CET)
Received: by oies66 with SMTP id s66so46238064oie.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 12:28:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
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

On Thu, Oct 29, 2015 at 12:06:16PM -0700, Caleb Crome wrote:

> This actually is exactly what I'm seeing now.  I'm seeing the
> *startup* happening from the trigger starting up slipped.  So this
> does make perfect sense to me.

I saw your problem in the other reply. And I suggested you to let
DMA work first before SSI gets enabled. As SDMA in that case would
transfer one burst length (16 if you applied my patch I sent you)
and pause before SSI gets enabled. Then SSI would have enough data
to send out without any startup issue.

> It occurred to me that perhaps the problem has to do when exactly when
> during the frame-sync period the fsl_ssi_trigger function was called.
> Perhaps, if it's called near the end or beginning of a frame, somehow

I don't know how you measured if it's before of after. But the frame
should not start until trigger() gets call -- more clearly SSIEN and
TE get enabled. From my point of view, you problem should be caused
by SSI getting enabled without enough data in the FIFO. And that's
what I just described in the previous paragraph and previous reply.

> something gets messed up.  (The docs for the SCR register imply some
> of this, but it talks about either 2 or 6 bit clocks, so I'd expect
> the error rate to be lower than 7% (more like 2.5%).

> In addition, I have run about 20 minutes of audio with no slips or
> problems, even though there have been aplay underruns.  This is a
> major step forward for me :-)

It'd be better to avoid user space ALSA underun as it may skip some
data.
