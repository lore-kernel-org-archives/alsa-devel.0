From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] MPU-401 fixes
Date: Wed, 7 May 2003 09:56:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305070956200.7448-100000@pnote.perex-int.cz>
References: <s5hu1c8avc7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu1c8avc7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 6 May 2003, Takashi Iwai wrote:

> > Ok, I'm now using the spin_trylock check in the trigger function and 
> > RX_LOOP and TX_LOOP protectors are removed now. Hopefully, it finally 
> > solves our problem.
> 
> i'm afraid no.  as mentioned before, we need to consider to avoid two
> things:
> 
> 1. (infinite) recursive call of trigger() (via input_read())
> 2. double spinlocks around input_read() from irq handler and
>    the suceeding call of trigger()
> 
> introducing spin_trylock() solves the case #2 but not case #1,
> since spin_trylock() always returns 1 on UP.
> for #1, an extra (formerly RX_LOOP bit) flag is still necessary.

I see. So the protectors are back in trigger() callbacks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
