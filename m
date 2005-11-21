From: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in
 process 'aplay', page c18eef30)
Date: Mon, 21 Nov 2005 17:09:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.61.0511211651270.16632@goblin.wat.veritas.com>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
 <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
 <1132510467.6874.144.camel@mindpipe> <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com>
 <s5hlkzinrq5.wl%tiwai@suse.de> <Pine.LNX.4.61.0511211507160.15988@goblin.wat.veritas.com>
 <s5h8xvinfg7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932351AbVKURJG@vger.kernel.org>
In-Reply-To: <s5h8xvinfg7.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Nov 2005, Takashi Iwai wrote:
> 
> Now another question arises:  Which is the recommended method for
> mmapping RAM pages, vma nopage callback or remap_pfn_range()?
> 
> IIRC, in the ealier versions, the former was recommended because
> remap_page_range() with page-reserve was regarded as a hack.

I do believe Linus (CC'ed so he can defend himself from my slanders)
saw it that way for a long while.  I believe he did, and still does,
think it more correct to work through the intended vm_operations_struct
methods.  But has relented a little down the years, and now accepts
that remap_pfn_range is here to stay (as much as anything stays).

> But, looking through these changes, I feel that remap_pfn_range() is
> better (easier and stabler) than vma nopage...

I'm not going to make a recommendation: whatever suits you best.

It does sometimes look like people converted from remap_pfn_range
to nopage, just because they felt under pressure to do so.

It is curious that your snd_pcm_mmap_status_nopage seems to have been
affected and nothing else (I'd expected trouble in DRM but no sign).

I've CC'ed hch also, he did have some pungent views on how you ought
better to go about this.

Hugh
