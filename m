From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000817]: pcm32 wrapper missing pcm_forward 32bit compatibility IOCTL
Date: Fri, 14 Jan 2005 11:55:24 +0100
Message-ID: <81347a0f9a02a7792b0bba5b29530fc1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 27D65283
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2005 11:55:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=817> 
======================================================================
Reported By:                skormilo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   817
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 3
Kernel Version:             Kernel 2.6.10-1.737_FC3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-14-2005 01:45 CET
Last Modified:              01-14-2005 11:55 CET
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
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
