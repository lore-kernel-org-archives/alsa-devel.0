From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002268]: No sound and odd problems
Date: Sun, 30 Jul 2006 22:19:46 +0200
Message-ID: <a7e356005f5f97a1067b438d0e634bb0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7FD05168
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 22:19:46 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2268> 
======================================================================
Reported By:                fjalvingh
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2268
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.16-r9
======================================================================
Date Submitted:             07-11-2006 01:08 CEST
Last Modified:              07-30-2006 22:19 CEST
======================================================================
Summary:                    No sound and odd problems
Description: 
The 1.0.10 driver worked without any problems but no longer compiles
against kernel 2.6.16. The latest versions (1.0.11, 1.0.12rc1) compile but
give a lot of problems:
- loading the driver causes the azx_get_response timeout error. Using
pci=noacpi or acpi=off does not fix this; only the single_cmd=1 option
fixes this.
- the driver loads. But aplay reports the error:
ALSA lib pcm_direct.c:819:(snd_pcm_direct_initialize_slave)
snd_pcm_hw_params_any failed
ALSA lib pcm_dmix.c:874:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:547: audio open error: Invalid argument
- Trying to cat /proc/asound/card0/codec#0 causes the system to use 100%
CPU (SYS). After a long time the cmd returns without any output. And my
dmesg log/syslog is filled with messages like:
----
Jul 11 00:25:30 chatelet ALSA
/var/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/hda/hda_codec.c:204:
hda_codec: invalid dep_range_val 0:7fff
----
This gets repeated a lot forming a messages file of about 1GB(!)

lspci -v returns:
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 03)
        Subsystem: CLEVO/KAPOK Computer Unknown device 0900
        Flags: bus master, fast devsel, latency 0, IRQ 20
        Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

cat /proc/asound/cards:
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xb0000000 irq 20

cat /proc/asound/devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 22: [ 0- 6]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 30: [ 0- 6]: digital audio capture
 33:        : timer

cat /proc/asound/pcm
00-06: Si3054 Modem : Si3054 Modem : playback 1 : capture 1
00-01: ALC880 Analog : ALC880 Analog : capture 2
00-00: ALC880 Analog : ALC880 Analog : playback 1 : capture 2

when loading the driver dmesg shows:
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 17 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1b.0 to 64

and (appearently 1st load only):
Jul 10 17:04:47 chatelet hda_codec: Unknown model for ALC880, trying
auto-probe from BIOS...
Jul 10 17:04:47 chatelet hda_codec: Cannot set up configuration from BIOS.
 Using 3-stack mode...

======================================================================

----------------------------------------------------------------------
 fjalvingh - 07-30-06 22:19 
----------------------------------------------------------------------
I just took a new alsa version from source repository, and this one works!
The dmesg shows:
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 17 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
ALSA /home/jal/prj/alsa/alsa-driver/pci/hda/hda_codec.c:2150: autoconfig:
line_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/jal/prj/alsa/alsa-driver/pci/hda/hda_codec.c:2154:   
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/jal/prj/alsa/alsa-driver/pci/hda/hda_codec.c:2156:    hp=0x0,
dig_out=0x0, din_in=0x0
ALSA /home/jal/prj/alsa/alsa-driver/pci/hda/hda_codec.c:2164:    inputs:
mic=0x0, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
hda_codec: Cannot set up configuration from BIOS.  Using 3-stack mode...
ALSA
/home/jal/prj/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:525:
hda_intel: azx_get_response timeout, switching to single_cmd mode...
ALSA /home/jal/prj/alsa/alsa-driver/pci/hda/hda_codec.c:572: hda_codec:
cannot malloc

Sound seems OK despite the malloc warning.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-06 01:08 fjalvingh      New Issue                                    
07-11-06 01:08 fjalvingh      Distribution              => gentoo          
07-11-06 01:08 fjalvingh      Kernel Version            => 2.6.16-r9       
07-11-06 01:09 fjalvingh      Issue Monitored: fjalvingh                    
07-30-06 22:19 fjalvingh      Note Added: 0011331                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
