From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000819]: Patch to make Dummy driver a loopback device
Date: Sat, 15 Jan 2005 02:26:40 +0100
Message-ID: <e9a643650d30899ad3303af9a2c712d1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 540F9296
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2005 02:26:40 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=819> 
======================================================================
Reported By:                tschneider
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   819
Category:                   GENERIC - dummy
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-15-2005 02:26 CET
Last Modified:              01-15-2005 02:26 CET
======================================================================
Summary:                    Patch to make Dummy driver a loopback device
Description: 
This patch updates the Dummy ALSA device to be a loopback device.  (i.e.
the sound played to the device is available on the capture output)  This
patch is against the dummy driver in the 2.6.10 linux kernel.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-05 02:26 tschneider     New Issue                                    
01-15-05 02:26 tschneider     File Added: loopback-alsa-dummy.v7.patch          
         
01-15-05 02:26 tschneider     Kernel Version            => 2.6.10          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
