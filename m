From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: aoss failures under Alsa-1.0.0rc1
Date: Fri, 5 Dec 2003 13:28:12 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGOEJDECAB.mknecht@controlnet.com>
References: <Pine.HPX.4.33n.0312051804500.8570-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312051804500.8570-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
> There is a change in alsa-oss.c, immediately after rc1 came out, with
> the following log message:
>
> - avoid the assert in snd_pcm_drain().
> - fixed the possible segfault at the wrong release of resources.
> - more debug messages.
>
>
> HTH
> Clemens

Clemens,
   rc2 is not working yet, but it is much improved and not crashing. I now
get a warning in the terminal when I run 'aoss xmms' from oss_open() saying
it cannot find /dev/sound/dsp, and a nice (I think xmms) dialog box asking
me to check that I have the right output plugin, no programs are blocking
and that the soundcard is configured properly.

   So, what do I need to do to solve this? /dev/sound/dsp seems to exist,
but it's one of those yellow special file thingies.

   How about something in .asoundrc? My oss playback definition is for
pcm.dsp0. I'm remote from the machine and looking at the xmms display, but I
tried changing the OSS thing we were working on to pcm.dsp and xmms seems to
be working, in the sense that it isn't crashing. However, hdspmixer (being
run over an ssh connection!) looks like the audio is on playback_1/2 instead
playback_5/6, so this isn't completely right yet.

   And, since I'm remote I don't know what this sounds like, but I presume
it's OK. I'll let you know in 5-6 hours.

   Anyway, rc2 is much better. aoss is happy even if I'm not. (YET!!!)

Thanks,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
