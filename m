From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Safe to call snd_pcm_close after failed snd_pcm_open?
Date: Tue, 9 Sep 2003 11:04:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309091102170.12936@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0309010807230.14319-100000@pnote.perex-int.cz>
 <3F53D15B.3090507@superbug.demon.co.uk> <Pine.LNX.4.53.0309021232410.29300@pnote.perex-int.cz>
 <3F548405.80902@superbug.demon.co.uk> <Pine.LNX.4.53.0309041141580.4568@pnote.perex-int.cz>
 <opru73f61vq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <opru73f61vq1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Sep 2003, Arve Knudsen wrote:

> Hi
>
> Is it safe to call snd_pcm_close for a pcm which failed to open (assuming
> the pcm handle is !NULL)? Not that important, but it might simplify my
> code somewhat.

No, if open failed, the pcm handle is unitialized, thus
the snd_pcm_close() call is not allowed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
