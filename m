From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000623]: No volume control on SPDIF on cmedia CMI8738-MC6
Date: Tue, 9 Nov 2004 18:56:55 +0100
Message-ID: <6baa62a64c3a6cf74d519be2234bd76c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7516A1E2
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 18:56:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=623> 
======================================================================
Reported By:                mtempels
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   623
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Linux 4.10
Kernel Version:             Linux bubbles 2.6.8.1-3-386
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Tue Oct 12 12:41:57 BST
2004 i686 GNU/Linux
======================================================================
Date Submitted:             11-02-2004 11:24 CET
Last Modified:              11-09-2004 18:56 CET
======================================================================
Summary:                    No volume control on SPDIF on cmedia CMI8738-MC6
Description: 
There is no way to control the output volume on the SPDIF/out on my CMI8738
soundcard. It can just be switched on or off..
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 18:56 
----------------------------------------------------------------------
Well, this is a hardware limitation.  The output to SPDIF isn't attenuated
by any controls.  Only the software attenuation would be possible.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-02-04 11:24 mtempels       New Issue                                    
11-02-04 11:24 mtempels       Distribution              => Ubuntu Linux 4.10
11-02-04 11:24 mtempels       Kernel Version            => Linux bubbles
2.6.8.1-3-386 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Tue Oct
12 12:41:57 BST 2004 i686 GNU/Linux
11-09-04 18:56 tiwai          Note Added: 0002337                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
