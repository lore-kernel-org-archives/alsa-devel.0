From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000414]: sb cant grab irq 65535
Date: Fri, 12 Nov 2004 12:25:47 +0100
Message-ID: <a30ae153a41bfbde88636794908ad40c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9259A280
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2004 12:25:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=414> 
======================================================================
Reported By:                montjoie
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   414
Category:                   ISA - sb8
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Debian Testing
Kernel Version:             2.6.7
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             07-30-2004 11:20 CEST
Last Modified:              11-12-2004 12:25 CET
======================================================================
Summary:                    sb cant grab irq 65535
Description: 
Laptop toshiba satelitte CD2520CDS
Soundcard WSS & sb built in

Alsa say when loading sb driver:
"sb cant grab irq 65535" three times
I try both to make sb module and to built in sb in the kernel(no modules)
but it make the same.
I compile alsaconf ant try but no change.(on a kernel discution i saw a
man that say to do that).
I change all hardware config (irq dma etc..) but no change.
I try to force irq= when loading module but no change

======================================================================

----------------------------------------------------------------------
 montjoie - 10-01-04 12:21 
----------------------------------------------------------------------
Oups excuse me i forgot to speak about the new fact.
With yamaha, the sound module load with no problem but i haven't any
sound.
The problem is that my friend has (temporarely) put win98, so i cant make
any more test for the moment.

----------------------------------------------------------------------
 tiwai - 10-12-04 15:01 
----------------------------------------------------------------------
I guess the volume was simply muted.

Anyway, I close this bug now.  If you get the linux system working 
again and still see the same bug, please reopen this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-30-04 11:20 montjoie       New Issue                                    
07-30-04 11:20 montjoie       Distribution              => Debian Testing  
07-30-04 11:20 montjoie       Kernel Version            => 2.6.7           
08-02-04 18:12 montjoie       Issue Monitored: montjoie                    
08-02-04 18:13 montjoie       Note Added: 0001520                          
08-02-04 18:18 tiwai          Note Added: 0001522                          
08-18-04 16:23 montjoie       Note Added: 0001585                          
08-18-04 16:25 montjoie       Note Added: 0001586                          
08-18-04 16:41 Clemens LadischNote Added: 0001588                          
10-01-04 12:21 montjoie       Note Added: 0001997                          
10-12-04 15:01 tiwai          Status                   new => resolved     
10-12-04 15:01 tiwai          Resolution               open => not an issue
10-12-04 15:01 tiwai          Assigned To               => tiwai           
10-12-04 15:01 tiwai          Note Added: 0002103                          
11-12-04 12:25 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
