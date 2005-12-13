From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000996]: Noise when enabling dmix
Date: Tue, 13 Dec 2005 12:41:38 +0100
Message-ID: <32f8c971ac9baf91f83da48510c76157@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6DBE01C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:41:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=996> 
======================================================================
Reported By:                daspooky
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   996
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-15-2005 16:25 CET
Last Modified:              12-13-2005 12:41 CET
======================================================================
Summary:                    Noise when enabling dmix
Description: 
I get noise/static when i use the dmix plugin. When i use alsa without an
.asoundrc file there is no problem. I noticed this since i upgraded alsa
from 1.0.5 to 1.0.8. Version 1.0.5 didn't have this problem. I didn't try
versions between 1.0.5 and 1.0.8. The oise dissapears when i lower the
samplerate in asoundrc to 22000 KHz. Higher than that i get noise. 
======================================================================

----------------------------------------------------------------------
 daspooky - 03-16-05 13:21 
----------------------------------------------------------------------
It is there constantly, but only when software mixing is enabled it seems.
When i don't use an asoundrc file there is no static, but then of course i
can only play 1 sound at a time. 

In alsa 1.0.9rc1 it seems hardware mixing is enabled by default and no
asoundrc is needed. Here the static occurs all the time. 
So to conclude it happens when mixing is enabled.

----------------------------------------------------------------------
 jdthood - 12-13-05 12:41 
----------------------------------------------------------------------
Submitter: Any improvement in 1.0.10?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-05 16:25 daspooky       New Issue                                    
03-15-05 16:27 daspooky       Issue Monitored: daspooky                    
03-15-05 16:28 daspooky       Issue End Monitor: daspooky                    
03-16-05 12:52 tiwai          Note Added: 0003948                          
03-16-05 13:21 daspooky       Note Added: 0003955                          
12-13-05 12:41 jdthood        Note Added: 0006996                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
