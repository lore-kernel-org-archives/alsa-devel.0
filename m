From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000691]: M-Audio USB Midisport 4x4 MIDI interfaces are not visible
Date: Mon, 29 Nov 2004 17:55:13 +0100
Message-ID: <81517943627444591a0fdfb07b30e0ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B65C12C8
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 17:55:13 +0100 (MET)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=691> 
======================================================================
Reported By:                comp
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   691
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               SuSE Linux 9.1
Kernel Version:             2.6.5-7.111-smp
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 SMP
======================================================================
Date Submitted:             11-29-2004 14:00 CET
Last Modified:              11-29-2004 17:55 CET
======================================================================
Summary:                    M-Audio USB Midisport 4x4 MIDI interfaces are not
visible
Description: 
I don't know how to reproduce, but the first time the kaconnect utility
shows the all midisport midi interfaces normally. After running any
application that use midi (muse or whatever), the midi ports lost. I
trying to unplug/plug the midisport and restart alsa with rcalsasound
restart command, but the ports are invisible.
When i create virtual raw midi ports, these midi interfaces always
visible.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-29-04 14:00 comp           New Issue                                    
11-29-04 14:00 comp           Distribution              => SuSE Linux 9.1  
11-29-04 14:00 comp           Kernel Version            => 2.6.5-7.111-smp
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 SMP
11-29-04 17:55 Clemens LadischAssigned To               => Clemens Ladisch 
11-29-04 17:55 Clemens LadischStatus                   new => assigned     
11-29-04 17:55 Clemens LadischCategory                 GENERIC - serialmidi =>
USB - usb-audio
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
