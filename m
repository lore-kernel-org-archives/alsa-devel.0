From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Re: [Jackit-devel] Re: should i be able to abort
 in the middle of snd_pcm_mmap_{begin,commit} ?
Date: Thu, 14 Feb 2002 19:48:18 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202141941020.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.31.0202141829480.510-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: jackit-devel@lists.sourceforge.net
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Feb 2002, Jaroslav Kysela wrote:

>> - ALSA is unable to detect xruns inside mmap_begin()->mmap_commit()
>>   code block
> I wonder why you say this. There is really very short time period in which
> the hardware pointer can cross the application pointer and PCM code won't
> react on this situation. There are no locks for the xrun detection between
> mmap_begin() and mmap_commit().

Quoting Paul: "i recall abramo saying that if the xrun happens within an
mmap_begin/commit pair, the driver can't detect it, or something like
that." 

Anyways, in this case the hw pointer does reach the sw pointer and we
won't notice it (snd_pcm_state() reports SND_PCM_STATE_RUNNING).

> If you want to debug the real problem, try to print hw_ptr and appl_ptr
> pointers when sound is garbled.

I'll try that next.

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
