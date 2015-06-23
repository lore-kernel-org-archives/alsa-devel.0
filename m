From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Tue, 23 Jun 2015 11:09:33 +0200
Message-ID: <20150623090932.GA6856@dellaz>
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
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id B3F8B2654CC
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 11:09:40 +0200 (CEST)
Received: by wiga1 with SMTP id a1so99863637wig.0
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 02:09:40 -0700 (PDT)
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
> Michele, can you change your machine driver to use the Vinods BYT DSP
> PCM driver (base it on bytcr_rt5640.c). Please test probing/booting with
> the current FW release from Vinod too. That way you should be ready to
> integrate the new FW when it is released. Please also CC Vinod on any
> issues you have getting the FW to boot using the new driver/FW.
>

Hi,
an update, thanks to Vinod now the driver compiles enabling only the (new)
CONFIG_SND_SOC_INTEL_BYTCR_RT5645_MACH option.

The sound card shows up:
[zio@asus ~]$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: baytrailcraudio [baytrailcraudio], device 0: Baytrail Audio (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

There are a lot of errors about missing backend dai:
[    7.195570]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port

dmesg with some debug output enabled:
[    2.198045] snd-soc-dummy snd-soc-dummy: codec register snd-soc-dummy
[    2.198058] snd-soc-dummy snd-soc-dummy: ASoC: dai register snd-soc-dummy #1
[    2.198064] snd-soc-dummy snd-soc-dummy: ASoC: Registered DAI 'snd-soc-dummy-dai'
[    2.198070] snd-soc-dummy snd-soc-dummy: ASoC: Registered codec 'snd-soc-dummy'
[    2.198075] snd-soc-dummy snd-soc-dummy: ASoC: platform register snd-soc-dummy
[    2.198081] snd-soc-dummy snd-soc-dummy: ASoC: Registered platform 'snd-soc-dummy'
[    2.200659] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    2.204484] ACPI: Lid Switch [LID]
[    2.210292] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    2.214379] ACPI: Power Button [PWRB]
[    2.221387] intel_sst_acpi 80860F28:00: for 80860F28
[    2.223389] intel_sst_acpi 80860F28:00: ACPI device id: 80860f28
[    2.223503] sst-mfld-platform sst-mfld-platform: ASoC: platform register sst-mfld-platform
[    2.223514] sst-mfld-platform sst-mfld-platform: ASoC: Registered platform 'sst-mfld-platform'
[    2.223521] sst-mfld-platform sst-mfld-platform: ASoC: dai register sst-mfld-platform #5
[    2.223527] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'media-cpu-dai'
[    2.223532] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'compress-cpu-dai'
[    2.223537] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'ssp0-port'
[    2.223542] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'ssp1-port'
[    2.223547] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'ssp2-port'
[    2.223621] intel_sst_acpi 80860F28:00: LPE base: 0x90a00000 size:0x200000
[    2.226965] intel_sst_acpi 80860F28:00: IRAM base: 0x90ac0000
[    2.230340] intel_sst_acpi 80860F28:00: DRAM base: 0x90b00000
[    2.233631] intel_sst_acpi 80860F28:00: SHIM base: 0x90b40000
[    2.236865] intel_sst_acpi 80860F28:00: Mailbox base: 0x90b44000
[    2.240034] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[    2.240884] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    2.240891] ACPI: Sleep Button [SLPB]
[    2.249534] intel_sst_acpi 80860F28:00: Got drv data max stream 25
[    2.253392] [Firmware Bug]: No valid trip found
[    2.256962] media: Linux media interface: v0.10
[    2.261504] wmi: Mapper loaded
[    2.266609] intel_sst_acpi 80860F28:00: Registered IRQ 0x6
[    2.266619] intel_sst_acpi 80860F28:00: Requesting FW intel/fw_sst_0f28.bin now...
[    2.267746] intel_sst_acpi 80860F28:00: registering device Intel(R) SST LPE
[    2.267792] intel_sst_acpi 80860F28:00: LPE is already in RESET state, No action
[    2.275168] intel_sst_acpi 80860F28:00: Enter
[    2.275177] intel_sst_acpi 80860F28:00: Request Fw completed
[    2.275486] intel_sst_acpi 80860F28:00: copied fw to ffff88007a900000
[    2.275493] intel_sst_acpi 80860F28:00: phys: 7a900000
[    2.275907] intel_sst_acpi 80860F28:00: Enter
[    2.275914] intel_sst_acpi 80860F28:00: header sign=$SST\xffffff86\xffffffdf	 size=9df86 modules=1 fmt=100 size=20
[    2.275920] intel_sst_acpi 80860F28:00: module sign $SSTr\xffffffdf	 size 9df72 blocks 13 type ffff
[    2.275925] intel_sst_acpi 80860F28:00: module entrypoint 0x0
[    2.278703] [drm] Initialized drm 1.1.0 20060810
[    2.278900] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    2.278903] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    2.293372] Linux video capture interface: v2.00
[    2.306515] ACPI: Battery Slot [BATC] (battery present)
[    2.346408] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    2.356216] rt5645 i2c-10EC5648:00: codec register i2c-10EC5648:00
[    2.356244] rt5645 i2c-10EC5648:00: ASoC: dai register i2c-10EC5648:00 #2
[    2.356251] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif1'
[    2.356257] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif2'
[    2.356263] rt5645 i2c-10EC5648:00: ASoC: Registered codec 'i2c-10EC5648:00'
[    2.378914] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (04f2:b483)
[    2.392617] cfg80211: Calling CRDA to update world regulatory domain
[    2.402518] input: USB2.0 VGA UVC WebCam as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/input/input4
[    2.405826] usbcore: registered new interface driver uvcvideo
[    2.409489] USB Video Class driver (1.1.1)
[    2.417281] SSE version of gcm_enc/dec engaged.
[    2.480445] Bluetooth: Core ver 2.20
[    2.483723] NET: Registered protocol family 31
[    2.486857] Bluetooth: HCI device and connection manager initialized
[    2.493490] Bluetooth: HCI socket layer initialized
[    2.497095] Bluetooth: L2CAP socket layer initialized
[    2.500650] Bluetooth: SCO socket layer initialized
[    2.509247] [drm] Memory usable by graphics device = 2048M
[    2.512242] checking generic (80000000 410000) vs hw (80000000 10000000)
[    2.512250] fb: switching to inteldrmfb from EFI VGA
[    2.515466] Console: switching to colour dummy device 80x25
[    2.518207] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    2.518382] [drm] Replacing VGA console driver
[    2.520674] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.522230] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.523796] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.526625] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.529055] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.529076] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.529082] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP1-Codec at idx 2
[    2.529385] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp2 Tx widget
[    2.529394] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp2 Rx widget
[    2.529401] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp1 Tx widget
[    2.529408] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp1 Rx widget
[    2.529415] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp0 Tx widget
[    2.529420] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp0 Rx widget
[    2.529426] sst-mfld-platform sst-mfld-platform: ASoC: adding Compress Playback widget
[    2.529433] sst-mfld-platform sst-mfld-platform: ASoC: adding Headset Playback widget
[    2.529439] sst-mfld-platform sst-mfld-platform: ASoC: adding Headset Capture widget
[    2.529498] snd-soc-dummy snd-soc-dummy: ASoC: adding Playback widget
[    2.529506] snd-soc-dummy snd-soc-dummy: ASoC: adding Capture widget
[    2.531155] asus_wmi: ASUS WMI generic driver loaded
[    2.533317] iTCO_vendor_support: vendor-support=0
[    2.534266] sst-mfld-platform sst-mfld-platform: widget type=22 name=codec_in0
[    2.534292] sst-mfld-platform sst-mfld-platform: widget type=22 name=codec_in1
[    2.534312] sst-mfld-platform sst-mfld-platform: widget type=23 name=codec_out0
[    2.534340] sst-mfld-platform sst-mfld-platform: widget type=23 name=codec_out1
[    2.534368] sst-mfld-platform sst-mfld-platform: widget type=6 name=media0_in
[    2.534385] sst-mfld-platform sst-mfld-platform: widget type=6 name=media1_in
[    2.534400] sst-mfld-platform sst-mfld-platform: widget type=6 name=media2_in
[    2.534415] sst-mfld-platform sst-mfld-platform: widget type=6 name=media3_in
[    2.534451] sst-mfld-platform sst-mfld-platform: widget type=6 name=media0_out
[    2.534471] sst-mfld-platform sst-mfld-platform: widget type=6 name=media1_out
[    2.534490] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm0_in
[    2.534505] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm1_in
[    2.534519] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm0_out
[    2.534541] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm1_out
[    2.534572] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm2_out
[    2.534596] sst-mfld-platform sst-mfld-platform: widget type=6 name=sprot_loop_in
[    2.534608] sst-mfld-platform sst-mfld-platform: widget type=6 name=media_loop1_in
[    2.534622] sst-mfld-platform sst-mfld-platform: widget type=6 name=media_loop2_in
[    2.534636] sst-mfld-platform sst-mfld-platform: widget type=6 name=sprot_loop_out
[    2.534661] sst-mfld-platform sst-mfld-platform: widget type=6 name=media_loop1_out
[    2.534697] sst-mfld-platform sst-mfld-platform: widget type=6 name=media_loop2_out
[    2.534727] sst-mfld-platform sst-mfld-platform: widget type=4 name=media0_out mix 0
[    2.534763] sst-mfld-platform sst-mfld-platform: widget type=4 name=media1_out mix 0
[    2.534783] sst-mfld-platform sst-mfld-platform: widget type=4 name=pcm0_out mix 0
[    2.534804] sst-mfld-platform sst-mfld-platform: widget type=4 name=pcm1_out mix 0
[    2.534827] sst-mfld-platform sst-mfld-platform: widget type=4 name=pcm2_out mix 0
[    2.534850] sst-mfld-platform sst-mfld-platform: widget type=4 name=sprot_loop_out mix 0
[    2.534875] sst-mfld-platform sst-mfld-platform: widget type=4 name=media_loop1_out mix 0
[    2.534905] sst-mfld-platform sst-mfld-platform: widget type=4 name=media_loop2_out mix 0
[    2.534934] sst-mfld-platform sst-mfld-platform: widget type=4 name=codec_out0 mix 0
[    2.534962] sst-mfld-platform sst-mfld-platform: widget type=4 name=codec_out1 mix 0
[    2.535181] rt5645 i2c-10EC5648:00: ASoC: adding AIF2 Playback widget
[    2.535192] rt5645 i2c-10EC5648:00: ASoC: adding AIF2 Capture widget
[    2.535199] rt5645 i2c-10EC5648:00: ASoC: adding AIF1 Playback widget
[    2.535205] rt5645 i2c-10EC5648:00: ASoC: adding AIF1 Capture widget
[    2.536951] asus_wmi: Initialization: 0x1
[    2.537106] asus_wmi: BIOS WMI version: 7.9
[    2.537375] asus_wmi: SFUN value: 0x37
[    2.540185] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late -2
[    2.540194] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late -2
[    2.540200] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late -2
[    2.540206] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late -1
[    2.540211] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late -1
[    2.540216] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late -1
[    2.540221] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late 0
[    2.540226] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late 0
[    2.540232] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late 0
[    2.540237] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late 1
[    2.540242] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late 1
[    2.540247] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late 1
[    2.540252] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late 2
[    2.540425] bytx205_rt5645 bytx205_rt5645: ASoC: registered pcm #0 Baytrail Audio (*)
[    2.540458] bytx205_rt5645 bytx205_rt5645: snd-soc-dummy-dai <-> media-cpu-dai mapping ok
[    2.540480] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late 2
[    2.540539] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai mapping ok
[    2.540555] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late 2
[    2.540635] bytx205_rt5645 bytx205_rt5645: ASoC: registered pcm #2 ((null))
[    2.540642] bytx205_rt5645 bytx205_rt5645: rt5645-aif1 <-> ssp1-port mapping ok
[    2.541070] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    2.541203] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3, TCOBASE=0x0460)
[    2.541602] rt5645 i2c-10EC5648:00: AIF2 Playback -> AIF2RX
[    2.541617] rt5645 i2c-10EC5648:00: AIF2TX -> AIF2 Capture
[    2.541626] rt5645 i2c-10EC5648:00: AIF1 Playback -> AIF1RX
[    2.541635] rt5645 i2c-10EC5648:00: AIF1TX -> AIF1 Capture
[    2.541644]  SSP1-Codec: connected DAI link sst-mfld-platform:ssp1 Tx -> i2c-10EC5648:00:AIF1 Playback
[    2.541649]  SSP1-Codec: connected DAI link i2c-10EC5648:00:AIF1 Capture -> sst-mfld-platform:ssp1 Rx
[    2.541778] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    2.546368] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input5
[    2.549984] intel_rapl: Found RAPL domain package
[    2.550004] intel_rapl: Found RAPL domain core
[    2.550559] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.550579] [drm] Driver supports precise vblank timestamp query.
[    2.550605] asus_wmi: Number of fans: 1
[    2.562665] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
[    2.571771] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
[    2.572129] input: PDEC3393:00 0B05:8585 as /devices/platform/80860F41:00/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001/input/input6
[    2.582969] hid-generic 0018:0B05:8585.0001: input,hidraw0: <UNKNOWN> HID v1.00 Keyboard [PDEC3393:00 0B05:8585] on 
[    2.603240] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
[    2.603874] usbcore: registered new interface driver brcmfmac
[    2.621326] random: nonblocking pool is initialized
[    2.629496] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.656020] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
[    2.662642] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
[    2.663158] input: ELAN0100:00 04F3:0401 as /devices/platform/80860F41:03/i2c-3/i2c-ELAN0100:00/0018:04F3:0401.0002/input/input7
[    2.663557] hid-generic 0018:04F3:0401.0002: input,hidraw1: <UNKNOWN> HID v1.00 Mouse [ELAN0100:00 04F3:0401] on 
[    2.669058] mousedev: PS/2 mouse device common for all mice
[    2.688871] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.689089] fbcon: inteldrmfb (fb0) is primary device
[    2.689295] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input8
[    2.689612] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02.0 on minor 0
[    3.812671] Console: switching to colour frame buffer device 170x48
[    3.823431] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.823434] i915 0000:00:02.0: registered panic notifier
[    4.785003] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
[    4.803337] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
[    4.904294] brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
[    4.904305] brcmfmac: brcmf_add_if: ignore IF event
[    5.542226] cfg80211: Calling CRDA to update world regulatory domain
[    5.812381] cfg80211: Calling CRDA to update world regulatory domain
[    6.827403] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.827413] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.827419] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.827424] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.827429]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.827433]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.827437]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.827442]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.827522] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.827783]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.827813]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.827818]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.827956]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.827975]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.828253]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.828261]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.828329]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.828361]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.828583]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.828589]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.828650]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.828697]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.828703]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.828710] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.828715] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.828722] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.829961] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.829970] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.829976] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.829981] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.829986]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.829990]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.829994]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.829998]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.830007] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.830260]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.830291]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.830296]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.830432]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.830451]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.830642]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.830648]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.830716]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.830742]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.830954]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.830960]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.831022]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.831068]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.831075]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.831083] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.831088] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.831094] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.837561] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.837571] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.837577] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.837582] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.837587]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.837591]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.837595]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.837599]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.837608] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.838129]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.838168]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.838176]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.838440]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.838481]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.838714]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.838722]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.838885]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.838931]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.839136]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.839143]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.839200]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.839240]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.839247]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.839254] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.839258] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.839265] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.840348] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.840356] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.840362] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.840367] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.840372]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.840376]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.840379]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.840383]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.840392] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.841255]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.841285]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.841290]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.841627]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.841670]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.841886]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.841892]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.842071]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.842116]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.842325]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.842331]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.842396]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.842441]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.842449]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.842457] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.842462] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.842469] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.846232] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.846242] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.846248] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.846253] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.846258]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.846263]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.846266]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.846270]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.846280] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.846528]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.846562]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.846567]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.846710]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.846730]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.846910]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.846915]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.846974]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.846994]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.847098]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.847103]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.847146]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.847191]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.847198]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.847205] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.847210] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.847216] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.847953] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.847962] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.847968] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.847972] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.847978]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.847981]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.847985]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.847989]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.848047] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.848317]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.848351]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.848356]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.848503]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.848529]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.848745]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.848750]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.848820]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.848843]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.849058]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.849064]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.849126]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.849171]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.849177]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.849184] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.849189] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.849196] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.849725] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.849734] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.849740] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.849745] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.849750]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.849754]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.849758]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.849762]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.849770] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.850274]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.850309]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.850314]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.850586]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.850626]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.850855]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.850862]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.851022]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.851067]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.851251]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.851257]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.851309]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.851409]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.851417]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.851427] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.851431] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.851439] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.852020] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.852030] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.852037] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.852043] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.852049]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.852053]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.852058]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.852062]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.852072] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.853057]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.853095]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.853101]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.853429]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.853477]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.853691]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.853697]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.853895]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.853947]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.854172]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.854179]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.854248]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.854295]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.854302]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.854310] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.854316] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.854323] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.855016] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[    6.855025]  Baytrail Audio Port: ASoC: found 0 audio playback paths
[    6.855030]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid playback route
[    6.855037]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.855042]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.855051] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.855189]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.855200]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.855206] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[    6.855211] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[    6.855216] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.855614] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[    6.855623]  Baytrail Audio Port: ASoC: found 0 audio playback paths
[    6.855627]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid playback route
[    6.855631]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.855636]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.855644] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.855775]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.855783]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.855789] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[    6.855794] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[    6.855799] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.856210] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[    6.856218]  Baytrail Audio Port: ASoC: found 0 audio playback paths
[    6.856223]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid playback route
[    6.856227]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.856231]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.856240] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.856422]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.856430]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.856436] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[    6.856441] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[    6.856447] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.856848] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[    6.856856]  Baytrail Audio Port: ASoC: found 0 audio playback paths
[    6.856861]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid playback route
[    6.856865]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.856869]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.856878] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.857452]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.857460]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.857467] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[    6.857472] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[    6.857477] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.857942] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[    6.857950]  Baytrail Audio Port: ASoC: found 0 audio playback paths
[    6.857954]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid playback route
[    6.857958]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.857962]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.857971] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.858275]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.858310]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.858316]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.858482]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.858504]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.858718]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.858725]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.858800]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.858827]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.859057]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.859064]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.859125]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.859171]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.859178]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.859186] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[    6.859191] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[    6.859199] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.859701] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[    6.859709]  Baytrail Audio Port: ASoC: found 0 audio playback paths
[    6.859714]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid playback route
[    6.859718]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.859723]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.859732] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.860023]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.860059]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.860065]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.860235]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.860258]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.860485]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.860497]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.860573]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.860599]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.860823]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.860830]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.860896]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.860936]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.860944]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.860952] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[    6.860957] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[    6.860964] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.861583] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[    6.861592]  Baytrail Audio Port: ASoC: found 0 audio playback paths
[    6.861597]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid playback route
... snip ...
[    7.192410]  Baytrail Audio Port: ASoC: found 0 audio playback paths
[    7.192415]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid playback route
[    7.192419]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    7.192423]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    7.192433] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    7.192955]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    7.192993]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    7.192999]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    7.193295]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    7.193339]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    7.193535]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    7.193541]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    7.193710]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    7.193758]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    7.193886]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    7.193892]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    7.193940]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    7.193986]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    7.193993]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    7.194002] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[    7.194007] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[    7.194014] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    7.194528] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[    7.194536]  Baytrail Audio Port: ASoC: found 0 audio playback paths
[    7.194541]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid playback route
[    7.194545]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    7.194550]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    7.194592] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    7.195526]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    7.195564]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    7.195570]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    7.195885]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    7.195930]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    7.196127]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    7.196133]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    7.196314]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    7.196363]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    7.196487]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    7.196493]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    7.196549]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    7.196597]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    7.196604]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    7.196613] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[    7.196618] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[    7.196624] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    8.698043] cfg80211: Calling CRDA to update world regulatory domain
[    9.498693] intel_sst_acpi 80860F28:00: LPE is already in RESET state, No action
[   11.844228] cfg80211: Calling CRDA to update world regulatory domain
[   11.857334]  Baytrail Audio Port: ASoC: pop wq checking: Playback status: inactive waiting: yes

