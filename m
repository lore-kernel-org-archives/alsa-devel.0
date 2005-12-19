From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001517]: No sound on hda-intel on Acer TravelMate 4061NLMi
Date: Mon, 19 Dec 2005 02:28:09 +0100
Message-ID: <8cae741cfd573cd6aa9c89fbeee48b77@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 099D216B
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2005 02:28:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1517> 
======================================================================
Reported By:                er-ku
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1517
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.12-9-686
======================================================================
Date Submitted:             10-31-2005 00:19 CET
Last Modified:              12-19-2005 02:28 CET
======================================================================
Summary:                    No sound on hda-intel on Acer TravelMate 4061NLMi
Description: 
This will be very much like other reports around.

Just bought a new laptop and installed Ubuntu Linux on it, and updated it.
Sound modules load silently, no complainments, alsamixer works and
channels are unmuted, but I get absolutely no sound from speakers of
headphones.

I'm not the only one having this issue
(http://ubuntuforums.org/showthread.php?p=450628), however, all the info I
managed to google either didn't help me, or was simply unfinished (like
forum questions that aren't answered).

I tried the stock drivers provided by the Ubuntu kernel, then I tried
1.0.10rc2, and cvs builds i made myself (created them as .debs though). In
all cases the result was the same - absolute silence.

======================================================================

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:28 
----------------------------------------------------------------------
Please test the latest ALSA release (1.0.11-rc1), this should be fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-05 00:19 er-ku          New Issue                                    
10-31-05 00:19 er-ku          Distribution              => Ubuntu Breezy   
10-31-05 00:19 er-ku          Kernel Version            => 2.6.12-9-686    
10-31-05 00:21 er-ku          Issue Monitored: er-ku                       
12-19-05 02:28 rlrevell       Note Added: 0007083                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
