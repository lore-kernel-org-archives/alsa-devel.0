From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000384]: Crackly PCM output.
Date: Fri,  3 Sep 2004 03:40:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040903014014.7E4CE1D00B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C8F0C28B
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 03:40:14 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000384
======================================================================
Reported By:                bryanb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     384
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo dev sources
Kernel Version:             2.6
======================================================================
Date Submitted:             07-13-2004 19:28 CEST
Last Modified:              09-03-2004 03:40 CEST
======================================================================
Summary:                    Crackly PCM output.
Description: 
When playing a sound through the speakers on Toshiba Tecra 8100 the only
sound produced is noise.
======================================================================

----------------------------------------------------------------------
 codefathers - 07-29-2004 22:43 CEST 
----------------------------------------------------------------------
Same for Suse 9.1 / Kernel 2.6
After restart sound randomly works with crackles or not at all.
Tried every workaround found on the web, none works. Driver must be broken
for this particular notebook. Any news for this bug since it is known for
a long time?

----------------------------------------------------------------------
 Derek_Burdick - 09-03-2004 03:40 CEST 
----------------------------------------------------------------------
Kernel 2.6.8.1-ck4 (custom compiled)
Fedora Core 2

Possible workaround:
  Load OSS driver, ymfpci, unload it.
  Load alsa driver.

Alsa sound produced now works correctly.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 19:28 bryanb         New Bug                                      
07-13-04 19:28 bryanb         Distribution              => Gentoo dev sources
07-13-04 19:28 bryanb         Kernel Version            => 2.6             
07-29-04 22:43 codefathers    Bugnote Added: 0001485                       
07-29-04 22:45 codefathers    Bug Monitored: codefathers                    
09-03-04 03:37 Derek_Burdick  Bug Monitored: Derek_Burdick                    
09-03-04 03:40 Derek_Burdick  Bugnote Added: 0001684                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
