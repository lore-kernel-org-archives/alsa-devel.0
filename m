From: Glenn Maynard <glenn@zewt.org>
Subject: Re: Removal of assert() in alsa-lib
Date: Fri, 10 Dec 2004 00:46:08 -0500
Message-ID: <20041210054607.GX14919@zewt.org>
References: <s5hzn0ym14c.wl@alsa2.suse.de> <Pine.LNX.4.58.0412011849430.2108@pnote.perex-int.cz> <s5hu0r5nbi6.wl@alsa2.suse.de> <s5h4qj429hh.wl@alsa2.suse.de> <s5hzn0n8mqd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hzn0n8mqd.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 09, 2004 at 05:23:06PM +0100, Takashi Iwai wrote:
> +void snd_err_msg(const char *file, int line, const char *function, int err, const char *fmt, ...) __attribute__ ((format (printf, 5, 6)));

Can this be a weak symbol, so it can be overridden by user code?

If my application causes errors on some version of ALSA, having diagnostic
information going to stderr is inconvenient: I centralize all diagnostics
for bug reporting in a single file, so I don't have to pull teeth from users
to have them copy bits of information from other places.

As long as snd_err_msg() is only called on "unexpected" errors (eg. what
used to be assertion failures), and made a weak symbol, I can redirect it
to my logs.

I currently do this with __assert_fail() and __assert_perror_fail(), and I'd
like to continue to be able to catch all important diagnostic output
automatically.

-- 
Glenn Maynard


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
