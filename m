From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001814]: EMU10K1 rear, center, LFE channels not work. bug in EMU10K1.conf
Date: Fri, 3 Feb 2006 18:51:29 +0100
Message-ID: <14bdecbabaee537918b0346de0f0bd2a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 109621AA
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2006 18:51:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1814> 
======================================================================
Reported By:                bilek
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1814
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-03-2006 18:35 CET
Last Modified:              02-03-2006 18:51 CET
======================================================================
Summary:                    EMU10K1 rear, center, LFE channels not work. bug in
EMU10K1.conf
Description: 
The problem is similar or the same to already reported problem id=1624
see link https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1624

After the update to alsa-lib-1.0.10-3.FC4.i386.rpm the rear, center LFE
and maybe more channels not "sounding" but can be used as output.

The "speaker-test -c 6" claims that everything is OK, but no sound.



======================================================================

----------------------------------------------------------------------
 rlrevell - 02-03-06 18:51 
----------------------------------------------------------------------
Um, that bug is resolved, did you even try any of the solutions?

- Upgrade your ALSA drivers to 1.0.10 or newer
- Upgrade to ALSA 1.0.11-rc3
- Replace your EMU10k1.conf with the one from the other bug report

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 18:35 bilek          New Issue                                    
02-03-06 18:51 rlrevell       Note Added: 0007902                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
