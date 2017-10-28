From: Chris Clayton <chris2553@googlemail.com>
Subject: "PM / QoS: Fix device resume latency PM QoS" breaks sound
Date: Sat, 28 Oct 2017 21:10:32 +0100
Message-ID: <6e4896f5-46ea-4b58-3b51-4ccde11ade04@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I pulled the latestchanges from Linus' tree this evening and have found that with the new kernel, sound is not working
on my laptop. More precisely, the built-in speakers don't produce any sound. Sound does work when I use ear-plugs in the
headphone socket. It also works via a bluetooth speaker.

I've bisected the problem and ended up at:

0cc2b4e5a020fc7f4d1795741c116c983e9467d7 is the first bad commit
commit 0cc2b4e5a020fc7f4d1795741c116c983e9467d7
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Tue Oct 24 15:20:45 2017 +0200

    PM / QoS: Fix device resume latency PM QoS

    The special value of 0 for device resume latency PM QoS means
    "no restriction", but there are two problems with that.

    First, device resume latency PM QoS requests with 0 as the
    value are always put in front of requests with positive
    values in the priority lists used internally by the PM QoS
    framework, causing 0 to be chosen as an effective constraint
    value.  However, that 0 is then interpreted as "no restriction"
    effectively overriding the other requests with specific
    restrictions which is incorrect.

    Second, the users of device resume latency PM QoS have no
    way to specify that *any* resume latency at all should be
    avoided, which is an artificial limitation in general.

    To address these issues, modify device resume latency PM QoS to
    use S32_MAX as the "no constraint" value and 0 as the "no
    latency at all" one and rework its users (the cpuidle menu
    governor, the genpd QoS governor and the runtime PM framework)
    to follow these changes.

    Also add a special "n/a" value to the corresponding user space I/F
    to allow user space to indicate that it cannot accept any resume
    latencies at all for the given device.

    Fixes: 85dc0b8a4019 (PM / QoS: Make it possible to expose PM QoS latency constraints)
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=197323
    Reported-by: Reinette Chatre <reinette.chatre@intel.com>
    Tested-by: Reinette Chatre <reinette.chatre@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Acked-by: Alex Shi <alex.shi@linaro.org>
    Cc: All applicable <stable@vger.kernel.org>

:040000 040000 f0c128ec799bb9894cfc5c341f88ad7bdfb15bac 9a2e8171ca47f864bd534cd9c160cce58449a889 M	Documentation
:040000 040000 0028ffec81675e686bdd621c0445d3e814d7980c 29db53c6356a6fed9c8bdbc2d6bc7bd56a96e529 M	drivers
:040000 040000 2e66b79bd2ffb4fcb00f04a69a0afe5c80d1d3f3 dd6d8e90b59389cd2bd8a0c92716d79d2eeb8268 M	include

With that change reverted, the speakers emit sound again.

The audio devices identified by "lspci -vv" are as follows:

00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller (rev 06)
        Subsystem: CLEVO/KAPOK Computer Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f7f14000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset High Definition Audio Controller (rev 05)
        Subsystem: CLEVO/KAPOK Computer 8 Series/C220 Series Chipset High Definition Audio Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at f7f10000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

Let me know if I can provide any additional diagnostics, but please cc me because I'm not subscribed.

Thanks

Chris
