From: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in
 process 'aplay', page c18eef30)
Date: Mon, 21 Nov 2005 16:51:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.61.0511211634440.16632@goblin.wat.veritas.com>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
 <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
 <1132510467.6874.144.camel@mindpipe> <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com>
 <s5hlkzinrq5.wl%tiwai@suse.de> <Pine.LNX.4.61.0511211507160.15988@goblin.wat.veritas.com>
 <20051121155239.GC21032@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051121155239.GC21032@flint.arm.linux.org.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>, Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Nov 2005, Russell King wrote:
> 
> Does this mean that in arch/arm/mm/consistent.c, we should also set
> __GFP_COMP ?  Should we be doing that today?

No, I don't believe so.  I notice there's use of PageReserved and page
count manipulation in there, which we may well want to rationalize in
a later phase, perhaps replacing by __GFP_COMP then; but I don't see
any need to change what you're doing at this stage.

Looking again, to see why you even thought you might need to change:
the vital thing you're doing (aside from the PageReserved, which is
becoming irrelevant), which is missing from the regular high-order
allocation, is the set_page_count(page, 1).  That's why you don't
need to change: the problems I was writing of come from when the
0-order page count goes down to 0.

Makes me wonder whether there could be a useful halfway stage to
compound pages, whether it would help for the page allocator to
set those counts to 1 generally.

Hugh


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
