From: noreply@alsa-project.org
Subject: [ALSA - driver 0000195]: alsa-driver uses SNDRV_DMA_TYPE_PCI where it should use SNDRV_DMA_TYPE_DEV (with patch to fix)
Date: Fri, 16 Jul 2004 12:54:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105426.D3E5826008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2D8DC22B
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:54:27 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000195
======================================================================
Reported By:                eradicator
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     195
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-08-2004 19:12 CEST
Last Modified:              07-16-2004 12:54 CEST
======================================================================
Summary:                    alsa-driver uses SNDRV_DMA_TYPE_PCI where it should use SNDRV_DMA_TYPE_DEV (with patch to fix)
Description: 
SNDRV_DMA_TYPE_PCI in a number of files should be SNDRV_DMA_TYPE_DEV. 
SNDRV_DMA_TYPE_PCI is not declared in any kernel header file I've seen...
maybe it was deprecated for a while... but SNDRV_DMA_TYPE_DEV is the
correct way
======================================================================

----------------------------------------------------------------------
 tiwai - 04-13-2004 19:38 CEST 
----------------------------------------------------------------------
fixed on CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-08-04 19:12 eradicator     New Bug                                      
04-08-04 19:12 eradicator     File Added: alsa-driver-1.0.4.devfix.patch                    
04-13-04 19:38 tiwai          Bugnote Added: 0000793                       
04-13-04 19:38 tiwai          Assigned To              perex => tiwai      
04-13-04 19:38 tiwai          Resolution               open => fixed       
04-13-04 19:38 tiwai          Status                   assigned => resolved
07-16-04 12:54 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
