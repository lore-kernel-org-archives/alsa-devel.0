From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001226]: Ego Sys NEON
Date: Mon, 25 Jul 2005 11:05:39 +0200
Message-ID: <4446dfd41dbf062697e97ec0fc651e07@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BED5F102
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2005 11:05:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1226> 
======================================================================
Reported By:                nictuku
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1226
Category:                   USB - usb-audio
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware Current
Kernel Version:             2.4
======================================================================
Date Submitted:             07-01-2005 21:21 CEST
Last Modified:              07-25-2005 11:05 CEST
======================================================================
Summary:                    Ego Sys NEON
Description: 
hi, i have a ESI NeON (
http://www.esi-pro.com/viewProduct.php?pid=42&page=1 ) i've tryed to make
it work with alsa with no success, but strangely on the oss the 24-bit
audio interface works. I just send this bug report to know if there's a
way to make it work or if it's planned to put support on this hardware. if
you need to test it feel free to contactme (nictuku@gmail.com)
thanx
======================================================================

----------------------------------------------------------------------
 nictuku - 07-23-05 00:32 
----------------------------------------------------------------------
hi, i recieved no notice.. i put the lsusb output, may i ask you what's
going to be done or something?

----------------------------------------------------------------------
 Clemens Ladisch - 07-25-05 11:05 
----------------------------------------------------------------------
This device should work with the ALSA driver.

Please make sure that the snd-usb-audio module is loaded, and that the
audio module is _not_ loaded.  All supported sample format should be
listed in /proc/asound/cardX/stream0.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 21:21 nictuku        New Issue                                    
07-01-05 21:21 nictuku        Distribution              => Slackware Current
07-01-05 21:21 nictuku        Kernel Version            => 2.4             
07-04-05 09:23 Clemens LadischNote Added: 0005382                          
07-06-05 23:04 nictuku        Issue Monitored: nictuku                     
07-06-05 23:06 nictuku        Note Added: 0005395                          
07-06-05 23:09 nictuku        Issue End Monitor: nictuku                    
07-23-05 00:32 nictuku        Note Added: 0005551                          
07-25-05 11:05 Clemens LadischNote Added: 0005562                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
