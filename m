From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 16:22:53 -0700
Message-ID: <20151029232252.GD44369@Asurada-CZ80>
References: <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
 <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <CAG5mAdw220n3K8vfRAgixxeYa=rBp5YbOrn_8ecwH+KN0JOnnA@mail.gmail.com>
 <56323D3F.4080708@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 34EDB265872
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 00:22:58 +0100 (CET)
Received: by padhy1 with SMTP id hy1so48065375pad.0
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 16:22:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56323D3F.4080708@tekno-soft.it>
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

On Thu, Oct 29, 2015 at 04:37:35PM +0100, Roberto Fichera wrote:

> Regarding my SSI problem, I was able to keep the DMA working for few second once before
> it get stopped and never retriggered. Currently I've 2 DMA channel one for TX and another for rx

DMA only stops when getting terminate_all() executed or FIFO doesn't
reach the watermark so that no newer DMA request would be issued.

> I've changed my DTS and update my fsl_ssi to handle new clocks, I guess only the CLK_SPBA
> has improved my situation. I've also tried to enable both RIE and TIE to service the ISR, with

Guessing? It'd weird that SPBA would ease the issue here as I was told
by the IC team that SSI and SAI in SoloX don't require SPBA clock IIRC.

> and without SSI DMA support, but this end with a full system freeze. The ISR was never changed
> in my fsl_ssi.c.

You mentioned that clock status from the Codec chip shows the bit clock
stops but now it's related to DMA? I think you should first figure out
where the problem locates as Caleb's problem is different from yours.

As I mentioned, you may need to confirm that if the bit clock generation
is stopped. DMA surely won't work when the bit clock ends as SSI may
no longer consume the data FIFO so the watermark would never be reached
again.

Nicolin
