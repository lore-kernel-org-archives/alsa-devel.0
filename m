From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: ALSA Driver for Sparc DBRI chips
Date: Sat, 18 Dec 2004 15:15:09 +0000
Message-ID: <20041218151509.GA13178@palantir8>
References: <20041121095008.GA18392@palantir8> <s5hpt22ni23.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hpt22ni23.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

Sorry for the late reply. I was travelling and forgot to check alsa-devel
(shame on me!). Besides, it seems quite hard to get hold of a sparc32 to
test on while on the road.

On Thu, Nov 25, 2004 at 03:01:56PM +0100, Takashi Iwai wrote:
> I modified some codes to adapt to the latest 2.6.10-rc2, and reduced
> compile warnings (just checked with the cross-compile environment.)
> ALso, the spin_lock() is changed to spin_lock_irq() in the prepare
> callback since the recent version is it became non-atomic.
> The patch is below.
> 
> If you think your driver is mature to merge to Linux kernel, let me
> know.   Otherwise I'll merge it to alsa-driver tree which is regarded
> as the experimental tree and not submitted to mainstream kernel.

I consider the code still expermental, so alsa-driver is okay. I'd like some
other sparc folks to try it before it gets submitted to mainstream, even if
it works okay for me.

> BTW, the build environment of alsa-driver for sparc has been fixed
> recently on CVS.

Thanks for the tip. I'll check it out.

Martin


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
