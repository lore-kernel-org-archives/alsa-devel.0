From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Tue, 16 Jun 2015 22:50:53 +0200
Message-ID: <20150616205053.GA323@asus>
References: <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id E18EA2659E7
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 22:50:58 +0200 (CEST)
Received: by wiwd19 with SMTP id d19so114241538wiw.0
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 13:50:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434387868.2434.50.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Koul, Vinod" <vinod.koul@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2015 at 06:04:28PM +0100, Liam Girdwood wrote:
> 
> We are also a little suspicious that this laptop is using SSP1 for the
> I2S audio connection to the codec. The bad news is that the FW used by
> this BYT ADSP driver does not support the SSP1 port. It's hard coded to
> use SSP0 (Jarrko, please correct the port numbering if it's wrong).
> There are going to be no further releases of this FW.
> 
> However, the other upstream BYT ADSP driver from Vinod's team is going
> to support the other SSP ports. It currently only supports SSP0, but I
> believe that a new FW will be released soon that will support SSP1.
> Vinod do you know the new FW release date ?
> 
> Michele, can you change your machine driver to use the Vinods BYT DSP
> PCM driver (base it on bytcr_rt5640.c). Please test probing/booting with
> the current FW release from Vinod too. That way you should be ready to
> integrate the new FW when it is released. Please also CC Vinod on any
> issues you have getting the FW to boot using the new driver/FW.
>

Sure!

A note, without enabling the config option SND_SOC_INTEL_SST the driver
will not compile/install but it seems strange because when doing a 
menuconfig the machine driver option is available even if the 
SND_SOC_INTEL_SST option is not selcted (I copied the Kconfig part 
from the SND_SOC_INTEL_BYTCR_RT5640_MACH one).

So I think I'm missing something...  The two "upstream BYT ADSP drivers"
are mutually exclusive?  I see mixed outputs like
[    2.209494] sst-acpi 80860F28:00: No matching ASoC machine driver found
followed by output of the machine driver that tries to bind cpu and codec 
dais..


Anyway, no sound cards show up, there are some strange errors about the
rt5645-aif1 codec dai not registered but dmesg says:
[    2.415511] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif1'


I saw:
[    2.307977] intel_sst_acpi 80860F28:00: Registered IRQ 0x6

so, in sound/soc/intel/atom/sst/sst_acpi.c I tried to change the
.acpi_ipc_irq_index to get the expected 0x1D (like with the prevoius 
driver, or it's a different thing?) and I got:

 acpi_ipc_irq_index |  Registered IRQ
--------------------+-----------------
         0          |        0x1
         1          |        0x2
         2          |        0x3
         3          |        0x4
         4          |        0x5
         5          |        0x6
        0x1c        |   probe failed*

* = [    2.370344] intel_sst_acpi: probe of 80860F28:00 failed with error -22


Here the dmesg output (with the default .acpi_ipc_irq_index == 5):

[    2.209494] sst-acpi 80860F28:00: No matching ASoC machine driver found
[    2.217914] hidraw: raw HID events driver (C) Jiri Kosina
[    2.237653] snd-soc-dummy snd-soc-dummy: codec register snd-soc-dummy
[    2.237667] snd-soc-dummy snd-soc-dummy: ASoC: dai register snd-soc-dummy #1
[    2.237674] snd-soc-dummy snd-soc-dummy: ASoC: Registered DAI 'snd-soc-dummy-dai'
[    2.237679] snd-soc-dummy snd-soc-dummy: ASoC: Registered codec 'snd-soc-dummy'
[    2.237696] snd-soc-dummy snd-soc-dummy: ASoC: platform register snd-soc-dummy
[    2.237704] snd-soc-dummy snd-soc-dummy: ASoC: Registered platform 'snd-soc-dummy'
[    2.251378] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    2.255439] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[    2.261140] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    2.264403] ACPI: Lid Switch [LID]
[    2.267688] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    2.270869] ACPI: Power Button [PWRB]
[    2.274188] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    2.277421] ACPI: Sleep Button [SLPB]
[    2.282078] intel_sst_acpi 80860F28:00: for 80860F28
[    2.285618] intel_sst_acpi 80860F28:00: ACPI device id: 80860f28
[    2.285739] sst-mfld-platform sst-mfld-platform: ASoC: platform register sst-mfld-platform
[    2.285750] sst-mfld-platform sst-mfld-platform: ASoC: Registered platform 'sst-mfld-platform'
[    2.285757] sst-mfld-platform sst-mfld-platform: ASoC: dai register sst-mfld-platform #5
[    2.285763] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'media-cpu-dai'
[    2.285769] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'compress-cpu-dai'
[    2.285774] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'ssp0-port'
[    2.285779] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'ssp1-port'
[    2.285785] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'ssp2-port'
[    2.285863] intel_sst_acpi 80860F28:00: LPE base: 0x90a00000 size:0x200000
[    2.289110] intel_sst_acpi 80860F28:00: IRAM base: 0x90ac0000
[    2.292291] intel_sst_acpi 80860F28:00: DRAM base: 0x90b00000
[    2.295391] intel_sst_acpi 80860F28:00: SHIM base: 0x90b40000
[    2.298497] intel_sst_acpi 80860F28:00: Mailbox base: 0x90b44000
[    2.301611] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[    2.304776] intel_sst_acpi 80860F28:00: Got drv data max stream 25
[    2.307977] intel_sst_acpi 80860F28:00: Registered IRQ 0x6
[    2.307986] intel_sst_acpi 80860F28:00: Requesting FW intel/fw_sst_0f28.bin now...
[    2.308001] intel_sst_acpi 80860F28:00: registering device Intel(R) SST LPE
[    2.309138] intel_sst_acpi 80860F28:00: LPE is already in RESET state, No action
[    2.309514] [Firmware Bug]: No valid trip found
[    2.315662] wmi: Mapper loaded
[    2.325338] intel_sst_acpi 80860F28:00: Enter
[    2.325347] intel_sst_acpi 80860F28:00: Request Fw completed
[    2.325739] intel_sst_acpi 80860F28:00: copied fw to ffff88007ac00000
[    2.325748] intel_sst_acpi 80860F28:00: phys: 7ac00000
[    2.325786] ACPI: Battery Slot [BATC] (battery present)
[    2.326231] intel_sst_acpi 80860F28:00: Enter
[    2.326236] intel_sst_acpi 80860F28:00: header sign=$SST\xffffff86\xffffffdf	 size=9df86 modules=1 fmt=100 size=20
[    2.326240] intel_sst_acpi 80860F28:00: module sign $SSTr\xffffffdf	 size 9df72 blocks 13 type ffff
[    2.326242] intel_sst_acpi 80860F28:00: module entrypoint 0x0
[    2.336296] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    2.340218] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    2.353258] media: Linux media interface: v0.10
[    2.357097] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    2.370554] [drm] Initialized drm 1.1.0 20060810
[    2.394018] Linux video capture interface: v2.00
[    2.410811] cfg80211: Calling CRDA to update world regulatory domain
[    2.415491] rt5645 i2c-10EC5648:00: codec register i2c-10EC5648:00
[    2.415505] rt5645 i2c-10EC5648:00: ASoC: dai register i2c-10EC5648:00 #2
[    2.415511] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif1'
[    2.415516] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif2'
[    2.415523] rt5645 i2c-10EC5648:00: ASoC: Registered codec 'i2c-10EC5648:00'
[    2.440490] SSE version of gcm_enc/dec engaged.
[    2.462788] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (04f2:b483)
[    2.481724] input: USB2.0 VGA UVC WebCam as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/input/input4
[    2.485443] usbcore: registered new interface driver uvcvideo
[    2.489754] USB Video Class driver (1.1.1)
[    2.499264] [drm] Memory usable by graphics device = 2048M
[    2.499493] Bluetooth: Core ver 2.20
[    2.499523] NET: Registered protocol family 31
[    2.499524] Bluetooth: HCI device and connection manager initialized
[    2.499531] Bluetooth: HCI socket layer initialized
[    2.499536] Bluetooth: L2CAP socket layer initialized
[    2.499553] Bluetooth: SCO socket layer initialized
[    2.520222] checking generic (80000000 410000) vs hw (80000000 10000000)
[    2.520230] fb: switching to inteldrmfb from EFI VGA
[    2.523516] Console: switching to colour dummy device 80x25
[    2.524348] [drm] Replacing VGA console driver
[    2.525446] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    2.531147] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.531165] [drm] Driver supports precise vblank timestamp query.
[    2.531613] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.533301] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.534844] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.537609] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.573178] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.573192] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.573199] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.573204] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.573226] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.574971] asus_wmi: ASUS WMI generic driver loaded
[    2.587049] iTCO_vendor_support: vendor-support=0
[    2.589084] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
[    2.589972] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    2.590094] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3, TCOBASE=0x0460)
[    2.590955] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.590970] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.590976] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.590982] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.591003] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.593272] asus_wmi: Initialization: 0x1
[    2.593443] asus_wmi: BIOS WMI version: 7.9
[    2.593548] asus_wmi: SFUN value: 0x37
[    2.594575] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    2.594672] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.594696] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.594705] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.594711] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.594733] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.595441] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
[    2.595819] input: PDEC3393:00 0B05:8585 as /devices/platform/80860F41:00/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001/input/input5
[    2.598334] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input6
[    2.605485] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.605500] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.605507] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.605513] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.605534] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.609178] hid-generic 0018:0B05:8585.0001: input,hidraw0: <UNKNOWN> HID v1.00 Keyboard [PDEC3393:00 0B05:8585] on 
[    2.609292] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.609308] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.609314] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.609320] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.609341] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.609573] intel_rapl: Found RAPL domain package
[    2.609588] intel_rapl: Found RAPL domain core
[    2.613927] asus_wmi: Number of fans: 1
[    2.619323] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
[    2.621281] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.621294] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.621300] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.621306] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.621332] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.621559] usbcore: registered new interface driver brcmfmac
[    2.621904] asus_wmi: Backlight controlled by ACPI video driver
[    2.623068] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.623087] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.623098] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.623107] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.623129] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.631277] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.631293] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.631299] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.631305] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.631340] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.635502] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.677904] random: nonblocking pool is initialized
[    2.679866] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
[    2.681810] fbcon: inteldrmfb (fb0) is primary device
[    2.682880] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.683662] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
[    2.684025] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.684034] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.684038] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.684041] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02.0 on minor 0
[    2.684043] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.684046] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.684079] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.684083] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.684086] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.684089] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.684092] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.688705] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
[    2.689046] input: ELAN0100:00 04F3:0401 as /devices/platform/80860F41:03/i2c-3/i2c-ELAN0100:00/0018:04F3:0401.0002/input/input8
[    2.689335] hid-generic 0018:04F3:0401.0002: input,hidraw1: <UNKNOWN> HID v1.00 Mouse [ELAN0100:00 04F3:0401] on 
[    2.689402] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.689410] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.689413] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP2-Codec at idx 2
[    2.689416] bytx205_rt5645 bytx205_rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    2.689419] bytx205_rt5645 bytx205_rt5645: devm_snd_soc_register_card failed -517
[    2.696827] mousedev: PS/2 mouse device common for all mice
[    3.799072] Console: switching to colour frame buffer device 170x48
[    3.812868] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.812870] i915 0000:00:02.0: registered panic notifier
[    4.808799] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
[    4.808826] brcmfmac: brcmf_c_preinit_dcmds: Retreiving version information failed, -52
[    4.808839] brcmfmac: brcmf_bus_start: failed: -52
[    4.808867] brcmfmac: brcmf_sdio_firmware_callback: dongle is not responding
[    5.562858] cfg80211: Calling CRDA to update world regulatory domain
[    8.715424] cfg80211: Calling CRDA to update world regulatory domain
[   11.860995] cfg80211: Calling CRDA to update world regulatory domain
[   15.010088] cfg80211: Calling CRDA to update world regulatory domain
[   18.155782] cfg80211: Calling CRDA to update world regulatory domain
[   21.301814] cfg80211: Calling CRDA to update world regulatory domain
[   24.448305] cfg80211: Calling CRDA to update world regulatory domain


