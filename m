From: sdaau <sd@create.aau.dk>
Subject: Help with pcm3168a device tree,
 and simple-audio-card/simple-scu-audio-card?
Date: Tue, 8 May 2018 08:56:56 +0200
Message-ID: <5AF14A38.4010104@create.aau.dk>
Reply-To: sd@create.aau.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0059.outbound.protection.outlook.com [104.47.1.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 33213266F0F
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 08:57:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I am experimenting with PCM3168A audio codec, connected to a Raspberry Pi 3 B running Raspbian 9.

I have set up GPIO4 (BCM4) of the Broadcom BCM2837 SoC of the RPi3B as GPCLK0, and use that as SCKI (System clock input) of the PCM3168A; other than that, I have set up the I2S pins of the BCM2837 in I2S/PCM mode, and use the BCLK/LRCLK clock lines to drive both AD and DA (respective) clock lines; and also the PCM DIN and DOUT lines are connected: the PCM3168A codec has 8 (mono, differential) DACs and 6 (mono, differential) ADCs - but I can only test with 2 DACs for stereo out, and 2 ADCs for stereo in, since there is only one line for DIN and DOUT each on the RPi3B/BCM2837 I2S interface. The PCM3168A is controlled by RPi3B's SPI lines, chip select 1.

I have had limited success in running this setup with a device tree overlay based on:

* simple-audio-card driver: https://github.com/raspberrypi/linux/blob/rpi-4.14.y/sound/soc/generic/simple-card.c
* The already existing PCM3168A Linux kernel driver: https://github.com/raspberrypi/linux/blob/rpi-4.14.y/sound/soc/codecs/pcm3168a.c

... however, I cannot get it to properly work, so I hope I can get some help filling in the blanks.

First question:

* Q1: In the above setup, the pcm3168a.c is a "codec class driver"; but is simple-card.c a platform class or a machine class driver? Also, would the device tree overlay act as a machine class driver, since it "acts as the glue that describes and binds the other component drivers together" (sound/soc/overview.html)?


Here are the relevant device tree fragments of the somewhat working device tree overlay, cased on `simple-card.c`:

```
fragment@3 {
  target = <&spi0>; 
  __overlay__ {
    #address-cells = <1>;
    #size-cells = <0>;
    status = "okay";

    pcm3168a: codec@1 {
      #sound-dai-cells = <0>;
      reg = <1>;
      compatible = "ti,pcm3168a";
      spi-max-frequency = <1000000>; 
      clocks = <&clocks 38>; // * BCM2835_CLOCK_GP0 * /
      clock-names = "scki";
      pinctrl-names = "default";
      pinctrl-0 = <&gpclk0_gpio4>;
      VDD1-supply = <&vdd_3v3_reg>;
      VDD2-supply = <&vdd_3v3_reg>;
      VCCAD1-supply = <&vdd_5v0_reg>;
      VCCAD2-supply = <&vdd_5v0_reg>;
      VCCDA1-supply = <&vdd_5v0_reg>;
      VCCDA2-supply = <&vdd_5v0_reg>;
      status = "okay";
    };
  };
};

fragment@4 { /////// a working one:
  target = <&sound>;
  slave_sound_overlay: __overlay__ {
    compatible = "simple-audio-card";
    i2s-controller = <&i2s>;
    status = "okay";

    simple-audio-card,name = "my-sound-card";

    simple-audio-card,widgets =
      "Line", "Line In",
      "Line", "Line Out";

    simple-audio-card,routing =
      "AIN1L", "Line In",
      "AIN1R", "Line In",
      "Line Out", "AOUT1L",
      "Line Out", "AOUT1R";

    simple-audio-card,format = "right_j"; //"i2s";
    simple-audio-card,mclk-fs = <128>;

    simple-audio-card,cpu {
      sound-dai = <&i2s>;
    };

    sound_master: simple-audio-card,codec {
      sound-dai = <&pcm3168a>;
      system-clock-frequency = <6144000>; // both these work: 12288000/48000 = 256; 6144000/48000 = 128
    };
  };
};
```

When I load this device tree on Raspbian, the following drivers get loaded:

```
pi@raspberrypi:~ $ lsmod
Module                  Size  Used by
snd_soc_bcm2835_i2s    16384  2
snd_soc_pcm3168a_spi    16384  1
snd_soc_pcm3168a       24576  1 snd_soc_pcm3168a_spi
snd_soc_simple_card    16384  0
snd_soc_simple_card_utils    20480  1 snd_soc_simple_card
snd_soc_core          204800  4 snd_soc_pcm3168a,snd_soc_simple_card_utils,snd_soc_bcm2835_i2s,snd_soc_simple_card
spidev                 16384  0
spi_bcm2835            16384  0
snd_compress           20480  1 snd_soc_core
snd_pcm_dmaengine      16384  1 snd_soc_core
...
snd_pcm                98304  5 snd_pcm_dmaengine,snd_soc_pcm3168a,snd_soc_bcm2835_i2s,snd_bcm2835,snd_soc_core
snd_timer              32768  1 snd_pcm
snd                    69632  7 snd_compress,snd_timer,snd_bcm2835,snd_soc_core,snd_pcm
...
```

... with relevant syslog messages:

```
kernel: [  410.676653] bus: 'platform': add driver spi-bcm2835
...
kernel: [  410.818605] bus: 'platform': add driver snd-soc-dummy
kernel: [  410.819136] bus: 'platform': add driver soc-audio
...
kernel: [  410.830593] bus: 'platform': add driver asoc-simple-card
...
kernel: [  410.833990] bus: 'spi': add driver pcm3168a
kernel: [  410.840144] bus: 'platform': add driver bcm2835-i2s
...
kernel: [  410.857249] asoc-simple-card soc:sound: pcm3168a-dac <-> 3f203000.i2s mapping ok
...
systemd-udevd[921]: Execute 'load' 'platform:snd-soc-dummy'
systemd-udevd[921]: No module matches 'platform:snd-soc-dummy'
...
systemd-udevd[914]: created db file '/run/udev/data/+sound:card1' for '/devices/platform/soc/soc:sound/sound/card1'
...
systemd[1]: sys-devices-platform-soc-soc:sound-sound-card1.device: Changed dead -> plugged
...
systemd-udevd[921]: handling device node '/dev/snd/pcmC1D0p', devnum=c116:48, mode=0660, uid=0, gid=29
...
systemd-udevd[917]: handling device node '/dev/snd/controlC1', devnum=c116:32, mode=0660, uid=0, gid=29
...
```

After this, I have a playback card device - but not a capture one:

```
pi@raspberrypi:~ $ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: ...
card 1: mysoundcard [my-sound-card], device 0: bcm2835-i2s-pcm3168a-dac pcm3168a-dac-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
pi@raspberrypi:~ $ arecord -l
**** List of CAPTURE Hardware Devices ****
pi@raspberrypi:~ $ 
```

Note that at this point, with drivers loaded, I do have "card controls" accessible by amixer - but no "simple controls":

```
pi@raspberrypi:~ $ amixer -d -D hw:CARD=mysoundcard info
Card hw:CARD=mysoundcard 'mysoundcard'/'my-sound-card'
  Mixer name	: ''
  Components	: ''
  Controls      : 45
amixer: Mixer load hw:CARD=mysoundcard error: Device or resource busy
pi@raspberrypi:~ $ amixer -d -D hw:CARD=mysoundcard scontrols
amixer: Mixer hw:CARD=mysoundcard load error: Device or resource busy
pi@raspberrypi:~ $ amixer -d -D hw:CARD=mysoundcard controls
numid=19,iface=MIXER,name='Master Playback Volume'
numid=42,iface=MIXER,name='Master Capture Volume'
numid=41,iface=MIXER,name='ADC Overflow Flag Polarity'
...
numid=13,iface=MIXER,name='DAC4 Zero Flag'
pi@raspberrypi:~ $ amixer -d -D hw:CARD=mysoundcard cset iface=MIXER,name='Master Playback Volume' 81%
VERIFY ID: numid=0,iface=MIXER,name='Master Playback Volume'
numid=19,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=201,step=0
  : values=163
  | dBscale-min=-100.50dB,step=0.50dB,mute=1
```

The accessible controls are, in fact, defined in pcm3168a.c (in ...struct snd_kcontrol_new pcm3168a_snd_controls[]) - so, more questions:

* Q2: Is the amixer "error: Device or resource busy" an indication that: *no* driver loaded by the device tree overlay, has a definition for any mixer "simple control"? If so, can I set that up via device tree overlay - or do I need to code it in a driver? If coding a driver, which driver should be patched - pcm3168a.c or simple-card.c?
* Q3: In the above `amixer cset` of 'Master Playback Volume', I can see `mute=1` in the output. Does that mean master playback is muted? If so, how do I unmute it with amixer?
* Q4: As far as I can see, `alsamixer` deals only with "simple controls", not "card controls" (it exits with `cannot load mixer controls: Device or resource busy` as soon as I choose mysoundcard). Is there any ALSA GUI software that can show and manipulate all card controls of a card?

Note that pcm3168a.c has notions of a *stereo* DAC and ADC, so the accessible amixer controls refer to ADC1-ADC3 and DAC1-DAC4.

Finally, I test this with:

```
pi@raspberrypi:~ $ speaker-test -D hw:CARD=mysoundcard,DEV=0 -c 2 -t sine -f 440
speaker-test 1.1.3

Playback device is hw:CARD=mysoundcard,DEV=0
Stream parameters are 48000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 128 to 131072
Period size range from 64 to 65536
Using max buffer size 131072
Periods = 4
was set period_size = 32768
was set buffer_size = 131072
 0 - Front Left
 1 - Front Right
Time per period = 2.781788
...
```

This is what I observe when speaker-test runs:

- I've captured I2S and SPI signals with Saleae Logic: GPCLK0 kicks in first, after about 20 ms, SPI sends on MOSI (and SCL) 14 bytes in about 1 ms - immediately after, BCLK starts; and after some 50 ms, LRCLK and DOUT start in synchrony. So, at least from the RPi3B/BCM2837 side, at first glance all seems fine. (I've also used I2S analyzer in the software, and can confirm there's a sinusoid in the I2S DOUT data, though I cannot decode it 100% yet, since I see some discontinuities in the plots)
- I've also measured PCM3168A outputs with "analog" scope - unfortunately I had a massive 50 Hz hum where I've measured, so it's difficult to say much with certainty. But basically, when speaker-test runs, there is a significant HF noise appearing on the DAC outputs (which disappears when speaker-test stops). I cannot tell if this is output from the DAC, but faulty, because of misconfiguration of the PCM3168a chip - or if the DAC is actually mute, and this is just noise leaking from GPCLK0 and similar signals (I'll need to find a quieter lab first to re-do measurements)

