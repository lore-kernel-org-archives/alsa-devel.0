From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Thu, 21 Feb 2002 12:25:11 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202211221370.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.31.0202210913180.578-100000@pnote.perex-int.cz>
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

> Yes, this condition is faulty. It should be 'avail >= pcm->stop_threshold'.

Btw; shouldn't that be 'avail > pcm->stop_threshold'...? For
     instance if you want to prefill playback buffers
     with silence before starting processing, you must be able
     to write buffer_size==stop_threshold frames of data.

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
