From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_ prefix for module options
Date: Wed, 09 Oct 2002 10:47:48 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210091005310.4186-100000@studcom.urz.uni-halle.de>
References: <s5hfzvh2fid.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hfzvh2fid.wl@alsa2.suse.de>
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

Takashi Iwai wrote:
> so, i'd like to ask you how do you think to remove this snd_ prefix.
> of course, there is one and only big problem - compatibility!
>
> the questions are
>
> - whether we should really do it or not?  is it worthy?

I'd say yes.

> - when? now or after 0.9.0-final release?

Better now than later, to minimize the number of installation which must
be changed. But the change will invalidate all modules.conf files and
every piece of documentation about it, so it should be announced loudly
and well in advance (and many people won't notice anyway until their
drivers refuse to load).

IMHO it would be nice if "make install" looks into modules.conf and
complains loudly if old parameters are found. And maybe snd.o should
detect the usage of old parameters, too, at least for some time.


Regards
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
