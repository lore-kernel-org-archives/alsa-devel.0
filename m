From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000759]: reloading opl4 driver isn't allowed - it segfaults
Date: Thu, 30 Dec 2004 00:05:56 +0100
Message-ID: <f53c51436de64d46c285d10d056ade0e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6403C127
	for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2004 00:05:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=759> 
======================================================================
Reported By:                martin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   759
Category:                   GENERIC - opl4
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-30-2004 00:05 CET
Last Modified:              12-30-2004 00:05 CET
======================================================================
Summary:                    reloading opl4 driver isn't allowed - it segfaults
Description: 
I'm writing a driver for the miroSOUND PCM12. But I have some trouble with
the OPL4 part and I'm afraid it's not related to my hardware/software. The
first modprobe works ok and OPL4 behaves correct. Then rmmod'ing the
driver and modprobe'ing it again shows a segfault.

The reason for the segfault is snd_opl4_create() which calls
snd_opl3_create() where snd_opl3_new() is the reason for the segfault. 

I don't see, that a correct unload of opl4 will ever run snd_device_free()
for the opl3 part? Any comments? Any OPL4 user out there for
cross-checking this with a working OPL4 environment? 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-30-04 00:05 martin         New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
