From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Mon, 15 Jun 2015 18:46:23 +0200
Message-ID: <20150615164623.GA693@asus>
References: <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 38B5926520E
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 18:46:29 +0200 (CEST)
Received: by wgzl5 with SMTP id l5so48733313wgz.3
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 09:46:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20150613T153708-781@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luka Karinja <luka.karinja@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 13, 2015 at 01:47:13PM +0000, Luka Karinja wrote:
> Hey guys i have a T100TAF which also has z3735f & rt5648 and 
> watching your development.
> 
> On the T100TA wich has the Z3740 and rt5645 a new /var/lib/alsa/asound.state
> was needed to get the sound working.
> It was making cracking sounds without it (saw in your previous post)
> found here:
> https://raw.githubusercontent.com/AdamWill/baytrail-m/master/alsa/t100_B.state
> 
> Eagerly following the development

Eheh :)

So far no news, sadly.

I suspect I'm doing something really wrong, because if I play a song, besides
not having any sound, speed is about 15x the normal speed, but changing any 
value in byt_rt5645_hw_params function (below there is the patch I'm using), 
there are no differences at all.

Reading the Documentation/sound/alsa/soc/clocking.txt I found:
<< It is also desirable to use the codec (if possible) to drive (or master)
the audio clocks as it usually gives more accurate sample rates than the 
CPU. >>
so I tried to use a firmware that makes the DSP slave
(intel/fw_sst_0f28.bin-48kHz_i2s_slave).  Don't remember what happened
exactly but it did not work (and however the LPE is a dedicated core, so I 
think that accuracy it's not a problem here.. just a try :p )

The dmesg output does not seems too bad:
[    2.254284] ACPI: Sleep Button [SLPB]
[    2.280891] media: Linux media interface: v0.10
[    2.281022] [drm] Initialized drm 1.1.0 20060810
[    2.288058] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    2.292471] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    2.293277] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    2.313440] Linux video capture interface: v2.00
[    2.317755] ACPI: Battery Slot [BATC] (battery present)
[    2.360443] rt5645 i2c-10EC5648:00: codec register i2c-10EC5648:00
[    2.360462] rt5645 i2c-10EC5648:00: ASoC: dai register i2c-10EC5648:00 #2
[    2.360468] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif1'
[    2.360473] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif2'
[    2.360480] rt5645 i2c-10EC5648:00: ASoC: Registered codec 'i2c-10EC5648:00'
[    2.373770] SSE version of gcm_enc/dec engaged.
[    2.373984] cfg80211: Calling CRDA to update world regulatory domain
[    2.390936] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (04f2:b483)
[    2.401882] [drm] Memory usable by graphics device = 2048M
[    2.405169] checking generic (80000000 410000) vs hw (80000000 10000000)
[    2.405175] fb: switching to inteldrmfb from EFI VGA
[    2.405312] input: USB2.0 VGA UVC WebCam as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/input/input4
[    2.405391] usbcore: registered new interface driver uvcvideo
[    2.405392] USB Video Class driver (1.1.1)
[    2.418824] Console: switching to colour dummy device 80x25
[    2.419094] [drm] Replacing VGA console driver
[    2.421947] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.421965] [drm] Driver supports precise vblank timestamp query.
[    2.459144] Bluetooth: Core ver 2.20
[    2.459193] NET: Registered protocol family 31
[    2.459205] Bluetooth: HCI device and connection manager initialized
[    2.459222] Bluetooth: HCI socket layer initialized
[    2.459236] Bluetooth: L2CAP socket layer initialized
[    2.459258] Bluetooth: SCO socket layer initialized
[    2.464045] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    2.477942] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    2.477955] byt-rt5645 byt-rt5645: ASoC: CPU DAI Baytrail PCM not registered
[    2.498718] baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP IPC
[    2.498830] baytrail-pcm-audio baytrail-pcm-audio: initialising audio DSP id 0xf28
[    2.499138] baytrail-pcm-audio baytrail-pcm-audio: header sign=$SST\xffffffb4
 size=0x40db4 modules=0x1 fmt=0x100 size=32
