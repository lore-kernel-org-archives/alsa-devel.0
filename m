From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Re: dmix plugin
Date: Thu, 20 Feb 2003 18:57:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E551713.7E5BB141@libero.it>
References: <Pine.LNX.4.44.0302201736580.1266-100000@pnote.perex-int.cz>
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
> On Thu, 20 Feb 2003, Abramo Bagnara wrote:
> 
> > Jaroslav Kysela wrote:
> > >
> > > On Wed, 19 Feb 2003, Abramo Bagnara wrote:
> > >
> > > > The results are amazing and I'd say Jaroslav has done some mistakes in
> > > > his handmade asm.
> > >
> > > I don't think so. It seems that my brain still remembers assembler ;-)
> > > You passed wrong values to my code so it did unaligned accesses.
> > >
> > > Fixes to make things same:
> >
> > I've done the needed changes in my version of sum.c to get correct
> > results from asm version, but I'm still unable to get from it good
> > performance numbers.
> >
> > I'm puzzled...
> >
> > $ ./sum 2048 8 32768
> > CPU clock: 1460474444.671998
> > mix_areas0: 90773 0.033459%
> > mix_areas1: 141173 0.052036% (1103)
> > mix_areas2: 870134 0.320731% (0)
> > mix_areas3: 343792 0.126722% (0)
> 
> 1) my asm code used lock prefix so there are huge differences in code for
>    UP and MP on i386

Indeed, this made the difference.

> 2) we need to clear dst and sum buffers to work with same values for all
>    routines

This was present in sum.c

> 3) we need to clear the CPU caches

This has irrelevant impact in sum.c.

> I've commited updated alsa-lib/test/code.c which solves all these troubles
> and I've added next optimizations to my asm routine and results are (not
> impressive, but I'm better than GCC, especially using MMX
> saturation instruction):

Now I'm able to get the same results you see.

However I think that we need to extract some results from this data.

I'll leave alone MMX optimizations because I want to compare apples with
apples.

The distributed saturation (also when it's missing the check/repeat
concurrency correctness part) costs more than 4 times the ticks needed
for a (fully correct wrt concurrency) saturate once approach for the
case 2048 8 32768.

CPU clock: 1460477150.884593
mix_areas0: 86747 0.031975%
mix_areas1: 259424 0.095623% (0)
mix_areas1_mmx: 253894 0.093585% (0)
mix_areas2: 132321 0.048773% (365)
mix_areas3: 332411 0.122526% (0)

The server based approach has an added cost of an extra context switch
every period (about 1500 cycles on my machine i.e.), but this is fully
amortized by such an huge difference.

What's your opinion?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
