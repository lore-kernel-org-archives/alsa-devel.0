From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000864]: No Support for C-Media CMI9880
Date: Mon, 31 Jan 2005 18:51:12 +0100
Message-ID: <3030e512c5ee2831fcf1ff7e92f5efc4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BC4CA21C
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 18:51:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=864> 
======================================================================
Reported By:                neverread
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   864
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             01-31-2005 01:57 CET
Last Modified:              01-31-2005 18:51 CET
======================================================================
Summary:                    No Support for C-Media CMI9880
Description: 
A number of the new ASUS motherboards have HD sound using the C-Media
cmi9880 chip.  I've looked through the list of supported devices and the
CMI9880 is not listed.  I expect support for the chipset to become more
common.

During the install (Through YaST) no sound device is detected at all. 
When trying to use sensible alternates (ie cmipci module by selecting
cmi87x support) the install fails.

It would be great if we could add support.

======================================================================

----------------------------------------------------------------------
 1g0R - 01-31-05 09:30 
----------------------------------------------------------------------
Hi,

Try with azx card support.
./configure --with-card=azx

Chher,
1gR

----------------------------------------------------------------------
 tiwai - 01-31-05 18:51 
----------------------------------------------------------------------
The corresponding driver for your device is snd-azx (in ALSA 1.0.8), not
cmipci driver.
YaST can't detect the newly added drivers.  Use alsaconf instead.

Note that in the CVS version, snd-azx is renamed to snd-hda-intel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 01:57 neverread      New Issue                                    
01-31-05 09:30 1g0R           Note Added: 0003447                          
01-31-05 18:51 tiwai          Status                   assigned => resolved
01-31-05 18:51 tiwai          Resolution               open => not an issue
01-31-05 18:51 tiwai          Note Added: 0003449                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
