From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Wed, 13 Feb 2002 18:44:43 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202131842190.495-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA22517
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 18:45:16 +0100
In-Reply-To: <200202131727.g1DHRM604896@op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Feb 2002, Paul Davis wrote:

> should it work for me to call snd_pcm_drop() for both playback and
> capture streams if i'm in the middle of a snd_pcm_mmap_{begin,commit}
> pair?

Nope. Do you think that we need to lock these related code blocks in
alsa-lib for threaded applications or leave this locking for application
coders?

> unless i use RT timing, on both the trident and hammerfall, doing do
> invariably causes an effect upon restarting the streams that suggests
> an out-of-sync hw-pointer.

I don't wonder.
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
