From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: [Jackit-devel] Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Thu, 14 Feb 2002 19:09:16 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202141851050.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200202141355.IAA27451@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: jackit-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Feb 2002, Paul Davis wrote:

>>- no xruns are detected even though after the timeout
>>  alsa_driver_wait() took 56.4msec which is more than
> cards, i am starting to suspect part of jack's design rather than
> ALSA, but i have not yet managed to figure out what it could be. when
> i check the channel_area_t addresses used by jack, they also appear to
> be just as one would expect.

It seems that the problem is:

- engine->process() is possibly a slow operation
- ALSA is unable to detect xruns inside mmap_begin()->mmap_commit()
  code block
-> engine->process() should not be inside the 
   begin()->commit() block

But the problem is that, as I understand it, mmap_begin() and
mmap_commit() are used to notify when application starts and stops
accessing a memory-mapped area. And engine->process() needs to do just
that, access the memory areas. This is the whole point of direct access.

So what we need is:

1. added layer of copying (I'd be suprised if anyone accepted 
   this one :)) so we can commit() the capture regions before
   entering engine->process()
2.a) way to notice that an xrun has happened during b->c 
  b) ability to reset the streams
3. way to make sure that engine->process() never takes longer
   than period_time*number_of_periods

Any ideas? I'd imagine this a problem all applications using the ALSA pcm
mmap API have to solve somehow (ecasound uses the read/write API so this
is all new to me).

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
