From: Fabio Estevam <festevam@gmail.com>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Thu, 5 Nov 2015 09:30:09 -0200
Message-ID: <CAOMZO5ARkQa5JbxuYCMjAev4nfo7mzrG73x2yxuXLgRsg3HUfg@mail.gmail.com>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it> <563A380E.8060406@tekno-soft.it>
 <CAG5mAdw_VZFjKz7_H+jg=48-Y3uG1-xGT2P8M1cGm8PQqunkzQ@mail.gmail.com>
 <563A45CC.2070605@tekno-soft.it>
 <20151104181144.GA4057@Asurada-CZ80> <563B2972.10202@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 03360265A01
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 12:30:11 +0100 (CET)
Received: by iodd200 with SMTP id d200so8231406iod.0
 for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2015 03:30:09 -0800 (PST)
In-Reply-To: <563B2972.10202@tekno-soft.it>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 5, 2015 at 8:03 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:

> Following your suggestion, I've increased the buffer size to 2K and set the period to fifo_length - 2 (13),
> with that I'm now running substantially smooth except 3 EVTERR on RX DMA over 4 million of interrupts.
>
> Thanks Nicolin! I'm quite happy now!

That's good progress, Roberto.

It would be nice if you and Caleb could post the patches to the mailing list.
