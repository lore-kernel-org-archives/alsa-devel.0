From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 16:21:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E50FDE6.81199A36@libero.it>
References: <Pine.LNX.4.44.0302171553180.1054-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jaroslaw Sobierski <fycio@gucio.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Mon, 17 Feb 2003, Abramo Bagnara wrote:
> 
> > You're wrong: xadd is atomic but xadd/read/saturation/write is not.
> >
> > Without the loop I've added you risk to write on hw_ring_buffer an *old*
> > value:
> >
> > A:            B:
> > xadd
> > read
> >               xadd
> >               read
> >               saturate
> >               write
> > saturate
> > write
> 
> I see, the read/saturate/write must be atomic, too. In this case, it would
> be better to use a global (or a set of) mutex(es) to lock the hardware
> ring buffer. The futexes are nice.

They are nice indeed, but definitely not the right solution here.

Although I don't know if it's the absolute best solution, the 'retry'
approach I've proposed is far better and much more efficient.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
