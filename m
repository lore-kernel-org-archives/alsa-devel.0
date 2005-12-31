From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000325]: Attempted use of arecord causes complete system lockup. Only a hard reset recovers.
Date: Sat, 31 Dec 2005 04:09:07 +0100
Message-ID: <3fa6b8df0921a0f7fb7cc72c3e5c91da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7C350155
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 04:09:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=325> 
======================================================================
Reported By:                meg
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   325
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 2
Kernel Version:             2.6.5-1.358
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-06-2004 23:49 CEST
Last Modified:              12-31-2005 04:09 CET
======================================================================
Summary:                    Attempted use of arecord causes complete system
lockup. Only a hard reset recovers.
Description: 
This is a bone stock Fedora Core 2 system. The sound card is a SB16 P&P.
Any attempted use of arecord, either from a console or xterm, results in a
complete system lockup. It is 100% reproducible. aplay can play a test
sound. alsamixer seems to work as well. The microphone can be heard
through the speakers and can be adjusted using alsamixer.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-07-05 00:07 
----------------------------------------------------------------------
Submitter: Was there any improvement in later ALSA releases?

----------------------------------------------------------------------
 rlrevell - 12-31-05 04:09 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-04 23:49 meg            New Issue                                    
06-06-04 23:49 meg            Distribution              => Fedora Core 2   
06-06-04 23:49 meg            Kernel Version            => 2.6.5-1.358     
06-07-04 06:02 meg            Issue Monitored: meg                         
04-07-05 00:07 jdthood        Note Added: 0004352                          
12-31-05 04:09 rlrevell       Status                   new => closed       
12-31-05 04:09 rlrevell       Note Added: 0007340                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
