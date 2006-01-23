From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001776]: Synchronisation of two m-audio delta 1010 cards
Date: Mon, 23 Jan 2006 18:32:44 +0100
Message-ID: <95b760b9da0df3d6e4d950ab1c7350bb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 11F4C167
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2006 18:32:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1776> 
======================================================================
Reported By:                Schafwoller
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1776
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.13
======================================================================
Date Submitted:             01-23-2006 18:32 CET
Last Modified:              01-23-2006 18:32 CET
======================================================================
Summary:                    Synchronisation of two m-audio delta 1010 cards
Description: 
Now we´re able to use two ice1712 cards full duplex and without xruns. The
synchronisation via word-clock (with the "no-signal"-state in
envy24control) seems to work for audio up to 48kHz (using 75Ohm cable).
Midi is running on both cards without any problems. We're able to use a tc
m-one(external multi-effects-processor) over spdif connected to the master
sound card.
The problems:
While using 88,2 kHz we get a lot of noise on the pcm-inputs of the
slave-card. Also sending and receiving to/from m-one over spdif on the
slave-card (using 48kHz) is impossible. The sync-signal seems to be broken
because the m-one is reporting error messages regarding a wrong sync-rate!
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-23-06 18:32 Schafwoller    New Issue                                    
01-23-06 18:32 Schafwoller    Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
