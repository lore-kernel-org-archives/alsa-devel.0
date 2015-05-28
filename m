From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Thu, 28 May 2015 21:17:55 +0200
Message-ID: <20150528191721.GA608@asus>
References: <20150521145232.GA12157@dellaz> <20150523163221.GA936@asus>
 <s5h7fruecx4.wl-tiwai@suse.de> <20150527085440.GA4445@dellaz>
 <1432752116.8235.25.camel@loki> <20150527201320.GA309@asus>
 <1432812668.2726.18.camel@loki> <20150528125325.GA418@asus>
 <1432819294.2726.33.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B278A260502
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 21:18:14 +0200 (CEST)
Received: by wizo1 with SMTP id o1so74671879wiz.1
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 12:18:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432819294.2726.33.camel@loki>
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
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2015 at 02:21:34PM +0100, Liam Girdwood wrote:
> On Thu, 2015-05-28 at 14:53 +0200, Michele Curti wrote:
> > and in dmesg I got:
> > 
> > [zio@asus ~]$ dmesg | grep probe
> > [    1.794754] sst_byt_pcm_dev_probe failed dsp init
> > 
> 
> Ok, so the DSP FW has been loaded but the FW is failing to boot. The FW
> is just copied with memcpy() from the host to the DSP memory. Some
> things to check :-
> 
> 1) Does the DSP have a valid IRQ number and handler. The IRQ is used to
> signal FW boot has completed.

Ok, now my ignorance is setting in..  Tried to understand how to determine
if the IRQ is valid but without success..  This is going to take a while, 
I'll be back :p

For now I tried to modify the code in this way:

        if (err == 0) {
                err = -EIO;
-               dev_err(byt->dev, "ipc: error DSP boot timeout\n");
-               goto boot_err;
+               dev_err(byt->dev, "ipc: error DSP boot timeout, continue anyway\n");
+               //goto boot_err;
        }

to let the probe continue, the system become quite unusable but I get the 
logs.

May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP IPC
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: initialising audio DSP id 0xf28
May 28 20:34:00 asus kernel: irq used for dsp = 6

---> The IRQ number used is 6

May 28 20:34:00 asus kernel: [101B blob data]
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x160 bytes at offset 0xc0000 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:0 at offset 0xc0000
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x170 bytes at offset 0xc0400 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0578 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0598 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05b8 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05d8 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05f8 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x8 bytes at offset 0xc0618 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0638 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x30 bytes at offset 0xc0658 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10438 bytes at offset 0xc06a0 type 0
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:1 at offset 0xc8000
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:2 at offset 0xd0000
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Requesting IRQ 146
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Requesting gpio 0
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
May 28 20:34:00 asus kernel: gpiod_direction_input: invalid GPIO
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x1a310 bytes at offset 0x400000 type 3
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x5738 bytes at offset 0x100010 type 1
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:0 at offset 0x100000
May 28 20:34:00 asus kernel: Linux video capture interface: v2.00
May 28 20:34:00 asus kernel: intel_rapl: Found RAPL domain package
May 28 20:34:00 asus kernel: intel_rapl: Found RAPL domain core
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10ad8 bytes at offset 0x105750 type 1
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:1 at offset 0x108000
May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:2 at offset 0x110000
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: Bluetooth: Core ver 2.20
May 28 20:34:00 asus kernel: NET: Registered protocol family 31
May 28 20:34:00 asus kernel: Bluetooth: HCI device and connection manager initialized
May 28 20:34:00 asus kernel: Bluetooth: HCI socket layer initialized
May 28 20:34:00 asus kernel: Bluetooth: L2CAP socket layer initialized
May 28 20:34:00 asus kernel: Bluetooth: SCO socket layer initialized
May 28 20:34:00 asus kernel: Bluetooth: Generic Bluetooth SDIO driver ver 0.1
May 28 20:34:00 asus kernel: asus_wmi: ASUS WMI generic driver loaded
May 28 20:34:00 asus kernel: i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
May 28 20:34:00 asus kernel: asus_wmi: Initialization: 0x1
May 28 20:34:00 asus kernel: asus_wmi: BIOS WMI version: 7.9
May 28 20:34:00 asus kernel: asus_wmi: SFUN value: 0x37
May 28 20:34:00 asus kernel: input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input5
May 28 20:34:00 asus kernel: i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
May 28 20:34:00 asus kernel: input: PDEC3393:00 0B05:8585 as /devices/platform/80860F41:00/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001/input/input6
May 28 20:34:00 asus kernel: uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (04f2:b483)
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: asus_wmi: Number of fans: 1
May 28 20:34:00 asus kernel: mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
May 28 20:34:00 asus kernel: mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
May 28 20:34:00 asus kernel: mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
May 28 20:34:00 asus kernel: input: USB2.0 VGA UVC WebCam as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/input/input7
May 28 20:34:00 asus kernel: asus_wmi: Backlight controlled by ACPI video driver
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: hid-generic 0018:0B05:8585.0001: input,hidraw0: <UNKNOWN> HID v1.00 Keyboard [PDEC3393:00 0B05:8585] on 
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
May 28 20:34:00 asus kernel: usbcore: registered new interface driver uvcvideo
May 28 20:34:00 asus kernel: USB Video Class driver (1.1.1)
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
May 28 20:34:00 asus kernel: brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: usbcore: registered new interface driver brcmfmac
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: random: nonblocking pool is initialized
May 28 20:34:00 asus kernel: i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
May 28 20:34:00 asus kernel: input: ELAN0100:00 04F3:0401 as /devices/platform/80860F41:03/i2c-3/i2c-ELAN0100:00/0018:04F3:0401.0002/input/input8
May 28 20:34:00 asus kernel: hid-generic 0018:04F3:0401.0002: input,hidraw1: <UNKNOWN> HID v1.00 Mouse [ELAN0100:00 04F3:0401] on 
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
May 28 20:34:00 asus kernel: mousedev: PS/2 mouse device common for all mice
May 28 20:34:00 asus kernel: (NULL device *): ipc: error DSP boot timeout, continue anyway
May 28 20:34:00 asus kernel: (NULL device *): FW version: 04.05.13.a0
May 28 20:34:00 asus kernel: (NULL device *): Build type: a0
May 28 20:34:00 asus kernel: (NULL device *): Build date: Apr  2 2014 14:14:39
May 28 20:34:00 asus kernel: sst_byt_pcm_probe probe ok

