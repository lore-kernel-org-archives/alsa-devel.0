From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000768]: HDSP speed/rate switching
Date: Fri, 28 Jan 2005 17:24:17 +0100
Message-ID: <37663c0ba51f910caf30abb7d434a35a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 08E7A20A
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2005 17:24:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=768> 
======================================================================
Reported By:                kme
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - tools
Issue ID:                   768
Category:                   hdsp progs
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             12-31-2004 18:40 CET
Last Modified:              01-28-2005 17:24 CET
======================================================================
Summary:                    HDSP speed/rate switching
Description: 
HDSP Muliface PCI:

HDSPconf/ALSA sampling rates do not switch between single and double speed
rates when file with new rate is played or when JACK requests new rate. 
Rate switches work as desired within each range (single: 32K-48k,
double:64k-96k)  Discussed on LAU here:

http://eca.cx/lau/2004/12/0947.html
======================================================================

----------------------------------------------------------------------
 charbonnel - 01-28-05 17:24 
----------------------------------------------------------------------
You can't change the speed mode (single/double speed) while the device is
in use (capture or playback). You have to manually switch to the desired
speed mode before opening the device, because the number of available
channels changes depending on the mode.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 18:40 kme            New Issue                                    
01-28-05 17:24 charbonnel     Note Added: 0003428                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
