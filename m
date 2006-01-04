From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001700]: CMI 9880 not detected and not implemented yet
Date: Wed, 4 Jan 2006 17:33:47 +0100
Message-ID: <373b00ff244f9894f43e39e9c7957a55@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 91863154
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:33:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1700> 
======================================================================
Reported By:                mitcoes
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1700
Category:                   1_OTHERS
Reproducibility:            unable to duplicate
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Breezy Ubuntu
Kernel Version:             all
======================================================================
Date Submitted:             01-02-2006 17:40 CET
Last Modified:              01-04-2006 17:33 CET
======================================================================
Summary:                    CMI 9880 not detected and not implemented yet
Description: 
CMI 9880 that comes integrated with ASUS P5AD2 Premium and others doesn't
work.

I have read 
>> know mine is running under an "i810_audio" module. << at
http://hardware.mcse.ms/archive13-2005-1-137173.html
but it does not give a complete performance.



======================================================================

----------------------------------------------------------------------
 tiwai - 01-04-06 17:33 
----------------------------------------------------------------------
CMI9880 is for HD-audio.  Use snd-hda-intel driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-06 17:40 mitcoes        New Issue                                    
01-02-06 17:40 mitcoes        Distribution              => Breezy Ubuntu   
01-02-06 17:40 mitcoes        Kernel Version            => all             
01-04-06 17:33 tiwai          Note Added: 0007444                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
