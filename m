From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: status pointer's problem with dmix.
Date: Thu, 18 Sep 2003 19:28:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309181927240.5983@pnote.perex-int.cz>
References: <3F68A8F9.6010605@superbug.demon.co.uk>
 <Pine.LNX.4.53.0309181144020.5983@pnote.perex-int.cz> <3F69A98B.5020106@superbug.demon.co.uk>
 <Pine.LNX.4.53.0309181459440.5983@pnote.perex-int.cz> <3F69DB4C.8070401@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F69DB4C.8070401@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Sep 2003, James Courtier-Dutton wrote:

> You are correct, my application does in fact get correct "delay" values,
> but the /proc/asound/card0/pcm0p/sub0/status does not show these when
> using dmix.
>
> The sound output from my application is very broken up when using
> "dmix", but sounds fine when using "front".
>
> The break up sounds like one period sound, one period mute, one period
> sound, one period mute.
>
> It must be something in my application, because aplay does not break up.
>
> I suspect it is my application trying to do xrun recovery or something
> like that, but dmix runs freewheel even on xruns, so I might have to
> change some of my code. My reasoning behind this, is that with "front",
> I can do xrun recovery by stopping and then restarting the pcm, so the
> recovery is very quick, but with dmix, I have to wait a whole period
> before sound output starts again.

A quick idea: Do you use snd_pcm_poll_descriptors_revents() function to
parse returned poll events? The dmix plugin uses the PCM timer as the poll
source, but it does not use POLLOUT but POLLIN !!!

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
