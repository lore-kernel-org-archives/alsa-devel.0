From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000609]: No Mixer control for Ouput on CMI9880
Date: Wed, 27 Oct 2004 02:36:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <648479eb6e3f9e4568fcdc1d604be2a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 559C92F5
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2004 02:36:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=609> 
======================================================================
Reported By:                Grazy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   609
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8
======================================================================
Date Submitted:             10-27-2004 00:10 CEST
Last Modified:              10-27-2004 02:36 CEST
======================================================================
Summary:                    No Mixer control for Ouput on CMI9880
Description: 
The CMI9880 chip on my MotherBoard is detect by the snd-azx module.
But there is only one mixer control for "Capture" and two mute switch for
"Line" and "Mic". But nothing to control the output volume.
======================================================================

----------------------------------------------------------------------
 cltien - 10-27-04 02:36 
----------------------------------------------------------------------
The CM9880 has no PCM volume control widget.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-27-04 00:10 Grazy          New Issue                                    
10-27-04 00:10 Grazy          Distribution              => Debian          
10-27-04 00:10 Grazy          Kernel Version            => 2.6.8           
10-27-04 02:36 cltien         Note Added: 0002270                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
