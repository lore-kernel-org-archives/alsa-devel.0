From: Pavel Roskin <proski@gnu.org>
Subject: Re: pkg-config for alsa?
Date: Wed, 2 Oct 2002 09:46:52 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210020856250.5153-100000@portland.hansa.lan>
References: <s5hy99hjdjw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy99hjdjw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

I haven't done any development for sound in the userspace, so don't put
too much weight into my words, but for what it's worth ...

> i'd like to rewrite configure for alsa-utils and alsa-tools to use
> pkg-config for alsa-lib.  you might have found alsa.pc already in
> alsa-lib. the only concern is that pkg-config is unlikely installed as a
> standard tool in most distributions.  but surely pkg-config is the right
> way to go.

I would object if portability between operating systems was desired.  But
since L in ALSA stands for Linux, it's probably a reasonable requirement.
I believe that somebody should rewrite pkgconfig in shell, so that it
could be distributed with packages.

I have no problem with giving pkgconfig more exposure, since I'm not aware
of any alternatives.  It addresses an issue that other tools don't
address.  For example, libtool doesn't keep path to the headers.  m4
macros either do wild guessing or resolve to a supplied executable script
(like glib-config), which is worse than pkgconfig, because pkgconfig
behaves in a more predictable way than a bunch of little scripts.

> also, how about to add a define "-DALSA_PCM_NEW_HW_PARAMS_API" to cflags
> in alsa.pc, so that the new PCM API is chosen if someone uses pkg-config
> ?  there is still alsa.m4 for the older API, so existing applications
> don't suffer by this.

Maybe it's too late to comment on this, but I don't like the name of that
define.  What is new today will be old one year later.  Instead of
inventing new names, it's better to use versions of API.  The application
would define what API version is expects, and the headers would enable
corresponding API or report that the given version of API is no longer
supported.

I understand that it would be convenient to force the applications to the 
new API when they switch to pkgconfig, but it would be even better to have 
them define the API they except themselves, so that it could later be 
updated in the right place - in the applications (together with the code
that needs updating).

While at this issue, is it possible to compile everything from CVS without
intermediate installs?  I mean, compile alsa-lib against the headers of
alsa-driver in CVS and alsa-util against alsa-lib in CVS. If it's
possible, please make sure not to break this functionality.  Otherwise,
I'd like to see it added (probably through temporary rc files for
uninstalled library and drivers).

-- 
Regards,
Pavel Roskin




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
