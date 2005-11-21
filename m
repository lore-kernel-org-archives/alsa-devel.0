From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 12/11] unpaged: fix sound Bad page states
Date: Mon, 21 Nov 2005 22:40:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.61.0511212240060.21223@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
 <20051121124105.1bf8090d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751190AbVKUWrW@vger.kernel.org>
In-Reply-To: <20051121124105.1bf8090d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: tiwai@suse.de, rmk+lkml@arm.linux.org.uk, wli@holomorphy.com, davem@davemloft.net, torvalds@osdl.org, nickpiggin@yahoo.com.au, airlied@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Nov 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> >   arch/sparc/kernel/ioport.c |    2 +-
> >   arch/sparc64/kernel/sbus.c |    2 +-
> >   sound/core/memalloc.c      |    2 ++
> >   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> So with this, do you think everything is in place for a mainline merge?

Yes, I believe so: thanks.

Hugh
