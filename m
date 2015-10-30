From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Fri, 30 Oct 2015 09:07:18 -0700
Message-ID: <20151030160717.GB3505@Asurada-CZ80>
References: <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
 <20151030012934.GA5456@Asurada-GSX> <56332A4E.3010704@invoxia.com>
 <56332E2C.4070405@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 90B8A26051B
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 17:07:22 +0100 (CET)
Received: by pacfv9 with SMTP id fv9so81489460pac.3
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 09:07:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56332E2C.4070405@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, shengjiu.wang@freescale.com, Caleb Crome <caleb@crome.org>, Markus Pargmann <mpa@pengutronix.de>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add Shengjiu.

On Fri, Oct 30, 2015 at 09:45:32AM +0100, arnaud.mouiche@invoxia.com wrote:

> >At imx50 age, I remember one workaround was to fill the fifo
> >manually, writing directly a number of samples (equal to the
> >number of slots for one frame to keep the synchronization), and
> >then, enable the TMDAE.
> >This just allow to not have to wait an undefined period of time
> >for the DMA to be ready.
> >But, on the other hand, if the time to wait the DMA is short
> >enough, it should not be an issue.

> In the same idea, they were other similar issues to deal with
> concerning the RX and TX fifo.
> 
> 1) Still some samples in the TX fifo when stoping/ re-starting the
> TX, while RX stream is going on.
> Since we can't reset the TX fifo content without disabling SSIEN,
> possible samples filled by the TX DMA are still there when the TX
> stream stops. And when we start it again, they introduce a random
> de-synchronization of the output.
> The workaround for this case was to add additional zero samples in
> the fifo manually to reach a multiple of the frame size.
> But I would prefer a way to empty manually the fifo instead. If
> Freescale can help us to find another way as they know the internal
> of the SSI...
> 
> 2) the same for RX fifo, if the RX stream is stopped/-restarted,
> while TX stream is not stopped.
> We may still have some samples in the RX fifo, and those fifo must
> be removed before starting the RX again.
> This was more simple in this case, since we only need to read the RX
> register manually until the fifo is empty, before enabling the DMA.
> 
> Obviously, disabling the SSIEN completely to start on good basis is
> not possible since we will lose a random number of samples already
> present in the fifo corresponding to the stream we don't want to
> stop, and this number of samples may not be a multiple of slots.

You are right. Since SSI doesn't have separate FIFO reset bits
for TX and RX respectively. These could be issues.
