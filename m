From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Thu, 20 Feb 2003 20:55:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302202045550.1266-100000@pnote.perex-int.cz>
References: <3E551713.7E5BB141@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E551713.7E5BB141@libero.it>
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

On Thu, 20 Feb 2003, Abramo Bagnara wrote:

> Now I'm able to get the same results you see.
> 
> However I think that we need to extract some results from this data.
> 
> I'll leave alone MMX optimizations because I want to compare apples with
> apples.
> 
> The distributed saturation (also when it's missing the check/repeat
> concurrency correctness part) costs more than 4 times the ticks needed
> for a (fully correct wrt concurrency) saturate once approach for the
> case 2048 8 32768.
> 
> CPU clock: 1460477150.884593
> mix_areas0: 86747 0.031975%
> mix_areas1: 259424 0.095623% (0)
> mix_areas1_mmx: 253894 0.093585% (0)
> mix_areas2: 132321 0.048773% (365)
> mix_areas3: 332411 0.122526% (0)
> 
> The server based approach has an added cost of an extra context switch
> every period (about 1500 cycles on my machine i.e.), but this is fully
> amortized by such an huge difference.
> 
> What's your opinion?

Interesting is that my Intel P3 CPU has slightly different times:

pnote:/home/perex/alsa/alsa-lib/test # ./code 2048 8 32768
Scheduler set to Round Robin with priority 99...
CPU clock: 847.292487Mhz (UP)

Summary (the best times):
mix_areas_srv : 576382 0.366206%
mix_areas0    : 556852 0.353798%
mix_areas1    : 867989 0.551480%
mix_areas1_mmx: 625144 0.397187%
mix_areas2    : 903335 0.573937%

areas1/srv ratio     : 1.505927
areas1_mmx/srv ratio : 1.084600

I think that we can lose more in the client/server model. Also, note that
we can use even futexes (if there's a hope that the possible context
switch is acceptable) and then we can remove the cmpxchg trick and
write-retry trick and use MMX for parallel saturation of two samples (this
last can be used in the client/server model, too, indeed).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
