From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: pcm_lib.c & pcm_memory.c
Date: Wed, 24 Jul 2002 07:27:55 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020724142755.24288.qmail@web11504.mail.yahoo.com>
References: <s5hlm81nrh7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlm81nrh7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> > OK, then I know how to solve my problem, but it would have been nice to
> > avoid copy and silence callbacks, and just get from the substream or
> > runtime structure the hw offset where the next period is expected to be
> > written to.
> 
> sorry, i don't understand your question.
> 
> regardless of the existence of copy callbacks, the hw_ptr is updated
> automatically.  it has nothing to do with the behavior of copy/silence.
> 
> copy and silence callbacks are called to replace on behalf of
> copy_from/to_user().

Sorry if I wasn't clear. I have seen the snd_pcm_lib_read_transfer(), but
rather than define my own capture copy function, I would have preferred to
write directly to the place in dma_area expected by the framework. In other
words, is the hw offset stored in any structure accessible from a substream?
The other option (that I am pursuing now) is to write a capture_copy() function
and manage my own hw offset in parallel.

Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
