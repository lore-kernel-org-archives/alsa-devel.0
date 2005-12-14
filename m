From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001365]: Dell/Creative Labs Audigy 2 ZS: No capture control
Date: Wed, 14 Dec 2005 23:03:40 +0100
Message-ID: <8c415be0d9f9b13027fd6eba48b05e7e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2FFCF198
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 23:03:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1365> 
======================================================================
Reported By:                phineas
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1365
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian testing (etch)
Kernel Version:             2.6.12.4 vanilla
======================================================================
Date Submitted:             08-24-2005 09:22 CEST
Last Modified:              12-14-2005 23:03 CET
======================================================================
Summary:                    Dell/Creative Labs Audigy 2 ZS: No capture control
Description: 
Unless this is a user overlooking a step...

There is no mute control on the "Master" item (or most other items for
that matter).
More importantly, the capture items do not have a capture control; they
have level adjustments, but one cannot actually select an item for
capturing.
It appears that this Dell-supplied device (with Audigy subsytem 1003) is
generally unknown to the drivers -- but it does work well for sound
playback.

======================================================================

----------------------------------------------------------------------
 phineas - 08-26-05 22:04 
----------------------------------------------------------------------
Okay, I was unable to compile alsa from cvs, so I applied the patch
(without the .id field) to the alsa sources included with vanilla kernel
2.6.12.4.  Everything seems to work now.  Do you need me to try it again
with cvs for admission in a future release?

----------------------------------------------------------------------
 phineas - 12-14-05 23:03 
----------------------------------------------------------------------
The code segment posted by pzad works as provided with alsa included with
debian kernel 2.6.14.

Could someone apply the definition posted by pzad as a patch to CVS?


$ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).

$ cat /proc/asound/cards   
0 [Audigy2        ]: Audigy2 - Audigy 2 ZS [SB0353]
                     Audigy 2 ZS [SB0353] (rev.4, serial:0x10031102) at
0xccc0, irq 17

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-24-05 09:22 phineas        New Issue                                    
08-24-05 09:22 phineas        File Added: vegan.state                      
08-24-05 09:22 phineas        Distribution              => Debian testing (etch)
08-24-05 09:22 phineas        Kernel Version            => 2.6.12.4 vanilla
08-24-05 20:58 phineas        Issue Monitored: phineas                     
08-25-05 17:11 pzad           Note Added: 0005941                          
08-26-05 22:04 phineas        Note Added: 0005958                          
09-17-05 18:54 jdthood        Summary                  Dell/Creative Labs Audigy
2 ZS mixer controls => Dell/Creative Labs Audigy 2 ZS: No capture control
12-14-05 23:03 phineas        Note Added: 0007043                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
