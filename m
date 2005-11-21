From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 12/11] unpaged: fix sound Bad page states
Date: Mon, 21 Nov 2005 13:57:10 -0800
Message-ID: <20051121215710.GR6916@holomorphy.com>
References: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751116AbVKUWCO@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511211801070.17464@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 21, 2005 at 06:12:38PM +0000, Hugh Dickins wrote:
> Earlier I unifdefed PageCompound, so that snd_pcm_mmap_control_nopage
> and others can give out a 0-order component of a higher-order page,
> which won't be mistakenly freed when zap_pte_range unmaps it.  But
> many Bad page states reported a PG_reserved was freed after all: I had
> missed that we need to say __GFP_COMP to get compound page behaviour.
> Some of these higher-order pages are allocated by snd_malloc_pages, some
> by snd_malloc_dev_pages; or if SBUS, by sbus_alloc_consistent - but that
> has no gfp arg, so add __GFP_COMP into its sparc32/64 implementations.
> I'm still rather puzzled that DRM seems not to need a similar change.
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
