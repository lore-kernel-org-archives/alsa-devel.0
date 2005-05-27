From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [ALSA - lib 0000154]: Master volume only controls
 front output (emu10k1)
Date: Fri, 27 May 2005 16:08:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505271605220.1757@pnote.perex-int.cz>
References: <da3ba5a8e39a99b562591bfbaba64ac7@bugtrack.alsa-project.org>
 <428E803F.9050608@voicenet.com> <42972875.7040309@voicenet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42972875.7040309@voicenet.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam K Kirchhoff <adamk@voicenet.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 27 May 2005, Adam K Kirchhoff wrote:

> Adam K Kirchhoff wrote:
> 
> > bugtrack@alsa-project.org wrote:
> >
> >>
> >> ----------------------------------------------------------------------
> >> rlrevell - 05-20-05 22:05 
> >> ----------------------------------------------------------------------
> >> Sorry, I don't have time to work on this.  Please bug the ALSA 
> >> developers
> >> to get the abstract mixer layer finished.
> >>
> >>  
> >>
> >
> > Hey developers, what's up with the abstract mixer layer? :-)
> >
> > Adam
> >
> >
> 
> Anyone?

I am working on it, but also doing zillions of other things. The actual 
status is that the virtual mixer can be created inside the lisp 
interpreter. I am looking for a clever code design to map the hardware 
controls with minimal lisp code to abstract ones.... I need something like 
an object model inside lisp (object == mixer element).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
