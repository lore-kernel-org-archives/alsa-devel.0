From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in process 'aplay', page c18eef30)
Date: Mon, 21 Nov 2005 15:52:39 +0000
Message-ID: <20051121155239.GC21032@flint.arm.linux.org.uk>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com> <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com> <1132510467.6874.144.camel@mindpipe> <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com> <s5hlkzinrq5.wl%tiwai@suse.de> <Pine.LNX.4.61.0511211507160.15988@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932334AbVKUPw6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511211507160.15988@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hugh Dickins <hugh@veritas.com>
Cc: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>, Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 21, 2005 at 03:46:50PM +0000, Hugh Dickins wrote:
> So another of my patches in -rc1-mm2 made the PageCompound technique
> available always, no longer under #ifdef CONFIG_HUGETLB_PAGE: so that
> get_page and put_page on the later constituents of the high-order
> page get redirected to the first one, and it should work okay again.
> 
> Except that I'd missed that you actually have to choose to have your
> high-order pages supplied as compound pages, by passing __GFP_COMP.
> Since I wasn't passing that, they still weren't allocated as compound
> pages, so were still being freed too soon - and the PG_reserved flag
> found while freeing gave rise to the "Bad page state" messages seen.

Does this mean that in arch/arm/mm/consistent.c, we should also set
__GFP_COMP ?  Should we be doing that today?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
