From: Paul Davis <pbd@op.net>
Subject: Re: About integer64
Date: Thu, 09 May 2002 07:07:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E175llC-0006zb-00@usw-sf-list1.sourceforge.net>
References: <3CDA2EE2.A3C6D824@alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 09 May 2002 10:10:10 +0200."
             <3CDA2EE2.A3C6D824@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>I don't think that's a bad thing to have support for 64 bit integers
>(perhaps for future use, who knows), but I think that to use this to
>store a fixed point float is a big mistake.
>
>If you think for it you realize that it's *not* an integer and
>applications are betrayed in their expectation.

in this case, it *is* an integer. your original question was about why
its 64 bits - i think that comes from the fixed point internal
arithmetic. but the end result is a straightforward 64 bit little
endian integer that needs scaling to get the actual RMS value.

which actually creates another problem that i've noticed with the
control API. INTEGER and INTEGER64 assume that the control value is
signed. there is no way to infer from the control element info that
its unsigned. this isn't a "deep" problem, but it will mess up user
interfaces that present a large unsigned value and end up displaying
it as a negative number.

--p


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
