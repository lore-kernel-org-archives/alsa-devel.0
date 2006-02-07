From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001825]: Latest Update (alsa-utils, alsa-lib and system-config-soundcard) causes severe distortion of sound output
Date: Tue, 7 Feb 2006 09:15:12 +0100
Message-ID: <319d38b5e706aa396814f4b85e323027@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 105861B4
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2006 09:15:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1825> 
======================================================================
Reported By:                poylywog
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1825
Category:                   speakertest
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-06-2006 16:23 CET
Last Modified:              02-07-2006 09:15 CET
======================================================================
Summary:                    Latest Update (alsa-utils, alsa-lib and
system-config-soundcard) causes severe distortion of sound output
Description: 
Sound card is Creative SB Audigy

Performed YUM update of above and upon performing soundcard detection and
testing of speakers output was extremely distorted (noise and pops)Music
Players were inoperable. Tried various settings (3 listed) of emu-10k1
driver with no effect. 
======================================================================

----------------------------------------------------------------------
 stransky - 02-07-06 09:15 
----------------------------------------------------------------------
It could be a bug in the latest s-c-s update. Please file a new bug on
http://bugzilla.redhat.com and attach the /root/scsound.log.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-06 16:23 poylywog       New Issue                                    
02-07-06 09:15 stransky       Note Added: 0007955                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
