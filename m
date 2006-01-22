From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001434]: Java plugin sound not working in OSS emulation
Date: Sun, 22 Jan 2006 14:45:00 +0100
Message-ID: <e296db9954b85146531729d08a5f1858@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5245510F
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 14:45:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1434> 
======================================================================
Reported By:                xolsonalsa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1434
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-18-2005 22:40 CEST
Last Modified:              01-22-2006 14:44 CET
======================================================================
Summary:                    Java plugin sound not working in OSS emulation
Description: 
Tried 2 different soundblaster 16 cards, and ISA and a pnp isa vibra 16. 
PCM sounds won't play if the Java Sound Audio Engine (software mixer that
opens /dev/dsp) is in use. Tried it with the JavaSoundDemo and also pogo
games. The symptom is it seems to play one sound and then io through
/dev/dsp becomes blocked. The only workaround is to start the web browser
using aoss so that it opens the native alsa pcm device instead of
/dev/dsp.
======================================================================

----------------------------------------------------------------------
 xolsonalsa - 01-22-06 13:57 
----------------------------------------------------------------------
Problem is getting worse, I just tried using the alsa drivers that came
with Fedora Core 4, kernel version 2.6.14-1.1656_FC4, alsa kernel drivers
version 1.0.10rc1; alsa-lib, alsa-util, alsa-oss all version 1.0.10.  And
now when I start the web browser using aoss and test java sound it behaves
exactly like the driver 1.0.9 did in oss emulation, plays one sound and
dies.

----------------------------------------------------------------------
 xolsonalsa - 01-22-06 14:44 
----------------------------------------------------------------------
Ok nevermind my previous comment about alsa 1.0.10, the workaround by
starting the browser with aoss still works, I just had a problem with my
asound.conf being overwritten by fedora system-config-soundcard (which
doesn't work with a non plug and play isa soundcard).  So it wasn't
loading the dmix plugin.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-18-05 22:40 xolsonalsa     New Issue                                    
09-23-05 14:46 xolsonalsa     Note Added: 0006367                          
09-25-05 01:07 xolsonalsa     Note Added: 0006380                          
09-25-05 12:38 xolsonalsa     Note Added: 0006385                          
09-27-05 03:54 xolsonalsa     Note Added: 0006402                          
01-22-06 13:57 xolsonalsa     Note Added: 0007746                          
01-22-06 14:44 xolsonalsa     Note Added: 0007747                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
