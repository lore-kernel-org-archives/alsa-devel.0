From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001408]: Ask for driver support
Date: Mon, 19 Dec 2005 02:39:17 +0100
Message-ID: <26a33cc4f6900be6f5df4cbaae50a338@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9137E16B
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2005 02:39:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1408> 
======================================================================
Reported By:                war0060
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1408
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-09-2005 12:12 CEST
Last Modified:              12-19-2005 02:39 CET
======================================================================
Summary:                    Ask for driver support
Description: 
The startup message told me that ALSA can't find the right driver for my
card. The  sound card is built-in on ASUS P5GL-MX motherboard.

the message of "lspci":
--------------------------------------------------------------------------------
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 05)
--------------------------------------------------------------------------------
I've tried "intel8x0" driver but doesn't work. Or I should use another
driver?
======================================================================

----------------------------------------------------------------------
 tiwai - 09-09-05 12:27 
----------------------------------------------------------------------
It's snd-hda-intel driver.

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:39 
----------------------------------------------------------------------
Not a bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-05 12:12 war0060        New Issue                                    
09-09-05 12:27 tiwai          Note Added: 0006092                          
12-19-05 02:39 rlrevell       Status                   new => closed       
12-19-05 02:39 rlrevell       Note Added: 0007087                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
