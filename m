From: noreply@alsa-project.org
Subject: [ALSA - driver 0000250]: SPDIF not functional
Date: Fri, 16 Jul 2004 12:57:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105729.444B226008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7AD19244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:57:29 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000250
======================================================================
Reported By:                mergl
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     250
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               fedora core2
Kernel Version:             2.6.5-1.327
======================================================================
Date Submitted:             05-02-2004 08:45 CEST
Last Modified:              07-16-2004 12:57 CEST
======================================================================
Summary:                    SPDIF not functional
Description: 
configuration problem: in order to use the SPDIF output
the configuration file  /usr/share/alsa/cards/NFORCE.conf
has to be changed:

from
        slave.pcm {
                type hw
                card $CARD
                device 1
        }
                                                                          
     
into
                                                                          
     
                                                                          
             slave.pcm {
                type hw
                card $CARD
                device 2
        }
  

reason:  

[mergl@shuttle backup]$ cat /proc/asound/pcm
00-00: Intel ICH : NVidia nForce3 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : NVidia nForce3 - MIC ADC : capture 1
00-02: Intel ICH - IEC958 : NVidia nForce3 - IEC958 : playback 1

======================================================================

----------------------------------------------------------------------
 tiwai - 05-02-2004 11:52 CEST 
----------------------------------------------------------------------
already fixed in the newer version.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-02-04 08:45 mergl          New Bug                                      
05-02-04 08:45 mergl          Distribution              => fedora core2    
05-02-04 08:45 mergl          Kernel Version            => 2.6.5-1.327     
05-02-04 11:52 tiwai          Bugnote Added: 0001003                       
05-02-04 11:52 tiwai          Assigned To               => tiwai           
05-02-04 11:52 tiwai          Resolution               open => fixed       
05-02-04 11:52 tiwai          Status                   new => resolved     
07-16-04 12:57 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