So, still no sound but there are new things I can play with ^^

Here the patch:

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 sound/soc/codecs/rt5645.c             |   2 +
 sound/soc/intel/Kconfig               |  18 ++-
 sound/soc/intel/atom/sst/sst_acpi.c   |   2 +
 sound/soc/intel/boards/Makefile       |   2 +
 sound/soc/intel/boards/bytcr_rt5645.c | 224 ++++++++++++++++++++++++++++++++++
 5 files changed, 246 insertions(+), 2 deletions(-)
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
index 0000000..9890d7b
--- /dev/null
+++ b/sound/soc/intel/boards/bytcr_rt5645.c
@@ -0,0 +1,224 @@
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
+	{"IN1P", NULL, "Headset Mic"},
+	{"IN1N", NULL, "Headset Mic"},
+	{"DMIC L1", NULL, "Int Mic"},
+	{"DMIC R1", NULL, "Int Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Ext Spk", NULL, "SPOL"},
+	{"Ext Spk", NULL, "SPOR"},
+
+	{"AIF1 Playback", NULL, "ssp1 Tx"},
+	{"ssp1 Tx", NULL, "codec_out0"},
+	{"ssp1 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp1 Rx"},
+	{"codec_in1", NULL, "ssp1 Rx"},
+	{"ssp1 Rx", NULL, "AIF1 Capture"},
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
+	/* set SSP12to 24-bit */
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
+static struct snd_soc_ops byt_be_ssp1_ops = {
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
+		.name = "SSP1-Codec",
+		.be_id = 1,
+		.cpu_dai_name = "ssp1-port",
+		.platform_name = "sst-mfld-platform",
+		.no_pcm = 1,
+		.codec_dai_name = "rt5645-aif1",
+		.codec_name = "i2c-10EC5648:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+						| SND_SOC_DAIFMT_CBS_CFS,
+		.be_hw_params_fixup = byt_codec_fixup,
+		.ignore_suspend = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &byt_be_ssp1_ops,
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
2.4.4

Regards,
Michele
