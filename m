From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001435]: ac97 codec is not found when loading the driver
Date: Tue, 22 Nov 2005 00:00:38 +0100
Message-ID: <e86503eef0e6fdefeccf643ead11e3fb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65D2819C
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 00:00:38 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1435> 
======================================================================
Reported By:                iluxa
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1435
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.13, 2.6.14-rc1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-19-2005 08:49 CEST
Last Modified:              11-22-2005 00:00 CET
======================================================================
Summary:                    ac97 codec is not found when loading the driver
Description: 
When loading snd-tiixp-modem _after_ loading snd-atiixp, I get a message
saying
"atiixp-modem: no codec available" and modem doesn't function after that.

Little more investigation shown that snd_ac97_mixer thinks the codec is
already 
registered as sound codec by audio card driver.

I'v tried alsa-1.0.9, driver included in 2.6.13, 2.6.14-rc1 and drivers
from CVS HEAD - all with same result.


======================================================================

----------------------------------------------------------------------
 sashak - 09-25-05 15:49 
----------------------------------------------------------------------
Last patch works good with my ICH too.

----------------------------------------------------------------------
 sashak - 11-22-05 00:00 
----------------------------------------------------------------------
The fix is in released version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-19-05 08:49 iluxa          New Issue                                    
09-19-05 08:49 iluxa          Kernel Version            => 2.6.13, 2.6.14-rc1
09-19-05 13:27 sashak         Note Added: 0006292                          
09-19-05 19:32 iluxa          File Added: pci.txt                          
09-19-05 19:56 iluxa          File Added: comment.diff                     
09-19-05 19:57 iluxa          Note Added: 0006296                          
09-19-05 20:01 iluxa          File Added: atiixp.txt                       
09-19-05 20:01 iluxa          File Added: codec97_0_ac97_0-0.txt                
   
09-19-05 20:07 iluxa          Note Added: 0006298                          
09-19-05 23:30 sashak         File Deleted: comment.diff                    
09-19-05 23:38 sashak         Note Added: 0006304                          
09-19-05 23:41 iluxa          File Added: codec97_0_ac97_0-0+regs.txt           
        
09-19-05 23:44 iluxa          Note Added: 0006306                          
09-20-05 01:03 sashak         File Added: atiixp-debug.patch                    
09-20-05 01:06 sashak         Note Added: 0006307                          
09-20-05 01:15 iluxa          Note Added: 0006308                          
09-21-05 22:24 sashak         Note Added: 0006325                          
09-21-05 22:24 sashak         File Added: atiixp-codec-detection.patch          
         
09-21-05 22:38 sashak         Note Added: 0006326                          
09-21-05 23:03 iluxa          Note Added: 0006328                          
09-21-05 23:05 iluxa          Note Added: 0006329                          
09-21-05 23:37 sashak         File Added: atiixp-modem-unshared.patch           
        
09-21-05 23:40 sashak         Note Added: 0006330                          
09-21-05 23:57 iluxa          Note Added: 0006331                          
09-22-05 00:01 iluxa          File Added: card1_codec97_0_mc97_0-0              
     
09-22-05 00:02 iluxa          File Added: card1_codec97_0_mc97_0-0+regs         
          
09-22-05 00:02 iluxa          Note Added: 0006332                          
09-22-05 02:21 sashak         File Added: ac97-unshared.patch                   

09-22-05 02:39 sashak         Note Added: 0006333                          
09-22-05 06:44 iluxa          Note Added: 0006334                          
09-22-05 20:02 sashak         File Added: ac97-unshared-full.patch              
     
09-22-05 20:07 sashak         Note Added: 0006359                          
09-25-05 15:49 sashak         Note Added: 0006387                          
11-22-05 00:00 sashak         Status                   assigned => resolved
11-22-05 00:00 sashak         Resolution               open => fixed       
11-22-05 00:00 sashak         Note Added: 0006780                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
