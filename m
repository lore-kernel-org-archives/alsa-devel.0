From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001185]: unable to control Center/LFE
Date: Sat, 11 Jun 2005 22:00:37 +0200
Message-ID: <837ddc3f2491ef6348ea15eab8dea8b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A046D1FC
	for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2005 22:00:37 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1185> 
======================================================================
Reported By:                weyer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1185
Category:                   PCI - cmipci
Reproducibility:            N/A
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-11-2005 22:00 CEST
Last Modified:              06-11-2005 22:00 CEST
======================================================================
Summary:                    unable to control Center/LFE
Description: 
I use the Hercules Gamesurround 5.1 dvd card, with the cmipci driver
(manual says it has a cmi-8738-chipset).  The driver compiled fine, and
the 5.1 works under mplayer using the -channels 6 option.  The problem is
that in amixer, alsamixer or any such problem, there is no slider for
center/LFE volume, and their volume is not under control of any
slider/switch

MASTER: just front 
PCM: Front and rear

the button mic as lfe  is for an extra sub i guess (doesn't influence the
sub if switched on or off, it keeps working)
the button line-in as rear is for an extra pair of speakers (i have my
hifi attached to it as extra line-out)

(the card has: front, rear, center/lfe, mic and line-in jacks on the
back)

It is not a real problem, but it's quite annoying to reach under my desk
to adjust the volume of the woofer/center while watching a movie...

if hope it can be solved
greetings
geert
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-05 22:00 weyer          New Issue                                    
06-11-05 22:00 weyer          Distribution              => gentoo          
06-11-05 22:00 weyer          Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
