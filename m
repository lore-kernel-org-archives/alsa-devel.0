From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Fri, 2 Sep 2005 05:49:06 +0200
Message-ID: <30bcfad98b6ef8abd985b1091ec7b069@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9B2F313E
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 05:49:06 +0200 (MEST)
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
Last Modified:              09-02-2005 05:49 CEST
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
 penguinparty - 09-02-05 02:49 
----------------------------------------------------------------------
the patch diff11.diff did the trick.

I can finally hear again!!! :)

Thanks

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
