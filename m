From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] plugin_ops.h fixes
Date: Thu, 11 Jul 2002 10:00:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207110956570.608-100000@pnote.perex-int.cz>
References: <3D2CB325.FB7CA340@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D2CB325.FB7CA340@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Jul 2002, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > On Tue, 9 Jul 2002, Abramo Bagnara wrote:
> > 
> > > > > > > And the summing/normalization code in pcm_route.c treats the sample as
> > > > > > > if it were unsigned.
> > > > >
> > > > > Be careful here. Use of signed vs. unsigned was an hard decision.
> > > > > Can you point me exactly where you see a problem?
> > > >
> > > > In the following code snippet
> > > >
> > > >         add_int64_att:
> > > >                 sum.as_sint64 += (u_int64_t) sample * ttp->as_int;
> > > >
> > > > each of the three variables has a signed integer type. Converting
> > > > the sample from int32_t to u_int64_t would give wrong results for
> > > > negative values, e.g., the sample -1 (0xffffffff) would be converted
> > > > to 4294967295 (0x00000000ffffffff).
> > > >
> > > > The following code
> > > >
> > > >         norm_int:
> > > >                 if (sum.as_sint64 > (u_int32_t)0xffffffff)
> > > >                         sample = (u_int32_t)0xffffffff;
> > > >                 else
> > > >                         sample = sum.as_sint64;
> > > >
> > > > doesn't check for negative values of sum.as_sint64. Additionally,
> > > > using 0xffffffff in case of overflow results in sample == -1.
> > > >
> > > > These code snippets would be correct if the sample would be unsigned,
> > > > but my point was that this isn't the case.
> > >
> > > I've just checked: this has been broken by Jaroslav with CVS version
> > > 1.55. I'd like to restore the original behaviour I wrote (that used
> > > unsigned for efficiency reason), but I don't understand what Jaroslav
> > > tried to solve.
> > >
> > > Jaroslav?
> > 
> > You cannot use unsigned values, because we need to sum samples (it means:
> > add positive and substract negative ones). If we are in positive range, we
> > can only add samples, so the final sum result is wrong.
> 
> Wow, I've never realized this...
> So mixing can only be done with signed values, otherwise we have bogus
> value for overranges. Right?
> 
> Taken this in account, I'm tempted to consider unsigned formats as
> second class citizen (i.e. format hard to handle and with some added
> difficulties wrt manipulation). I'm wrong?

Yes, unsigned formats are dangerous in the sense of arithmetics.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
PC Mods, Computing goodies, cases & more
http://thinkgeek.com/sf
