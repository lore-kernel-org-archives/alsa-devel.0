From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001755]: nforce4 - missing rear right channel
Date: Mon, 16 Jan 2006 16:59:35 +0100
Message-ID: <22b3906ed60e1433c7d8e095acec21bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A7B24154
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2006 16:59:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1755> 
======================================================================
Reported By:                fearofcarpet
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1755
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-16-2006 16:59 CET
Last Modified:              01-16-2006 16:59 CET
======================================================================
Summary:                    nforce4 - missing rear right channel
Description: 
On an ASUS A8N-SLI Deluxe w/integrated RealTek ALC850 (nforce4) sound the
rear right channel is missing when using analog outputs. In alsamixer all
the channels respond correctly (e.g. if I mute 'center' the center speaker
mutes), but the rear channel is only outputting to the rear left speaker.
It is not downmixing the rear channels either; the rear right is simply
missing. Using the ASUS drivers in Windows the rear channels work
correctly.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-16-06 16:59 fearofcarpet   New Issue                                    
01-16-06 16:59 fearofcarpet   Distribution              => Gentoo          
01-16-06 16:59 fearofcarpet   Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
