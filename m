From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Thu, 21 Feb 2002 11:35:37 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202211131050.502-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.44.0202211221370.3739-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 21 Feb 2002, Kai Vehmanen wrote:

> On Thu, 21 Feb 2002, Jaroslav Kysela wrote:
>
> > Yes, this condition is faulty. It should be 'avail >= pcm->stop_threshold'.
>
> Btw; shouldn't that be 'avail > pcm->stop_threshold'...? For
>      instance if you want to prefill playback buffers
>      with silence before starting processing, you must be able
>      to write buffer_size==stop_threshold frames of data.

Yes, but in this case avail == 0, so the XRUN doesn't occur. But it's
true, that the check for XRUN should be active only when PCM state is
RUNNING. I'll correct it soon.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
