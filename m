From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: User land drivers.
Date: Fri, 3 Sep 2004 17:57:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409031756110.21405@linux.local>
References: <413456AE.7000007@superbug.demon.co.uk>
 <Pine.LNX.4.58.0409031603060.21405@linux.local> <s5hy8jrwhoy.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0409031628530.21405@linux.local> <41389491.1030804@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 69C172C8
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 18:10:17 +0200 (MEST)
In-Reply-To: <41389491.1030804@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Sep 2004, James Courtier-Dutton wrote:

> Currently, to support a new sound card in ALSA, we just write a small 
> bit of code to talk to the hardware, and other alsa kernel modules 
> provide all the helper functions(period_elapsed etc.), so for a user 
> land driver(bluetooth), these helper functions should be in alsa-lib.

Exactly.

> You mention the PCM plugin. I did not know there was already a PCM 
> plugin api that could be used to talk to some other user land program. I 
> just thought the PCM plugins were for sample rate conversion and simple 
> stuff like that.

No, unfortunately, the PCM plugin interface is completely hidden inside
alsa-lib. But we can add some plugins like ladspa/meter/jack plugin which
can connect to other external code.

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
