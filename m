From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000578]:  No soundcard detected on Chaintech 9CJS
Date: Mon, 11 Oct 2004 15:59:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041011135935.3D2AB1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8A22C27D
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2004 15:59:35 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000578
======================================================================
Reported By:                tarsi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     578
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               mandrake linux 10.1
Kernel Version:             2.6.8.1-10mdksmp
======================================================================
Date Submitted:             10-11-2004 12:58 CEST
Last Modified:              10-11-2004 15:59 CEST
======================================================================
Summary:                     No soundcard detected on Chaintech 9CJS
Description: 
 cat /proc/asound/cards don't stop and gives many lines "--no souncards--"

/etc/init.d/alsaconf found ice1724 card, but exiting gives:
.... 

/usr/sbin/alsactl: save_state:1066: No soundcards found...

======================================================================

----------------------------------------------------------------------
 tiwai - 10-11-2004 15:59 CEST 
----------------------------------------------------------------------
Try model=k8x800 module option.  This will force the model type.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-11-04 12:58 tarsi          New Bug                                      
10-11-04 12:58 tarsi          File Added: command-outputs.tar.bz2                    
10-11-04 12:58 tarsi          Distribution              => mandrake linux 10.1
10-11-04 12:58 tarsi          Kernel Version            => 2.6.8.1-10mdksmp
10-11-04 12:58 tarsi          Bug Monitored: tarsi                         
10-11-04 15:59 tiwai          Bugnote Added: 0002081                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
