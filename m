From: Jeremy Hall <jhall@maoz.com>
Subject: Re: rme9652: possible deadlock
Date: Mon, 28 Apr 2003 04:25:28 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304280825.h3S8PSi8030008@sith.maoz.com>
References: <3EA7B654.2090108@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EA7B654.2090108@libero.it> from Abramo Bagnara at "Apr 24, 2003
 12:03:00 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jaroslav Kysela <perex@suse.cz>, Jeremy Hall <jhall@maoz.com>, "paul@linuxaudiosystems.com" <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

now I see your fix is in CVS, but I currently compile alsa into the kernel 
to aid in gdb.  Is it possible to compile alsa-kernel directly into the 
kernel? Does it have the irqreturn_t stuff in CVS?

Is there some doc I have shamelessly not read that explains this answer?

_J

In the new year, Abramo Bagnara wrote:
> Jaroslav Kysela ha scritto:
> > 
> > 
> > Bingo, I got it. You mean this scenario (linked two streams):
> > 
> > CPU0: stream1 interrupt: stream1 locked -> snd_pcm_stop()
> > CPU1: stream2 interrupt: stream2 locked -> snd_pcm_stop()
> > CPU0: try to lock stream2 (in ACTION macro)
> > CPU1: try to lock stream1 (in ACTION macro)
> > 
> > Yes, this is next deadlock issue.
> > 
> > I have probably only one solution in my brain: Separate snd_pcm_stop() to 
> > two steps:
> > 
> > 1) stop only the locked stream and unlock it
> > 2) stop all other linked streams
> 
> My proposal is to have a per "linked PCM group" lock and to use it for 
> proper locking (with also some side benefits substituting some use of 
> snd_pcm_link_lock).
> 
> This mean also we need to change the linked list struct from
> 
> struct _snd_pcm_substream {
> 	...
>          /* -- linked substreams -- */
>          snd_pcm_substream_t *link_next;
>          snd_pcm_substream_t *link_prev;
> 
> to
> 	struct list_head link_list;
> 	snd_pcm_link_t *link;	/* 0 for non linked stream */
> 
> typedef struct _snd_pcm_link {
> 	spinlock_t lock;
> 	struct list_head substreams;
> };
> 
> Of course creation and destruction of a snd_pcm_link_t need to be 
> protected by snd_pcm_link_lock.
> 
> 
> -- 
> Abramo Bagnara                       mailto:abramo.bagnara@libero.it
> 
> Opera Unica                          Phone: +39.546.656023
> Via Emilia Interna, 140
> 48014 Castel Bolognese (RA) - Italy
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
