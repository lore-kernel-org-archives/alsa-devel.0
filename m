From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001402]: No SOUND in ASUS A6
Date: Fri, 9 Sep 2005 12:37:08 +0200
Message-ID: <143adcd8a14f6454cd0353ad15b5f9e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B3D3158
	for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2005 12:37:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1402> 
======================================================================
Reported By:                pedrosalazar
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1402
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Red Hat Fedora Core 4
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-07-2005 23:47 CEST
Last Modified:              09-09-2005 12:37 CEST
======================================================================
Summary:                    No SOUND in ASUS A6
Description: 
There is no sound in asus laptop A6 with alsa drivers.

laptop: ASUS A6 (A6Q00VA) Intel Pentium M Processor 740

Initially verified with the alsa-driver bundle in FC4 (1.0.9rc2 if I'm not
wrong) with kernel 2.6.12-1.1398_FC4, then I updated to alsa-driver 1.0.9b
working with alsa-lib 1.0.9 and alsa-utils 1.0.9a.

After, I updated kernel to 2.6.12.5, and now I'm using the 2.6.13.

All would be fine (alsamixer, aplay, ...) unless there is no sound.

I compiled alsa-driver with debug, and added the module option
"model=asus", that prints the following message when module is inserted:

Sep  7 21:59:39 undertaker kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] ->
Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Sep  7 21:59:39 undertaker kernel: ALSA
/home/psalazar/build/alsa-driver-1.0.9b/pci/hda/../../alsa-kernel/pci/hda/patch_realtek.c:1409:
hda_codec: Unknown model for ALC880

======================================================================

----------------------------------------------------------------------
 pedrosalazar - 09-09-05 03:12 
----------------------------------------------------------------------
It's OK.

I tested with alsa-driver from kernel 2.6.13 passing "model=asus" to the
module, and there is sound! :-)

great!

about the alsa-driver version differences, is normal?

regards,
PS

----------------------------------------------------------------------
 tiwai - 09-09-05 12:37 
----------------------------------------------------------------------
The ALSA code is merged with kernel tree occasionally, not always together
with the kernel/ALSA releases.  That's why you see a difference.  But,
anyway, you should use the latest ALSA version, 1.0.10rc1 (or more better,
CVS version) for such a new driver and a new board.

Does your laptop have an SPDIF output?  If yes, ASUS_DIG can be chosen. 
The only difference between ALC880_ASUS and ALC880_ASUS_DIG is the support
of SPDIF.  W1V has additional "line2" output jack.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-07-05 23:47 pedrosalazar   New Issue                                    
09-07-05 23:47 pedrosalazar   File Added: 2.6.13.config                    
09-07-05 23:47 pedrosalazar   Distribution              => Red Hat Fedora Core 4
09-07-05 23:47 pedrosalazar   Kernel Version            => 2.6.13          
09-08-05 19:02 tiwai          Note Added: 0006078                          
09-09-05 02:42 pedrosalazar   Note Added: 0006085                          
09-09-05 03:12 pedrosalazar   Note Added: 0006087                          
09-09-05 12:37 tiwai          Note Added: 0006095                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
