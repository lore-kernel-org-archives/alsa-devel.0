From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Wed, 4 Nov 2015 10:18:23 -0800
Message-ID: <20151104181821.GB4057@Asurada-CZ80>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it>
 <20151104175815.GB3794@Asurada-CZ80>
 <563A49CA.8090501@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D0C9260537
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 19:18:28 +0100 (CET)
Received: by pasz6 with SMTP id z6so61541130pas.2
 for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2015 10:18:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <563A49CA.8090501@tekno-soft.it>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 04, 2015 at 07:09:14PM +0100, Roberto Fichera wrote:

> I can try to increase the FIFO watermark up to 15 elements, but after that
> I don't have more choices. The problem is that the TDM has to run continuously
> because the SLIC need it. I can eventually enable and disable the DMA requests
> depending by the active channels for optimization, but the problem still,why the
> DMA transfer is not triggered?
 
There's nothing you can do from SSI side. If you don't clear the
Channel Error bit, the channel might be still hanging there until
you clear the bit or reset the channel. You may read SDMA chapter
for details.
