From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000857]: intel8x0m does not work on asus a3n laptop
Date: Thu, 3 Feb 2005 21:55:32 +0100
Message-ID: <d7759cbd8554bf31682de041b69d6bc9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7CB64146
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2005 21:55:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=857> 
======================================================================
Reported By:                mart
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   857
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               slackware 10
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-29-2005 16:43 CET
Last Modified:              02-03-2005 21:55 CET
======================================================================
Summary:                    intel8x0m does not work on asus a3n laptop
Description: 
with this laptop, the sound by intel8x0 works ok, but the modem with the 
alsa-driver intel8x0m and slmodemd 2.9.10 does not.
slmodemd starts ok, it opens the alsa device hw:1 that is tje modem, but
when i try to dial a number (i tried with kppp and minicom) the modem does
dial, but after a while it quits with a NO ANSWER error.
making some exprtiments, i found that when i connect under windows, if i
listen to the phone connected to the same line, i can hear the tones
gererated by the modem, but when i dial under linux i can't hear anything,
so i think this is a driver issue, the driver that can't make the modem
produce any sound.

this is what lspci tells me on that modem:
00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03)

======================================================================

----------------------------------------------------------------------
 mart - 02-03-05 21:55 
----------------------------------------------------------------------
the exact model of the laptop is asus z91n:
http://usa.asus.com/products/notebook/z9series/Z9100N/z9100n_overview.htm

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-05 16:43 mart           New Issue                                    
01-29-05 16:43 mart           Distribution              => slackware 10    
01-29-05 16:43 mart           Kernel Version            => 2.6.10          
01-29-05 16:44 mart           Issue Monitored: mart                        
02-03-05 21:55 mart           Note Added: 0003494                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
