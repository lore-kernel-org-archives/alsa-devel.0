From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: return value of snd_pcm_wait()
Date: Mon, 14 Jul 2003 16:39:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307141638510.27533-100000@pnote.perex-int.cz>
References: <s5hel0tuqxx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hel0tuqxx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Jul 2003, Takashi Iwai wrote:

> Hi,
> 
> currently, snd_pcm_wait() returns -EIO if any error happens during
> poll(), regardless what really happened.
> i believe it's better to return a reasonable error code corresponding
> to the current state, such as -EPIPE and -ESTRPIPE.
> 
> the attached patch adds this feature by calling snd_pcm_state() in
> snd_pcm_wait().  this cleans up also some codes there.
> 
> i think there is no major drawback by this change.  but i'd like to
> ask here to make it sure.

This change is ok for me.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