Here are some more questions:

* Q5: How would I go about reading the internal configuration registers of the PCM3168A? I guess I could use printk's in pcm3168a.c - but is there an easy/generic way of reading those from user space?
* Q6: Is it possible to set internal configuration registers of the PCM3168A from a device tree overlay - say, if I'd like to set up DAC1 and DAC2 (as per datasheet, which is = stereo DAC1 in pcm3168a.c) to work in differential (or single-ended) mode?  

Note that the device tree overlay sets "right_j" (right justified) digital data exchange (I2S/PCM) format; because whenever I try to set it to "i2s", running speaker-test fails with "Unable to set hw params for playback: Invalid argument" and these syslog messages:

```
pcm3168a spi0.1: 32-bit frames are supported only for slave mode using right justified
pcm3168a spi0.1: ASoC: can't set pcm3168a-dac hw params: -22
``` 

* Q6: Where did this "32-bit frames" come from, when using format "i2s"? As far as I see it, speaker-test requested S16_LE stereo, meaning 16-bits need to be clocked in when LRCLK is 'L', and 16-bits when LRCLK is 'R' - can't see a "32-bit frame" here anywhere? On the other hand, there is in the PCM3168A datasheet "Table 11. Audio Data Interface Formats and Sampling Rate, Bit Clock, and System Clock Restrictions", with "(1) BCK = 48 fS, 32 fS is supported only in slave mode; BCK = 32 fS is supported only for 16-bit data length." - Does this mean that, since I've requested 16-bit samples, earlier code decided that BCK should be 32 fS, resulting with this "32-bit frame", which then fails at the point it does ?! Can I explicitly override this frame length in the device tree overlay - if so, w
 here?