[    2.499147] baytrail-pcm-audio baytrail-pcm-audio: block request 0x160 bytes at offset 0xc0000 type 0
[    2.499153] baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:0 at offset 0xc0000
[    2.499188] baytrail-pcm-audio baytrail-pcm-audio: block request 0x170 bytes at offset 0xc0400 type 0
[    2.499225] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0578 type 0
[    2.499231] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0598 type 0
[    2.499237] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05b8 type 0
[    2.499243] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05d8 type 0
[    2.499248] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05f8 type 0
[    2.499254] baytrail-pcm-audio baytrail-pcm-audio: block request 0x8 bytes at offset 0xc0618 type 0
[    2.499260] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0638 type 0
[    2.499266] baytrail-pcm-audio baytrail-pcm-audio: block request 0x30 bytes at offset 0xc0658 type 0
[    2.499272] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10438 bytes at offset 0xc06a0 type 0
[    2.499278] baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:1 at offset 0xc8000
[    2.499283] baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:2 at offset 0xd0000
[    2.500041] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    2.500053] byt-rt5645 byt-rt5645: ASoC: CPU DAI Baytrail PCM not registered
[    2.502006] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.506099] baytrail-pcm-audio baytrail-pcm-audio: block request 0x1a310 bytes at offset 0x1000000 type 3
[    2.507492] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.508573] baytrail-pcm-audio baytrail-pcm-audio: block request 0x5738 bytes at offset 0x100010 type 1
[    2.508584] baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:0 at offset 0x100000
[    2.509226] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.510984] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.512430] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10ad8 bytes at offset 0x105750 type 1
[    2.512442] baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:1 at offset 0x108000
[    2.512448] baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:2 at offset 0x110000
[    2.514053] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.526854] intel_rapl: Found RAPL domain package
[    2.526875] intel_rapl: Found RAPL domain core
[    2.527708] (NULL device *): ipc: DSP is ready 0x80000000002C2081
[    2.527805] (NULL device *): FW version: 04.05.13.a0
[    2.527821] (NULL device *): Build type: a0
[    2.527832] (NULL device *): Build date: Apr  2 2014 14:14:39
[    2.527847] baytrail-pcm-audio baytrail-pcm-audio: ASoC: platform register baytrail-pcm-audio
[    2.527874] baytrail-pcm-audio baytrail-pcm-audio: ASoC: Registered platform 'baytrail-pcm-audio'
[    2.527896] baytrail-pcm-audio baytrail-pcm-audio: ASoC: dai register baytrail-pcm-audio #2
[    2.527903] baytrail-pcm-audio baytrail-pcm-audio: ASoC: Registered DAI 'Baytrail PCM'
[    2.527908] baytrail-pcm-audio baytrail-pcm-audio: ASoC: Registered DAI 'Baytrail PCM fake'
[    2.527976] byt-rt5645 byt-rt5645: ASoC: binding Baytrail Audio at idx 0
[    2.528053] baytrail-pcm-audio baytrail-pcm-audio: ASoC: adding System Playback fake widget
[    2.528067] baytrail-pcm-audio baytrail-pcm-audio: ASoC: adding Analog Capture fake widget
[    2.528074] baytrail-pcm-audio baytrail-pcm-audio: ASoC: adding System Playback widget
[    2.528081] baytrail-pcm-audio baytrail-pcm-audio: ASoC: adding Analog Capture widget
[    2.528240] rt5645 i2c-10EC5648:00: ASoC: adding AIF2 Playback widget
[    2.528247] rt5645 i2c-10EC5648:00: ASoC: adding AIF2 Capture widget
[    2.528255] rt5645 i2c-10EC5648:00: ASoC: adding AIF1 Playback widget
[    2.528261] rt5645 i2c-10EC5648:00: ASoC: adding AIF1 Capture widget
[    2.534687] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late -2
[    2.534698] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late -1
[    2.534703] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late 0
[    2.534708] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late 1
[    2.534713] byt-rt5645 byt-rt5645: ASoC: probe byt-rt5645 dai link 0 late 2
[    2.535172] byt-rt5645 byt-rt5645: ASoC: registered pcm #0 System Playback rt5645-aif1-0
[    2.535266] byt-rt5645 byt-rt5645: rt5645-aif1 <-> Baytrail PCM mapping ok
[    2.535305] rt5645 i2c-10EC5648:00: AIF2 Playback -> AIF2RX
[    2.535315] rt5645 i2c-10EC5648:00: AIF2TX -> AIF2 Capture
[    2.535323] rt5645 i2c-10EC5648:00: AIF1 Playback -> AIF1RX
[    2.535331] rt5645 i2c-10EC5648:00: AIF1TX -> AIF1 Capture
[    2.535339]  Baytrail Audio: connected DAI link baytrail-pcm-audio:System Playback -> i2c-10EC5648:00:AIF1 Playback
[    2.535344]  Baytrail Audio: connected DAI link i2c-10EC5648:00:AIF1 Capture -> baytrail-pcm-audio:Analog Capture
[    2.537723] iTCO_vendor_support: vendor-support=0
[    2.541088] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    2.541211] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3, TCOBASE=0x0460)
[    2.544590] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    2.548865] asus_wmi: ASUS WMI generic driver loaded
[    2.550811] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
[    2.551504] asus_wmi: Initialization: 0x1
[    2.551634] asus_wmi: BIOS WMI version: 7.9
[    2.551833] asus_wmi: SFUN value: 0x37
[    2.556455] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input5
[    2.557489] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
[    2.558343] input: PDEC3393:00 0B05:8585 as /devices/platform/80860F41:00/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001/input/input6
[    2.567268] asus_wmi: Number of fans: 1
[    2.574317] hid-generic 0018:0B05:8585.0001: input,hidraw0: <UNKNOWN> HID v1.00 Keyboard [PDEC3393:00 0B05:8585] on 
[    2.574323] asus_wmi: Backlight controlled by ACPI video driver
[    2.580432] fbcon: inteldrmfb (fb0) is primary device
[    2.582430] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.582783] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
[    2.583053] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02.0 on minor 0
[    2.591292] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
[    2.591735] usbcore: registered new interface driver brcmfmac
[    2.613591] random: nonblocking pool is initialized
[    2.645650] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
[    2.652269] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
[    2.652458] input: ELAN0100:00 04F3:0401 as /devices/platform/80860F41:03/i2c-3/i2c-ELAN0100:00/0018:04F3:0401.0002/input/input8
[    2.653565] hid-generic 0018:04F3:0401.0002: input,hidraw1: <UNKNOWN> HID v1.00 Mouse [ELAN0100:00 04F3:0401] on 
[    2.665828] mousedev: PS/2 mouse device common for all mice
[    3.711100] Console: switching to colour frame buffer device 170x48
[    3.724631] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.724634] i915 0000:00:02.0: registered panic notifier
[    4.782027] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
[    4.796110] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
[    4.889020] brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
[    4.889042] brcmfmac: brcmf_add_if: ignore IF event
[    5.526484] cfg80211: Calling CRDA to update world regulatory domain
[    5.777199] cfg80211: Calling CRDA to update world regulatory domain
[    6.675788]  Baytrail Audio: PCM: open
[    6.675800] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.675804] ASoC: rate mask 0x80
[    6.675807] ASoC: min ch 2 max ch 2
[    6.675810] ASoC: min rate 48000 max rate 48000
[    6.675929]  Baytrail Audio: PCM: hw_free
[    6.675934]  Baytrail Audio: PCM: close
[    6.676601]  Baytrail Audio: PCM: open
[    6.676609] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.676613] ASoC: rate mask 0x80
[    6.676616] ASoC: min ch 2 max ch 2
[    6.676619] ASoC: min rate 48000 max rate 48000
[    6.676711]  Baytrail Audio: PCM: hw_free
[    6.676716]  Baytrail Audio: PCM: close
[    6.678300]  Baytrail Audio: PCM: open
[    6.678311] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.678315] ASoC: rate mask 0x80
[    6.678318] ASoC: min ch 2 max ch 2
[    6.678321] ASoC: min rate 48000 max rate 48000
[    6.678490]  Baytrail Audio: PCM: hw_free
[    6.678495]  Baytrail Audio: PCM: close
[    6.679014]  Baytrail Audio: PCM: open
[    6.679022] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.679025] ASoC: rate mask 0x80
[    6.679028] ASoC: min ch 2 max ch 2
[    6.679031] ASoC: min rate 48000 max rate 48000
[    6.679540]  Baytrail Audio: PCM: hw_free
[    6.679546]  Baytrail Audio: PCM: close
[    6.684538]  Baytrail Audio: PCM: open
[    6.684550] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.684553] ASoC: rate mask 0x80
[    6.684556] ASoC: min ch 2 max ch 2
[    6.684560] ASoC: min rate 48000 max rate 48000
[    6.711668] rt5645 i2c-10EC5648:00: Sysclk is 12288000Hz and clock id is 1
[    6.722266] rt5645 i2c-10EC5648:00: bypass=1 m=0 n=30 k=6
[    6.735720] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[    6.735731] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 0 for iis 0
[    6.743663]  Baytrail Audio: PCM: hw_params, pcm_data ffff880037a58780
[    6.782949]  Baytrail Audio: PCM: hw_free
[    6.782990]  Baytrail Audio: PCM: hw_free
[    6.782997]  Baytrail Audio: PCM: close
[    6.784766]  Baytrail Audio: PCM: open
[    6.784777] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.784781] ASoC: rate mask 0x80
[    6.784785] ASoC: min ch 2 max ch 2
[    6.784788] ASoC: min rate 48000 max rate 48000
[    6.784903]  Baytrail Audio: PCM: hw_free
[    6.784908]  Baytrail Audio: PCM: close
[    6.785140]  Baytrail Audio: PCM: open
[    6.785147] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.785151] ASoC: rate mask 0x80
[    6.785154] ASoC: min ch 2 max ch 2
[    6.785158] ASoC: min rate 48000 max rate 48000
[    6.785250]  Baytrail Audio: PCM: hw_free
[    6.785256]  Baytrail Audio: PCM: close
[    6.785505]  Baytrail Audio: PCM: open
[    6.785513] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.785517] ASoC: rate mask 0x80
[    6.785521] ASoC: min ch 2 max ch 2
[    6.785524] ASoC: min rate 48000 max rate 48000
[    6.785679]  Baytrail Audio: PCM: hw_free
[    6.785685]  Baytrail Audio: PCM: close
[    6.785935]  Baytrail Audio: PCM: open
[    6.785943] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.785946] ASoC: rate mask 0x80
[    6.785950] ASoC: min ch 2 max ch 2
[    6.785953] ASoC: min rate 48000 max rate 48000
[    6.786536]  Baytrail Audio: PCM: hw_free
[    6.786542]  Baytrail Audio: PCM: close
[    6.786862]  Baytrail Audio: PCM: open
[    6.786870] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.786873] ASoC: rate mask 0x80
[    6.786876] ASoC: min ch 2 max ch 2
[    6.786879] ASoC: min rate 48000 max rate 48000
[    6.786980] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[    6.786988] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 0 for iis 0
[    6.786996]  Baytrail Audio: PCM: hw_params, pcm_data ffff880037a58720
[    6.814677]  Baytrail Audio: PCM: open
[    6.814690] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.814694] ASoC: rate mask 0x80
[    6.814697] ASoC: min ch 2 max ch 2
[    6.814700] ASoC: min rate 48000 max rate 48000
[    6.814820] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[    6.814825] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 0 for iis 0
[    6.814833]  Baytrail Audio: PCM: hw_params, pcm_data ffff880037a58780
[    6.816382]  Baytrail Audio: PCM: hw_free
[    6.816423]  Baytrail Audio: PCM: hw_free
[    6.816430]  Baytrail Audio: PCM: close
[    6.816931]  Baytrail Audio: PCM: hw_free
[    6.816956]  Baytrail Audio: PCM: hw_free
[    6.816961]  Baytrail Audio: PCM: close
[    6.824756]  Baytrail Audio: PCM: open
[    6.824771] ASoC: rt5645-aif1 <-> Baytrail PCM info:
[    6.824776] ASoC: rate mask 0x80
[    6.824780] ASoC: min ch 2 max ch 2
[    6.824784] ASoC: min rate 48000 max rate 48000
[    6.824934] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[    6.824942] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 0 for iis 0
[    6.824953]  Baytrail Audio: PCM: hw_params, pcm_data ffff880037a58720
[    6.825298]  Baytrail Audio: PCM: mmap
[    6.852871]  Baytrail Audio: PCM: trigger 1
[    8.676099] cfg80211: Calling CRDA to update world regulatory domain
[   11.843261] cfg80211: Calling CRDA to update world regulatory domain
[   11.875548]  Baytrail Audio: PCM: trigger 0
[   11.875608]  Baytrail Audio: PCM: hw_free
[   11.875643]  Baytrail Audio: PCM: hw_free
[   11.875650]  Baytrail Audio: PCM: close
[   14.991784] cfg80211: Calling CRDA to update world regulatory domain
[   16.878036]  Baytrail Audio: ASoC: pop wq checking: AIF1 Playback status: inactive waiting: yes


