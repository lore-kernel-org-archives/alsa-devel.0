From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: new timer code in CVS
Date: Wed, 5 Feb 2003 12:17:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302051216340.1303-100000@pnote.perex-int.cz>
References: <s5h7kcfgexh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA08810
	for <alsa-devel@alsa-project.org>; Wed, 5 Feb 2003 13:08:21 +0100
In-Reply-To: <s5h7kcfgexh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Feb 2003, Takashi Iwai wrote:

> At Tue, 4 Feb 2003 14:30:30 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > Hi all,
> > 
> > 	I've commited improved kernel code for the ALSA timer interface. 
> > It should fix many troubles (my own lowlatency kernel with HZ=1000 easily 
> > hung up my laptop when I used older code for the system timer) and there 
> > are major improvements especialy in locking and handling of slave timers
> > and slower callbacks (like sequencer one).
> 
> the sequencer switches to tasklet inside if it takes too long time
> (too much event processed).  i'll remove this check if the timer
> callback is invoked already via tasklet.

Yep, the sequencer callback is now "slow" (it will be called always using 
tasklet) so the limit of processed events can be removed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
