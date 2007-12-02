From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Realtek ALC883 support on Albatron KI690-AM2
	motherboard
Date: Sun, 2 Dec 2007 16:08:32 -0500
Message-ID: <76366b180712021308n4d5fd0fk5906c8928795b0c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id E768C103811
	for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2007 22:08:33 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so2142364rvb
	for <alsa-devel@alsa-project.org>; Sun, 02 Dec 2007 13:08:32 -0800 (PST)
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, Claudio Matsuoka <cmatsuoka@gmail.com>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hello everyone,

I'm currently trying to get the ALC883 on the Albatron KI690-AM2
motherboard working under ALSA and I'm running into problems with some
of the ports. From looking at the patch_realtek.c file inside the
intel_hda driver, it appears there are many variants of hookups to
this chipset which all require some manual configuration in the
driver. I've tried what appears to be the closest match
(ALC883_6ST_DIG or 6stack-dig), but it still does not enable all of
the ports.

The motherboard webpage is here:
http://www.albatron.com.tw/English/product/mb/pro_detail.asp?rlink=Specification&no=239

The board has two audio stacks on the back panel. Facing the jack
inputs, the left-hand stack contains:
    <S/PDIF output>
    <TOSLINK w/ green cover>

Next to that stack is a larger 6-stack with the following configuration:
    <blue> <black>
    <green> <pink>
    <grey> <TOSLINK w/ pink cover>

The box is running a stock debian 2.6.18-4-486 kernel. The kernel
outputs this at startup if the "6stack-dig" model is not explicitly
supplied:

    hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
    hda-intel: Invalid position buffer, using LPIB read method instead.

When using the "6stack-dig" mode, ALSA sees two devices:

    card 0: SB [HDA ATI SB], device 0: ALC883 Analog [ALC883 Analog]
      Subdevices: 1/1
      Subdevice #0: subdevice #0
    card 0: SB [HDA ATI SB], device 2: ALC883 Digital [ALC883 Digital]
      Subdevices: 1/1
      Subdevice #0: subdevice #0

When attempting to use ALSA to open the first device in raw mode to
output to each stereo pair separately, 5 pairs are detected, and the
outputs appear as follows...

    Pair 1: <green> (working)
    Pair 2: <pink> (working)
    Pair 3: <black> (working)
    Pair 4: (no audio)
    Pair 5: (no audio)

No sound can be heard from the blue or grey jacks in any
configuration. I'm wondering if a special entry is needed in
patch_realtek.c to handle this board's usage of the ALC883. I am
willing to try changing the code and testing if someone can point me
to what might need to be done.

01:05.2 Audio device: ATI Technologies Inc Unknown device 7919
        Subsystem: Albatron Corp. Unknown device 5000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 4 bytes
        Interrupt: pin B routed to IRQ 3
        Region 0: Memory at fdffc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

Thanks,
-Andrew
