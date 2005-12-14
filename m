From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001624]: No front channels on AC3
Date: Wed, 14 Dec 2005 20:22:35 +0100
Message-ID: <e955354fa880d6092c2d55fe0c9ea291@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E557F1B1
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 20:22:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1624> 
======================================================================
Reported By:                Cimi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1624
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Etch
Kernel Version:             2.6.13.4
======================================================================
Date Submitted:             12-06-2005 21:31 CET
Last Modified:              12-14-2005 20:22 CET
======================================================================
Summary:                    No front channels on AC3
Description: 
I can't hear any sound playing any ac3 track with xine. Same with 2.6.14.3
kernel.
======================================================================

----------------------------------------------------------------------
 mikma - 12-14-05 20:11 
----------------------------------------------------------------------
It's available via the CVS Web interface:
http://cvs.sourceforge.net/viewcvs.py/*checkout*/alsa/alsa-lib/src/conf/cards/EMU10K1.conf?rev=1.16

----------------------------------------------------------------------
 Winterbird - 12-14-05 20:22 
----------------------------------------------------------------------
thx. using the old EMU10K1.conf I get sound from all speakers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-06-05 21:31 Cimi           New Issue                                    
12-06-05 21:31 Cimi           Distribution              => Debian Etch     
12-06-05 21:31 Cimi           Kernel Version            => 2.6.13.4        
12-08-05 16:21 Cimi           Issue Monitored: Cimi                        
12-13-05 12:57 mikma          Note Added: 0007006                          
12-13-05 20:50 Winterbird     Note Added: 0007022                          
12-14-05 18:23 mikma          Note Added: 0007039                          
12-14-05 20:06 Winterbird     Note Added: 0007040                          
12-14-05 20:11 mikma          Note Added: 0007041                          
12-14-05 20:22 Winterbird     Note Added: 0007042                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
