From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Removal of assert() in alsa-lib
Date: Wed, 1 Dec 2004 18:51:44 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0412011849430.2108@pnote.perex-int.cz>
References: <s5hzn0ym14c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzn0ym14c.wl@alsa2.suse.de>
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

On Wed, 1 Dec 2004, Takashi Iwai wrote:

> The patch attached below is a part of changes to replace the excessive
> assert() with if & error-return.  It's for some PCM codes only.
> Any comments are appreciated.

I think that we should add new macros like SNDERR_VERBOSE etc. to not 
compile error messages to small version of ALSA library (for embedded 
devices etc). Almost all current assert()s meet this rule.

					Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
