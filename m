From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: [PATCH] plugin_ops.h fixes
Date: Tue, 09 Jul 2002 11:23:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2AAB9E.C401BD17@libero.it>
References: <3D295521.A14C950@ladisch.de> <s5hadp2v7ni.wl@alsa2.suse.de>
	 <3D29C6D0.D0B442F0@libero.it> <3D2AA09B.12C7B125@ladisch.de>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> 
> Abramo Bagnara wrote:
> > min & max are interchanged indeed. My bad...
> 
> Oh, there's no problem with using _max instead of _min  -- I just
> noticed that the code for _max writes 0 for unsigned 16/24/32-bit
> values ...  ;o)

Fixed now in CVS.

> 
> > Use of 32/64 bits for 24/32 bit is wanted. Take in account that this
> > function is called on mix results (where I need to avoid wrap before
> > normalization).
> 
> Then it should use bigger types for 8/16 bits, too. Checking for a type
> to overflow its own valid range seems to be rather pointless to me.

It *does* use bigger types.

> 
> > > > And the summing/normalization code in pcm_route.c treats the sample as
> > > > if it were unsigned.
> >
> > Be careful here. Use of signed vs. unsigned was an hard decision.
> > Can you point me exactly where you see a problem?
> 
> In the following code snippet
> 
>         add_int64_att:
>                 sum.as_sint64 += (u_int64_t) sample * ttp->as_int;
> 
> each of the three variables has a signed integer type. Converting
> the sample from int32_t to u_int64_t would give wrong results for
> negative values, e.g., the sample -1 (0xffffffff) would be converted
> to 4294967295 (0x00000000ffffffff).
> 
> The following code
> 
>         norm_int:
>                 if (sum.as_sint64 > (u_int32_t)0xffffffff)
>                         sample = (u_int32_t)0xffffffff;
>                 else
>                         sample = sum.as_sint64;
> 
> doesn't check for negative values of sum.as_sint64. Additionally,
> using 0xffffffff in case of overflow results in sample == -1.
> 
> These code snippets would be correct if the sample would be unsigned,
> but my point was that this isn't the case.

I've just checked: this has been broken by Jaroslav with CVS version
1.55. I'd like to restore the original behaviour I wrote (that used
unsigned for efficiency reason), but I don't understand what Jaroslav
tried to solve.

Jaroslav?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Stuff, things, and much much more.
http://thinkgeek.com/sf
