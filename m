From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000450]: Line In only gives left channel - no stereo recording/listening
Date: Wed, 18 Aug 2004 02:17:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040818001702.8AC171102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E8FE6208
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 02:17:02 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 9BE2D18B91
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 02:17:02 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000450
======================================================================
Reported By:                ZaphodB
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     450
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian unstable/testing/experimental
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             08-18-2004 02:04 CEST
Last Modified:              08-18-2004 02:17 CEST
======================================================================
Summary:                    Line In only gives left channel - no stereo recording/listening
Description: 
Whatever stunts i do with alsamixer, selecting Line IN as capture source
leaves me with one channel (left) on output hw/0 - hw/1 does neither
contains the right channel nor does setting the hw/1 output to hw/0
provide me with a stereo signal. Same with recording from Line, audacity
shows good input signal (waveform pattern) for the left channel but
absolutely nothing for right.
======================================================================

----------------------------------------------------------------------
 ZaphodB - 08-18-2004 02:08 CEST 
----------------------------------------------------------------------
forgot: stereo-recording from Line In with audacity works with WindowsXP
;-)

----------------------------------------------------------------------
 ZaphodB - 08-18-2004 02:17 CEST 
----------------------------------------------------------------------
sorry, overlooked BugID 0000382 reporting basically same bug.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 02:04 ZaphodB        New Bug                                      
08-18-04 02:04 ZaphodB        Distribution              => Debian unstable/testing/experimental
08-18-04 02:04 ZaphodB        Kernel Version            => 2.6.8.1         
08-18-04 02:08 ZaphodB        Bugnote Added: 0001573                       
08-18-04 02:17 ZaphodB        Bugnote Added: 0001574                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
