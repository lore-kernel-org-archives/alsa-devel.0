From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: About integer64
Date: Thu, 9 May 2002 13:18:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205091316530.482-100000@pnote.perex-int.cz>
References: <200205091107.NAA14247@gate.perex.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200205091107.NAA14247@gate.perex.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Abramo Bagnara <abramo@alsa-project.org>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 May 2002, Paul Davis wrote:

> >I don't think that's a bad thing to have support for 64 bit integers
> >(perhaps for future use, who knows), but I think that to use this to
> >store a fixed point float is a big mistake.
> >
> >If you think for it you realize that it's *not* an integer and
> >applications are betrayed in their expectation.
> 
> in this case, it *is* an integer. your original question was about why
> its 64 bits - i think that comes from the fixed point internal
> arithmetic. but the end result is a straightforward 64 bit little
> endian integer that needs scaling to get the actual RMS value.
> 
> which actually creates another problem that i've noticed with the
> control API. INTEGER and INTEGER64 assume that the control value is
> signed. there is no way to infer from the control element info that
> its unsigned. this isn't a "deep" problem, but it will mess up user
> interfaces that present a large unsigned value and end up displaying
> it as a negative number.

I think that we can add 'int unsign: 1;' to sndrv_ctl_elem_info for 
integer and integer64. Any objections?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
