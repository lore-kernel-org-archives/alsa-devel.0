From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: final release - Tuesday
Date: Mon, 10 Mar 2003 11:15:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303101113450.1071-100000@pnote.perex-int.cz>
References: <200303091043.29357.tfjellstrom@telusplanet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA27017
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2003 11:15:59 +0100
In-Reply-To: <200303091043.29357.tfjellstrom@telusplanet.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Fjellstrom <tfjellstrom@telusplanet.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 9 Mar 2003, Thomas Fjellstrom wrote:

> On March 9, 2003 05:13 pm, Jaroslav Kysela wrote:
> > Hi all,
> >
> > 	I have just released the 0.9.0rc8d version of the ALSA driver for
> > tests. It should fix the trident problems as Paul noticed. If no major bug
> > is reported until Tuesday, I will release the final packages.
> >
> > 					Have fun,
> > 						Jaroslav
> >
> 
> Hey,
> 
> I've brought this up a couple times, and It looked like Takashi was working on 
> it. I added alsa 0.5 and 0.9x rawmidi support to a library called Allegro 
> (alleg.sf.net) but since upgrading to alsa 9x (I also just installed the 
> latest release from alsa-project.org) the midi test app that comes with 
> allegro (and a midi player of mine...) will eventually (in a couple minutes) 
> eat up 100% cpu time. The allegro midi system has no problems with its 
> software synth, in OSS (or so I've heard), Windows, or any of the other 
> platforms it supports.

I cannot find 0.9 code in your CVS tree.

Note: Don't use the APPEND mode for single-byte writting. This mode is 
indended for full MIDI messages (including running state) otherwhise there 
is no guarantee that another application doesn't break the stream with 
other bytes.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
