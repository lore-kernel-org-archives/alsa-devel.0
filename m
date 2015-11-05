From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Thu, 5 Nov 2015 12:48:00 +0100
Message-ID: <563B41F0.8060508@tekno-soft.it>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it> <563A380E.8060406@tekno-soft.it>
 <CAG5mAdw_VZFjKz7_H+jg=48-Y3uG1-xGT2P8M1cGm8PQqunkzQ@mail.gmail.com>
 <563A45CC.2070605@tekno-soft.it> <20151104181144.GA4057@Asurada-CZ80>
 <563B2972.10202@tekno-soft.it>
 <CAOMZO5ARkQa5JbxuYCMjAev4nfo7mzrG73x2yxuXLgRsg3HUfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 9932E265A01
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 12:48:19 +0100 (CET)
In-Reply-To: <CAOMZO5ARkQa5JbxuYCMjAev4nfo7mzrG73x2yxuXLgRsg3HUfg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11/05/2015 12:30 PM, Fabio Estevam wrote:
> On Thu, Nov 5, 2015 at 8:03 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>
>> Following your suggestion, I've increased the buffer size to 2K and set the period to fifo_length - 2 (13),
>> with that I'm now running substantially smooth except 3 EVTERR on RX DMA over 4 million of interrupts.
>>
>> Thanks Nicolin! I'm quite happy now!
> That's good progress, Roberto.
>
> It would be nice if you and Caleb could post the patches to the mailing list.
>

Indeed! Now the TDM is stable, I've also found the reason of the EVTERRs, which was related to some stale
code I've used to enable and disable both RDMAE and TDMAE bits to try to reset the transfers.
Once removed that code everything is looks ok now.

Regarding patches, well, from my side there isn't nothing special compared to the original fsl_ssi.c code.
I'm basically running against a very skinny fsl_ssi.c version, I've just setup a bit larger DMA buffer, from
16bytes to 2K, and now reduced the DMA period to 8 because I'm mostly comfortable with that size to simplify
sampling exchange against DAHDI subsystem within my DMA callbacks.

In a few words, my problem was related due to a DMA buffer too small.

What eventually might be interesting to have is the INTRMASK and EVTERR DMA setting to trigger DMA
related errors, but I guess this need to be discussed elsewhere.
