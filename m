From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000903]: Patch for acpi resume.
Date: Mon, 14 Feb 2005 07:27:34 +0100
Message-ID: <4d1394a5c69317cdb34e22cc13957db3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9BE7A1F7
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 07:27:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=903> 
======================================================================
Reported By:                ryo-dairiki
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   903
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-12-2005 04:48 CET
Last Modified:              02-14-2005 07:27 CET
======================================================================
Summary:                    Patch for acpi resume.
Description: 
When you use acpi suspend-to-ram (=S3 sleep), you have to kill applications
playing sounds and unload snd_intel8x0 module.
(You can't unload the module when you are using sound servers)
Otherwise, the applications will freeze when you resume the machine.
I found that this problem is caused by "snd_pcm_suspend_all" call in
"intel8x0_suspend" method described in "intel8x0.c".
It suspend pcm streams and won't resume them, then causes the applications
to freeze.
So I made a patch to make it resume pcm streams on resume.

This works fine for me.
I mean I can suspend and resume even if some applications are playing
sounds without unloading the modules or killing them.
======================================================================

----------------------------------------------------------------------
 ryo-dairiki - 02-14-05 07:27 
----------------------------------------------------------------------
I've found that freezing will still occure with this patch, if you use dmix
or dsnoop plugin.
(No idea to fix it, unfornately)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-12-05 04:48 ryo-dairiki    New Issue                                    
02-12-05 04:48 ryo-dairiki    File Added: alsa-resume-all.patch                 
  
02-12-05 04:48 ryo-dairiki    Distribution              => Fedora Core 3   
02-12-05 04:48 ryo-dairiki    Kernel Version            => 2.6.10          
02-13-05 04:44 ryo-dairiki    Note Added: 0003579                          
02-13-05 08:36 ryo-dairiki    Note Deleted: 0003579                        
02-14-05 07:27 ryo-dairiki    Note Added: 0003586                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
