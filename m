From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001530]: Fix for ali5451 driver taking 10 seconds to load
Date: Mon, 13 Feb 2006 22:08:36 +0100
Message-ID: <377b8c3af44e98bc217b6ed5a4d764a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4FAAF1AC
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 22:08:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1530> 
======================================================================
Reported By:                Vince
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1530
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Ubuntu 5.10 & Fedora Core 4
Kernel Version:             2.6.12-9-k7 & 2.6.13-1.1526_FC4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-05-2005 20:29 CET
Last Modified:              02-13-2006 22:08 CET
======================================================================
Summary:                    Fix for ali5451 driver taking 10 seconds to load
Description: 
On bootup on my laptop, the ali5451 driver takes 10 seconds to load, which
is quite annoying.  Changing the wait time in snd_ali_codec_ready improves
this dramatically.
======================================================================

----------------------------------------------------------------------
 Vince - 02-13-06 21:37 
----------------------------------------------------------------------
Actually, a better version of this patch is already in the latest kernel,
so this should be closed.

----------------------------------------------------------------------
 rlrevell - 02-13-06 22:08 
----------------------------------------------------------------------
Thanks for the feedback.

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
02-13-06 21:37 Vince          Note Added: 0008063                          
02-13-06 22:08 rlrevell       Status                   new => resolved     
02-13-06 22:08 rlrevell       Resolution               open => fixed       
02-13-06 22:08 rlrevell       Assigned To               => rlrevell        
02-13-06 22:08 rlrevell       Note Added: 0008064                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
