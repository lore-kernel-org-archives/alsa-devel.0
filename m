From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Half Speed on rc6 ?
Date: Mon, 25 Nov 2002 13:02:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211251302260.517-100000@pnote.perex-int.cz>
References: <3DE1D319.5040308@tele-ip.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DE1D319.5040308@tele-ip.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bruce Paterson <bruce@tele-ip.com>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 25 Nov 2002, Bruce Paterson wrote:

> Bruce Paterson wrote:
> > Thanks for your reply Daniel.
> > 
> > Daniel Haus wrote:
> > 
> >>> Behaviour:
> >>> The output sound is perfect for about 2 minutes. After that every now 
> >>> and then I get "distortion" in the audio. No xruns or errors are 
> >>> reported in the software. It sounds like only part of the output 
> >>> buffer is correct (the general gist is right, but there's crap and 
> >>> warbles there as well).
> >>
> >>
> >>
> >> this might not be caused by your app, this could be an alsa-problem.
> >> i did not do any more testing, but about 24 hours ago i upgraded to
> >> 0.9.0-rc6 and had no problems since then, but that might not mean
> >> anything ...
> 
> I have now tried 0.9.0rc6 and something VERY weird has happened. 
> Suddenly the sample rate appears to have halved. A previous 600Hz tone
> now is 300Hz and everything takes twices the time to output.
> Surely this is a bug that has crept in.
> 
> Has anyone else at all used rc6 on the EWS88 and had it work ok ?

This problem is fixed in CVS. Try the latest CVS snapshot or wait for rc7.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
