From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001600]: On a Shuttle SD11G5 the audio card is recognized but does not work.
Date: Mon, 9 Jan 2006 22:25:54 +0100
Message-ID: <23b2b4bcab5ec89c6da59fbd62469b51@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B72E314F
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2006 22:25:54 +0100 (MET)
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


The issue 0001700 has been removed as a DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1600> 
======================================================================
Reported By:                bolmsted
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1600
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             11-26-2005 02:59 CET
Last Modified:              01-09-2006 22:21 CET
======================================================================
Summary:                    On a Shuttle SD11G5 the audio card is recognized but
does not work.
Description: 

I have a Shuttle SD11G5 with a builtin Creative Labs Sound Blaster Live!
24-bit EAX 7.1.

The alsa driver does not recognize the serial number and defaults to
Unknown. The unknown state fails to play any audio.

I added the following to fix the problem:

         /* Shuttle XPC SD11G5 which has an onboard Creative Labs Sound
Blaster Live! 24-bit EAX
          * high-definition 7.1 audio processor".
          */
         { .serial = 0x30411297,
           .name   = "Shuttle XPC SD11G5 [SD11G5]",
           .gpio_type = 1,
           .i2c_adc = 1 } ,


This was added to "ca0106_chip_details" structure in ca0106_main.c.

It fixed the problem and the sound works great.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001675 Shuttle SD11G5 (pentium M) CA0106 sound...
======================================================================

----------------------------------------------------------------------
 jcdutton - 01-09-06 22:21 
----------------------------------------------------------------------
Fixed in alsa-driver 1.0.11rc3 or above.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-26-05 02:59 bolmsted       New Issue                                    
12-28-05 22:24 sjenkins       Issue Monitored: sjenkins                    
01-09-06 22:13 jcdutton       Relationship added       has duplicate 0001675
01-09-06 22:21 jcdutton       Status                   assigned => closed  
01-09-06 22:21 jcdutton       Note Added: 0007543                          
01-09-06 22:25 jcdutton       Relationship added       has duplicate 0001700
01-09-06 22:25 jcdutton       Relationship deleted     has duplicate 0001700
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
