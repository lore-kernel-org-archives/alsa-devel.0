From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000378]: Audigy LS - Video playback stutters the first 5 seconds
Date: Fri, 27 Aug 2004 20:08:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827180834.EC2DB2C008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 44E9718F
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 20:08:46 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000378
======================================================================
Reported By:                Luke
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     378
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-12-2004 10:41 CEST
Last Modified:              08-27-2004 20:08 CEST
======================================================================
Summary:                    Audigy LS - Video playback stutters the first 5 seconds
Description: 
When playing a video (doesn't matter what kind) with mplayer, the whole
playback stutters approximately the first 5 seconds when the alsa modules
are loaded. No difference when compiling mplayer w or w/o oss/alsa
support.
======================================================================

----------------------------------------------------------------------
 jcdutton - 08-27-2004 20:08 CEST 
----------------------------------------------------------------------
Can you please verify which version of the audigyls.c file you have, by
doing:
 grep Version ./alsa-driver/pci/emu10k1/audigyls.c

It should say:
 *  Version: 0.0.14

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-12-04 10:41 Luke           New Bug                                      
07-12-04 10:41 Luke           Distribution              => Gentoo          
07-12-04 10:41 Luke           Kernel Version            => 2.6.7           
08-27-04 20:08 jcdutton       Bugnote Added: 0001649                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
