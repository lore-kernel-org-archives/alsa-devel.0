From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Wed, 28 Oct 2015 09:23:01 +0100
Message-ID: <563085E5.1030401@tekno-soft.it>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 7036F26044B
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 09:23:20 +0100 (CET)
In-Reply-To: <20151027201101.GA9527@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Caleb Crome <caleb@crome.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

On 10/27/2015 09:11 PM, Nicolin Chen wrote:
> On Tue, Oct 27, 2015 at 08:13:44AM +0100, Markus Pargmann wrote:
>
>>> So, the dma priority doesn't seem to be the issue.  It's now set in
>>> the device tree, and strangely it's set to priority 0 (the highest)
>>> along with the UARTS.  priority 0 is just the highest in the device
>>> tree -- it gets remapped to priority 3 in the sdma driver.  the DT
>>> exposes only 3 levels of DMA priority, low, medium, and high.  I
>>> created a new level that maps to DMA priroity 7 (the highest in the
>>> hardware), but still got the problem.
>>>
>>> So, still something unknown causing dma to miss samples.  must be in
>>> the dma ISR I would assume.  I guess it's time to look into that.
>> Cc Nicolin, Fabio, Shawn
>>
>> Perhaps you have an idea about this?
> Off the top of my head:
>
> 1) Enable TUE0, TUE1, ROE0, ROE1 to see if there is any IRQ trigged.

I'm my case I was never able to see an interrupt triggered when setting both RDMAE and TDMAE
bits in the SIER register.

> 2) Set the watermarks for both TX and RX to 8 while using burst sizes
>    of 6. It'd be nicer to provisionally set these numbers using hard
>    code than your current change depending on fifo_depth as it might
>    be an odd value.
>
> 3) Try to enlarge the ALSA period size in the asound.conf or passing
>    parameters when you do the playback/capture so that the number of
>    interrupts from SDMA may reduce.
>
> You may also see if the reproducibility is somehow reduced or not.
>
> Nicolin
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
