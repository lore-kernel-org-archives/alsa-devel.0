From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001658]: Capture happens only on one channel
Date: Fri, 13 Jan 2006 18:17:57 +0100
Message-ID: <fef8509a228b863b096209e919103249@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2AF25127
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 18:17:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1658> 
======================================================================
Reported By:                phil_troin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1658
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r2
======================================================================
Date Submitted:             12-18-2005 08:40 CET
Last Modified:              01-13-2006 18:17 CET
======================================================================
Summary:                    Capture happens only on one channel
Description: 
When I am playing a CD, if I capture the sound output via the capture
channel OR the CD channel (amixer output attached), the captured sound is
only one one channel (the right one) and is very distorted.
The audio plays normally in stereo on the speakers.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-13-06 17:51 
----------------------------------------------------------------------
This should have been already fixed in the latest version.

----------------------------------------------------------------------
 vsu - 01-13-06 18:17 
----------------------------------------------------------------------
Yes, upgrading only alsa-lib to 1.0.11rc2 seems to fix this problem for me.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-18-05 08:40 phil_troin     New Issue                                    
12-18-05 08:40 phil_troin     File Added: amixout                          
12-18-05 08:40 phil_troin     Distribution              => Gentoo          
12-18-05 08:40 phil_troin     Kernel Version            => 2.6.14-gentoo-r2
12-18-05 12:00 linuxbear      Note Added: 0007071                          
12-18-05 12:02 linuxbear      Note Edited: 0007071                         
12-27-05 10:34 linuxbear      Issue Monitored: linuxbear                    
01-07-06 06:24 tgutwin        Note Added: 0007508                          
01-07-06 06:25 tgutwin        Issue Monitored: tgutwin                     
01-09-06 01:34 legluondunet   Note Added: 0007529                          
01-09-06 01:35 legluondunet   File Added: alsa.conf.record1channel              
     
01-09-06 01:37 legluondunet   File Added: alsa.conf.ubuntu                    
01-09-06 01:43 legluondunet   Note Added: 0007530                          
01-13-06 02:17 rlrevell       Note Added: 0007615                          
01-13-06 14:29 Matthias KoenigNote Added: 0007640                          
01-13-06 17:12 legluondunet   Note Added: 0007644                          
01-13-06 17:46 vsu            Note Added: 0007645                          
01-13-06 17:49 vsu            Issue Monitored: vsu                         
01-13-06 17:51 tiwai          Note Added: 0007646                          
01-13-06 18:17 vsu            Note Added: 0007647                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
