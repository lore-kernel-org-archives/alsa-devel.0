From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001663]: LW20 bugs with headphone input, realtek.com.tw has a fix, please intergrate it!
Date: Mon, 16 Jan 2006 19:24:06 +0100
Message-ID: <aab3bdf0e2908b7cdf862d58cce2e392@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 339EC153
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2006 19:24:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1663> 
======================================================================
Reported By:                mikael
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1663
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Archlinux
Kernel Version:             2.4.13.4
======================================================================
Date Submitted:             12-20-2005 19:11 CET
Last Modified:              01-16-2006 19:24 CET
======================================================================
Summary:                    LW20 bugs with headphone input, realtek.com.tw has a
fix, please intergrate it!
Description: 
My new laptop has a HDA Intel (Realtek ALC880) soundcard. 

It though for some reason do not turn off the main speaker when you insert
headphones. On the site
http://www.realtek.com.tw/downloads/dlhd-2.aspx?lineid=2004052&famid=2004052&series=2004061&Software=True
there is a patched alsa package available which fixes this issue by adding
a "Headphone" mixer which you can turn on/off and also gives you the
availability to mute the main speakers without (as in 1.0.10/11-rc1)
muting the headphones aswell.

Can you please intergrate this? I struggled trying to intergrate this
properly but their alsa is built on 1.0.9 and I suppose I am not the
sharpest of programers either for the job.

Greets,
  Mikael
======================================================================

----------------------------------------------------------------------
 mikael - 01-16-06 16:22 
----------------------------------------------------------------------
I realize this is a low prio matter but an update/status notification or
anything would be very appreciated after one months time.

----------------------------------------------------------------------
 rlrevell - 01-16-06 19:24 
----------------------------------------------------------------------
All of the Realtek code should have been merged into the latest ALSA
drivers, is it still broken with 1.0.11-rc2?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 19:11 mikael         New Issue                                    
12-20-05 19:11 mikael         Distribution              => Archlinux       
12-20-05 19:11 mikael         Kernel Version            => 2.4.13.4        
01-16-06 16:22 mikael         Note Added: 0007688                          
01-16-06 19:24 rlrevell       Note Added: 0007691                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
