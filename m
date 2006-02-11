From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001840]: vortex: IRQ fifo error - au8830
Date: Sat, 11 Feb 2006 10:24:39 +0100
Message-ID: <2a4f81e44b607b5a2f0f1ba312db581a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DCB318C
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2006 10:24:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1840> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1840
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-11-2006 09:29 CET
Last Modified:              02-11-2006 10:24 CET
======================================================================
Summary:                    vortex: IRQ fifo error - au8830
Description: 
The message "vortex: IRQ fifo error" was logged in system log after au88x0
migrated from alsa-driver to alsa-kernel on au8830.

Does au8810 and au8820 has this error ?


======================================================================

----------------------------------------------------------------------
 mjander - 02-11-06 10:24 
----------------------------------------------------------------------
This is not a bug. Its a bit that gets set in the IRQ handler once, the
first time PCM audio is transferred via DMA, and is not a problem.
It happens always. If anybody knows what that bit signifies, would be
great to hear from you; most probably only some former Aureal Engineer
maybe remember that, and won't tell anyone about due to "shutup
agreements".

Best Regards,

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-06 09:29 Raymond        New Issue                                    
02-11-06 10:24 mjander        Note Added: 0008012                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