Thanks,
Michele

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 sound/soc/codecs/rt5645.c             |   2 +
 sound/soc/intel/Kconfig               |  18 ++-
 sound/soc/intel/atom/sst/sst_acpi.c   |   2 +
 sound/soc/intel/boards/Makefile       |   2 +
 sound/soc/intel/boards/bytcr_rt5645.c | 227 ++++++++++++++++++++++++++++++++++
 5 files changed, 249 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/intel/boards/bytcr_rt5645.c

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ce311e..7733659 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3192,6 +3192,7 @@ static const struct regmap_config rt5645_regmap = {
 
 static const struct i2c_device_id rt5645_i2c_id[] = {
 	{ "rt5645", 0 },
+	{ "rt5648", 0 },
 	{ "rt5650", 0 },
 	{ }
 };
@@ -3200,6 +3201,7 @@ MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 #ifdef CONFIG_ACPI
 static struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
+	{ "10EC5648", 0 },
 	{ "10EC5650", 0 },
 	{},
 };
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index f3060a4..33d26b9 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -87,14 +87,28 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
-	tristate "ASoC Audio DSP Support for MID BYT Platform"
+	tristate "ASoC Audio DSP Support for MID BYT Platform with RT5640 codec"
 	depends on X86 && I2C
 	select SND_SOC_RT5640
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) MID Baytrail platform
-          used as alsa device in audio substem in Intel(R) MID devices
+          used as alsa device in audio substem in Intel(R) MID devices coupled with a
+          Realtek RT5640 codec.
+          Say Y if you have such a device
+          If unsure select "N".
+
+config SND_SOC_INTEL_BYTCR_RT5645_MACH
+	tristate "ASoC Audio DSP Support for MID BYT Platform with RT5645 codec"
+	depends on X86 && I2C
+	select SND_SOC_RT5645
+	select SND_SST_MFLD_PLATFORM
+	select SND_SST_IPC_ACPI
+	help
+	  This adds support for ASoC machine driver for Intel(R) MID Baytrail platform
+          used as alsa device in audio substem in Intel(R) MID devices coupled with a
+          Realtek RT5645 codec.
           Say Y if you have such a device
           If unsure select "N".
 
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index bb19b58..d908758 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -345,6 +345,8 @@ static int sst_acpi_remove(struct platform_device *pdev)
 static struct sst_machines sst_acpi_bytcr[] = {
 	{"10EC5640", "T100", "bytt100_rt5640", NULL, "intel/fw_sst_0f28.bin",
 						&byt_rvp_platform_data },
+	{"10EC5648", "X205", "bytx205_rt5645", NULL, "intel/fw_sst_0f28.bin",
+						&byt_rvp_platform_data },
 	{},
 };
 
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index cb94895..8e71631 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -3,6 +3,7 @@ snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
+snd-soc-sst-bytcr-rt5645-objs := bytcr_rt5645.o
 snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
 snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
 snd-soc-sst-cht-bsw-max98090_ti-objs := cht_bsw_max98090_ti.o
