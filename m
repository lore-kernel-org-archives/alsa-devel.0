From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000709]: Recording doesnt work
Date: Mon, 6 Dec 2004 20:59:36 +0100
Message-ID: <b1f0422d5eba85b9e89d79c95d1584bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6F8752FA
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 20:59:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=709> 
======================================================================
Reported By:                tigermb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   709
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-05-2004 16:33 CET
Last Modified:              12-06-2004 20:59 CET
======================================================================
Summary:                    Recording doesnt work
Description: 
Soundcard: Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)

The recording doesnt work.
When trying to record, nuthing happens. No errors. Although gnome-meeting
got an error and wonders if i have permission to device. But i tried it
under root and i get the same error. arecord give no error, but just
doesnt do anything.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-06-04 20:59 
----------------------------------------------------------------------
"Doesn't do anything" means that you get silent data?

If so, it's likely a mixer configuration problem.
Attach /etc/asound.state.

Hint: don't forget to raise "Capture Volume", turn on "Capture Switch",
and choose the appropriate "Capture Source".  Then, choose "Input1" for
"Input Source Select" control.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-04 16:33 tigermb        New Issue                                    
12-05-04 16:34 tigermb        Issue Monitored: tigermb                     
12-06-04 20:59 tiwai          Note Added: 0002735                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
