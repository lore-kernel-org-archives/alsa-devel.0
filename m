From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: ALSA on MIPS platform
Date: Wed, 8 Aug 2007 12:58:52 +0100
Message-ID: <20070808115852.GA6700@linux-mips.org>
References: <46B332AC.8020403@lemote.com>
	<5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com>
	<5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com>
	<20070807.230157.59463765.anemo@mba.ocn.ne.jp>
	<20070807175402.GA24731@linux-mips.org>
	<s5hlkcnmbll.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ftp.linux-mips.org (ftp.linux-mips.org [194.74.144.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 277E62440C
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 13:59:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56460 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026881AbXHHL7H (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Wed, 8 Aug 2007 12:59:07 +0100
Content-Disposition: inline
In-Reply-To: <s5hlkcnmbll.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, greg@kroah.com, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, tiansm@lemote.com, jiankemeng@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2007 at 08:41:10PM +0200, Takashi Iwai wrote:

> > It's ALSA that is doing funny things here so there is no point in fixing
> > the arch code to work for ALSA.
> 
> Yep, but OTOH, the arch code doesn't provide a proper standard way to
> mmap the pages allocated via dma_alloc_coherent().  That's the missing
> piece, especially on mips and sparc.  ARM has already one.
> 
> My wish is implementing dma_mmap_coherent() on all architectures, so
> that the driver can use it safely without messy ifdefs.

Adding dma_mmap_coherent has been proposed in 2004 but the discussion for
some reason went nowhere because it apparently isn't implementable on
PARISC due to cache synonyms - on MIPS we'd solve those issues where they
exist by using uncached or writethrough mappings, as apropriate.

  Ralf
