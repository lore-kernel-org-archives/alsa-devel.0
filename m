From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000504]: after the alsa modules are loaded, active speaker beginns to make noise
Date: Tue, 28 Sep 2004 16:07:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928140718.28E3939006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8787830A
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 16:07:18 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000504
======================================================================
Reported By:                placew
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     504
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo.2004
Kernel Version:             2.6.7-gentoo-r6
======================================================================
Date Submitted:             09-16-2004 12:36 CEST
Last Modified:              09-28-2004 16:07 CEST
======================================================================
Summary:                    after the alsa modules are loaded, active speaker beginns to make noise
Description: 
i've got my alsa modules compiled in a kernel, v.2.6.7-gentoo-r6. At boot,
once, there are the alsa modules loaded, active speaker starts hissing.
When mp3 (or other sound) is playing, the noise is getting low, almoust
unhearable. Active speaker stops hissing once the modules are unloaded
during the reboot.  My soundcard is ensoniq PCI128, using module ens1371.
Thanks for cooperation.
======================================================================

----------------------------------------------------------------------
 djtm - 09-28-2004 16:07 CEST 
----------------------------------------------------------------------
Check if removing the inputs helps. TV-Cards and other often issue a low
hiss when connected to the line in. Muting the channel might also help.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-16-04 12:36 placew         New Bug                                      
09-16-04 12:36 placew         Distribution              => Gentoo.2004     
09-16-04 12:36 placew         Kernel Version            => 2.6.7-gentoo-r6 
09-17-04 10:42 placew         Bug Monitored: placew                        
09-17-04 10:42 placew         Bug End Monitor: placew                      
09-28-04 16:07 djtm           Bugnote Added: 0001948                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
