From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000720]: Audigy 2 NX: Digital recording produces silent wave files
Date: Mon, 25 Apr 2005 10:59:36 +0200
Message-ID: <69f488680be514c5a2b313fdc5a445bb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2465B187
	for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2005 10:59:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=720> 
======================================================================
Reported By:                suamor
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   720
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Mandrake Linux 10.1
Kernel Version:             2.6.8.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-11-2004 09:02 CET
Last Modified:              04-25-2005 10:59 CEST
======================================================================
Summary:                    Audigy 2 NX: Digital recording produces silent wave
files
Description: 
Hi,

When I connect an digital device (like a DAT) to the audigy NX I can hear
the sound being played from the device. I can record using both arecord or
an OSS
compatible recording tool. Both tools produce wave files but they record
nothing but silence.

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 04-25-05 10:59 
----------------------------------------------------------------------
The latest driver (only in CVS for now) changes the names of the mixer
controls to something more sane.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-11-04 09:02 suamor         New Issue                                    
12-11-04 09:02 suamor         Distribution              => Mandrake Linux 10.1
12-11-04 09:02 suamor         Kernel Version            => 2.6.8.1         
04-25-05 10:59 Clemens LadischStatus                   assigned => resolved
04-25-05 10:59 Clemens LadischResolution               open => fixed       
04-25-05 10:59 Clemens LadischNote Added: 0004574                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