So, well, for now I'm only trying to understand the ASoC 
design/implementation...

Regards,
Michele




Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 sound/soc/codecs/rt5645.c                   |   2 +
 sound/soc/intel/Kconfig                     |   9 ++
 sound/soc/intel/baytrail/sst-baytrail-pcm.c |  18 ++++
 sound/soc/intel/boards/Makefile             |   2 +
 sound/soc/intel/boards/byt-rt5645.c         | 128 ++++++++++++++++++++++++++++
 sound/soc/intel/common/sst-acpi.c           |   3 +-
 6 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/boards/byt-rt5645.c

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index dd0f86e..2ab4df3 100644
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
index 791953f..886c833 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -65,6 +65,15 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 	  This adds audio driver for Intel Baytrail platform based boards
 	  with the RT5640 audio codec.
 
+config SND_SOC_INTEL_BYT_RT5645_MACH
+	tristate "ASoC Audio driver for Intel Baytrail with RT5645 codec"
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
+	select SND_SOC_INTEL_BAYTRAIL
+	select SND_SOC_RT5645
+	help
+	  This adds audio driver for Intel Baytrail platform based boards
+	  with the RT5645 audio codec.
+
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 79547be..04a11cf 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -364,6 +364,24 @@ static struct snd_soc_dai_driver byt_dais[] = {
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
 	},
