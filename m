From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: future ALSA development
Date: Thu, 3 Jul 2003 17:21:29 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307031655560.27053-100000@ecabase.localdomain>
References: <Pine.LNX.4.44.0306222010030.1838-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ecabase.localdomain (cs78235140.pp.htv.fi [62.78.235.140])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA23264
	for <alsa-devel@alsa-project.org>; Thu, 3 Jul 2003 16:26:00 +0200
In-Reply-To: <Pine.LNX.4.44.0306222010030.1838-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 22 Jun 2003, Jaroslav Kysela wrote:

> 	here are my next goals for the ALSA library development (short 
> term). I invite all developers to comment these directions.
[...]
> * create ordinary pcm & mixer interfaces

These are very welcome additions, especially the mixer part! Although most
people can easily use (for instance) alsamixer, the controls on some cards
are hopelessly confusing. Having all cards publish a simple set of
standard controls will significantly improve ALSA's user-friendliness. It
would be good if even the high-end cards would provide a mapping to these
simple controls. Ideally, a DVD player using the simple PCM and mixer
interfaces would work as expected even if your card is a Hammerfall or
some ice1712-based.

> * investigate a lisp integration to the current configuration syntax
[...]
>   - I don't rely on lisp, but what another interpreter with function
>     definition has only 22kB binary (slisp-1.2 - i686)?

Hmm, it'd be great if this functionality was optional (at build time). 
Although I must admit 22kB is not much... 

> * initiate a development of a graphical tool which will manage
>   the alsa configuration files (~/.asoundrc)

One possible addtional item (not alsa-lib specific):

* making alsa-conf the primary tool for setting up ALSA user-space

I'm not sure what's the status of alsa-conf is currently, but based on the 
mailing list activity and ALSA websites, it doesn't seem to be widely 
used. OTOH; the few times I've tried it, it has worked well. And what's 
most important, it solves two of the top-3 user problems with setting up 
ALSA:

1. Finding out what audio hardware you have and what is the
   correct ALSA module.
2. Editing modules.conf.
3. Managing to compile alsa-driver against kernel sources.

... alsa-conf solves (1) and (2), while (3) will be history once linux-2.6
is released. Hmm, editing asoundrc is also one common issue, but as
asoundrc is not required to get a basic ALSA setup up, it's not in my
top-3. :)

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
