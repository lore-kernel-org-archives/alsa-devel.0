From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: S/PDIF on AD1980 patch
Date: Sun, 16 Feb 2003 13:39:18 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302161338430.1060-100000@pnote.perex-int.cz>
References: <1045265537.3e4d7c8203055@webmail2.namezero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045265537.3e4d7c8203055@webmail2.namezero.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslaw Sobierski <fycio@gucio.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 14 Feb 2003, Jaroslaw Sobierski wrote:

> 
> Here's the patch I promised. I had some trouble compiling the CVS version
> (not the drivers but libs, still don't know why), but I supplemented with
> libs compiled from the tarball (rc7) and it worked. Anyway - I created two
> controls - a simple switch ( the "Link" ) and an enum ("Source") first
> was simple yet fully functional and had the adventage of being modifiable
> via alsamixer, which an enum isn't. The second control is more elegant
> (based on a similar control for the YMF753), but needs much more code
> and cannot be used in alsamixer (or I don't know how to do it). Works
> fine via amixer controls though. Anyway, it doesn't make sense to add
> both (although they do work simultanously), so I leave it up to alsa
> vetrans maintaining the CVS tree to decide which solution is better.
> 
> According to Analog Devices specs this patch should work for all 1980
> series chips, namely 41445370 (ad1980-that's the one I test for),
> 41445371 (ad1980A) and 41445374 (ad1980B). But since I can't test the
> other ones - I left it at that.

Send us unified diff, please. It's more readable to verify the contents.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
