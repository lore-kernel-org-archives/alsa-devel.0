From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001663]: LW20 bugs with headphone input, realtek.com.tw has a fix, please intergrate it!
Date: Tue, 20 Dec 2005 19:11:51 +0100
Message-ID: <f9c132ba213177659c1e96331eaba76e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6DE981B2
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 19:11:51 +0100 (MET)
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
Last Modified:              12-20-2005 19:11 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 19:11 mikael         New Issue                                    
12-20-05 19:11 mikael         Distribution              => Archlinux       
12-20-05 19:11 mikael         Kernel Version            => 2.4.13.4        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
