From: Eric Sharkey <sharkey@netrics.com>
Subject: Re: problem with ALSA on AMD64 w/VIA chipset
Date: Mon, 22 Nov 2004 13:26:38 -0500
Message-ID: <E1CWIta-0001s1-00@mastermind.netrics.internal>
References: <s5hu0rhvm5c.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 22 Nov 2004 18:17:19 +0100."
             <s5hu0rhvm5c.wl@alsa2.suse.de>
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

> > This happens with both 64 and 32 bit kernels, and no amount of
> > twiddling with kernel parameters (ACPI/CPU frequency scaling, apic,
> > preemption, etc.) seems to make any difference.
> 
> Hmm, I just thought of cpurfreq, but your report sounds that it's not
> the case.  Could you unload powernow-k8 module just to be sure?

I've spent a good deal of time trying to track this down over the
last couple of months.  I've compiled and booted under more configurations
than I care to count.  I'm absolutely certain that with a kernel
with no power management support at all, and all power management turned
off in the bios, the problem still persists.

> I think you'd better to ask this on LKML, since the symptom looks like
> the kernel core problem.

Hmm.  Ok.

If there's something you can think of that I could do to gather more
information to help diagnose the problem, please let me know.

Thanks,

Eric


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
