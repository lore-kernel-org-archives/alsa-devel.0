From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002294]: Mvox speakerphone fails to
	attach
Date: Wed, 19 Jul 2006 06:46:31 +0200
Message-ID: <c15587ed0e34817dcd83bbf0908233ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EB164242
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 06:46:31 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2294> 
======================================================================
Reported By:                malexmedia
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2294
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-19-2006 06:46 CEST
Last Modified:              07-19-2006 06:46 CEST
======================================================================
Summary:                    Mvox speakerphone fails to attach
Description: 
The Mvox MV100 USB speakerphone generates an error when plugged in, even
though it is advertised as a usb-audio device and works without a driver
on most recent generations of Windows, Mac OS, etc..

The dmesg transcript is as follows:

usb 2-8: new full speed USB device using ohci_hcd and address 3
invalid SELECTOR UNIT descriptor 7
snd-usb-audio: probe of 2-8:1.0 failed with error -5
usb 2-8: USB disconnect, address 3

Is there any chance that we can figure out what this device is doing that
is weird so it can be made to work?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-06 06:46 malexmedia     New Issue                                    
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
