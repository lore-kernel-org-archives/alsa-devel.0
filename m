From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002215]: Agere softmodem attached to
	Intel HDA does not work
Date: Sat, 17 Jun 2006 07:45:50 +0200
Message-ID: <8d22620c247001799ac6300c926745ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24C39183
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jun 2006 07:45:51 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2215> 
======================================================================
Reported By:                bluebottle
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2215
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             
======================================================================
Date Submitted:             06-17-2006 07:45 CEST
Last Modified:              06-17-2006 07:45 CEST
======================================================================
Summary:                    Agere softmodem attached to Intel HDA does not work
Description: 
I have an MSI 1057 notebook with an Agere winmodem attached to the Intel
HDA device. It does not function with the latest release of ALSA
(currently 1.0.11). I attempted to modify patch_si3054.c and changed the
last device ID from 3026 to 3055 so that it loads and IDs the modem
(incorrectly) as a Si3054. That was just to prove that it *could* be
identified. When dialling via slmodemd though, nothing happens. KPPP or
any other app just gets no response from slmodemd after an ATDT.

# cat /proc/asound/card0/codec#1
Codec: Generic 11c1 Si3054        (before my hack, "Si3054" was "ID
3055")
Address: 1
Vendor Id: 0x11c13055
Subsystem Id: 0x11c11601
Revision Id: 0x100700

I have a .INF from the windows drivers CD with lots of device command
codes in it, if that would help. I'm not sure about license issues so I
won't post it initially. Windows is not installed on this machine so I
can't test it with Windows without swapping out the disk, sorry.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-06 07:45 bluebottle     New Issue                                    
06-17-06 07:45 bluebottle     Distribution              => Ubuntu          
======================================================================
