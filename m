From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: pcm_jack plugin attempt
Date: Wed, 12 Feb 2003 10:15:33 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302121012390.14550-100000@pnote.perex-int.cz>
References: <20030211183624.31306337.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030211183624.31306337.mdeboer@iua.upf.es>
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

On Tue, 11 Feb 2003, Maarten de Boer wrote:

> > [...]
> > Nope. The snd_pcm_mmap_appl_forward(pcm, size) is the appropriate.
> > [...]
> > I think that it should be opposite:
> > 
> > appl_ptr should be increased when application writes samples (commit) and
> > hw_ptr should be increased when jack callback processes samples
> 
> Okay, your mail made everything fall into place in my mind :-)
> 
> I now have pmc->jack playback working nicely! Tomorrow I will do capture,
> which should be a piece of cake. 
> 
> One question. For testing I use aplay, which now uses almost 100% cpu. Adding
> a usleep in snd_pcm_jack_delay solves that problem, but I am sure it is not
> the right way. How should I do it?

Do you handle "poll" in your plugin? Initialize "pcm->poll_fd", 
"pcm->poll_events" and make your own "poll_revents" callback if necessary.
The thread which manages the jack transfers have to acknowlede that there 
is some room (or data - capture) in the ring buffer.

> If I send you my code - once I have capture working - could you have a look at
> it?

Yes, of course. I can put your sources to CVS immediately and we can 
improve it then.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
