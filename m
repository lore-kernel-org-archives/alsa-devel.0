From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000771]: snd-pcm-oss makes /dev/sound device, not directory, if loaded before sound card drivers
Date: Fri, 31 Dec 2004 18:57:12 +0100
Message-ID: <307c0f1307e0b34dcd00b900698a75bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C30D632C
	for <alsa-devel@alsa-project.org>; Fri, 31 Dec 2004 18:57:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=771> 
======================================================================
Reported By:                roothorick
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   771
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux 2004.0
Kernel Version:             2.6.10-gentoo-r1
======================================================================
Date Submitted:             12-31-2004 18:57 CET
Last Modified:              12-31-2004 18:57 CET
======================================================================
Summary:                    snd-pcm-oss makes /dev/sound device, not directory,
if loaded before sound card drivers
Description: 
If snd-pcm-oss is loaded before the soundcard drivers are loaded,
/dev/sound is created as a character special with major 116 and minor 33.
When the soundcard drivers are later loaded, /dev/sound remains a device,
which means there's nowhere for the OSS compatibility devices to go.

This system uses udev.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 18:57 roothorick     New Issue                                    
12-31-04 18:57 roothorick     Distribution              => Gentoo Linux 2004.0
12-31-04 18:57 roothorick     Kernel Version            => 2.6.10-gentoo-r1
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
