From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001692]: sound doesn't work
Date: Thu, 29 Dec 2005 05:34:31 +0100
Message-ID: <e20eeb36b337f791b1b02e673d1f1462@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D60E4193
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2005 05:34:31 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1692> 
======================================================================
Reported By:                jra2003
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1692
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.5
======================================================================
Date Submitted:             12-29-2005 04:50 CET
Last Modified:              12-29-2005 05:34 CET
======================================================================
Summary:                    sound doesn't work
Description: 
After folling the instructions to the letter, I restart the computer and it
finds the sound card and I let it configure it.  Once logged into root
with KDE I goto KMenu > system settings > soundcard detection and I click
'play test'  It might works once or twice with a sound being played then a
question asking if it worked.  When it doesn't work it doesn't ask if I
heard anything until a few seconds pass.  So the command to play the sound
went through, but the final result is that the sound went to the wrong
place and not to me sndcard and to my speakers.

BTW: I did check the mixer levels and if it was muted or not and no
problems there.
======================================================================

----------------------------------------------------------------------
 jra2003 - 12-29-05 05:34 
----------------------------------------------------------------------
Here is more info on my snd card

written in pci card:

Sound Blaster Live! 24-bit
Main chip:  CA0106-DAT

Also, when occasionally detected, FC2 see's the card as a 'SB Audigy LS'

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-05 04:50 jra2003        New Issue                                    
12-29-05 04:50 jra2003        Distribution              => Fedora Core 2   
12-29-05 04:50 jra2003        Kernel Version            => 2.6.5           
12-29-05 04:50 jra2003        Issue Monitored: jra2003                     
12-29-05 05:34 jra2003        Note Added: 0007187                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
