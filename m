From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001792]: SB16 value: OPL3 playback hangs
Date: Sun, 29 Jan 2006 14:38:36 +0100
Message-ID: <ac02f53a192018955bbc066fc26de0c6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B04516B
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2006 14:38:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1792> 
======================================================================
Reported By:                strcmp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1792
Category:                   GENERIC - opl3
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-29-2006 14:38 CET
Last Modified:              01-29-2006 14:38 CET
======================================================================
Summary:                    SB16 value: OPL3 playback hangs
Description: 
The snd-opl3-synth module doesn't really work, I never managed to get more
than 0 or 1 note of a midi file played, depending on midi player (playmidi
-f,
tse3play, pmidi) and input file. stracing shows that the players stuff
lots of
data into the appropriate device and then hang, while nothing is played.
Some
times playmidi even hung unkillable, had to reboot for further
experiments.

This may have to do with missing/wrong irq/port/dma/other parameters, just
I
can't think of more things to fiddle with; I compared them with the
working OSS
settings and the Windows configuration data.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-06 14:38 strcmp         New Issue                                    
01-29-06 14:38 strcmp         Distribution              => Debian          
01-29-06 14:38 strcmp         Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
