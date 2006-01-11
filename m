From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001732]: Support for Intel D945Pvs Board
Date: Wed, 11 Jan 2006 18:30:34 +0100
Message-ID: <e3da7284c4b571dac7de93d9ec02814f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B3C415A
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2006 18:30:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1732> 
======================================================================
Reported By:                timtt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1732
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               FC4
Kernel Version:             2.6.14-1656
======================================================================
Date Submitted:             01-11-2006 04:53 CET
Last Modified:              01-11-2006 18:30 CET
======================================================================
Summary:                    Support for Intel D945Pvs Board
Description: 
Alsa is only able to output regular 2-channel audio via the headphone jack
at the back of this motherboard. This motherboard has an SPDIF connection
available that is currently not supported, but should be.
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-11-06 05:04 
----------------------------------------------------------------------
Did you try the various "model" options for hda-intel which are documented
in ALSA-Configuration.txt?

----------------------------------------------------------------------
 timtt - 01-11-06 18:30 
----------------------------------------------------------------------
I have not. I just looked at it though and am unsure on how to do so. Could
you give me the correct syntax to enable the "5stack-digout" directive for
either /etc/modprobe.conf or for doing it on the shell loading and
unloading modules?

I'm sorry that I'm not so familiar with how modules work in the Linux
kernel. Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 04:53 timtt          New Issue                                    
01-11-06 04:53 timtt          Distribution              => FC4             
01-11-06 04:53 timtt          Kernel Version            => 2.6.14-1656     
01-11-06 05:04 rlrevell       Note Added: 0007558                          
01-11-06 18:30 timtt          Note Added: 0007563                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
