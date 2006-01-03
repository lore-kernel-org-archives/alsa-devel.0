From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001702]: No sound in front speakers emu10k1
Date: Tue, 3 Jan 2006 09:47:16 +0100
Message-ID: <b0df7c35fb842a195f3399a501e7d41b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C936816A
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2006 09:47:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1702> 
======================================================================
Reported By:                pupp3tmast3r
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1702
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-03-2006 09:41 CET
Last Modified:              01-03-2006 09:47 CET
======================================================================
Summary:                    No sound in front speakers emu10k1
Description: 
Card: SBLive! Value [CT4832]
Chip: Cirrus Logic CS4297A rev 4

When playing in surroud mode with mplayer (-af surround) or audio streams
of 4 or more channels there is no front audio just rear.

This card does only 4 channels playing since is one of the very first
models.

The bug appears in versions of mplayer from 1.0pre7try2 to CVS2005-12-15
======================================================================

----------------------------------------------------------------------
 pzad - 01-03-06 09:47 
----------------------------------------------------------------------
Make sure, you have same alsa-lib and alsa-driver version.
What is in /proc/asound/version ?
Make sure, you have set "Front" volume.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-06 09:41 pupp3tmast3r   New Issue                                    
01-03-06 09:47 pzad           Note Added: 0007400                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
