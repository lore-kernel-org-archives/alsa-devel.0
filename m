From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Thu, 5 Jan 2006 10:01:38 +0100
Message-ID: <bfc8c87a99dbc00acbdf7ebfaece147a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4BE76162
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2006 10:01:40 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1138> 
======================================================================
Reported By:                penguinparty
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1138
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               ubuntu 5.04
Kernel Version:             2.6.11.11 2.6.11.8 and 2.6.10
======================================================================
Date Submitted:             05-28-2005 22:22 CEST
Last Modified:              01-05-2006 10:01 CET
======================================================================
Summary:                    errors when installing au8820 modules
Description: 
Please see the section additional information for a dump of my dmesg output
regarding the au8820 module.

I have tried installing this module using 2.6.11.11 2.6.11.8 and 2.6.10
kernels. The shipping alsa support under each of these kerenls provies me
with the same result. I have also tried installing each of these kernels
without alsa support only CONFIG_SOUND and then installing the
alsa-drivers 1.0.9rc4a

I get the same result every time I do the modprobe snd-au8820

Using older versions of debian as well as the ubuntu live cd's I am able
to get this sound card working.
======================================================================

----------------------------------------------------------------------
 Raymond - 09-02-05 05:49 
----------------------------------------------------------------------
Please post the result

lspci -vvn  (for your au8820)

cat /proc/asound/au8820/codec97#0/ac97#0-0+regs

This may help us to find out the left/right channels swap problem for
other au8820 user

Need more feedback from testers with au8810/au8830 on AMD64 and
au8810/au8820/au8830 on 32 bits machines to test this patch.

----------------------------------------------------------------------
 Raymond - 01-05-06 10:01 
----------------------------------------------------------------------
Do your hear any sound when playing mono pcm wav through hw:0,3(WT) of your
au8820 after applying this patch ?

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1593

> -  (dma->dma_ctrl & FMT_MASK) | ((fmt << FMT_SHIFT) & FMT_MASK);
> + (dma->dma_ctrl & ~FMT_MASK) | ((fmt << FMT_SHIFT) & FMT_MASK);

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 22:22 penguinparty   New Issue                                    
05-28-05 22:22 penguinparty   Distribution              => ubuntu 5.04     
05-28-05 22:22 penguinparty   Kernel Version            => 2.6.11.11 2.6.11.8
and 2.6.10
05-28-05 22:22 penguinparty   Issue Monitored: penguinparty                    
06-08-05 04:41 penguinparty   File Added: typescript                       
06-08-05 04:43 penguinparty   Note Added: 0004914                          
08-24-05 10:55 Raymond        Note Added: 0005925                          
08-24-05 10:58 Raymond        Note Added: 0005926                          
08-24-05 10:59 Raymond        Note Deleted: 0005926                        
09-01-05 04:24 penguinparty   File Added: make-typescript                    
09-01-05 04:25 penguinparty   Note Added: 0005993                          
09-01-05 05:58 Raymond        Note Added: 0005994                          
09-02-05 02:49 penguinparty   Note Added: 0006002                          
09-02-05 05:49 Raymond        Note Added: 0006003                          
11-16-05 06:29 Raymond        Note Added: 0006736                          
11-23-05 13:50 Raymond        Note Added: 0006810                          
01-02-06 10:07 Raymond        Note Deleted: 0006810                        
01-05-06 09:51 Raymond        Note Deleted: 0006736                        
01-05-06 10:01 Raymond        Note Added: 0007465                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
