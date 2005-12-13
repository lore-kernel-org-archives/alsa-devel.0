From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000165]: random snd_es1938 crashes
Date: Tue, 13 Dec 2005 12:45:15 +0100
Message-ID: <00b03c39e398900e35ae1d4d971a9d5d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B965D1C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:45:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=165> 
======================================================================
Reported By:                lucas
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   165
Category:                   PCI - es1938
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-29-2004 16:25 CEST
Last Modified:              12-13-2005 12:45 CET
======================================================================
Summary:                    random snd_es1938 crashes
Description: 
Some randoms alsa problems appeared after I upgraded from 2.6.3 to 2.6.4.
Here is what hit the logs :

<3>irq 7: nobody cared!
Call Trace:
 [<c010a8aa>] __report_bad_irq+0x2a/0x90
 [<c010a99c>] note_interrupt+0x6c/0xb0
 [<c010ac51>] do_IRQ+0x121/0x130
 [<c01090a4>] common_interrupt+0x18/0x20
 [<c011dd80>] do_softirq+0x40/0xa0
 [<c010ac2d>] do_IRQ+0xfd/0x130
 [<c0105000>] rest_init+0x0/0x60
 [<c01090a4>] common_interrupt+0x18/0x20
 [<c0105000>] rest_init+0x0/0x60
 [<c0106c13>] default_idle+0x23/0x30
 [<c0106c7c>] cpu_idle+0x2c/0x40
 [<c031e6e3>] start_kernel+0x163/0x180
 [<c031e430>] unknown_bootoption+0x0/0x120

handlers:
[<df994980>] (snd_es1938_interrupt+0x0/0x1b0 [snd_es1938])
Disabling IRQ #7
spurious 8259A interrupt: IRQ7.

xmms hangs when trying to listen to music, but xawtv/xawdecode still works
with sound. rmmod-ing and modprob-ing snd_es1938 restores the normal
behaviour.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 12:43 
----------------------------------------------------------------------
Submitter: Is this still a problem?

----------------------------------------------------------------------
 jdthood - 12-13-05 12:45 
----------------------------------------------------------------------
No feedback was forthcoming.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-04 16:25 lucas          New Issue                                    
03-29-04 16:25 lucas          Distribution              => Debian          
03-19-05 12:43 jdthood        Note Added: 0004037                          
12-13-05 12:45 jdthood        Status                   new => closed       
12-13-05 12:45 jdthood        Note Added: 0007000                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
