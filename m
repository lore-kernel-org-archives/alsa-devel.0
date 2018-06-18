From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Date: Mon, 18 Jun 2018 22:04:55 +0200
Message-ID: <20180618220455.1810f2a5@bbrezillon>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180618104159.24b9fffb@bbrezillon>
        <87d0wnrhqz.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d0wnrhqz.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Jun 2018 21:56:20 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Boris Brezillon <boris.brezillon@bootlin.com> writes:
> 
> > Hi Robert,
> >
> > On Sun, 17 Jun 2018 19:02:03 +0200
> > Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> >  
> >> As I gathered almost all the required acks, this is an information only post
> >> before queuing to the PXA tree.  
> >
> > We'll need an immutable branch/tag containing those changes, just in
> > case other conflicting changes get submitted to the NAND driver.  
> Sure, this branch will be usable from next Wednesday onward, here :
>  - git fetch https://github.com/rjarzmik/linux.git
>    tags/pxa-for-4.19-dma_slave_map
> 
> I must insist on "Wednesday", as I need to have one last pass from 0-day kernel
> checker to be fully covered, and I'd like as well to know which tree the ASoC
> patch will take, ie. if Mark commits to take it, or rather wants to pull from
> the imutable branch.
> 
> Until Wednesday, even if the branch exist, consider it doesn't please, and
> Thursday morning you can pull if you wish.

Don't worry, we're not planning to merge it unless it happens to be
required (Stephen Rothwell reporting a merge conflict in next), and we
don't have conflicting changes in the pipeline so far.
