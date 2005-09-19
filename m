From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001435]: ac97 codec is not found when loading the driver
Date: Mon, 19 Sep 2005 23:38:06 +0200
Message-ID: <3c196aa019d4a180a5825654c5dbcd77@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 78CC3194
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 23:38:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1435> 
======================================================================
Reported By:                iluxa
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1435
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.13, 2.6.14-rc1
======================================================================
Date Submitted:             09-19-2005 08:49 CEST
Last Modified:              09-19-2005 23:38 CEST
======================================================================
Summary:                    ac97 codec is not found when loading the driver
Description: 
When loading snd-tiixp-modem _after_ loading snd-atiixp, I get a message
saying
"atiixp-modem: no codec available" and modem doesn't function after that.

Little more investigation shown that snd_ac97_mixer thinks the codec is
already 
registered as sound codec by audio card driver.

I'v tried alsa-1.0.9, driver included in 2.6.13, 2.6.14-rc1 and drivers
from CVS HEAD - all with same result.


======================================================================

----------------------------------------------------------------------
 iluxa - 09-19-05 20:07 
----------------------------------------------------------------------
and here is dmesg output after running modprobe snd-atiixp and
snd-atiixp-modem
(--with-debug=detect)

ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 185
ALSA /root/alsa/alsa-driver/pci/../alsa-kernel/pci/atiixp_modem.c:1084:
atiixp-modem: codec 0 not available for modem
ALSA /root/alsa/alsa-driver/pci/../alsa-kernel/pci/atiixp_modem.c:1091:
atiixp-modem: no codec available
ACPI: PCI interrupt for device 0000:00:14.6 disabled

BTW, on unrelated note - I had to tweak manually include/config.h - 
CONFIG_HAVE_PCI_SAVED_CONFIG and CONFIG_HAVE_NEW_PCI_SAVE_STATE were
undefined, even though it seems they should have been defined.
I am not sure if it's something wrong with my build environment, or some
changes in 2.6.14 that are affecting it.
When building against 2.6.14 this compile problem didn't occur.

----------------------------------------------------------------------
 sashak - 09-19-05 23:38 
----------------------------------------------------------------------
> Damn.. uploaded wrong file 

deleted. :)

Hmm, this is some HP machine and there is Conexant codec CXT30 (likely
AMC) - we don't know how to support it due to lack of datasheets. We may
try to investigate it deeper, but chance to be supported is really small.

Please upload also '/proc/asound/card0/codec97#0/ac97#0-0+regs' file.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-19-05 08:49 iluxa          New Issue                                    
09-19-05 08:49 iluxa          Kernel Version            => 2.6.13, 2.6.14-rc1
09-19-05 13:27 sashak         Note Added: 0006292                          
09-19-05 19:32 iluxa          File Added: pci.txt                          
09-19-05 19:56 iluxa          File Added: comment.diff                     
09-19-05 19:57 iluxa          Note Added: 0006296                          
09-19-05 20:01 iluxa          File Added: atiixp.txt                       
09-19-05 20:01 iluxa          File Added: codec97_0_ac97_0-0.txt                
   
09-19-05 20:07 iluxa          Note Added: 0006298                          
09-19-05 23:30 sashak         File Deleted: comment.diff                    
09-19-05 23:38 sashak         Note Added: 0006304                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
