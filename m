From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000974]: AC'97 Modem Controller not known
Date: Tue, 8 Mar 2005 16:02:32 +0100
Message-ID: <138a667b932da07914c00900bfa552ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5D98B14D
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2005 16:02:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=974> 
======================================================================
Reported By:                bidoubidou
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   974
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               MandrakeLinux cooker
Kernel Version:             2.6.11-mm1
======================================================================
Date Submitted:             03-08-2005 16:02 CET
Last Modified:              03-08-2005 16:02 CET
======================================================================
Summary:                    AC'97 Modem Controller not known
Description: 
On my new laptop (Aspire 1691WLI),I have a 
Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem
Controller (rev 04)
If I modprobe snd-intel8xOm, it doesn't happen anything. If I edit
./sound/pci/intel8x0m.c
@@ -269,6 +270,7 @@
        { 0x8086, 0x24c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL }, /*
ICH4 */
        { 0x8086, 0x24d6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL }, /*
ICH5 */
+       { 0x8086, 0x266d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL }, /*
ICH6 */
        { 0x8086, 0x7196, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL }, /*
440MX */

I obtain the message.

Mar  8 15:23:40 pitouef kernel: ACPI: PCI interrupt 0000:00:1e.3[B] -> GSI
10 (level, low) -> IRQ 10
Mar  8 15:23:41 pitouef kernel: Unable to initialize codec
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
Mar  8 15:23:41 pitouef kernel: Intel ICH Modem: probe of 0000:00:1e.3
failed with error -13

  The sound card part worked. It is possible to use the modem part ?


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 16:02 bidoubidou     New Issue                                    
03-08-05 16:02 bidoubidou     Distribution              => MandrakeLinux cooker
03-08-05 16:02 bidoubidou     Kernel Version            => 2.6.11-mm1      
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
