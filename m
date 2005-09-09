From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001402]: No SOUND in ASUS A6
Date: Fri, 9 Sep 2005 03:12:18 +0200
Message-ID: <4ee2bc9f2700beb80e361ee123998049@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 20BAC1C1
	for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2005 03:12:19 +0200 (MEST)
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
Last Modified:              09-09-2005 03:12 CEST
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
 pedrosalazar - 09-09-05 02:42 
----------------------------------------------------------------------
I followed your alternative suggestion, just for testing: I put my device
under a specific model (I used the W810 for instance) and it worked ok. I
can hear the sound and control it through alsamixer!! It's a great step
even the headphones aren't working but it isn't my model anyway!!

Anyway, there are some issues that I would like to clarify with you about
the alsa-driver version:

- The snd-hda-intel module didn't detected any asus module because there
is no asus model defined in the sources I'm using (1.0.9b from alsa site -
in this point I was already a specific alsa-driver version and not the
kernel ones). 

- As I'm using kernel 2.6.13, I saw in the patch_realtek.c that there are
some asus definitions (e.g. ASUS, ASUS_DIG, ASUS_W1V) as you said. I look
for the alsa-version and noticed that is also the 1.0.9b!?!

How can it be?!? 
The same version but different code: the 2.6.13 kernel and the 1.0.9b from
alsa site!? Can you explain me this issue here?

I was suspecting something like that after you said that I wasn't passing
the "model=asus" correctly - but in fact I was, yet when I verified with
"model=test"that worked well.

So, now I will reinstall the alsa-driver from kernel 2.6.13, and I will
pass the model=asus to see if it works. I'll update here the result.

Even so, I put below my device (lspci -nv) for the subsystem information
from the ASUS A6 laptop for your information:

00:1b.0 Class 0403: 8086:2668 (rev 04)
        Subsystem: 1043:1173
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at febf8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
