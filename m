From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: User land drivers.
Date: Fri, 3 Sep 2004 16:31:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409031628530.21405@linux.local>
References: <413456AE.7000007@superbug.demon.co.uk>
 <Pine.LNX.4.58.0409031603060.21405@linux.local> <s5hy8jrwhoy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 728E424C
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 16:43:25 +0200 (MEST)
In-Reply-To: <s5hy8jrwhoy.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Sep 2004, Takashi Iwai wrote:

> Also, we may provide a more easy-to-use interface for additional ALSA
> pcm plugins.  The current design of plugin is bound too tightly to the
> ALSA lowlevel structure, and it's a pain to implement all on that at
> each time.

I think that we should follow the kernel space here - create only helper 
functions which might be used in the user space driver design.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
