From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001522]: unable to mute line in while recording(capturing) line in.
Date: Sat, 31 Dec 2005 03:28:52 +0100
Message-ID: <064e2b47bc8fabff15ad5507adbbdcf2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA77112B
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 03:28:52 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1522> 
======================================================================
Reported By:                penguinz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1522
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu 5.10(Breezy)
Kernel Version:             2.6.12-9-k7
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             11-01-2005 16:00 CET
Last Modified:              12-31-2005 03:28 CET
======================================================================
Summary:                    unable to mute line in while recording(capturing)
line in.
Description: 
Unable to mute line in while recording line in. I have a Mythtv system
runing, and since the upgrade from Ubuntu 5.04(Warty) to Ubuntu
5.10(Breezy) I can not mute line in. I tried it on my desktop machine and
get the same results, but also duel boots back into 5.04 so I can test it
both ways.
======================================================================

----------------------------------------------------------------------
 pzad - 11-22-05 21:45 
----------------------------------------------------------------------
Set capture on "Capture" and your source ("Line In" or "Mic").
Changing (mute) Line In (or Mic) volume can not affect recorded signal -
this will change only playback volume (if you have SB Live). Make sure,
you have set "Wave Capture" to 0.

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:28 
----------------------------------------------------------------------
Mixer settings

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-05 16:00 penguinz       New Issue                                    
11-01-05 16:00 penguinz       Distribution              => Ubuntu 5.10(Breezy)
11-01-05 16:00 penguinz       Kernel Version            => 2.6.12-9-k7     
11-22-05 21:26 penguinz       Note Added: 0006800                          
11-22-05 21:45 pzad           Note Added: 0006803                          
12-31-05 03:28 rlrevell       Status                   new => closed       
12-31-05 03:28 rlrevell       Note Added: 0007327                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