+	{
+		.name  = "Baytrail PCM fake",
+		.playback = {
+			.stream_name = "System Playback fake",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S24_3LE |
+				   SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			.stream_name = "Analog Capture fake",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+	},
 };
 
 static int sst_byt_pcm_probe(struct snd_soc_platform *platform)
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index cb94895..24685c5 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -1,5 +1,6 @@
 snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
+snd-soc-sst-byt-rt5645-mach-objs := byt-rt5645.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
@@ -9,6 +10,7 @@ snd-soc-sst-cht-bsw-max98090_ti-objs := cht_bsw_max98090_ti.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
+obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5645_MACH) += snd-soc-sst-byt-rt5645-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
diff --git a/sound/soc/intel/boards/byt-rt5645.c b/sound/soc/intel/boards/byt-rt5645.c
new file mode 100644
index 0000000..c29d22d
--- /dev/null
+++ b/sound/soc/intel/boards/byt-rt5645.c
@@ -0,0 +1,128 @@
+/*
+ * Intel Baytrail SST RT5645 machine driver
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include "../../codecs/rt5645.h"
+
+#include "../common/sst-dsp.h"
+
+static const struct snd_soc_dapm_widget byt_rt5645_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_audio_map[] = {
+	{"IN1P", NULL, "Internal Mic"},
+	{"IN2P", NULL, "Headset Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Speaker", NULL, "SPOL"},
+	{"Speaker", NULL, "SPOR"},
+};
+
+static const struct snd_kcontrol_new byt_rt5645_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+};
+
+static int byt_rt5645_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5645_SCLK_S_PLL1,
+				     params_rate(params) * 256,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set codec clock %d\n", ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5645_PLL1_S_BCLK1,
+				  params_rate(params) * 64,
+				  params_rate(params) * 256);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static struct snd_soc_ops byt_rt5645_ops = {
+	.hw_params = byt_rt5645_hw_params,
+};
+
+static struct snd_soc_dai_link byt_rt5645_dais[] = {
+	{
+		.name = "Baytrail Audio",
+		.stream_name = "System Playback",
+		.cpu_dai_name = "Baytrail PCM",
+		.codec_dai_name = "rt5645-aif1",
+		.codec_name = "i2c-10EC5648:00",
+		.platform_name = "baytrail-pcm-audio",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBS_CFS,
+		.ops = &byt_rt5645_ops,
+	},
+};
+
+static struct snd_soc_card byt_rt5645_card = {
+	.name = "byt-rt5645",
+	.dai_link = byt_rt5645_dais,
+	.num_links = ARRAY_SIZE(byt_rt5645_dais),
+	.dapm_widgets = byt_rt5645_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_rt5645_widgets),
+	.dapm_routes = byt_rt5645_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_rt5645_audio_map),
+	.controls = byt_rt5645_controls,
+	.num_controls = ARRAY_SIZE(byt_rt5645_controls),
+	.fully_routed = true,
+};
+
+static int byt_rt5645_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &byt_rt5645_card;
+
+	card->dev = &pdev->dev;
+	return devm_snd_soc_register_card(&pdev->dev, card);
+}
+
+static struct platform_driver byt_rt5645_audio = {
+	.probe = byt_rt5645_probe,
+	.driver = {
+		.name = "byt-rt5645",
+		.pm = &snd_soc_pm_ops,
+	},
+};
+module_platform_driver(byt_rt5645_audio)
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail Machine driver");
+MODULE_AUTHOR("Omair Md Abdullah, Jarkko Nikula");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:byt-rt5645");
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 42f293f..945af95 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -248,6 +248,7 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 
 static struct sst_acpi_mach baytrail_machines[] = {
 	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
+	{ "10EC5648", "byt-rt5645", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
 	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
 	{}
 };
@@ -258,7 +259,7 @@ static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 	.resindex_lpe_base = 0,
 	.resindex_pcicfg_base = 1,
 	.resindex_fw_base = 2,
-	.irqindex_host_ipc = 5,
+	.irqindex_host_ipc = 0,
 	.sst_id = SST_DEV_ID_BYT,
 	.resindex_dma_base = -1,
 };
-- 
2.4.3
