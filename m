From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000396]: /dev/mixer problem with alsa-lib 1.0.5
Date: Fri, 24 Sep 2004 13:36:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113645.54CC1101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B2218263
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:36:45 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000396
======================================================================
Reported By:                dgh0st
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     396
Category:                   mixer
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             07-18-2004 15:45 CEST
Last Modified:              09-24-2004 13:36 CEST
======================================================================
Summary:                    /dev/mixer problem with alsa-lib 1.0.5
Description: 
When I try to play a movie in Mplayer (tried with version 1.0pre5 and
1.0pre4) i receive this output:
ALSA lib control.c:654:(snd_ctl_open_noupdate) Invalid CTL /dev/mixer
alsa-control: mixer attach /dev/mixer error: No such file or directory

I don't have such a problem with xmms (i don't use any other players) I
don't knowif it is my fault or Mplayer bug or...
I didn't use the ALSA for slackware packages. I have built it myself.
I am using newest alsa packages (not cvs).
/etc/asound.conf looks like this:
pcm.emu10k1 {
	type hw
	card 0
}

ctl.emu10k1 {
	type hw
	card 0
}

======================================================================

----------------------------------------------------------------------
 dgh0st - 07-18-2004 19:14 CEST 
----------------------------------------------------------------------
Heh, I solved it by myself. It looks that MPlayer does not tolerate the
symlink to /dev/mixer* so I moved /dev/mixer0 to /dev/mixer and now it
works perfeclty with no errors.

----------------------------------------------------------------------
 tiwai - 07-30-2004 17:30 CEST 
----------------------------------------------------------------------
Ok, closing now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-18-04 15:45 dgh0st         New Bug                                      
07-18-04 19:14 dgh0st         Bugnote Added: 0001460                       
07-20-04 19:59 xblahallo      Bug Monitored: xblahallo                     
07-30-04 17:30 tiwai          Bugnote Added: 0001501                       
07-30-04 17:30 tiwai          Assigned To               => tiwai           
07-30-04 17:30 tiwai          Resolution               open => not a bug   
07-30-04 17:30 tiwai          Status                   new => resolved     
09-24-04 13:36 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
