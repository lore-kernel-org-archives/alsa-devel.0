From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: warning "hda-intel: IRQ timing workaround is activated
	for card #0. Suggest a bigger bdl_pos_adj."
Date: Mon, 29 Jun 2009 14:28:04 +0100
Message-ID: <598e9210906290628v65cd871ege11e1455bfdf968b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ED1D10382B
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 15:28:25 +0200 (CEST)
Received: by fxm26 with SMTP id 26so3724213fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2009 06:28:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I am getting the above warning when trying to play audio files.

Contrary to other similar cases with this warning, in my case the playback
of the media files fails. For every single media file, the playback
fails after a random
amount of time (a few seconds to a few minutes).

I am running Ubuntu 9.04 (kernel 2.6.28-13-generic, x86_64, upgraded
to Alsa 1.0.20 using AlsaUpgrade,
http://ubuntuforums.org/showthread.php?p=6589810).

I increased bdl_pos_adj to 32 and there is no effect (I added "options
snd-hda-intel bdl_pos_adj=32" to /etc/modprobe.d/alsa-base.conf,
then "/sbin/alsa force-reload").

lspci -vvv says:

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio
Controller (rev 03)
        Subsystem: Dell Device 02bb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 2293
        Region 0: Memory at f6500000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable+
                Address: 00000000fee0300c  Data: 41d1
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag- RBE- FLReset+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed unknown, Width x0, ASPM
unknown, Latency L0 <64ns, L1 <1us
                        ClockPM- Suprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed unknown, Width x0, TrErr- Train-
SlotClk- DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [130] Root Complex Link <?>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

lshw says:

        *-multimedia
             description: Audio device
             product: 82801I (ICH9 Family) HD Audio Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@0000:00:1b.0
             version: 03
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress bus_master cap_list
             configuration: driver=HDA Intel latency=0 module=snd_hda_intel

Simos
