From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001719]: [PATCH] Fix the unability of snd-bt87x to recognize AVerMedia Studio No. 103, 203 (and perhaps others)
Date: Thu, 5 Jan 2006 17:53:50 +0100
Message-ID: <dd0bdc538292cfa1c8e80f00b0806bfc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17C44176
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2006 17:53:51 +0100 (MET)
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
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-05-2006 17:53 CET
Last Modified:              01-05-2006 17:53 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-05-06 17:53 drab           New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
