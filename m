From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: how to define a 2-index control element?
Date: Tue, 7 May 2002 11:55:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205071151170.508-100000@pnote.perex-int.cz>
References: <s5hit605mrk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hit605mrk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Abramo Bagnara <abramo@alsa-project.org>, Paul Davis <pbd@op.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 May 2002, Takashi Iwai wrote:

> > Card specific code may solve all that easily.
>  
> that's true.
> but user may start alsamixer (or what else) and get huge amount of
> bars (i thought), which should be avoided.

We can avoid this in alsa-lib.

> > We need to separate in our minds the _basic_ hardware access and
> > layout/display consideration. Kernel is for the former, libraries and
> > applications for the latter.
> 
> i reconsidered this issue yesterday.
> in this case, we need to take also the number of controls in the
> kernel space into accout.  if we have an instance for each of 1400+
> controls, there are really 1400+ mallocs, and we'll look for a control
> by a linear search from them.
> and most likely the hardware doesn't need them.
> it will be a big drawback.

If someone has hardware with 1400+ controls, than memory allocation issue 
is out of question. I wrote that we can optimize current code - add some 
hash tables for faster lookups for example.

> otoh, the indexed access as Paul's suggestion needs only one control.
> the drawback of this method is, as Jaroslav pointed, the lack of
> notification.  the notification can be done but we cannot know which
> element is affected.

I think that it's much bigger drawback than allocation of some more 
kilobytes of memory.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
