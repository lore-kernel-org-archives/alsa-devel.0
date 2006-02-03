From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001813]: STAC9750 not recognised by hda-intel
Date: Fri, 3 Feb 2006 17:09:08 +0100
Message-ID: <a5a0ad69cd6d9d75ee4cdf824b79572f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24F251A9
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2006 17:09:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1813> 
======================================================================
Reported By:                hsheppard
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1813
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.16-rc1
======================================================================
Date Submitted:             02-03-2006 17:09 CET
Last Modified:              02-03-2006 17:09 CET
======================================================================
Summary:                    STAC9750 not recognised by hda-intel
Description: 
I have a Dell Inspiron 630M (AKA Dell XPS140) that has an ICH6 controller
and a STAC9750 HDaudio codec. ALSA currently recognises the codec as a
9200-series, not the 9750.

As such, the internal speakers and mic-in jacks do not work and the mixer
is looking extremely spartan (see attachment).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 17:09 hsheppard      New Issue                                    
02-03-06 17:09 hsheppard      File Added: alsamixer.png                    
02-03-06 17:09 hsheppard      Distribution              => Gentoo Linux    
02-03-06 17:09 hsheppard      Kernel Version            => 2.6.16-rc1      
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
