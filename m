From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Thu, 21 Feb 2002 14:08:09 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202211403480.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.31.0202211131050.502-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 21 Feb 2002, Jaroslav Kysela wrote:

>> Btw; shouldn't that be 'avail > pcm->stop_threshold'...? For
> Yes, but in this case avail == 0, so the XRUN doesn't occur. But it's
> true, that the check for XRUN should be active only when PCM state is
> RUNNING. I'll correct it soon.

Ok, sounds good. One thing to remember is that if stream is already in
XRUN state, snd_pcm_hw_avail_update() should always return -EPIPE.

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
