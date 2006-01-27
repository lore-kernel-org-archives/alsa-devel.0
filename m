From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001785]: ice1712 driver -cs8427 SPDIF chip not always set up correctly
Date: Fri, 27 Jan 2006 10:10:16 +0100
Message-ID: <1be783c2347435fb95a3f88db3c7dd9b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7093D1A6
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 10:10:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1785> 
======================================================================
Reported By:                alanmann
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1785
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-26-2006 23:27 CET
Last Modified:              01-27-2006 10:10 CET
======================================================================
Summary:                    ice1712 driver -cs8427 SPDIF chip not always set up
correctly
Description: 
There are regular occasions when SPDIF IN operates spuriously, on Terratec
DMX6fire (& presumably others, like delta1010LT?).

At start-up or when changing between non-spdif master clock settings,
Digital Input stream has incorrect signal present, real enough to be
recorded with audacity.  The cause is errors in writing to the cs8427
spdif chip.  Will add notes with my findings.
======================================================================

----------------------------------------------------------------------
 alanmann - 01-26-06 23:50 
----------------------------------------------------------------------
I have traced the problems to the following, if I understand correctly:

1. In ice1712.c, function snd_ice1712_pro_internal_clock_put L1858:
	if ((oval & ICE1712_SPDIF_MASTER) !=
	    (inb(ICEMT(ice, RATE)) & ICE1712_SPDIF_MASTER)) {
tests if spdif has changed, and updates the chip if so.

When the driver is started, the test fails, so the chip is not sent spdif
set-up data, and operates wrong.  Selecting spdif writes correct data and
all is OK .

2. When set to eg 44K, selecting eg 48K results in
snd_ice1712_pro_internal_clock_put calling snd_ice1712_set_pro_rate which
ends up in cs8427.c with function snd_cs8427_iec958_pcm.  This sets spdif
status & rate data then performs a reset, writing to 0x04 and deleting the
spdif set-up.  As the spdif has not been set changed, back in
snd_ice1712_pro_internal_clock_put the spdif test in 1. is failed again so
the chip has become un-set as in 1.


The easiest solution to both is to remove the test L1858 shown above from
ice1712.c so that the cs8427 is written to every time master clock is
changed.  I have tried this and it does work.  Then the cs8427 is written
or re-written each time, but is the test there for any other reason?

Otherwise I suppose extra spdif set-up is needed during driver start-up,
AND the reset routine in cs8427.c would need changing to perhaps read the
register state and re-establish the spdif setting.

The former solution sounds preferable to me if it doesn't break anything
else.

If this were agreed, I could prepare a patch to submit.

Please add comments.



----------------------------------------------------------------------
 alanmann - 01-27-06 10:10 
----------------------------------------------------------------------
The previous note has been added to, but the extra didn't come to
alsa-devel list.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-26-06 23:27 alanmann       New Issue                                    
01-26-06 23:41 alanmann       Note Added: 0007795                          
01-26-06 23:50 alanmann       Note Edited: 0007795                         
01-27-06 10:10 alanmann       Note Added: 0007797                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
