From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: About integer64
Date: Thu, 09 May 2002 14:27:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDA6B48.3E68AE3A@alsa-project.org>
References: <Pine.LNX.4.33.0205091316530.482-100000@pnote.perex-int.cz>
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: Paul Davis <pbd@op.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Thu, 9 May 2002, Paul Davis wrote:
> 
> > >I don't think that's a bad thing to have support for 64 bit integers
> > >(perhaps for future use, who knows), but I think that to use this to
> > >store a fixed point float is a big mistake.
> > >
> > >If you think for it you realize that it's *not* an integer and
> > >applications are betrayed in their expectation.
> >
> > in this case, it *is* an integer. your original question was about why
> > its 64 bits - i think that comes from the fixed point internal
> > arithmetic. but the end result is a straightforward 64 bit little
> > endian integer that needs scaling to get the actual RMS value.
> >
> > which actually creates another problem that i've noticed with the
> > control API. INTEGER and INTEGER64 assume that the control value is
> > signed. there is no way to infer from the control element info that
> > its unsigned. this isn't a "deep" problem, but it will mess up user
> > interfaces that present a large unsigned value and end up displaying
> > it as a negative number.
> 
> I think that we can add 'int unsign: 1;' to sndrv_ctl_elem_info for
> integer and integer64. Any objections?

I'd avoid that.

About the problem Paul has shown the important thing is to know if all
64 bits are used. This is also the reason why I've asked the original
question: I can't imagine a quantity in audio problem space that need 64
bit of resolution and all the bits are significant and they make a
sensible difference.

However also if this is the case I'd prefer to have UINTEGER and/or
UINTEGER64.


-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
