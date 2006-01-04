From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001657]: no iec958 controls for hda-intel
Date: Wed, 4 Jan 2006 16:47:00 +0100
Message-ID: <ce2febb3a8a15462685c3b04794848ce@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9C500184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 16:47:00 +0100 (MET)
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
Last Modified:              01-04-2006 16:47 CET
======================================================================
Summary:                    no iec958 controls for hda-intel
Description: 
When trying to configure sound to pass through the spdif port, alsamixer
does not show any controls for the iec958.

Sound plays fine from rear headphone jack.
======================================================================

----------------------------------------------------------------------
 lilbudda - 12-30-05 22:46 
----------------------------------------------------------------------
No the Realtek driver did not work.

I have not been able to use plugins with programs (mplayer, xine, or
aplayer) or anything else to get sound from the spdif port. No mixer
controls in alsamixer relating to digital out or IEC958.



----------------------------------------------------------------------
 lilbudda - 01-04-06 16:47 
----------------------------------------------------------------------
I am now able to see the IEC958 control with the latest (Jan 03, 2006) CVS.
Still working on getting sound but this bug can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-17-05 18:44 lilbudda       New Issue                                    
12-19-05 08:05 rlrevell       Note Added: 0007091                          
12-19-05 16:39 lilbudda       Note Added: 0007095                          
12-19-05 16:50 rlrevell       Note Added: 0007096                          
12-20-05 06:14 lilbudda       File Added: lspci.txt                        
12-20-05 06:20 lilbudda       Note Added: 0007102                          
12-23-05 18:16 lilbudda       Note Added: 0007134                          
12-23-05 19:35 rlrevell       Note Added: 0007136                          
12-24-05 00:54 lilbudda       Note Added: 0007138                          
12-30-05 22:46 lilbudda       Note Edited: 0007138                         
01-04-06 16:47 lilbudda       Note Added: 0007427                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
