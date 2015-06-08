From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Mon, 8 Jun 2015 10:49:51 +0200
Message-ID: <20150608084951.GA7512@dellaz>
References: <20150527085440.GA4445@dellaz> <1432752116.8235.25.camel@loki>
 <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 4211726057A
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 10:49:57 +0200 (CEST)
Received: by wiga1 with SMTP id a1so78126750wig.0
 for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2015 01:49:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1433156768.2642.21.camel@loki>
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
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, "Nikula, Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 01, 2015 at 12:06:08PM +0100, Liam Girdwood wrote:
> On Fri, 2015-05-29 at 15:17 +0200, Michele Curti wrote:
> > On Fri, May 29, 2015 at 10:42:01AM +0100, Liam Girdwood wrote:
> > > On Thu, 2015-05-28 at 21:17 +0200, Michele Curti wrote:
> > > 
> > > This is confusing as we can see messages about the baytrail-pcm-audio
> > > device not being registered and then valid messages from said device ?
> > > I'm wondering if you have created 2 baytrail-pcm-audio devices ? The
> > > ordering is also confusing since the block allocation should come before
> > > the DSP boot....
> > > 
> > > Can you paste the diff for all the audio changes you have made and also
> > > the output of lsmod when this happens.
> > >
> > 
> > Sure, sorry for the number of attachments.. :p
> 
> Ok, I can see something that might be causing the potential double
> registration of the PCM driver. Can you change the cpu_dai_name in your
> machine driver to "Baytrail PCM".
> 
> Liam
>

For those who are following the discussion, this change does not work 
"as is".

