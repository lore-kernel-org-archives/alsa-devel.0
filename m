From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001719]: [PATCH] Fix the unability of snd-bt87x to recognize AVerMedia Studio No. 103, 203 (and perhaps others)
Date: Thu, 5 Jan 2006 19:34:07 +0100
Message-ID: <93b0dffd456a7d60fd4b1bc06e22a30c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1741B18B
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2006 19:34:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1719> 
======================================================================
Reported By:                drab
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1719
Category:                   PCI - bt87x
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-05-2006 17:53 CET
Last Modified:              01-05-2006 19:34 CET
======================================================================
Summary:                    [PATCH] Fix the unability of snd-bt87x to recognize
AVerMedia Studio No. 103, 203 (and perhaps others)
Description: 
The patch siply adds the PCI IDs of AVerMedia Studio No. 103, 203, and
possibly even other versions with the same PCI IDs to the snd-bt87x driver
and sets its default sampling rate to 48 kHz.

Signed-off-by: Martin Drab <drab@kepler.fjfi.cvut.cz>

diff -Napur linux-2.6.15.orig/sound/pci/bt87x.c
linux-2.6.15/sound/pci/bt87x.c
--- linux-2.6.15.orig/sound/pci/bt87x.c 2006-01-05 04:02:52.000000000
+0100
+++ linux-2.6.15/sound/pci/bt87x.c      2006-01-05 04:03:20.000000000
+0100
@@ -781,6 +781,8 @@ static struct pci_device_id snd_bt87x_id
        BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_879, 0x0070, 0x13eb, 32000),
        /* Viewcast Osprey 200 */
        BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x0070, 0xff01, 44100),
+       /* AVerMedia Studio No. 103, 203, ...? */
+       BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x1461, 0x0003, 48000),
        { }
 };
 MODULE_DEVICE_TABLE(pci, snd_bt87x_ids);

======================================================================

----------------------------------------------------------------------
 tiwai - 01-05-06 19:34 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-05-06 17:53 drab           New Issue                                    
01-05-06 19:34 tiwai          Status                   assigned => resolved
01-05-06 19:34 tiwai          Resolution               open => fixed       
01-05-06 19:34 tiwai          Note Added: 0007473                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
