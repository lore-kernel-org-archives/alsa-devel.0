From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: pcm_jack plugin attempt
Date: Wed, 12 Feb 2003 22:57:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302122157410.30420-100000@pnote.perex-int.cz>
References: <20030212185838.15069c79.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030212185838.15069c79.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Feb 2003, Maarten de Boer wrote:

> > > I now have pmc->jack playback working nicely! Tomorrow I will do capture,
> > > which should be a piece of cake. 
> 
> Hmmm.. Something broke. After doing a CVS update, everything stopped
> working. I reverted to yesterday's CVS, and it worked again. I'll
> explain what happens, maybe you see how your changes are involved here,
> and how to fix it (in my code, most likely)
> 
> Yesterday, I got a couple of calls to my snd_pcm_jack_mmap_commit, a
> call to snd_pcm_jack_start, where I started the jack process, and I
> continued receiving snd_pcm_jack_mmap_commit calls, where I forwarded
> the appl_ptr (with snd_pcm_mmap_appl_forward). The jack process copies
> copies snd_pcm_mmap_areas(pcm) from the snd_pcm_mmap_hw_offset(pcm) to
> the jack buffer, and forwards the hw_ptr (snd_pcm_mmap_hw_forward).
> snd_pcm_jack_avail_update(snd_pcm_t *pcm) simple returns
> snd_pcm_mmap_avail(pcm). This worked fine (with aplay -Dmyplug, where
> 
> pcm.myplug
> {
>         type plug
>         slave
>         {
>                 pcm "myjack"
>         }
> }
> 
> pcm.myjack
> {
>         type jack
> }
> 
> 
> This is, as I understand, how we concluded in our previous mails.
> 
> Now, today, after a CVS update, I don't get any snd_pcm_jack_mmap_commit
> anymore after the snd_pcm_jack_start. Why? The result obviously is that
> only the data that has been written to the mmap areas before the start
> get copied in a loop to jack.

I've updated a bit your code, but I cannot test it myself, because I 
cannot connect to a jack port - invalid destination port name - (I'll 
look what's wrong tomorrow).

> > > One question. For testing I use aplay, which now uses almost 100% cpu. Adding
> > > a usleep in snd_pcm_jack_delay solves that problem, but I am sure it is not
> > > the right way. How should I do it?
> > 
> > Do you handle "poll" in your plugin? Initialize "pcm->poll_fd", 
> > "pcm->poll_events" and make your own "poll_revents" callback if necessary.
> > The thread which manages the jack transfers have to acknowlede that there 
> > is some room (or data - capture) in the ring buffer.
> 
> poll_revents is a pretty recent addition isn't it? 
> 
> What I try now is
> - create a socketpair
> - set pcm->poll_fd to one end of the socketpair
> - writing 1 byte into the other in the jack process callback
> - read this 1 byte in the poll_revents callback (if not, poll keeps
>   returned true)
> 
> Is this the way to go?

Yes, it should work, but I've added missing poll_revents callback 
initialization.

> > > If I send you my code - once I have capture working - could you have a look at
> > > it?
> > 
> > Yes, of course. I can put your sources to CVS immediately and we can 
> > improve it then.
> 
> Which would mean I would have CVS write access?

Not really, I and Takashi verify the patches before they're commited to 
CVS.

> I attach my src/pcm/pcm_jack.c and a patch with the other changes. I added a --with-jack
> option to configure jack support.

I've commited your code to CVS so we can share it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
