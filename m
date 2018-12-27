From: tmptmp15 <tmptmp15@gmail.com>
Subject: Codec tlv320aic3401 and SoC im6ul (no i2c input/output,
	aplay hang up)
Date: Thu, 27 Dec 2018 16:43:25 +0700
Message-ID: <CAJ1upHceZoUffO_wB8P+osJJtbjyBDxUXzYs=vQ=9zXBO6vFWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
 [209.85.166.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3AE1267A78
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2018 10:43:28 +0100 (CET)
Received: by mail-it1-f193.google.com with SMTP id p197so23089584itp.0
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2018 01:43:28 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello !

I try make kernel with ALSA drivers for tlv320aic3401. Platform arm / imx6ul.
CPU:   Freescale i.MX6UL rev1.2 528 MHz (running at 396 MHz)

Kernel config:
$grep SND_ .config |grep -v ^#
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_ARM=y
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_IMX_PCM_DMA=y
CONFIG_SND_SOC_IMX_AUDMUX=y
CONFIG_SND_IMX_SOC=y
CONFIG_SND_SOC_IMX_PCM_FIQ=y
CONFIG_SND_SOC_FSL_ASOC_CARD=y
CONFIG_SND_SOC_IMX_TLV320AIC3X=y
CONFIG_SND_SOC_I2C_AND_SPI=y
CONFIG_SND_SOC_TLV320AIC3X=y

$uname -a
Linux myd-y6ul14x14 4.1.15+ #20 SMP PREEMPT Thu Dec 27 16:00:37 +07
2018 armv7l GNU/Linux

dmesg / i2c:

imx-i2c 21a4000.i2c: <i2c_imx_probe>
i2c i2c-1: adapter [21a4000.i2c] registered
i2c i2c-1: of_i2c: walking child nodes
i2c i2c-1: of_i2c: register /soc/aips-bus@02100000/i2c@021a4000/tlv320aic3104@18
i2c 1-0018: uevent
i2c i2c-1: client [tlv320aic3104] registered with bus id 1-0018
i2c i2c-1: of_i2c: register /soc/aips-bus@02100000/i2c@021a4000/rtc@68
i2c 1-0068: uevent
i2c i2c-1: client [ds1307] registered with bus id 1-0068
i2c i2c-1: claimed irq 228
i2c i2c-1: device resources: [mem 0x021a4000-0x021a7fff]
i2c i2c-1: adapter name: "21a4000.i2c"
i2c i2c-1: IMX I2C adapter registered
i2c i2c-1: can't request DMA tx channel
i2c i2c-1: can't use DMA

I2C physic work fine: i can access to ds1307, and tlv320 may detect
with i2cdetect (if disable tlv320 in DTS).

On console, dmesg / tlv320:
....
of_get_named_gpiod_flags: parsed 'gpio-reset' property of node
'/soc/aips-bus@02100000/i2c@021a4000/tlv320aic3104@18[0]' - status (0)
aic3x_i2c_probe: model=3
1-0018 supply IOVDD not found, using dummy regulator
1-0018 supply DVDD not found, using dummy regulator
1-0018 supply AVDD not found, using dummy regulator
1-0018 supply DRVDD not found, using dummy regulator
i2c-core: driver [tlv320aic3x-codec] registered
fsl-asrc 2034000.asrc: driver registered
...
tlv320aic3x sound: tlv320aic3x-hifi <-> 202c000.sai mapping ok
...
ALSA device list:
  #0: tlv320-audio-U
....


Device Tree Source:

&i2c2 {
	clock_frequency = <100000>;
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_i2c2>;
	status = "okay";


	codec: tlv320aic3104@18 {
		/*   ai3x-micbias-vg = <2>; */
		compatible = "ti,tlv320aic3104";
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_gpio_key>;
		reg = <0x18>;
		gpio-reset = <&gpio5 0 GPIO_ACTIVE_LOW>;

		clocks = <&clks IMX6UL_CLK_SAI2>;
		clock-names = "mclk";
/*
		clock-frequency = <19200000>;
*/
		status = "okay";
	};
.....
};

/ {
   .....
	sound {
		compatible = "fsl,imx-audio-tlv320aic3x";
		model = "tlv320-audio-U";
		cpu-dai = <&sai2>;
		audio-codec = <&codec>;
		ssi-controller = <&sai2>;
		mux-int-port = <2>;  /* 1, 2, 7 - SSI */
		mux-ext-port = <5>;  /* 3-6, IOMUX */
		audio-routing =
		    "LINE1L", "Mic Jack",
		    "Headphone Jack", "HPLOUT",
		    "Headphone Jack", "HPROUT",
		    "Mic Jack", "Mic Bias";
	};
  .....
}



Machine driver imx-audio-tlv320aic3x.c not present in kernel sources,
I try some version from Inet. At any case codec driver
sound/soc/codec/tlv320aic3x.c call procedure snd_soc_write() for init
codec registers, but no any messages from i2c for address 0x18 in
dmesg or /var/log/messages. In kernel config i2c debug messages
enable:

CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y

But if I run aplay:

#aplay -vvv x.wav

Playing WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 15876
  period_size  : 1764
  period_time  : 40000
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1764
  period_event : 0
  start_threshold  : 15876
  stop_threshold   : 15876
  silence_threshold: 0
  silence_size : 0
  boundary     : 2080899072
Hardware PCM card 0 'tlv320-audio-U' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 15876
  period_size  : 1764
  period_time  : 40000
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1764
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 2080899072
  silence_threshold: 0
  silence_size : 2080899072
  boundary     : 2080899072
  appl_ptr     : 0
  hw_ptr       : 0
Max peak (3528 samples): 0x00000000 #                    0%
Max peak (3528 samples): 0x00000285 #                    1%
Max peak (3528 samples): 0x000003dd #                    3%
Max peak (3528 samples): 0x000004b8 #                    3%
Max peak (3528 samples): 0x00001739 ####                 18%
Max peak (3528 samples): 0x0000068d ##                   5%
Max peak (3528 samples): 0x0000058f #                    4%
Max peak (3528 samples): 0x00000534 #                    4%
Max peak (3528 samples): 0x000004a3 #                    3%

Then in /var/log/messages append some messages, like this:
Dec 27 09:29:39 myd-y6ul14x14 user.debug kernel: i2c i2c-1:
master_xfer[0] W, addr=0x18, len=2
and in I2C wire I see some pulses.

And then aplay is locked. :( No pulses at SAI.

Questions:
1) It problem may occur due to my error in DTS ?
2) snd_soc_write() / snd_soc_read() do call direct to i2c or more
complex way ? For what reason can request not always reach i2c?
3) Any advice ?

Thank you!
