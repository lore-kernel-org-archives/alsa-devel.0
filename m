From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000791]: snd-ioctl32 is failing on x86_64 (no crashes, just errors)
Date: Fri, 7 Jan 2005 02:28:24 +0100
Message-ID: <1e0d3d917fe209dd5b948954c75308b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C4D2A2E9
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 02:28:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=791> 
======================================================================
Reported By:                chutzimir
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   791
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-07-2005 02:28 CET
Last Modified:              01-07-2005 02:28 CET
======================================================================
Summary:                    snd-ioctl32 is failing on x86_64 (no crashes, just
errors)
Description: 
Running a 32-bit version of any application on my 64-bit 2.6.10 kernel
fails with:

$ amixer -c 0
amixer: Mixer hw:0 load error: Invalid argument

for example. I have snd-ioctl32 loaded properly (lsmod shows it).

Kernel is vanilla 2.6.10 and I just tried it with version 1.0.8rc2 of
alsa-driver. Also, alsa-lib and alsa-utils version 1.0.8rc2 are
installed in my 64-bit environment, and also in the 32-bit chroot env
where I am trying to run amixer from. The distro is Gentoo, and I also
have their alsa-headers-1.0.8_rc2 installed in the 32-bit chroot.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-05 02:28 chutzimir      New Issue                                    
01-07-05 02:28 chutzimir      Distribution              => Gentoo          
01-07-05 02:28 chutzimir      Kernel Version            => 2.6.10          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
