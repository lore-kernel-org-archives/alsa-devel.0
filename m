From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000801]: Persistent "max-amp" level on hdspmixer inputs
Date: Tue, 1 Feb 2005 21:40:43 +0100
Message-ID: <33ea4c12628f43f874e36f5688e854a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 52A6C1E7
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2005 21:40:43 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=801> 
======================================================================
Reported By:                kme
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - tools
Issue ID:                   801
Category:                   hdsp progs
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-10-2005 09:20 CET
Last Modified:              02-01-2005 21:40 CET
======================================================================
Summary:                    Persistent "max-amp" level on hdspmixer inputs
Description: 
HDSPmixer shows constant "max-amp" (actually -6db or so) levels at all
times in the first 8 channels.  And when sound is played internally the
middle row meters (playback) show the left channel with maxed-out levels
while the right channel shows nothing.  Peak meters (yellow), however,
appear to work normally.

A screenshot of the mixer while playing a stereo soundfile routed to AN1+2
and Analog (headphones) only with NOTHING connected to the inputs can be
cound here:

http://www.esm.rochester.edu/kevine/hdsp_screenshot.jpg

Note that the outputs (bottom row) show proper levels as do the yellow
peak meters in playback (Out 1+2).  

Signal quality is unaffected.
======================================================================

----------------------------------------------------------------------
 slick - 01-31-05 22:27 
----------------------------------------------------------------------
Hello Thomas,

I tried ALSA 1.08 and the latest hdsp.c from the ALSA-CVS (including your
patch). Now the hdspmixer is working fine with my Multiface. 
Thanks a a lot.

----------------------------------------------------------------------
 charbonnel - 02-01-05 21:40 
----------------------------------------------------------------------
Fixed in cvs, the fix should appear in alsa > 1.0.8

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 09:20 kme            New Issue                                    
01-15-05 19:27 slick          Note Added: 0003212                          
01-15-05 19:28 slick          Issue Monitored: slick                       
01-15-05 19:32 slick          Note Added: 0003213                          
01-27-05 21:47 charbonnel     Note Added: 0003422                          
01-28-05 22:00 kme            Note Added: 0003436                          
01-31-05 22:27 slick          Note Added: 0003459                          
02-01-05 21:40 charbonnel     Status                   assigned => resolved
02-01-05 21:40 charbonnel     Resolution               open => fixed       
02-01-05 21:40 charbonnel     Note Added: 0003467                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
