From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000817]: pcm32 wrapper missing pcm_forward 32bit compatibility IOCTL
Date: Mon, 14 Feb 2005 19:39:41 +0100
Message-ID: <93bf607b0447032f6725ec08e24a3a61@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 01C35249
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:39:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=817> 
======================================================================
Reported By:                skormilo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   817
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3
Kernel Version:             Kernel 2.6.10-1.737_FC3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-14-2005 01:45 CET
Last Modified:              02-14-2005 19:39 CET
======================================================================
Summary:                    pcm32 wrapper missing pcm_forward 32bit
compatibility IOCTL
Description: 
The pcm_forward IOCTL is not implemented in the pcm32.c 32bit compatibility
mode ioctl. Produces the following output in /var/log/messages:

ioctl32(wine:7260): Unknown cmd fd(79) cmd(40044149){00} arg(5b0a21a4) on
/dev/snd/pcmC0D0p


======================================================================

----------------------------------------------------------------------
 tiwai - 01-14-05 11:55 
----------------------------------------------------------------------
Thanks fixed on cvs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-14-05 01:45 skormilo       New Issue                                    
01-14-05 01:45 skormilo       File Added: alsa_pcm32_forward.patch              
     
01-14-05 01:45 skormilo       Distribution              => Fedora Core 3   
01-14-05 01:45 skormilo       Kernel Version            => Kernel
2.6.10-1.737_FC3
01-14-05 11:55 tiwai          Status                   new => resolved     
01-14-05 11:55 tiwai          Resolution               open => fixed       
01-14-05 11:55 tiwai          Assigned To               => tiwai           
01-14-05 11:55 tiwai          Note Added: 0003207                          
01-14-05 11:55 tiwai          Assigned To              tiwai =>            
02-14-05 19:39 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
