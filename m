From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000992]: no supported card
Date: Tue, 13 Dec 2005 13:24:19 +0100
Message-ID: <d62fa0e804202115298b21213961e24e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24A4F1C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 13:24:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=992> 
======================================================================
Reported By:                rav0r
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   992
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-14-2005 21:52 CET
Last Modified:              12-13-2005 13:24 CET
======================================================================
Summary:                    no supported card
Description: 
I am not sure what model my s.card is. I only know it's ct4830 , 4.1 .Will
this model ever be supported?
======================================================================

----------------------------------------------------------------------
 jcdutton - 10-23-05 19:47 
----------------------------------------------------------------------
lspci is used to detect your sound card.
You don't seem to have it installed.
install pciutils.
The ./configure should then work fine.

----------------------------------------------------------------------
 jcdutton - 12-13-05 13:24 
----------------------------------------------------------------------
Closed due to lack of feedback

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 21:52 rav0r          New Issue                                    
03-14-05 21:52 rav0r          Kernel Version            => 2.4             
03-14-05 22:57 mikma          Note Added: 0003910                          
03-15-05 23:13 rav0r          Note Added: 0003925                          
03-16-05 11:05 mikma          Note Added: 0003935                          
03-17-05 00:51 rav0r          Note Added: 0003974                          
03-20-05 19:14 rav0r          Note Added: 0004096                          
03-20-05 20:28 mikma          Note Added: 0004099                          
03-21-05 03:32 rav0r          File Added: config.log                       
03-21-05 03:33 rav0r          Note Added: 0004112                          
03-21-05 03:33 rav0r          Note Added: 0004113                          
03-21-05 15:44 mikma          Note Added: 0004118                          
03-21-05 17:13 rav0r          Note Added: 0004120                          
04-06-05 18:15 rav0r          Note Added: 0004347                          
04-06-05 18:16 rav0r          Note Added: 0004348                          
04-06-05 18:40 jcdutton       Note Added: 0004349                          
04-06-05 18:40 jcdutton       Status                   assigned => feedback
04-07-05 12:54 rav0r          Note Added: 0004355                          
04-07-05 12:55 rav0r          Note Added: 0004356                          
04-11-05 13:30 rav0r          Note Edited: 0004356                         
06-06-05 10:03 perex          Assigned To              perex => jcdutton   
06-06-05 10:03 perex          Category                 0_compilation problem_!!!
=> PCI - emu10k1
09-10-05 13:16 jcdutton       Note Added: 0006119                          
10-23-05 19:47 jcdutton       Note Added: 0006516                          
12-13-05 13:24 jcdutton       Status                   feedback => closed  
12-13-05 13:24 jcdutton       Note Added: 0007009                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
