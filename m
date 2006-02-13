From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001530]: Fix for ali5451 driver taking 10 seconds to load
Date: Mon, 13 Feb 2006 19:56:26 +0100
Message-ID: <37ee844acb229d00db0a4903deaee7cd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D2C77196
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 19:56:26 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1530> 
======================================================================
Reported By:                Vince
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1530
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 & Fedora Core 4
Kernel Version:             2.6.12-9-k7 & 2.6.13-1.1526_FC4
======================================================================
Date Submitted:             11-05-2005 20:29 CET
Last Modified:              02-13-2006 19:56 CET
======================================================================
Summary:                    Fix for ali5451 driver taking 10 seconds to load
Description: 
On bootup on my laptop, the ali5451 driver takes 10 seconds to load, which
is quite annoying.  Changing the wait time in snd_ali_codec_ready improves
this dramatically.
======================================================================

----------------------------------------------------------------------
 avuton - 02-13-06 19:56 
----------------------------------------------------------------------
Does this problem still exist? I've never had this problem and have to
wonder the downside to this patch.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-05-05 20:29 Vince          New Issue                                    
11-05-05 20:29 Vince          File Added: ali5451-init.patch                    
11-05-05 20:29 Vince          Distribution              => Ubuntu 5.10 & Fedora
Core 4
11-05-05 20:29 Vince          Kernel Version            => 2.6.12-9-k7 &
2.6.13-1.1526_FC4
02-13-06 19:56 avuton         Note Added: 0008062                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
