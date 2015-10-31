From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Fri, 30 Oct 2015 18:32:06 -0700
Message-ID: <20151031013205.GA3525@Asurada-CZ80>
References: <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
 <20151030012934.GA5456@Asurada-GSX>
 <CAG5mAdwUKwzGvpO3ckKZWfE+oKXHK7umT5Z3Ru3Oyq8AD7gNMg@mail.gmail.com>
 <CAG5mAdxNPKZw1_9HSKA0HrgzpZKOhq8dy2TZi095M9AibdcNCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id EBA68260462
 for <alsa-devel@alsa-project.org>; Sat, 31 Oct 2015 02:32:12 +0100 (CET)
Received: by pasz6 with SMTP id z6so89122318pas.2
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 18:32:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdxNPKZw1_9HSKA0HrgzpZKOhq8dy2TZi095M9AibdcNCQ@mail.gmail.com>
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

On Fri, Oct 30, 2015 at 03:35:17PM -0700, Caleb Crome wrote:

> > **********************
> > ** Problem 2 *******
> > **********************

> I realized the problem with the dual fifo mode:  it's that you had set
> the maxburst to 16 in your patch.  I guess this must be the maxburst
> to a single fifo maybe?  When I set the fual fifo maxburst back to 8,
> I get perfection again!

I actually set 16 for dual FIFO and tested with 2-channel playback.
Since you have dual FIFO right now, burst 8 doesn't hurt a lot as
SPBA should be a pretty dedicated bus from SDMA point of view. As
long as you don't have too many SPBA modules working with SDMA. It
should work for you.
