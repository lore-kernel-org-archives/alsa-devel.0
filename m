From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: status pointer's problem with dmix.
Date: Thu, 18 Sep 2003 17:02:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309181650430.5983@pnote.perex-int.cz>
References: <200309181410.h8IEARdE017529@oud>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309181410.h8IEARdE017529@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Sep 2003, Paul Davis wrote:

> >The problem is that my application relies on a correct "delay" value, so
> >that it can use it to keep sound/video in sync.
>
> although i think that the dmix plugin should work correctly, i would
> be suprised, no, lets just say pleasantly suprised, if you could get
> perfect sound/video sync using it. otoh, i don't recall enough of
> jaroslav's description of how it worked at ZKM to really judge that.
>
> i suspect its a bit like trying to an audio interface with a "sloppy"
> hardware pointer. jaroslav will correct me, right jaroslav?

Actually the dmix plugin offers the stream position in "period-size"
steps, but it's no problem to call the standard ioctl() from the dmix
plugin to the real device to obtain the accurate stream position. I think
that it's the problem which James is noting.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
