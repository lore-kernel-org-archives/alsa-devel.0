From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 20:45:55 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302172038300.15268-100000@pnote.perex-int.cz>
References: <1045495976.3e5100a8efb9b@webmail3.namezero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045495976.3e5100a8efb9b@webmail3.namezero.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslaw Sobierski <fycio@gucio.com>
Cc: "abramo.bagnara@libero.it" <abramo.bagnara@libero.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Feb 2003, Jaroslaw Sobierski wrote:

> >> I see, the read/saturate/write must be atomic, too. In this case, it would
> >> be better to use a global (or a set of) mutex(es) to lock the hardware
> >> ring buffer. The futexes are nice.
> >
> >They are nice indeed, but definitely not the right solution here.
> >
> >Although I don't know if it's the absolute best solution, the 'retry'
> >approach I've proposed is far better and much more efficient.
> 
> I have to agree with Abramo. A global mutex would cause long and unnecessary 
> waits for the processes trying to write to the plugin. Locking access to
> individual parts of the buffer is messy. Notice that concurrent writes 
> to the same sample in the buffer will occur sporadically, and the "re-read"
> in the loop costs almost nothing, while synchronization mechanisms could 
> block often.

Note that your all nice ideas go to some blind alley. Who will silence the 
sum buffer? Driver silences only hardware buffer which will not be used 
for the calculation in your algorithm.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
