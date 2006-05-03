From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002081]: and-atiixp module does not load into kernel
Date: Wed, 3 May 2006 11:46:56 +0200
Message-ID: <99a27ad2b1712d955b2c5956ff3b68a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65168223
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 11:46:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2081> 
======================================================================
Reported By:                KaszeL
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2081
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16-ck6-r1
======================================================================
Date Submitted:             04-28-2006 00:07 CEST
Last Modified:              05-03-2006 11:46 CEST
======================================================================
Summary:                    and-atiixp module does not load into kernel
Description: 
On DFI Infinity RS432 kernel module snd-atiixp does not load into kernel.
After succesfoul compilation via gentoo portage/emerge i allways get
errors similar to this:

ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/../alsa-kernel/pci/atiixp.c:458:
atiixp: codec read timeout (reg 0) 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/../alsa-kernel/pci/atiixp.c:458:
atiixp: codec read timeout (reg 3c) 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/../alsa-kernel/pci/atiixp.c:458:
atiixp: codec read timeout (reg 1c) 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/ac97/ac97_codec.c:1910:
AC'97 2 does not respond - RESET 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/ac97/ac97_codec.c:1919:
AC'97 2 access is not valid [0xffffffff], removing mixer. 
ALSA
/usr/data/temp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/../alsa-kernel/pci/atiixp.c:1411:
atiixp: no codec available 

Here is my lspci info:
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97
Audio Controller (rev 80) 
        Subsystem: DFI Inc Unknown device 3100 
        Flags: 66MHz, slow devsel, IRQ 18 
        Memory at fe02b000 (32-bit, non-prefetchable) [size=256] 
        Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0
Enable

I've tried several kernel and alsa-driver versions. I've also tried to
compile alsa staticly into the kernel but this does not work either.
======================================================================

----------------------------------------------------------------------
 KaszeL - 05-02-06 20:25 
----------------------------------------------------------------------
Here is my kernel .config (APCI section only).

cat .config|grep ACPI
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_SERIAL_8250_ACPI is not set

Should i disable APCI and try again?

----------------------------------------------------------------------
 tiwai - 05-03-06 11:46 
----------------------------------------------------------------------
Try acpi=off or pci=noacpi boot option at first.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-28-06 00:07 KaszeL         New Issue                                    
04-28-06 00:07 KaszeL         Distribution              => Gentoo          
04-28-06 00:07 KaszeL         Kernel Version            => 2.6.16-ck6-r1   
04-28-06 00:08 KaszeL         Issue Monitored: KaszeL                      
05-02-06 18:10 tiwai          Note Added: 0009567                          
05-02-06 20:25 KaszeL         Note Added: 0009577                          
05-03-06 11:46 tiwai          Note Added: 0009588                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
