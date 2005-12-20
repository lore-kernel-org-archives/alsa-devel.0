From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001657]: no iec958 controls for hda-intel
Date: Tue, 20 Dec 2005 06:20:16 +0100
Message-ID: <fef59f7b1b704507682d3edd018a1fd3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A3A5F195
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 06:20:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1657> 
======================================================================
Reported By:                lilbudda
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1657
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-17-2005 18:44 CET
Last Modified:              12-20-2005 06:20 CET
======================================================================
Summary:                    no iec958 controls for hda-intel
Description: 
When trying to configure sound to pass through the spdif port, alsamixer
does not show any controls for the iec958.

Sound plays fine from rear headphone jack.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-19-05 16:50 
----------------------------------------------------------------------
OK, try some of the other "model" options listed in the "Module
snd-hda-intel" section of Documentation/ALSA-Configuration.txt.

----------------------------------------------------------------------
 lilbudda - 12-20-05 06:20 
----------------------------------------------------------------------
Edited the /etc/modules.d/alsa file and tried the various configurations by
adding the model= to the end of the module line. Restarted the alsa
service and then re-ran alsamixer but no new controls appeared. Also
deleted local .asoundrc and /etc/asound.conf and asound.state but still no
change.

uploaded results from lspci -nv

my machine is an HP Pavilion a730n
http://h10025.www1.hp.com/ewfrf/wc/document?dlc=en&lc=en&product=431078&lang=en&cc=us&docname=c00196251

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-17-05 18:44 lilbudda       New Issue                                    
12-19-05 08:05 rlrevell       Note Added: 0007091                          
12-19-05 16:39 lilbudda       Note Added: 0007095                          
12-19-05 16:50 rlrevell       Note Added: 0007096                          
12-20-05 06:14 lilbudda       File Added: lspci.txt                        
12-20-05 06:20 lilbudda       Note Added: 0007102                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
