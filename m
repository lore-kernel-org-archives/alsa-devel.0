From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000062]: No volume control - cmi9739 AC97 codec
Date: Tue, 22 Feb 2005 09:47:19 +0100
Message-ID: <1234de7ba61a7e8dd806c24b5f57fa7a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 54696174
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 09:47:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=62> 
======================================================================
Reported By:                LP
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   62
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               gentoo
Kernel Version:             2.6.0
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-15-2004 02:21 CET
Last Modified:              02-22-2005 09:47 CET
======================================================================
Summary:                    No volume control - cmi9739 AC97 codec
Description: 
Using motherboard asrock k7s8xe+(sis748 chipset) which features sis7012,
cmi9739 AC97 codec it is not possible to control volume. Is there any
chance, that this can be implemented in future alsa versions, I heard, the
problem is, that this hardware doesn't have a hardware PCM-Out volume
control.

P.S. There is an OSS driver available:
http://www.cmedia.com.tw/download/e_UDA9738_linux.htm
which maybe helpful.
======================================================================

----------------------------------------------------------------------
 LP - 03-02-04 00:05 
----------------------------------------------------------------------
Cool thanks.

----------------------------------------------------------------------
 perex - 02-22-05 09:47 
----------------------------------------------------------------------
The softvol plugin in alsa-lib fixes this issue. It is default now (in
CVS).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-15-04 02:21 LP             New Issue                                    
02-26-04 12:08 perex          Status                   new => assigned     
02-26-04 12:08 perex          Assigned To               => perex           
02-26-04 12:08 perex          Note Added: 0000341                          
02-29-04 20:19 perex          Summary                  No volume control => No
volume control - cmi9739 AC97 codec
03-02-04 00:05 LP             Note Added: 0000428                          
03-20-04 11:37 erol           Issue Monitored: erol                        
11-22-04 20:58 ajir           Issue Monitored: ajir                        
02-22-05 09:47 perex          Status                   assigned => resolved
02-22-05 09:47 perex          Resolution               open => fixed       
02-22-05 09:47 perex          Note Added: 0003693                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
