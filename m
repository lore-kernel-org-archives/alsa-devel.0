From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Tue, 18 Feb 2003 22:07:06 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302182159440.1636-100000@pnote.perex-int.cz>
References: <3E520454.C2D74B18@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E520454.C2D74B18@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jaroslaw Sobierski <fycio@gucio.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Feb 2003, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > On Mon, 17 Feb 2003, Jaroslaw Sobierski wrote:
> > 
> > > >> I see, the read/saturate/write must be atomic, too. In this case, it would
> > > >> be better to use a global (or a set of) mutex(es) to lock the hardware
> > > >> ring buffer. The futexes are nice.
> > > >
> > > >They are nice indeed, but definitely not the right solution here.
> > > >
> > > >Although I don't know if it's the absolute best solution, the 'retry'
> > > >approach I've proposed is far better and much more efficient.
> > >
> > > I have to agree with Abramo. A global mutex would cause long and unnecessary
> > > waits for the processes trying to write to the plugin. Locking access to
> > > individual parts of the buffer is messy. Notice that concurrent writes
> > > to the same sample in the buffer will occur sporadically, and the "re-read"
> > > in the loop costs almost nothing, while synchronization mechanisms could
> > > block often.
> > 
> > Note that your all nice ideas go to some blind alley. Who will silence the
> > sum buffer? Driver silences only hardware buffer which will not be used
> > for the calculation in your algorithm.
> 
> 
> Not so blind ;-)
> 
> 	v = *src;
> 	if (cmpxchg(hw, 0, 1) == 0)
> 		v -= *sw;
>         xadd(sw, v);
>         do {
>                 v = *sw;
>                 if (v > 0x7fff)
>                         s = 0x7fff;
>                 else if (v < -0x8000)
>                         s = -0x8000;
>                 else
>                         s = v;
>                 *hw = s;
>         } while (unlikely(v != *sw));
> 
> I've convinced you?
> 
> However as I've written in the my first message the evil of dmix
> approach lies in details: they might destroy efficiency of approach
> rather easily.

I've implemented the whole transfer and mix loop in assembly and it works
without any drastic impact on CPU usage. I tried to optimize the assembler
part as much as I can, but if some assembler guru want to give a glance,
I'll appreciate it. The function is named mix_areas1() in
alsa-lib/src/pcm/pcm_dmix.c.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