* Q7: I'm very confused about how the master/slave I2S relationship is established in a device tree with `simple-audio-card`. For instance, I've seen `simple-audio-card,bitclock-master` and `,frame-master`, but also `,bitclock-slave` and `,frame-slave`; and yet, my device tree fragment above, uses none of those - and still, at least some of the system works?! So some relationship must have been established implicitly - my guess is (ignoring the `sound_master` label) that since GPCLK0 is set as SCKI of pcm3168a, bcm2835-i2s becomes master, and pcm3168a (codec) becomes slave. Is that correct - if not, how would one derive the actual implied relationship?


I should mention, that one of the biggest mysteries for me here is:

* Q8: Why is there no capture interface with this usage of `simple-audio-card` in device tree? In fact, I can see nowhere in the above device tree fragment that there is an explicit setup for playback - and yet, I do get a playback interface (and partially, it works)? I would have thought, that the setup of `simple-audio-card,widgets` and `simple-audio-card,routing` (most of the other .dts examples I've seen, have this as the only reference to input/capture vs output/playback) would have been enough to infer that capture interface is needed too, since I refer to "AIN1L", "AIN1R" along with "AOUT1L", "AOUT1R" (all defined in pcm3168a.c) - but apparently, not? Only other example I've seen is `arch/arm/boot/dts/overlays/pibell-overlay.dts`, which sets up `capture_link: simple-audio-card,dai-l
 ink@0` and `playback_link: simple-audio-card,dai-link@1` in `target = <&sound>`; but then again, it uses different chips for input and output - is this approach preferable, also when a single chip d
 e
als with both playback and capture?


Now, an interesting thing is that, even in my above device tree fragment, if I just change `compatible = "simple-audio-card";` to `compatible = "simple-scu-audio-card";` - drivers will typically load with the device tree, but speaker-test will fail with a segfault at very start. To be sure, I tried writing another device tree fragment for "simple-scu-audio-card":

```
fragment@4 {
  target = <&sound>;
  slave_sound_overlay: __overlay__ {
    compatible = "simple-scu-audio-card";
    i2s-controller = <&i2s>;
    status = "okay";

    simple-audio-card,name = "my-sound-card";
    simple-audio-card,format = "i2s";

    simple-audio-card,convert-rate = <48000>; // simple-scu-card.txt (simple-scu-audio-card); prob no effect with simple-card.c (simple-audio-card) only;

    //simple-audio-card,prefix = "pcm3168a"; // NOTE: this causes the // ASoC: no source widget found for AOUT1L!
    // without ,widgets: "ASoC: no sink widget found for Line Out/In"
    simple-audio-card,widgets =
      //~ "Line", "Line In",
      "Line", "Line Out";
    simple-audio-card,routing =
      "Line Out","AOUT1L",
      "Line Out","AOUT1R"; //,
      //~ "AIN1L","Line In",
      //~ "AIN1R","Line In";
      //"Playback","DAC1"; //passes without simple-audio-card,widgets - but segfaults

    sndcpu: simple-audio-card,cpu {
      sound-dai = <&i2s>;
    };

    sndcodec: simple-audio-card,codec {
      sound-dai = <&pcm3168a>;
      system-clock-frequency = <12288000>;
    };
  };
};
```

The funny thing here is - even if the "Line In" references are commented in ,routing - still, both a playback and a capture interface appear, along with the load of device tree and corresponding drivers! However, speaker-test causes segfault with a stack trace like: 

```
kernel: [20819.557733] Unable to handle kernel NULL pointer dereference at virtual address 000000b0
...
kernel: [20819.557997] Hardware name: BCM2835
kernel: [20819.558008] task: 9f31ad00 task.stack: 9f3c8000
kernel: [20819.558148] PC is at is_connected_output_ep+0x1c/0x1fc [snd_soc_core]
kernel: [20819.558274] LR is at snd_soc_dapm_dai_get_connected_widgets+0x90/0x1e4 [snd_soc_core]
...
[ 1190.725416] [<7f4d1e50>] (is_connected_output_ep [snd_soc_core]) from [<7f4d4cf4>] (snd_soc_dapm_dai_get_connected_widgets+0x90/0x1e4 [snd_soc_core])    ### sound/soc/soc-dapm.c
[ 1190.725663] [<7f4d4cf4>] (snd_soc_dapm_dai_get_connected_widgets [snd_soc_core]) from [<7f4db064>] (dpcm_path_get+0x2c/0x8c [snd_soc_core])    ###  sound/soc/soc-dapm.c
[ 1190.725908] [<7f4db064>] (dpcm_path_get [snd_soc_core]) from [<7f4db55c>] (dpcm_fe_dai_open+0x74/0x688 [snd_soc_core])    ### sound/soc/soc-pcm.c
[ 1190.726104] [<7f4db55c>] (dpcm_fe_dai_open [snd_soc_core]) from [<7f101e9c>] (snd_pcm_open_substream+0x6c/0x114 [snd_pcm])   ### sound/soc/soc-pcm.c
[ 1190.726238] [<7f101e9c>] (snd_pcm_open_substream [snd_pcm]) from [<7f101ffc>] (snd_pcm_open+0xb8/0x218 [snd_pcm])
[ 1190.726370] [<7f101ffc>] (snd_pcm_open [snd_pcm]) from [<7f102214>] (snd_pcm_playback_open+0x4c/0x6c [snd_pcm])
[ 1190.726498] [<7f102214>] (snd_pcm_playback_open [snd_pcm]) from [<7f0d24f8>] (snd_open+0xa4/0x144 [snd])
[ 1190.726573] [<7f0d24f8>] (snd_open [snd]) from [<80288a54>] (chrdev_open+0xe0/0x1b4)
...
```

* Q9: I've added some extra prints to driver code - but as far as I can see, `simple-audio-card` never ends up calling `is_connected_output_ep`, but `simple-scu-audio-card` does; unless I've made a mistake during debugging, would there a reason for that?
* Q10: How can I tell `simple-scu-audio-card` which DACs/ADCs should be used in playback and capture device - given that apparently ,widgets and ,routing alone are not enough to specify state (given that it creates a capture device, even if there are no references to AIN*/Line in there) ?!


And finally, in general:

* Q11: I generally want to use PCM3168A chip DAC1 and DAC2 as stereo OUT (driver: stereo DAC1), and chip ADC1 and ADC2 as stereo IN (driver: stereo ADC1). Am I better off basing myself on `simple-audio-card`, or on `simple-scu-audio-card`, in the device tree overlay? In fact, is it possible to set up this kind of operation using existing drivers in a device tree overlay - or would I have to add my own driver code (either as patch of existing drivers, or as "my own" driver, possibly started from an existing driver)?
* Q12: I'd also want to use (driver: stereo DAC1) and (driver: stereo ADC1) in full-duplex mode. Can this be set up solely via `dai-tdm-slot-num`, `-width`, `-tx-mask` and `-rx-mask` under `simple-audio-card,cpu` in device tree overlay - or would I have to add my own driver code (either patching, or "my own")?


Many thanks in advance for any pointers!