@@ -12,6 +13,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
+obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5645_MACH) += snd-soc-sst-bytcr-rt5645.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) += snd-soc-sst-cht-bsw-max98090_ti.o
diff --git a/sound/soc/intel/boards/bytcr_rt5645.c b/sound/soc/intel/boards/bytcr_rt5645.c
new file mode 100644
index 0000000..c64b524
--- /dev/null
+++ b/sound/soc/intel/boards/bytcr_rt5645.c
@@ -0,0 +1,227 @@
+/*
+ *  byt_cr_dpcm_rt5645.c - ASoc Machine driver for Intel Byt CR platform
+ *
+ *  Copyright (C) 2014 Intel Corp
+ *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "../../codecs/rt5645.h"
+#include "../atom/sst-atom-controls.h"
+
+static const struct snd_soc_dapm_widget byt_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route byt_audio_map[] = {
+	{"IN2P", NULL, "Headset Mic"},
+	{"IN2N", NULL, "Headset Mic"},
+	{"Headset Mic", NULL, "MICBIAS1"},
+	{"IN1P", NULL, "MICBIAS1"},
+	{"LDO2", NULL, "Int Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Ext Spk", NULL, "SPOLP"},
+	{"Ext Spk", NULL, "SPOLN"},
+	{"Ext Spk", NULL, "SPORP"},
+	{"Ext Spk", NULL, "SPORN"},
+
+	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+	{"ssp2 Rx", NULL, "AIF1 Capture"},
+};
+
+static const struct snd_kcontrol_new byt_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Ext Spk"),
+};
+
+static int byt_aif1_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	snd_soc_dai_set_bclk_ratio(codec_dai, 50);
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5645_SCLK_S_PLL1,
+				     params_rate(params) * 512,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec clock %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5645_PLL1_S_BCLK1,
+				  params_rate(params) * 50,
+				  params_rate(params) * 512);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_pcm_stream byt_dai_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+};
+
+static int byt_codec_fixup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	/* set SSP2 to 24-bit */
+	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+	return 0;
+}
+
+static unsigned int rates_48000[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_48000 = {
+	.count = ARRAY_SIZE(rates_48000),
+	.list  = rates_48000,
+};
+
+static int byt_aif1_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_48000);
+}
+
+static struct snd_soc_ops byt_aif1_ops = {
+	.startup = byt_aif1_startup,
+};
+
+static struct snd_soc_ops byt_be_ssp2_ops = {
+	.hw_params = byt_aif1_hw_params,
+};
+
+static struct snd_soc_dai_link byt_dailink[] = {
+	[MERR_DPCM_AUDIO] = {
+		.name = "Baytrail Audio Port",
+		.stream_name = "Baytrail Audio",
+		.cpu_dai_name = "media-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.ignore_suspend = 1,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &byt_aif1_ops,
+	},
+	[MERR_DPCM_COMPR] = {
+		.name = "Baytrail Compressed Port",
+		.stream_name = "Baytrail Compress",
+		.cpu_dai_name = "compress-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+	},
+		/* back ends */
+	{
+		.name = "SSP2-Codec",
+		.be_id = 1,
+		.cpu_dai_name = "ssp2-port",
+		.platform_name = "sst-mfld-platform",
+		.no_pcm = 1,
+		.codec_dai_name = "rt5645-aif1",
+		.codec_name = "i2c-10EC56458:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+						| SND_SOC_DAIFMT_CBS_CFS,
+		.be_hw_params_fixup = byt_codec_fixup,
+		.ignore_suspend = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &byt_be_ssp2_ops,
+	},
+};
+
+/* SoC card */
+static struct snd_soc_card snd_soc_card_byt = {
+	.name = "baytrailcraudio",
+	.dai_link = byt_dailink,
+	.num_links = ARRAY_SIZE(byt_dailink),
+	.dapm_widgets = byt_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_dapm_widgets),
+	.dapm_routes = byt_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_audio_map),
+	.controls = byt_mc_controls,
+	.num_controls = ARRAY_SIZE(byt_mc_controls),
+};
+
+static int snd_byt_mc_probe(struct platform_device *pdev)
+{
+	int ret_val = 0;
+
+	/* register the soc card */
+	snd_soc_card_byt.dev = &pdev->dev;
+
+	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_byt);
+	if (ret_val) {
+		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n", ret_val);
+		return ret_val;
+	}
+	platform_set_drvdata(pdev, &snd_soc_card_byt);
+	return ret_val;
+}
+
+static struct platform_driver snd_byt_mc_driver = {
+	.driver = {
+		.name = "bytx205_rt5645",
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = snd_byt_mc_probe,
+};
+
+module_platform_driver(snd_byt_mc_driver);
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail CR Machine driver");
+MODULE_AUTHOR("Subhransu S. Prusty <subhransu.s.prusty@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:bytx205_rt5645");
-- 
2.4.3
