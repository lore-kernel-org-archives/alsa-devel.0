From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The ALSA Situation
Date: Thu, 11 Nov 2004 10:23:44 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411111021520.2301@ppc970.osdl.org>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
 <Pine.LNX.4.58.0411110714280.2179@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411102241240.2301@ppc970.osdl.org> <s5his8cfiot.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0411110855380.2301@ppc970.osdl.org> <s5hhdnwfgbz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhdnwfgbz.wl@alsa2.suse.de>
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



On Thu, 11 Nov 2004, Takashi Iwai wrote:
> 
> Oh, that's hard to tell what should be the "default" parameters.
> This strongly depends on the board.

Which is exactly why apps should not even try to set them.

My point is that the driver can select some default parameters, and then 
users just use them by default, and thus there are no issues of 
synchronizing between them.

> ALSA tries to provide as much function as possible.  This results in
> variety of configurations, i.e. the famous complexity.

That may or may not be a valid excuse.

Complexity also often arises from bad decisions. And the decision to only 
have one user open at a time appears like a pretty fundamentally bad one.

		Linus


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
