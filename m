From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: Sequencer events not arriving guaranteed
Date: Tue, 19 Feb 2002 09:33:47 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202190933340.535-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA22424
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 09:34:25 +0100
In-Reply-To: <XFMail.020219092451.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Feb 2002, Guenther Sohler wrote:

> Does that mean, i have to do following:
>
> 1.) open sequencer
> 2.) create my own port on client
> 3.) subscribe sender=my port receiver=midi device
> 4.) create events set source to my client/port destination=midi device
> 5.) send events
>
> is this the correct way of doing it ?

Yes, it is.

> are there some extra things, which are not neccessary ?

Nope.

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
