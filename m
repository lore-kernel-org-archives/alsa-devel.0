From: Paul Davis <pbd@op.net>
Subject: Re: pcm_drain() behavior (Re: snd_pcm_close hangs)
Date: Mon, 24 Jun 2002 10:14:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206241412.g5OEChf09030@post2.fast.net>
References: <s5hlm9494nq.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 24 Jun 2002 15:39:53 +0200."
             <s5hlm9494nq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Tim Goetze <tim@quitte.de>
List-Id: alsa-devel@alsa-project.org

>but..  from my feeling, i agree with you.  it doesn't matter if the
>samples are simply dropped at close() when its stream was already
>stopped.  so i myself would like to change this behavior.
>the fix must be quite easy.
>
>however, we need a consensus about this.

i agree with the proposal.


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
