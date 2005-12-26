From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001661]: alsaconf gets everything working but mic input doesn't work after a reboot
Date: Mon, 26 Dec 2005 07:49:25 +0100
Message-ID: <0f4d018b288da29fdc47f32923b5d0f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E1D10117
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2005 07:49:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1661> 
======================================================================
Reported By:                amarsh04
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1661
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.14.2-686
======================================================================
Date Submitted:             12-20-2005 03:16 CET
Last Modified:              12-26-2005 07:49 CET
======================================================================
Summary:                    alsaconf gets everything working but mic input
doesn't work after a reboot
Description: 
I've finally obtained a SB Live! card that works and alsaconf made
everything work. However, after a reboot, output still works but not
microphone input. krecord shows zero input level. Re-running alsaconf
restores microphone input to a working state.
======================================================================

----------------------------------------------------------------------
 amarsh04 - 12-21-05 22:23 
----------------------------------------------------------------------
I have attached the output of amixer for both the working and the
non-working cases, and will also attach the output of lsmod for both the
working and non-working cases.

----------------------------------------------------------------------
 amarsh04 - 12-26-05 07:49 
----------------------------------------------------------------------
After removing ld10k1, and writing a startup script to run asfxload, the SB
Live! card works fully after reboot.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 03:16 amarsh04       New Issue                                    
12-20-05 03:16 amarsh04       Distribution              => Debian          
12-20-05 03:16 amarsh04       Kernel Version            => 2.6.14.2-686    
12-20-05 12:44 amarsh04       Note Added: 0007104                          
12-20-05 20:58 rlrevell       Note Added: 0007105                          
12-21-05 22:20 amarsh04       File Added: amixerworking.txt                    
12-21-05 22:21 amarsh04       File Added: amixernotworking.txt                  
 
12-21-05 22:23 amarsh04       Note Added: 0007112                          
12-21-05 22:24 amarsh04       File Added: lsmodworking.txt                    
12-21-05 22:25 amarsh04       File Added: lsmodnotworking.txt                   

12-26-05 07:49 amarsh04       Note Added: 0007148                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
