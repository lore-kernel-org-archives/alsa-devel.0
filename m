From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000754]: parameter mpu_port dissapeared from 1.0.6 to 1.0.7 midi device is ot detected
Date: Mon, 31 Jan 2005 19:06:27 +0100
Message-ID: <9fbbbf8bb521b5635c179182354f645e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A5B41235
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 19:06:27 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=754> 
======================================================================
Reported By:                jmfrank
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   754
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian/GNU Linux
Kernel Version:             2.6.9
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             12-28-2004 23:56 CET
Last Modified:              01-31-2005 19:06 CET
======================================================================
Summary:                    parameter mpu_port dissapeared from 1.0.6 to 1.0.7
midi device is ot detected
Description: 
Dear Developer,
this is my first filed bug ever, so I might not have done everything
correct.
I never got midi running on my p4p800 Deluxe mainboard also it worked on a
P4C800 Deluxe Board with the same configuration. Difference is a 865 to
875 in Chip-Version.
Now Midi isn't detected anymore since the midi support is gone completly,
without an update in the documentation.

This no I do not hear any sound issue. I want to access a midi-keyboard.
I am willing to do testing for you.

Many thanks for your assistance.

Johannes Frank
======================================================================

----------------------------------------------------------------------
 jmfrank - 12-29-04 17:26 
----------------------------------------------------------------------
Thank you it loaded sucessfully. And now the port is there.

This solves the issue. You should update the intel8x0 documentation
though.

Again many thanks.

----------------------------------------------------------------------
 tiwai - 12-29-04 17:36 
----------------------------------------------------------------------
OK, let's close now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 23:56 jmfrank        New Issue                                    
12-28-04 23:56 jmfrank        Distribution              => Debian/GNU Linux
12-28-04 23:56 jmfrank        Kernel Version            => 2.6.9           
12-29-04 14:18 tiwai          Note Added: 0002999                          
12-29-04 17:26 jmfrank        Note Added: 0003002                          
12-29-04 17:36 tiwai          Status                   new => resolved     
12-29-04 17:36 tiwai          Resolution               open => not an issue
12-29-04 17:36 tiwai          Assigned To               => tiwai           
12-29-04 17:36 tiwai          Note Added: 0003003                          
12-29-04 17:36 tiwai          Assigned To              tiwai =>            
01-31-05 19:06 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
