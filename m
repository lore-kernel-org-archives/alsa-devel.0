From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ISA: set 24-bit dma_mask for ISA devices.
Date: Fri, 30 May 2008 15:55:08 -0700
Message-ID: <20080530155508.0b4e5776.akpm@linux-foundation.org>
References: <4823AAF2.7070102@keyaccess.nl> <482B38D6.5030804@keyaccess.nl>
	<48406E8D.8050408@keyaccess.nl>
	<200805301543.42208.bjorn.helgaas@hp.com>
	<48407B99.4080209@keyaccess.nl> <48408191.6030104@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 64D6424438
	for <alsa-devel@alsa-project.org>;
	Sat, 31 May 2008 00:55:42 +0200 (CEST)
In-Reply-To: <48408191.6030104@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, bjorn.helgaas@hp.com
List-Id: alsa-devel@alsa-project.org

On Sat, 31 May 2008 00:37:05 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> [ PNP: set the pnp_card dma_mask for use by ISAPnP cards. ]
> 
> > Thanks. I'll assume Andrew picks it up from the CC...

Actually I would have missed it

> And here's the ISA one...
> 

If this one hadn't mentioned it.

> From: Rene Herman <rene.herman@gmail.com>
> Date: Sat, 31 May 2008 00:31:40 +0200
> Subject: [PATCH] ISA: set 24-bit dma_mask for ISA devices.
> 
> Set the ISA device dma_mask in preparation for using the actual device
> with the DMA API.

Argh.  Could we please be better with the changelogs?

This one tells us briefly what the patch does, but it deosn't tell us
why it does it.  It doesn't tell us whether it fixes some bug (and if
so what that bug is) and it gives me no means of determining whether
the patch is needed in 2.6.26 or in 2.6.25.x.

Ditto pnp-set-the-pnp_card-dma_mask-for-use-by-isapnp-cards.patch
