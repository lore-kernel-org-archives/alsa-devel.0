From: noreply@alsa-project.org
Subject: [ALSA - lib 0000396]: /dev/mixer problem with alsa-lib 1.0.5
Date: Sun, 18 Jul 2004 15:45:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040718134501.6141228006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CC4C21AE
	for <alsa-devel@alsa-project.org>; Sun, 18 Jul 2004 15:45:01 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 7FE3D13B7B
	for <alsa-devel@alsa-project.org>; Sun, 18 Jul 2004 15:45:01 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000396
======================================================================
Reported By:                dgh0st
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     396
Category:                   mixer
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-18-2004 15:45 CEST
Last Modified:              07-18-2004 15:45 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-18-04 15:45 dgh0st         New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
