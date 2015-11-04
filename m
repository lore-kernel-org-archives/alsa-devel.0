From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Wed, 4 Nov 2015 09:41:23 -0800
Message-ID: <CAG5mAdw_VZFjKz7_H+jg=48-Y3uG1-xGT2P8M1cGm8PQqunkzQ@mail.gmail.com>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it> <563A380E.8060406@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E2BE0260537
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 18:41:42 +0100 (CET)
Received: by wmff134 with SMTP id f134so47939456wmf.0
 for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2015 09:41:42 -0800 (PST)
In-Reply-To: <563A380E.8060406@tekno-soft.it>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 4, 2015 at 8:53 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
> On 11/04/2015 04:33 PM, Roberto Fichera wrote:
>>         *RX DMA frame count=36795*
>>         RX DMA addr=0x9ef0e000
>>         RX DMA buffer len=16
>>         *TX DMA frame count=36795*
>>         TX DMA addr=0x9ee49000
>>         TX DMA buffer len=16


I notice your DMA buffer length is very short, which would require
very frequency interrupts to service, right?   Can you increase your
DMA buffer length by increasing the period size?  Maybe that would
help reduce the likelyhood of a failure.  Although it would be good to
be able to recover from a failure gracefully.
-Caleb
