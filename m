From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000444]: Need a way to select analog I/O levels on Delta66/44
Date: Fri, 27 Aug 2004 22:17:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827201717.192302C008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6F20F20F
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 22:17:17 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000444
======================================================================
Reported By:                c0ff
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     444
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.8-rc4
======================================================================
Date Submitted:             08-15-2004 17:21 CEST
Last Modified:              08-27-2004 22:17 CEST
======================================================================
Summary:                    Need a way to select analog I/O levels on Delta66/44
Description: 
Delta66/44 cards support 3 analog level settings (+4dBu, Consumer, -10dBV).
One setting for all outputs, and per-input settings. We need a way to
change them :). Thank you.

======================================================================

----------------------------------------------------------------------
 edrz - 08-27-2004 22:17 CEST 
----------------------------------------------------------------------
I think this functionality is available in the ADC/DAC level section of
envy24control (2nd tab from the right). As I understand it the Window's
driver sets these levels at predefined points for the 3 input level
settings. The alsa driver gives you access to the whole range. Perhaps
markers could be placed on the bars in envy24control as reference points
for +4dBu, Consumer, -10dBV to make this more clear for users who actually
have read their soundcard's manual. :)

-Eric Rz.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-15-04 17:21 c0ff           New Bug                                      
08-15-04 17:21 c0ff           Distribution              => Gentoo          
08-15-04 17:21 c0ff           Kernel Version            => 2.6.8-rc4       
08-27-04 22:17 edrz           Bugnote Added: 0001658                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
