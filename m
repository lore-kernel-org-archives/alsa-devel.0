From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001649]: No surround sound on ICH5 (AC'97 AD1980)
Date: Wed, 14 Dec 2005 02:37:51 +0100
Message-ID: <14d4fdda52c52a2a759f3dc1d84fd3a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CB93A196
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 02:37:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1649> 
======================================================================
Reported By:                znerd
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1649
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.14
======================================================================
Date Submitted:             12-14-2005 02:37 CET
Last Modified:              12-14-2005 02:37 CET
======================================================================
Summary:                    No surround sound on ICH5 (AC'97 AD1980)
Description: 
I cannot get my AC'97 device (AD1980) to produce any sound other than
stereo output. I have tried various settings on alsamixer and I used
various speaker-test forms to validate settings. When I use:

   speaker-test -Dplug:surround40 -c4

then I hear just Front-Left and Front-Right. There is total silence on the
rear channels. I plugged the rear speakers plug into the 2nd sound output
jack.

Some hints would be appreciated. I have been searching around the internet
and have found other issues regarding the AD1980, but not this one. I do
realize it may be my setup that's wrong, but the chance is getting quite
small by now.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-14-05 02:37 znerd          New Issue                                    
12-14-05 02:37 znerd          Distribution              => Gentoo Linux    
12-14-05 02:37 znerd          Kernel Version            => 2.6.14          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
