From: Joel Fernandes <joelf@ti.com>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Mon, 1 Jul 2013 22:33:21 -0500
Message-ID: <51D24A01.2050709@ti.com>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A2D2652C4
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 05:33:24 +0200 (CEST)
In-Reply-To: <51D11D64.3070805@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Hi Mike,

On 07/01/2013 01:10 AM, Mike Looijmans wrote:
[..]
> The trouble with the current davinci driver is that the IRQ handler has a
> real-time requirement, it must finish before the next DMA block completes. This

I looked into this a little more.

I think you are picturing the following:

DMA transfer -> IRQ has to complete -> DMA transfer -> IRQ has to complete.. etc.

This is not really true in the davinci-pcm driver, the normal case without IRAM
works more like..

DMA ----> DMA ---> DMA
 \        \        \
  \__ IRQ  \__ IRQ  \__ IRQ

The only hard requirement is the IRQ handler much finish updating before the
next DMA transfer, or we're in trouble. Is this what you mean by real-time
requirement, or did you mean something else?

Either way I'm sure your multi-slot approach is superior, but I don't see how
you can get away with not updating the DMA addresses on every IRQ with the
current davinci-pcm or EDMA controller (Unless you use a complicated mechanism
like ping-pong where the address updates take care of itself). If you are using
a set of chained slots, you only have so many slots so you have to continuously
change addresses of the slots at some point or the other for a large transfer.

Thanks,

-Joel
