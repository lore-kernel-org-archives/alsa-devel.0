From: Jeremy Hall <jhall@maoz.com>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: Thu, 7 Aug 2003 07:07:52 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308071107.h77B7q88030388@sith.maoz.com>
References: <Pine.LNX.4.44.0308071003230.861-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0308071003230.861-100000@ecabase.localdomain> from
 Kai Vehmanen at "Aug 7, 2003 10:05:28 am"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: Jeremy Hall <jhall@maoz.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

WICKED!

How does THAT work? when was that feature added? how does it maintain 
sample-synch? Is it better to use a pcm_multi or this option?

I suspect people are finding locking issues in the multi code, but not 
sure.  I'm doing ok with it in 2.5.75-mm1, although I'm having latency 
issues and clients get killed when you use jack_connect in rapid fire.

_J

In the new year, Kai Vehmanen wrote:
> On Thu, 7 Aug 2003, Jeremy Hall wrote:
> 
> > Kai, did you make a multi out of your cards together?
> 
> Nope, jackd accessed the individual soundcards directly (... "-d alsa -d
> hw:{0,1,2}").
> 
> > In the new year, Kai Vehmanen wrote:
> >> No lockups so far with the following setup:
> >> 
> >> 2.4.19-ll
> >> ALSA CVS of today 
> >> JACK CVS of today
> >> snd-ens1371/snd-ice1712/snd-dummy low-level drivers (tried all three)
> >> jackd run SCHED_FIFO with -n 3 -p 256
> >> two or more JACK clients active
> >> 
> >> Do you get lockups if you use snd-dummy as the lowlevel driver? How about
> >> without ardour (just jackd and some example clients running)?
> 
> -- 
>  http://www.eca.cx
>  Audio software for Linux!
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
