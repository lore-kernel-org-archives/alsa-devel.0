From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001643]: Microphone is muted and no mic option available
Date: Mon, 12 Dec 2005 04:12:02 +0100
Message-ID: <a37a11636cdc12982acad799366d4b61@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8C5319D
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2005 04:12:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1643> 
======================================================================
Reported By:                MACHINE
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1643
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             12-12-2005 04:12 CET
Last Modified:              12-12-2005 04:12 CET
======================================================================
Summary:                    Microphone is muted and no mic option available
Description: 
This issue exists since I bought this notebook, and it was never solved
since ALSA 1.0.9, no matter what kernel I use.

The only mixer option related to microphone is "Input Source", and there
is a "Front Mic", but useless.

in 'alsamixer -V capture', the only three columns are IEC958, Capture, and
Capture (not a typo!)

I unmuted everything and push every volumes to 100%. Everything works
fine, except microphone.

Hardware has no problem (checked by Windows2000).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-12-05 04:12 MACHINE        New Issue                                    
12-12-05 04:12 MACHINE        File Added: alsa                             
12-12-05 04:12 MACHINE        Distribution              => Gentoo          
12-12-05 04:12 MACHINE        Kernel Version            => 2.6.14.3        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
