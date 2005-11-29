From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000521]: Jack + Alsa not working in full duplex, works with OSS, griffin imic
Date: Tue, 29 Nov 2005 10:14:26 +0100
Message-ID: <6dd22998e4082e997c8f9cfcb71d5eb5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10F371AE
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2005 10:14:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=521> 
======================================================================
Reported By:                LokiDavison
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   521
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake
Kernel Version:             2.4.22-28mm.2mdk
======================================================================
Date Submitted:             09-21-2004 21:06 CEST
Last Modified:              11-29-2005 10:14 CET
======================================================================
Summary:                    Jack + Alsa not working in full duplex, works with
OSS, griffin imic
Description: 
Jack works with the OSS audio driver in full duplex but only works simplex
with alsa driver. The alsa driver works full duplex when used with alsa
apps. 100% reproducable. This is using a griffin imic with the
snd-usb-audio module tested on 2.6 and 2.4 kernels. All jack versions
including 0.99. I'm often on LAD irc if you want more info.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000758 Full duplex is not working in OSS emula...
======================================================================

----------------------------------------------------------------------
 LokiDavison - 11-28-05 11:17 
----------------------------------------------------------------------
I now have a new machine and no longer a laptop so don't use my usb card
any more. I've previously tried many different jack params, including low
buffer size and high number of interrupts per period. If you want more
info i can provide full details on lad irc irc.freenode.org #lad 

Loki

----------------------------------------------------------------------
 LokiDavison - 11-29-05 10:14 
----------------------------------------------------------------------
Just tested on my new machine with jack and my griffin imic, kernel
2.6.12-12.mm.2mdk (mandriva multimedia thing not sure what patches are
included) 
cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10rc1

running jack with no probs full duplex. Frames/Period 128, periods/buffer
3. Overall latency, 8ms. Haven't tried with lower options. No x runs yet,
but i've only run it for half an hour.

This suggests either something has fixed or it was a problem with some
laptop hardware.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 21:06 LokiDavison    New Issue                                    
09-21-04 21:06 LokiDavison    Distribution              => Mandrake        
09-21-04 21:06 LokiDavison    Kernel Version            => 2.4.22-28mm.2mdk
10-08-04 18:32 ryanpg         Issue Monitored: ryanpg                      
10-08-04 18:40 ryanpg         Note Added: 0002055                          
09-14-05 15:49 jdthood        Note Added: 0006160                          
09-14-05 16:16 jdthood        Relationship added       related to 0000758  
11-28-05 09:54 croiset        Note Added: 0006854                          
11-28-05 10:24 Clemens LadischNote Added: 0006855                          
11-28-05 10:32 croiset        Note Added: 0006856                          
11-28-05 11:17 LokiDavison    Note Added: 0006858                          
11-29-05 10:14 LokiDavison    Note Added: 0006872                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