For what I understood, the baytrail-pcm-audio probe function calls
snd_soc_register_component() which calls snd_soc_register_dais() with
legacy_dai_naming to true, so (having only one dai) the dai name is
overridden:

	/*
	 * Back in the old days when we still had component-less DAIs,
	 * instead of having a static name, component-less DAIs would
	 * inherit the name of the parent device so it is possible to
	 * register multiple instances of the DAI. We still need to
	 * keep
	 * the same naming style even though those DAIs are not
	 * component-less anymore.
	 */
	if (count == 1 && legacy_dai_naming &&
		(dai_drv[i].id == 0 || dai_drv[i].name == NULL)) {
		dai->name = fmt_single_name(dev, &dai->id);
	} else {


So, for my tests I added in sound/soc/intel/baytrail/sst-baytrail-pcm.c
a "Baytrail PCM fake" dai to the byt_dais[] list.

Plus the change in sst_acpi_baytrail_desc:

-       .irqindex_host_ipc = 5,
+       .irqindex_host_ipc = 0,

plus the v3 patch series from Bard:
  http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093237.html
  http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093239.html
  http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093238.html

now the sound card shows up:

  [zio@asus ~]$ aplay -l
  **** List of PLAYBACK Hardware Devices ****
  card 0: bytrt5645 [byt-rt5645], device 0: Audio rt5645-aif1-0 []
    Subdevices: 1/1
    Subdevice #0: subdevice #0

Still no sound and still some errors but things are much better, I 
think.  Thank you ^^

[    1.363551] snd-soc-dummy snd-soc-dummy: codec register snd-soc-dummy
[    1.363565] snd-soc-dummy snd-soc-dummy: ASoC: dai register snd-soc-dummy #1
[    1.363571] snd-soc-dummy snd-soc-dummy: ASoC: Registered DAI 'snd-soc-dummy-dai'
[    1.363577] snd-soc-dummy snd-soc-dummy: ASoC: Registered codec 'snd-soc-dummy'
[    1.363582] snd-soc-dummy snd-soc-dummy: ASoC: platform register snd-soc-dummy
[    1.363589] snd-soc-dummy snd-soc-dummy: ASoC: Registered platform 'snd-soc-dummy'
[    1.365877] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    1.366565] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[    1.379441] ACPI: AC Adapter [ADP1] (off-line)
[    1.379869] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    1.379918] ACPI: Lid Switch [LID]
[    1.380061] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.380414] ACPI: Power Button [PWRB]
[    1.380553] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.380561] ACPI: Sleep Button [SLPB]
[    1.394613] [Firmware Bug]: No valid trip found
[    1.406949] wmi: Mapper loaded
[    1.439237] [drm] Memory usable by graphics device = 2048M
[    1.439247] checking generic (80000000 410000) vs hw (80000000 10000000)
[    1.439251] fb: switching to inteldrmfb from EFI VGA
[    1.439293] Console: switching to colour dummy device 80x25
[    1.439465] [drm] Replacing VGA console driver
[    1.442903] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.442910] [drm] Driver supports precise vblank timestamp query.
[    1.475607] systemd[1]: Found device /dev/mmcblk0p1.
[    1.481509] systemd[1]: Starting File System Check on /dev/mmcblk0p1...
[    1.484268] cfg80211: Calling CRDA to update world regulatory domain
[    1.495323] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x13303f810e3, max_idle_ns: 440795235405 ns
[    1.495364] Switched to clocksource tsc
[    1.498831] ACPI: Battery Slot [BATC] (battery present)
[    1.504688] rt5645 i2c-10EC5648:00: codec register i2c-10EC5648:00
[    1.504708] rt5645 i2c-10EC5648:00: ASoC: dai register i2c-10EC5648:00 #2
[    1.504714] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif1'
[    1.504719] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif2'
[    1.504726] rt5645 i2c-10EC5648:00: ASoC: Registered codec 'i2c-10EC5648:00'
[    1.536943] systemd[1]: Device dev-disk-by\x2dpath-platform\x2d80860F14:00.device appeared twice with different sysfs paths /sys/devices/platform/80860F14:00/mmc_host/mmc0/mmc0:0001/block/mmcblk0 and /sys/devices/platform/80860F14:00/mmc_host/mmc0/mmc0:0001/block/mmcblk0/mmcblk0boot0
[    1.544175] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    1.552408] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.566639] systemd[1]: Started Journal Service.
[    1.579262] SSE version of gcm_enc/dec engaged.
[    1.586247] systemd-journald[125]: Received request to flush runtime journal from PID 1
[    1.588588] Bluetooth: Core ver 2.20
[    1.588620] NET: Registered protocol family 31
[    1.588625] Bluetooth: HCI device and connection manager initialized
[    1.588634] Bluetooth: HCI socket layer initialized
[    1.588641] Bluetooth: L2CAP socket layer initialized
[    1.588656] Bluetooth: SCO socket layer initialized
[    1.592010] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    1.593942] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    1.596148] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    1.598907] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    1.608142] fbcon: inteldrmfb (fb0) is primary device
[    1.608167] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.608570] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    1.608673] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02.0 on minor 0
[    1.669289] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
[    1.669770] usbcore: registered new interface driver brcmfmac
[    1.678085] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    1.678090] byt-rt5645 byt-rt5645: ASoC: CPU DAI Baytrail PCM not registered
[    1.678357] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    1.678895] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    1.678901] byt-rt5645 byt-rt5645: ASoC: CPU DAI Baytrail PCM not registered
[    1.706686] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
[    1.709071] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
[    1.709590] input: PDEC3393:00 0B05:8585 as /devices/platform/80860F41:00/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001/input/input5
[    1.719078] hid-generic 0018:0B05:8585.0001: input,hidraw0: <UNKNOWN> HID v1.00 Keyboard [PDEC3393:00 0B05:8585] on 
[    1.719141] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    1.719148] byt-rt5645 byt-rt5645: ASoC: CPU DAI Baytrail PCM not registered
[    1.720825] random: nonblocking pool is initialized
[    1.768716] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[    1.787905] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
[    1.795383] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
[    1.795560] input: ELAN0100:00 04F3:0401 as /devices/platform/80860F41:03/i2c-3/i2c-ELAN0100:00/0018:04F3:0401.0002/input/input6
[    1.795797] hid-generic 0018:04F3:0401.0002: input,hidraw1: <UNKNOWN> HID v1.00 Mouse [ELAN0100:00 04F3:0401] on 
[    1.795856] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    1.795862] byt-rt5645 byt-rt5645: ASoC: CPU DAI Baytrail PCM not registered
[    1.874048] iTCO_vendor_support: vendor-support=0
[    1.936609] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    1.936784] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3, TCOBASE=0x0460)
[    1.937431] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    1.937513] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    1.937519] byt-rt5645 byt-rt5645: ASoC: CPU DAI Baytrail PCM not registered
[    1.950239] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    1.950246] byt-rt5645 byt-rt5645: ASoC: CPU DAI Baytrail PCM not registered
[    1.982952] (NULL device *): FW version: 04.05.13.a0
[    1.982954] (NULL device *): Build type: a0
[    1.982956] (NULL device *): Build date: Apr  2 2014 14:14:39
[    1.982957] sst_byt_pcm_dev_probe: dsp init OK
[    1.982973] baytrail-pcm-audio baytrail-pcm-audio: ASoC: platform register baytrail-pcm-audio
[    1.982992] baytrail-pcm-audio baytrail-pcm-audio: ASoC: Registered platform 'baytrail-pcm-audio'
[    1.982993] sst_byt_pcm_dev_probe: register platform OK
[    1.982998] baytrail-pcm-audio baytrail-pcm-audio: ASoC: dai register baytrail-pcm-audio #2
[    1.983011] baytrail-pcm-audio baytrail-pcm-audio: ASoC: Registered DAI 'Baytrail PCM'
[    1.983015] baytrail-pcm-audio baytrail-pcm-audio: ASoC: Registered DAI 'Baytrail PCM fake'
[    1.983016] sst_byt_pcm_dev_probe: register componet OK
[    1.983084] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    1.989205] sst_byt_pcm_probe
[    1.989212] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late -2
[    1.989216] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late -1
[    1.989219] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late 0
[    1.989222] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late 1
[    1.989225] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late 2
[    1.989389] byt-rt5645 byt-rt5645: rt5645-aif1 <-> Baytrail PCM mapping ok

