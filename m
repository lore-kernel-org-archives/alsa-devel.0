From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000974]: AC'97 Modem Controller not known
Date: Tue, 8 Mar 2005 20:31:07 +0100
Message-ID: <810eed9b3415c76d4ba24c0371c03e00@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CE8CC1C1
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2005 20:31:07 +0100 (MET)
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
Last Modified:              03-08-2005 20:31 CET
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

----------------------------------------------------------------------
 bidoubidou - 03-08-05 20:14 
----------------------------------------------------------------------
no /proc/asound/card0/codec#0/ac97#0-0

cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Conexant id 30

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x0000
Subsys. ID       : 0x0000

Capabilities     : -reserved1- -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 AMAP DSA=0 SPDIF
Extended status  : PRL PRK PRJ PRI SPCV SPDIF=10/11
SPDIF Control    : Consumer PCM Copyright Category=0x22 Generation=1
Rate=48kHz
Extended modem ID: codec=0 LIN1
Modem status     : PRA(GPIO)
Line1 rate       : 48000Hz

----------------------------------------------------------------------
 pzad - 03-08-05 20:31 
----------------------------------------------------------------------
AFAIK "Conexant id 30" is AMC97 codec. I have same modem, but fortunatly I
don't need it.

For me: When I load modem driver, then sound will stop working (I have to
put snd-intel8x0m in to blacklist, because modem will always kill sound).
This is because support for AMC97 codec is little broken for ICH (it
failed to initialize modem part of codec and then audio part is reset
too).

AFAIK, only modem software which uses alsa modem driver is slmodem, but
this is conexant modem. Even if you get snd-intel8x0m driver to work (I
think this is not so big problem - I know where is problem), this will not
help you and slmodem will not work with it (there is Line Side Device and
it needs initialization too, but there is no doc for it).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 16:02 bidoubidou     New Issue                                    
03-08-05 16:02 bidoubidou     Distribution              => MandrakeLinux cooker
03-08-05 16:02 bidoubidou     Kernel Version            => 2.6.11-mm1      
03-08-05 18:38 pzad           Note Added: 0003815                          
03-08-05 20:14 bidoubidou     Note Added: 0003817                          
03-08-05 20:31 pzad           Note Added: 0003818                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
