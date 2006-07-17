From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002251]: Speaker sound is fine,
	but headphones not recognized, so no sound
Date: Mon, 17 Jul 2006 18:28:28 +0200
Message-ID: <965131f539e4caf76eef4202271d333d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5303E226
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Jul 2006 18:28:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2251> 
======================================================================
Reported By:                moret
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2251
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.17.2
======================================================================
Date Submitted:             07-02-2006 06:27 CEST
Last Modified:              07-17-2006 18:28 CEST
======================================================================
Summary:                    Speaker sound is fine, but headphones not
recognized, so no sound
Description: 
Sound comes through fine on built-in speakers.  Plugging in headphones
silences the built-in speakers, but nothing comes through on the
headphones
jack.
The machine is a Panasonic CF-Y5 (Japanese market) with L2300 Core Duo
processor, 82801G (ICH7) chipset, and the following audio device (from
lspci -vv), with device ID 27d8, identified by ALSA as a SigmaTel STAC
9200:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: Matsushita Electric Industrial Co., Ltd. Unknown device
8338
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at d0340000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown,
Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)
As hinted at by the lspci listing, the alsamixer list only one output
device
(the built-in speakers).
======================================================================

----------------------------------------------------------------------
 moret - 07-06-06 23:40 
----------------------------------------------------------------------
OK, I downloaded ALSA HG, compiled the driver, and compared
/proc/asound/cardo/codec#0 with and without headphones plugged in.
The results are identical (I saved each and gave them to diff).

When the module is inserted, a few lines are saved to /var/log/syslog:
here they are
ul  6 23:17:18 localhost kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] ->
GSI 22 (level, low) -> IRQ 185
Jul  6 23:17:18 localhost kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Jul  6 23:17:18 localhost kernel: codec_mask = 0x1
Jul  6 23:17:18 localhost kernel: hda_codec: Unknown model for STAC9200,
using BIOS defaults
Jul  6 23:17:18 localhost kernel: autoconfig: line_outs=0
(0x0/0x0/0x0/0x0/0x0)
Jul  6 23:17:18 localhost kernel:    speaker_outs=1 (0xe/0x0/0x0/0x0/0x0)
Jul  6 23:17:18 localhost kernel:    hp=0xd, dig_out=0x0, din_in=0x0
Jul  6 23:17:18 localhost kernel:    inputs: mic=0x10, fmic=0x0, line=0x0,
fline=0x0, cd=0x0, aux=0x0
Jul  6 23:17:18 localhost kernel: hda_intel: azx_get_response timeout,
switching to single_cmd mode...

----------------------------------------------------------------------
 moret - 07-17-06 18:28 
----------------------------------------------------------------------
Partial resolution:
I just added a new stanza to pci/hda/patch_sigmatel.c,
copying lines 267-270 to create the extra stanza
        { .modelname = "CFY5",
          .pci_subvendor = PCI_VENDOR_ID_INTEL,
          .pci_subdevice = 0x27d8, /* /sys/class/sound/audio/device/device
*/
          .config = STAC_REF }, /* seems to work */
This avoids having the routine
   static int patch_stac9200(struct hda_codec *codec)
fail to obtain a valid spec->board_config; the original patch_sigmatel.c
would result in the error message
   hda_codec: Unknown model for STAC9200, using BIOS defaults
but this no longer happens with the extra stanza.
What matters is that headphones now work ;-)

On the other hand, this is only a partial resolution: neither alsa nor
xmix provides a mixer entry for the headphones, so sound volume has
to be controlled through speaker volume.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-02-06 06:27 moret          New Issue                                    
07-02-06 06:27 moret          Distribution              => Debian          
07-02-06 06:27 moret          Kernel Version            => 2.6.17.2        
07-02-06 16:17 moret          Note Added: 0010792                          
07-03-06 14:48 moret          Note Added: 0010799                          
07-06-06 20:03 tiwai          Note Added: 0010876                          
07-06-06 23:40 moret          Note Added: 0010886                          
07-17-06 18:28 moret          Note Added: 0011048                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
