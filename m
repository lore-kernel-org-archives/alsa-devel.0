From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Removal of assert() in alsa-lib
Date: Fri, 10 Dec 2004 08:49:36 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0412100848580.1749@pnote.perex-int.cz>
References: <s5hzn0ym14c.wl@alsa2.suse.de> <Pine.LNX.4.58.0412011849430.2108@pnote.perex-int.cz>
 <s5hu0r5nbi6.wl@alsa2.suse.de> <s5h4qj429hh.wl@alsa2.suse.de>
 <s5hzn0n8mqd.wl@alsa2.suse.de> <20041210054607.GX14919@zewt.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041210054607.GX14919@zewt.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn Maynard <glenn@zewt.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Dec 2004, Glenn Maynard wrote:

> On Thu, Dec 09, 2004 at 05:23:06PM +0100, Takashi Iwai wrote:
> > +void snd_err_msg(const char *file, int line, const char *function, int err, const char *fmt, ...) __attribute__ ((format (printf, 5, 6)));
> 
> Can this be a weak symbol, so it can be overridden by user code?

snd_lib_error_set_handler() (or something similar) will do it for you.

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