--> the probe "succeed"

May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: rt5645-aif1 <-> baytrail-pcm-audio mapping ok
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: no source widget found for SPOLP
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: Failed to add route SPOLP -> direct -> Speaker
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: no source widget found for SPOLN
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: Failed to add route SPOLN -> direct -> Speaker
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: no source widget found for SPORP
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: Failed to add route SPORP -> direct -> Speaker
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: no source widget found for SPORN
May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: Failed to add route SPORN -> direct -> Speaker
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC1 Swap Mux has no paths
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC2 Swap Mux has no paths
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC3 Swap Mux has no paths
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC Mux has no paths
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC1 L Mux has no paths
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC1 R Mux has no paths
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC2 L Mux has no paths
May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC2 R Mux has no paths
May 28 20:34:00 asus kernel: Console: switching to colour frame buffer device 170x48
May 28 20:34:00 asus kernel: i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
May 28 20:34:00 asus kernel: i915 0000:00:02.0: registered panic notifier
May 28 20:34:02 asus kernel: brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
May 28 20:34:02 asus kernel: brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
May 28 20:34:02 asus kernel: brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
May 28 20:34:02 asus kernel: brcmfmac: brcmf_add_if: ignore IF event
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: open
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: hw_free
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: close
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: open
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: hw_free
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: close
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: open
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: hw_free
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: close
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: open
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: hw_free
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: close
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: open

--> and then every second i got the following errors

May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: hw_params, pcm_data ffff880076b6f780
May 28 20:34:02 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeout-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
May 28 20:34:02 asus kernel: (NULL device *): ipc: error stream commit failed
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: failed stream commit -110
May 28 20:34:02 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-audio hw params failed: -110
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: hw_free
May 28 20:34:02 asus kernel:  Baytrail Audio: PCM: hw_params, pcm_data ffff880076b6f780
May 28 20:34:03 asus kernel: cfg80211: Calling CRDA to update world regulatory domain
May 28 20:34:03 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeout-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
May 28 20:34:03 asus kernel: (NULL device *): ipc: error stream commit failed
May 28 20:34:03 asus kernel:  Baytrail Audio: PCM: failed stream commit -110
May 28 20:34:03 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-audio hw params failed: -110
May 28 20:34:03 asus kernel:  Baytrail Audio: PCM: hw_free
May 28 20:34:03 asus kernel:  Baytrail Audio: PCM: hw_params, pcm_data ffff880076b6f780


> 
> 2) Can you verify the FW data copied with memcpy by reading it back from
> DSP memory. The DSP device may be in D3 here...
> 
> 3) can you send the output of sst_byt_dump_shim() when boot fails.
> 
> Liam
> 
