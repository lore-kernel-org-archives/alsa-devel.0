From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The ALSA Situation
Date: Fri, 12 Nov 2004 07:50:58 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411120741300.2301@ppc970.osdl.org>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
 <Pine.LNX.4.58.0411110714280.2179@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411102241240.2301@ppc970.osdl.org> <s5his8cfiot.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0411110855380.2301@ppc970.osdl.org> <s5hhdnwfgbz.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0411111021520.2301@ppc970.osdl.org> <s5hekizfo0n.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekizfo0n.wl@alsa2.suse.de>
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
Cc: Jaroslav Kysela <perex@suse.cz>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Fri, 12 Nov 2004, Takashi Iwai wrote:
>
> But, solving the concurrent access in another way in the *driver
> level* (the intermediate buffer or the soft-mixing) doesn't sound good
> to me.  It brings more complexity than the simple -EBUSY strategy.

I won't argue against that. I don't actually mind EBUSY myself. At least
it's a pretty obvious error condition, and together with some (alternate)  
mixing interface - whether user or kernel mode - I don't think there is
anything fundamentally wrong with just saying "I'm busy, I can't take you
right now".

My arguments have really been against blocking. And to some degree an 
argument against people thinking it's _good_ to set individual parameters. 

		Linus


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
