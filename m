From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: .hw_free() while audio is running ??
Date: Sun, 8 Aug 2004 22:39:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408082235380.1771@pnote.perex-int.cz>
References: <20040808172946.43212219.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040808172946.43212219.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 8 Aug 2004, Giuliano Pochini wrote:

> It happened that the hw_free() callback was called for a running substream.
> System freezed. I had a look to the other drivers and none of them seems to
> take into account this possibility and my driver also doesn't support it. If
> it's my fault, please ignore the following.
> 
> Some details:
> 
> The call sequence in the logs is:
> 
> pcm_trigger (start)	- of two synced ss's
> pcm_hw_free (playback ss)
> Crash, nothing more in the logs :(
> 
> trigger(stop) wasn't called before hw_free.

You have an SMP machine? The hw_free is protected with the 
runtime->status->state checking, but the code is not protected with 
spinlock, so I suspect trouble here.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
