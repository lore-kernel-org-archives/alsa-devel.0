From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 16:00:39 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302171553180.1054-100000@pnote.perex-int.cz>
References: <3E50E3D3.49AF1D55@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E50E3D3.49AF1D55@libero.it>
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

On Mon, 17 Feb 2003, Abramo Bagnara wrote:

> You're wrong: xadd is atomic but xadd/read/saturation/write is not.
> 
> Without the loop I've added you risk to write on hw_ring_buffer an *old*
> value:
> 
> A:		B:
> xadd
> read
> 		xadd
> 		read
> 		saturate
> 		write
> saturate
> write

I see, the read/saturate/write must be atomic, too. In this case, it would
be better to use a global (or a set of) mutex(es) to lock the hardware
ring buffer. The futexes are nice.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
