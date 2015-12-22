From: Luka Karinja <luka.karinja@gmail.com>
Subject: Re: [PATCH 18/19] ASoC: Intel: Atom: add support for
	RT5642
Date: Tue, 22 Dec 2015 18:48:44 +0100
Message-ID: <56798CFC.7040909@gmail.com>
References: <5679871B.1050200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id EEBC626592E
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 18:48:47 +0100 (CET)
Received: by mail-wm0-f48.google.com with SMTP id p187so117439363wmp.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 09:48:47 -0800 (PST)
In-Reply-To: <5679871B.1050200@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> The machine driver is not loaded when the BIOS uses the 10EC5642
> _HID. Add it to the white list of known _HIDs, codec_name is
> already taken care of by previous commit
>
> Tested on Asus T100TAF.
>

I'm trying to get sound working on my T100TAF i did apply all the 19 patches
on top of broonie/sound and added UCM files to my system.
Does the TAF need different UCM file than the T100TA?

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: bytcrrt5640 [bytcr-rt5640], device 0: Baytrail Audio (*) []
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: bytcrrt5640 [bytcr-rt5640], device 1: Deep-Buffer Audio (*) []
   Subdevices: 1/1
   Subdevice #0: subdevice #0

dmesg:

[    5.209239] Adding 1049596k swap on /dev/mmcblk0p4.  Priority:-1 
extents:1 across:1049596k SSFS
[    5.219099] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    5.273802] i2c i2c-10: Added multiplexed i2c bus 13
[    5.274629] intel_sst_acpi 80860F28:00: LPE base: 0x50a00000 
size:0x200000
[    5.274638] intel_sst_acpi 80860F28:00: IRAM base: 0x50ac0000
[    5.274671] intel_sst_acpi 80860F28:00: DRAM base: 0x50b00000
[    5.274685] intel_sst_acpi 80860F28:00: SHIM base: 0x50b40000
[    5.274700] intel_sst_acpi 80860F28:00: Mailbox base: 0x50b44000
[    5.274712] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[    5.274842] intel_sst_acpi 80860F28:00: Got drv data max stream 25
[    5.290156] Error: Driver 'pcspkr' is already registered, aborting...
[    5.311924] random: nonblocking pool is initialized
[    5.397912] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data 
mode. Opts: data=ordered
[    5.506882] genirq: Flags mismatch irq 8. 00000083 (volume_down) vs. 
00000000 (rtc0)
[    5.507025] gpio-keys gpio-keys.0.auto: Unable to claim irq 8; error -16
[    5.507283] gpio-keys: probe of gpio-keys.0.auto failed with error -16
[    5.507518] input: gpio-keys as 
/devices/platform/gpio-keys.1.auto/input/input8
[    5.519513] iTCO_vendor_support: vendor-support=0
[    5.591021] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    5.591153] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3, 
TCOBASE=0x0460)
[    5.604447] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    5.613586] bytcr_rt5640 bytcr_rt5640: snd-soc-dummy-dai <-> 
media-cpu-dai mapping ok
[    5.613794] bytcr_rt5640 bytcr_rt5640: snd-soc-dummy-dai <-> 
deepbuffer-cpu-dai mapping ok
[    5.613922] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai 
mapping ok
[    5.615555] bytcr_rt5640 bytcr_rt5640: rt5640-aif1 <-> ssp2-port 
mapping ok
[    5.642183] asus_wmi: ASUS WMI generic driver loaded
[    5.663786] usbcore: registered new interface driver usbmouse
[    5.665362] usbcore: registered new interface driver usbkbd
[    5.681990] asus_wmi: Initialization: 0x1
[    5.682121] asus_wmi: BIOS WMI version: 7.9
[    5.682219] asus_wmi: SFUN value: 0x37
[    5.685337] input: Asus WMI hotkeys as 
/devices/platform/asus-nb-wmi/input/input9
[    5.708007] asus_wmi: Number of fans: 1
[    5.801413] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[    5.801529] input: SIS0817:00 0457:1071 as 
/devices/platform/80860F41:03/i2c-11/i2c-SIS0817:00/0018:0457:1071.0004/input/input10
[    5.802167] hid-multitouch 0018:0457:1071.0004: input,hidraw3: I2C 
HID v1.00 Device [SIS0817:00 0457:1071] on i2c-SIS0817:00
[    5.816775] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[    5.816996] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[    5.817204] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[    5.817405] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    5.817616] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    5.818884] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    5.819109] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
[    5.911351] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[    5.911578] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[    5.911787] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[    5.911997] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[    5.912201] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    5.912417] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    5.912634] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    5.915142] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
[    6.042680] intel_rapl: Found RAPL domain package
[    6.042692] intel_rapl: Found RAPL domain core
[    6.247467] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.247489] Bluetooth: BNEP filters: protocol multicast
[    6.247515] Bluetooth: BNEP socket layer initialized
[    7.524852] brcmf_sdio_drivestrengthinit: No SDIO Drive strength init 
done for chip 43340 rev 2 pmurev 20
[    7.525341] usbcore: registered new interface driver brcmfmac
[    7.722004] brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 
2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
[    7.739335] brcmf_cfg80211_reg_notifier: not a ISO3166 code
[    7.899345] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    7.921532] audit: type=1006 audit(1450805770.516:2): pid=1018 uid=0 
old-auid=4294967295 auid=1000 old-ses=4294967295 ses=1 res=1
[    7.984230] audit: type=1006 audit(1450805770.580:3): pid=1091 uid=0 
old-auid=4294967295 auid=1000 old-ses=4294967295 ses=2 res=1
[    7.996410] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    8.151283] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    9.038571] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   11.245916] Bluetooth: hci1: BCM: chip id 82
[   11.245928] Bluetooth: hci1: BCM43341B0 (002.001.014) build 0000
[   11.755123] Bluetooth: hci1: BCM (002.001.014) build 0164
[   14.513027] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x0 fw_state 0x1
[   14.513045] intel_sst_acpi 80860F28:00: fw download failed -16
[   14.513067] intel_sst_acpi 80860F28:00: FW download fail -16
[   14.513864]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   14.514676]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   14.515574]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   14.518058]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   14.518941]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   14.520293]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   14.525383]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   14.527248]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   14.528335]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   14.534111]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