wow :p

[    1.989451] baytrail-pcm-audio baytrail-pcm-audio: ASoC: Failed to create System Playback debugfs file
[    1.989455] baytrail-pcm-audio baytrail-pcm-audio: ASoC: Failed to create Analog Capture debugfs file
[    1.989804] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC1 Swap Mux has no paths
[    1.989809] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC2 Swap Mux has no paths
[    1.989814] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC3 Swap Mux has no paths
[    1.989819] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC Mux has no paths
[    1.989872] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC1 L Mux has no paths
[    1.989877] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC1 R Mux has no paths
[    1.989882] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC2 L Mux has no paths
[    1.989887] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC2 R Mux has no paths
[    1.996722] media: Linux media interface: v0.10
[    2.003447] mousedev: PS/2 mouse device common for all mice
[    2.017078] Linux video capture interface: v2.00
[    2.028150] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (04f2:b483)
[    2.035335] input: USB2.0 VGA UVC WebCam as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/input/input7
[    2.035578] usbcore: registered new interface driver uvcvideo
[    2.035579] USB Video Class driver (1.1.1)
[    2.062423] asus_wmi: ASUS WMI generic driver loaded
[    2.096618] asus_wmi: Initialization: 0x1
[    2.096737] asus_wmi: BIOS WMI version: 7.9
[    2.096819] asus_wmi: SFUN value: 0x37
[    2.099422] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input8
[    2.101983] asus_wmi: Number of fans: 1
[    2.109834] asus_wmi: Backlight controlled by ACPI video driver
[    2.117818] intel_rapl: Found RAPL domain package
[    2.117823] intel_rapl: Found RAPL domain core
[    2.735378] Console: switching to colour frame buffer device 170x48
[    2.751890] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    2.751896] i915 0000:00:02.0: registered panic notifier
[    3.867748] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
[    3.881956] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
[    3.978214] brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
[    3.978226] brcmfmac: brcmf_add_if: ignore IF event
[    4.631189] cfg80211: Calling CRDA to update world regulatory domain
[    5.570120]  Baytrail Audio: PCM: open
[    5.570247]  Baytrail Audio: PCM: hw_free
[    5.570253]  Baytrail Audio: PCM: close
[    5.570761]  Baytrail Audio: PCM: open
[    5.570910]  Baytrail Audio: PCM: hw_free
[    5.570916]  Baytrail Audio: PCM: close
[    5.572642]  Baytrail Audio: PCM: open
[    5.572798]  Baytrail Audio: PCM: hw_free
[    5.572805]  Baytrail Audio: PCM: close
[    5.573153]  Baytrail Audio: PCM: open
[    5.573705]  Baytrail Audio: PCM: hw_free
[    5.573711]  Baytrail Audio: PCM: close
[    5.578257]  Baytrail Audio: PCM: open
[    5.578636] rt5645 i2c-10EC5648:00: bypass=0 m=15 n=85 k=2
[    5.619235] rt5645 i2c-10EC5648:00: Sysclk is 24576000Hz and clock id is 1
[    5.619266] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[    5.619275] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 1 for iis 0
[    5.624380]  Baytrail Audio: PCM: hw_params, pcm_data ffff880037a03380
[    5.667105]  Baytrail Audio: PCM: hw_free
[    5.667152]  Baytrail Audio: PCM: hw_free
[    5.667159]  Baytrail Audio: PCM: close
[    5.669219]  Baytrail Audio: PCM: open
[    5.669364]  Baytrail Audio: PCM: hw_free
[    5.669372]  Baytrail Audio: PCM: close
[    5.669649]  Baytrail Audio: PCM: open
[    5.669763]  Baytrail Audio: PCM: hw_free
[    5.669770]  Baytrail Audio: PCM: close
[    5.670063]  Baytrail Audio: PCM: open
[    5.670249]  Baytrail Audio: PCM: hw_free
[    5.670256]  Baytrail Audio: PCM: close
[    5.670553]  Baytrail Audio: PCM: open
[    5.671232]  Baytrail Audio: PCM: hw_free
[    5.671240]  Baytrail Audio: PCM: close
[    5.671640]  Baytrail Audio: PCM: open
[    5.671783] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[    5.671793] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 1 for iis 0
[    5.671804]  Baytrail Audio: PCM: hw_params, pcm_data ffff880037a03320
[    5.711536]  Baytrail Audio: PCM: open
[    5.711696] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[    5.711704] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 1 for iis 0
[    5.711714]  Baytrail Audio: PCM: hw_params, pcm_data ffff880037a03380
[    5.713969]  Baytrail Audio: PCM: hw_free
[    5.714017]  Baytrail Audio: PCM: hw_free
[    5.714024]  Baytrail Audio: PCM: close
[    5.715293]  Baytrail Audio: PCM: hw_free
[    5.715344]  Baytrail Audio: PCM: hw_free
[    5.715352]  Baytrail Audio: PCM: close
[    5.725955]  Baytrail Audio: PCM: open
[    5.726109] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[    5.726117] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 1 for iis 0
[    5.726128]  Baytrail Audio: PCM: hw_params, pcm_data ffff880037a03320
[    5.727565]  Baytrail Audio: PCM: mmap
[    5.750790]  Baytrail Audio: PCM: trigger 1
[    5.750820]  Baytrail Audio: PCM: DMA pointer 0 bytes
[    5.752840]  Baytrail Audio: PCM: DMA pointer 0 bytes
[    5.752863]  Baytrail Audio: PCM: DMA pointer 0 bytes
[    5.753019]  Baytrail Audio: PCM: App/DMA pointer 0/3072 bytes
[    5.753043]  Baytrail Audio: PCM: DMA pointer 3072 bytes
[    5.753081]  Baytrail Audio: PCM: DMA pointer 3072 bytes
[    5.753089]  Baytrail Audio: PCM: App/DMA pointer 0/3072 bytes
[    5.753096]  Baytrail Audio: PCM: DMA pointer 3072 bytes
