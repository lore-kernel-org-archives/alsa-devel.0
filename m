From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000760]: alsa 32-bit emulation hangs computer
Date: Thu, 30 Dec 2004 07:28:43 +0100
Message-ID: <13319061e6650d473c96f69ecb508b26@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5FD6F2A0
	for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2004 07:28:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=760> 
======================================================================
Reported By:                bugfood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   760
Category:                   OTHERS
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Debian 64-bit, &quot;gcc-3.4 flavor&quot;
Kernel Version:             2.6.10, 64-bit
======================================================================
Date Submitted:             12-30-2004 07:28 CET
Last Modified:              12-30-2004 07:28 CET
======================================================================
Summary:                    alsa 32-bit emulation hangs computer
Description: 
I'm working on setting up the 64-bit port of Debian on my computer. So far
so good, except that running 32-bit alsa programs within a chroot causes
the computer to hang and become almost completely unresponsive; all I can
do is use magic SysRq to reboot. There are no messages from the kernel in
/var/log/messages or reported to the console.

64-bit alsa programs work fine
64-bit oss programs work fine
32-bit oss programs work fine

I've tested with an SB Live and with my motherboard's onboard i810 audio -
both have the same problem.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-30-04 07:28 bugfood        New Issue                                    
12-30-04 07:28 bugfood        File Added: config-2.6.10                    
12-30-04 07:28 bugfood        Distribution              => Debian 64-bit,
"gcc-3.4 flavor"
12-30-04 07:28 bugfood        Kernel Version            => 2.6.10, 64-bit  
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
