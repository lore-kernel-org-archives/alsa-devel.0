From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: YMF754 with front & rear output?
Date: Wed, 20 Feb 2002 16:29:14 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202201628350.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.10.10202201014410.4013-100000@sorrow.ashke.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Adam K Kirchhoff <adamk@voicenet.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 20 Feb 2002, Adam K Kirchhoff wrote:

> > It's no problem for us to add a new control for the rear
> > device (hw:0,2) which can control front speakers as well. We can also
> > invert hw:0,2 and hw:0,0 after that change, so the default working mode
> > will be "use front & rear speakers".
>
> That would be perfect.  I'm curious though, is this also how it's done
> with the the emu10k1 drivers?

No, it's different hardware.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
