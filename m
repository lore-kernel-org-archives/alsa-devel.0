From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000446]: System freezes everytime when I start recording.
Date: Sat, 31 Dec 2005 04:07:34 +0100
Message-ID: <566bc7ed8b0a6977748417f995b84275@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DE7215C
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 04:07:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=446> 
======================================================================
Reported By:                Marc_R
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   446
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Debian GNU/Linux / DeMuDi
Kernel Version:             every kernel I tried 2.4.x / 2.6.x
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-16-2004 22:24 CEST
Last Modified:              12-31-2005 04:07 CET
======================================================================
Summary:                    System freezes everytime when I start recording.
Description: 
I have a Terratec 128i PCI soundcard which works great as long as I don't
record something.
I tried recording from cd, microphone, and mix via arecord and Audacity.
The capture devices were set correctly.
As soon as the recording begins, the system freezes immediately. Even the
Magic SysRq doesn't work so I have to reset the PC.
I had this problem with every Linux-kernel version I tried from 2.4.x to
2.6.8.1.
I even installed DeMuDi but had the same problem there.

After some more testing I found out that recording works more or less,
when I unload the usb-module (uhci_hcd). But I have to unload it when X is
not running (?!), otherwise the system still crashes.

I then borrowed another soundcard (SB 128) and got it working with no
problems. So it seems that there is some bug in the recording part of the
es1938-driver...

If there's additional information needed, please ask.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 04:26 
----------------------------------------------------------------------
Submitter: Do you see any improvement in later ALSA releases?

----------------------------------------------------------------------
 rlrevell - 12-31-05 04:07 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-16-04 22:24 Marc_R         New Issue                                    
08-16-04 22:24 Marc_R         Distribution              => Debian GNU/Linux /
DeMuDi
08-16-04 22:24 Marc_R         Kernel Version            => every kernel I tried
2.4.x / 2.6.x
04-09-05 04:26 jdthood        Note Added: 0004382                          
12-31-05 04:07 rlrevell       Status                   new => closed       
12-31-05 04:07 rlrevell       Note Added: 0007338                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
