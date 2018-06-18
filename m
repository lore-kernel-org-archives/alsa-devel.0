From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Date: Mon, 18 Jun 2018 21:56:20 +0200
Message-ID: <87d0wnrhqz.fsf@belgarion.home>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180618104159.24b9fffb@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180618104159.24b9fffb@bbrezillon> (Boris Brezillon's message
        of "Mon, 18 Jun 2018 10:41:59 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> Hi Robert,
>
> On Sun, 17 Jun 2018 19:02:03 +0200
> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>> As I gathered almost all the required acks, this is an information only post
>> before queuing to the PXA tree.
>
> We'll need an immutable branch/tag containing those changes, just in
> case other conflicting changes get submitted to the NAND driver.
Sure, this branch will be usable from next Wednesday onward, here :
 - git fetch https://github.com/rjarzmik/linux.git
   tags/pxa-for-4.19-dma_slave_map

I must insist on "Wednesday", as I need to have one last pass from 0-day kernel
checker to be fully covered, and I'd like as well to know which tree the ASoC
patch will take, ie. if Mark commits to take it, or rather wants to pull from
the imutable branch.

Until Wednesday, even if the branch exist, consider it doesn't please, and
Thursday morning you can pull if you wish.

Cheers.

-- 
Robert
