From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Ready Developer
Date: Fri, 13 Sep 2002 17:23:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209131721220.521-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.21.0209131335310.639-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA22543
	for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2002 17:23:32 +0200
In-Reply-To: <Pine.LNX.4.21.0209131335310.639-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Sep 2002, Tim Goetze wrote:

> - get rid of nasty clicks on open/start/stop/close of pcms.

I don't think that it's a problem of ALSA, because I've tested some cards 
in digital -> digital mode and the stream IS OK. It seems that some DACs 
(or ADCs) might need some other initialization, but it's driver specific.
Anyway, fixing drivers is always good.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
