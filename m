From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Thu, 20 Feb 2003 17:49:17 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302201736580.1266-100000@pnote.perex-int.cz>
References: <3E54978A.D43EC9DE@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E54978A.D43EC9DE@libero.it>
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

> Jaroslav Kysela wrote:
> > 
> > On Wed, 19 Feb 2003, Abramo Bagnara wrote:
> > 
> > > The results are amazing and I'd say Jaroslav has done some mistakes in
> > > his handmade asm.
> > 
> > I don't think so. It seems that my brain still remembers assembler ;-)
> > You passed wrong values to my code so it did unaligned accesses.
> > 
> > Fixes to make things same:
> 
> I've done the needed changes in my version of sum.c to get correct
> results from asm version, but I'm still unable to get from it good
> performance numbers.
> 
> I'm puzzled...
> 
> $ ./sum 2048 8 32768
> CPU clock: 1460474444.671998
> mix_areas0: 90773 0.033459%
> mix_areas1: 141173 0.052036% (1103)
> mix_areas2: 870134 0.320731% (0)
> mix_areas3: 343792 0.126722% (0)

1) my asm code used lock prefix so there are huge differences in code for 
   UP and MP on i386
2) we need to clear dst and sum buffers to work with same values for all
   routines
3) we need to clear the CPU caches

I've commited updated alsa-lib/test/code.c which solves all these troubles 
and I've added next optimizations to my asm routine and results are (not 
impressive, but I'm better than GCC, especially using MMX 
saturation instruction):

pnote:/home/perex/alsa/alsa-lib/test # ./code 2048 8 32768
Scheduler set to Round Robin with priority 99...
CPU clock: 847.293134Mhz (UP)

Summary (the best times):
mix_areas0    : 548456
mix_areas1    : 863636
mix_areas1_mmx: 629765
mix_areas2    : 910819

pnote:/home/perex/alsa/alsa-lib/test # ./code 2048 8 32768
Scheduler set to Round Robin with priority 99...
CPU clock: 847.293395Mhz (SMP)

Summary (the best times):
mix_areas0    : 562342
mix_areas1    : 1705274
mix_areas1_mmx: 1565539
mix_areas2    : 1735491

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
