From: Tom Watson <sdc695@yahoo.com>
Subject: Re: I thought it would simple....
Date: Mon, 11 Aug 2003 14:30:41 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030811213041.62867.qmail@web21507.mail.yahoo.com>
References: <s5hk7a82fzb.wl@alsa2.suse.de>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7a82fzb.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry I could not get back to you...  Vacation and travel over 9 time
zones in the last 36 hours...

The soundcard appears to work quite nicely using 'aplay' (default
parameters, but device 'surround40').  I just want to get an idea of
what I'm doing that causes this problem.  The "sample" program OUGHT to
work, after all it is a "sample", isn't it...

Maybe there could be a "debugging" version of the library that is
similar to "strace" for the library calls.  Setting an environment
variable (output device file??) turns it on.  That way people could
analyze the flow thru the library, which is much less verbiage and raw
data then the true I/O calls.  Maybe an install option, or something in
the library.

Just an idea.  I suspect that if it were available, the sequence used
by 'aplay' would be immediately obvious (DUH!), and I could modify my
dumb program.

In any event, I'll try the suggestions to see what comes next. 
Anything is possible!!
--- Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 23 Jul 2003 22:03:25 -0700 (PDT),
> Tom Watson wrote:
> > 
> > OK, here is more data.  The enclosed files are:
> > 1) The "minimal playback program" described in the original
> message,
> > modified to clear the buffer, and do the "dump" of the parameters. 
> The
> > buffer size is lengthened a bit (maybe this makes a difference??)
> 
> in general, it'd better to specify proper period and buffer sizes in
> hw_params.  (you can use *_near() for that purpose, too, in the case
> the hardware doesn't support the request size.)
> 
> note that the configuration of buffer and period sizes is often
> sensitive to the card type.  and they define the stability and the
> latency of the application.  that's why many applications have
> options
> to set up these things.
> 
> also, calling snd_pcm_prepare() is not necessary.  it's called
> automatically after hw_params().  it's needed only after xrun/suspend
> occurs.
> 
> many programs have the xrun recovery.  in the playback direction, if
> a buffer underrun occurs, snd_pcm_writei() returns -EPIPE (and
> -ESTRPIPE if the suspend occurs).  and ALSA drivers don't recover
> this
> status automatically as default.  you need to call snd_pcm_prepare()
> to recover the status. so,
> 
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites
> including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
>
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
