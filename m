From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000801]: Persistent "max-amp" level on hdspmixer inputs
Date: Fri, 28 Jan 2005 22:00:39 +0100
Message-ID: <a7b49854704e84caa96ec14da11d193f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CB58E20A
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2005 22:00:39 +0100 (MET)
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
Status:                     assigned
======================================================================
Date Submitted:             01-10-2005 09:20 CET
Last Modified:              01-28-2005 22:00 CET
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
 charbonnel - 01-27-05 21:47 
----------------------------------------------------------------------
I just posted a patch on alsa-devel that should fix the problem, could you
please try it ?

----------------------------------------------------------------------
 kme - 01-28-05 22:00 
----------------------------------------------------------------------
Looks good!  The levels look great all around.  Many, many thanks.

However, for some reason I now get no audible signal from the front
"Analog" headphone out, although the mixer shows proper levels.  I have
tested with several headsets and a direct feed to monitors.

This error (from restarting the alsasound service) looks pertinent:

Restoring sound driver settings /usr/sbin/alsactl: set_control:930:
warning: name mismatch (Passthru/Line Out) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=21
/usr/sbin/alsactl: set_control:930: warning: name mismatch (Line
Out/Precise Pointer) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=22
/usr/sbin/alsactl: set_control:930: warning: name mismatch (ADAT Lock
Status/Use Midi Tasklet) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=23
/usr/sbin/alsactl: set_control:932: warning: index mismatch (1/0) for
control https://bugtrack.alsa-project.org/alsa-bug/view.php?id=23
/usr/sbin/alsactl: set_control:1025: bad control.23.value type

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 09:20 kme            New Issue                                    
01-15-05 19:27 slick          Note Added: 0003212                          
01-15-05 19:28 slick          Issue Monitored: slick                       
01-15-05 19:32 slick          Note Added: 0003213                          
01-27-05 21:47 charbonnel     Note Added: 0003422                          
01-28-05 22:00 kme            Note Added: 0003436                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
