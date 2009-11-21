From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] MIPS: Fixups of ALSA memory maps
Date: Sat, 21 Nov 2009 20:31:41 +0800
Message-ID: <1258806701.5752.8.camel@falcon.domain.org>
References: <9cbcd06037c18288a6493459b8f3a6e1562eca77.1258389992.git.wuzhangjin@gmail.com>
	 <s5hd43iiebt.wl%tiwai@suse.de> <20091116174324.GA17748@linux-mips.org>
	 <s5hhbst4hzt.wl%tiwai@suse.de> <20091118142056.GB6615@linux-mips.org>
	 <s5hskcbbu80.wl%tiwai@suse.de>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754123AbZKUMcV@vger.kernel.org>
In-Reply-To: <s5hskcbbu80.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-11-18 at 18:47 +0100, Takashi Iwai wrote:
[...]
> 
> Well, we haven't reached the consensus.  The discussion faded away
> somehow mainly because I had too little time to update and ping people
> again.
> 
> In Tokyo, I talked with some guys regarding this.  Ben agreed to take
> this approach for ppc, and David said that he doesn't mind for sparc
> part.   Fujita-san mentioned it's no big problem to add one op from
> the generic dma_ops.
> 
> So, maybe somehow need to convince James in the end (and ask Paul to
> check SH part, too), then it'll be all up... theoretically :)
> 
> Anyway, I'm going to raise the discussion again on linux-arch.
> I'm afraid it's a bit too late game for 2.6.33, but starting now is
> better than too late again.

Hi, Takashi Iwai

Before the API stuff going into the mainline(2.6.33), can we apply this
"[PATCH] MIPS: Fixups of ALSA memory maps"(This is the minimal
necessares) as a current fixup. and then we will not get a broken sound
support for MIPS, and also the support to the latest Loongson2F family
machines will benefit from it.

and Ralf, what about your suggestion?

Thanks & Best wishes,
	Wu Zhangjin
