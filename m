From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000138]: Not sound although device is correctly detected...
Date: Thu, 20 Jan 2005 19:15:13 +0100
Message-ID: <75d0288fb98eaba95f14daa030f0b6cb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CC7501B4
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2005 19:15:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=138> 
======================================================================
Reported By:                Eric Valette
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   138
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               debian sid
Kernel Version:             2.6.4-mm2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-15-2004 13:57 CET
Last Modified:              01-20-2005 19:15 CET
======================================================================
Summary:                    Not sound although device is correctly detected...
Description: 
On 2.4, I was using the built-in driver and it worked nicely. On 2.6, I'm
forced to use the 2.6 and get no sound. NB : I have started the ALSAMIXER
and set output level to speaker to non zero...
======================================================================

----------------------------------------------------------------------
 Eric Valette - 03-15-04 17:51 
----------------------------------------------------------------------
I managed to make it work in 2.6.4-mm2 today. So apparently it is fixed in
the last bk tree. You can close it.

Side note : The speakers are muted by default which may lead to trouble
when volume are not zero...

BTW I have an Oops in the intel8x0M modem driver due to null ponter
dereference.
I must fill another bug report...

----------------------------------------------------------------------
 Eric Valette - 12-19-04 15:16 
----------------------------------------------------------------------
Please close this bug : it works now

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-04 13:57 Eric Valette   New Issue                                    
03-15-04 13:57 Eric Valette   Distribution              => debian sid      
03-15-04 13:57 Eric Valette   Kernel Version            => 2.6.4-mm2       
03-15-04 17:41 perex          Note Added: 0000617                          
03-15-04 17:51 Eric Valette   Note Added: 0000619                          
12-19-04 15:16 Eric Valette   Note Added: 0002849                          
12-20-04 14:41 tiwai          Status                   new => resolved     
12-20-04 14:41 tiwai          Resolution               open => fixed       
12-20-04 14:41 tiwai          Assigned To               => tiwai           
12-20-04 14:41 tiwai          Assigned To              tiwai =>            
01-20-05 19:15 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
