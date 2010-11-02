From: James Liu <telecom888@gmail.com>
Subject: Re: About CS42L52---Where to find CS42L52 ASoC driver
Date: Tue, 2 Nov 2010 10:57:47 +0800
Message-ID: <AANLkTinBMMU9qpXYk8hx6mHUfsx_hRHskHNyeMMi4oKp@mail.gmail.com>
References: <AANLkTinywr73_wLiaeRArZDdOmFYOo0kxbGJoxgrQPTp@mail.gmail.com>
	<8153F08C-D4FB-4555-8519-6091E5E9115D@cirrus.com>
	<AANLkTim_K46ja6p=7JbXr5BWdMb3_7PwU2WjXDy0MYcu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 98BA32443B
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 03:57:50 +0100 (CET)
Received: by iwn2 with SMTP id 2so7202538iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 19:57:48 -0700 (PDT)
In-Reply-To: <AANLkTim_K46ja6p=7JbXr5BWdMb3_7PwU2WjXDy0MYcu@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,guys!

2010/10/13 James Liu <telecom888@gmail.com>:
> 2010/10/13 Austin, Brian <Brian.Austin@cirrus.com>
>>
>> I have not had time to make some changes suggested by the maintainers as I have been too busy. I will start that again soon
>> Brian

The follow  is  cs42l52  machine code for  Samsung S5PC100    and   system log.
I used aplay tool to test the system  with wav file, but   don't hear
any voice  from the speakers.
where is the BUG  of this code ? Please help me,and thanks!

the cs42l52 codec driver is  from Brian.  I  port  this codec driver
to   Samsung  S5PC100   2.6.29 kernel.



A).   cs42l52  machine code for  Samsung S5PC100.


/*
 * smdks5p_cs42l52.c  --  SoC audio for smdkc100
 *
 *
 */

#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/module.h>
#include <linux/device.h>
#include <linux/clk.h>
#include <linux/delay.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>
#include <sound/soc-dai.h>

#include <asm/io.h>
#include <asm/gpio.h>
#include <plat/gpio-cfg.h>
#include <plat/map-base.h>
#include <plat/regs-clock.h>
#include <plat/regs-gpio.h>
#include <plat/gpio-bank-c.h>
#include <plat/clock.h>
#include <plat/regs-iis1.h>

#include "../codecs/cs42l52.h"
#include "s3c-dma.h"
#include "s5p-i2s.h"
#include "s3c-i2s-v2.h"



#define wait_stable(utime_out)					\
	do {							\
		if (!utime_out)					\
			utime_out = 1000;			\
		utime_out = loops_per_jiffy / HZ * utime_out;	\
		while (--utime_out) { 				\
			cpu_relax();				\
		}						\
	} while (0);

#if defined(DEBUG)
static unsigned long get_epll_rate(void)
{
	struct clk *fout_epll;
	unsigned long rate;

	fout_epll = clk_get(NULL, "fout_epll");
	if (IS_ERR(fout_epll)) {
		printk(KERN_ERR "%s: failed to get fout_epll\n", __func__);
		return -ENOENT;
	}

	rate = clk_get_rate(fout_epll);

	clk_put(fout_epll);

	return rate;
}
#endif

static int set_epll_rate(unsigned long rate)
{
	struct clk *fout_epll;
	unsigned int wait_utime = 100;

	fout_epll = clk_get(NULL, "fout_epll");
	if (IS_ERR(fout_epll)) {
		printk(KERN_ERR "%s: failed to get fout_epll\n", __func__);
		return -ENOENT;
	}

	if (rate == clk_get_rate(fout_epll))
		goto out;

	clk_disable(fout_epll);
	wait_stable(wait_utime);

	clk_set_rate(fout_epll, rate);
	wait_stable(wait_utime);

	clk_enable(fout_epll);

out:
	clk_put(fout_epll);

	return 0;
}


static int smdkc100_hw_params(struct snd_pcm_substream *substream,
	struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
	struct s3c_i2sv2_rate_calc div;
	unsigned int epll_out_rate;
	int ret;

	switch (params_rate(params)) {
	case 8000:
	case 12000:
	case 16000:
	case 24000:
	case 32000:
	case 48000:
	case 64000:
	case 96000:
		epll_out_rate = 49152000;
		break;
	case 11025:
	case 22050:
	case 44100:
	case 88200:
		epll_out_rate = 67738000;
		break;
	default:
		printk(KERN_ERR "%s:%d Sampling Rate %u not supported!\n",
			__func__, __LINE__, params_rate(params));
		return -EINVAL;
	}

#if 0
// Use  SCLK_AUDIO

	/* Set EPLL clock rate */
	ret = set_epll_rate(epll_out_rate);
	if (ret < 0)
		return ret;

	/* Set the AP DAI configuration */
	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
				| SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
	if (ret < 0)
		return ret;

	/* Set the Codec DAI configuration */
	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
				| SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
	if (ret < 0)
		return ret;

	/* Select the AP Sysclk */
	ret = snd_soc_dai_set_sysclk(cpu_dai, S5P_CLKSRC_CDCLK, 0,
				 SND_SOC_CLOCK_OUT);
	if (ret < 0)
		return ret;

	/* We use SCLK_AUDIO for basic ops in SoC-Master mode */
	ret = snd_soc_dai_set_sysclk(cpu_dai, S5P_CLKSRC_MUX, 0,
				 SND_SOC_CLOCK_IN);
	if (ret < 0)
		return ret;

#endif




#if 1
// USE PCLK
//	writel(readl(S5P_CLKGATE_D20)|S5P_CLKGATE_D20_HCLKD2|S5P_CLKGATE_D20_I2SD2,S5P_CLKGATE_D20);
	writel(readl(S5P_LPMP_MODE_SEL) | (1<<1), S5P_LPMP_MODE_SEL);

	/* Set the AP DAI configuration */
	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
				| SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
	if (ret < 0)
		return ret;

	/* Set the Codec DAI configuration */
	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
				| SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
	if (ret < 0)
		return ret;

	/* Select the AP Sysclk */
	ret = snd_soc_dai_set_sysclk(cpu_dai, S5P_CLKSRC_CDCLK, 0,
				 SND_SOC_CLOCK_OUT);
	if (ret < 0)
		return ret;

	/* We use PCLK for basic ops in SoC-Master mode */
	ret = snd_soc_dai_set_sysclk(cpu_dai, S5P_CLKSRC_PCLK, 0,
				 SND_SOC_CLOCK_IN);
	if (ret < 0)
		return ret;

#endif

	s3c_i2sv2_iis_calc_rate(&div, NULL, params_rate(params),
				s5p_i2s_get_clock(cpu_dai));

	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_RCLK, div.fs_div);
	if (ret < 0)
		return ret;

	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_PRESCALER,
							div.clk_div - 1);
	if (ret < 0)
		return ret;
	return 0;
}

/* SMDK Playback widgets */
static const struct snd_soc_dapm_widget cs42l52_dapm_widgets[] = {
	SND_SOC_DAPM_SPK("Front-L/R", NULL),
	SND_SOC_DAPM_MIC("MIC-L/R", NULL),
};

/* example machine audio_mapnections */
static const struct snd_soc_dapm_route audio_map[] = {
	{"Front-L/R", NULL, "SPKA"},
	{"Front-L/R", NULL, "SPKB"},
	{"MICA", NULL, "MIC-L/R"},
	{"MICB", NULL, "MIC-L/R"},

};

static int smdkc100_cs42l52_init(struct snd_soc_codec *codec)
{

	/* Add smdkc100 specific widgets */
	snd_soc_dapm_new_controls(codec, cs42l52_dapm_widgets,
				 ARRAY_SIZE(cs42l52_dapm_widgets));
	
	/* set up smdkc100 specific audio paths */
	snd_soc_dapm_add_routes(codec, audio_map,ARRAY_SIZE(audio_map));

	/* All enabled by default */
	snd_soc_dapm_enable_pin(codec, "Front-L/R");
	snd_soc_dapm_enable_pin(codec, "MIC-L/R");

	snd_soc_dapm_sync(codec);

	return 0;
}

static struct snd_soc_ops smdk_i2s_ops = {
	.hw_params = smdkc100_hw_params,
};



static struct snd_soc_card smdkc100;

static struct snd_soc_dai_link smdkc100_dai[] = {
{
	.name = "CS42L52",
	.stream_name = "TXRX",
	.cpu_dai = &s5p_i2s_dai[0],
	.codec_dai = &soc_cs42l52_dai,
	.init = smdkc100_cs42l52_init,
	.ops = &smdk_i2s_ops,
}

};

static struct snd_soc_card smdkc100 = {
	.name = "SMDKC100",
	.platform = &s3c24xx_soc_platform,
	.dai_link = smdkc100_dai,
	.num_links = ARRAY_SIZE(smdkc100_dai),
};

static struct soc_codec_cs42l52_data smdkc100_snd_cs42l52_data = {
	.i2c_bus = 0,
	.i2c_addr = 0x4a,
};

static struct snd_soc_device smdkc100_snd_cs42l52_devdata = {
	.card = &smdkc100,
	.codec_dev = &soc_codec_cs42l52_dev,
	.codec_data = &smdkc100_snd_cs42l52_data,
};

static struct platform_device *smdkc100_snd_cs42l52_device;

static int __init smdkc100_init(void)
{
	int ret;
	
	smdkc100_snd_cs42l52_device = platform_device_alloc("soc-audio", -1);
	if (!smdkc100_snd_cs42l52_device)
		return -ENOMEM;

	platform_set_drvdata(smdkc100_snd_cs42l52_device,
				&smdkc100_snd_cs42l52_devdata);
	smdkc100_snd_cs42l52_devdata.dev = &smdkc100_snd_cs42l52_device->dev;

	ret = platform_device_add(smdkc100_snd_cs42l52_device);

	if (ret)
		platform_device_put(smdkc100_snd_cs42l52_device);

	return ret;
}

static void __exit smdkc100_exit(void)
{
	platform_device_unregister(smdkc100_snd_cs42l52_device);
}

module_init(smdkc100_init);
module_exit(smdkc100_exit);

/* Module information */
MODULE_AUTHOR("Samsung: Ryu");
MODULE_DESCRIPTION("ALSA SoC CS42L52 SMDKC100");
MODULE_LICENSE("GPL");




B).   system   log

U-Boot 1.3.4 (Sep 19 2010 - 21:26:25) for SMDKC100 (ver1.2.1)


CPU:     S5PC100@666MHz
         Fclk = 1332MHz, Hclk = 166MHz, Pclk = 66MHz, Serial = PCLK
Board:   SMDKC100
DRAM:    256 MB
Flash:   0 kB
SD/MMC:  1889 MB
NAND:    128 MB
*** Warning - using default environment

In:      serial
Out:     serial
Err:     serial
Hit any key to stop autoboot:  0
Reading kernel from sector 3857358 (8192 sectors).. completed
Boot with zImage

Starting kernel ...

Uncompressing Linux............................................................................................................................................................
.
Linux version 2.6.29 (james@james-desktop) (gcc version 4.3.3
(Sourcery G++ Lite 2009q1-203) ) #435 Tue Nov 2 10:29:35 CST 2010
CPU: ARMv7 Processor [412fc081] revision 1 (ARMv7), cr=10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: SMDKC100
Ignoring unrecognised tag 0x41001099
Memory policy: ECC disabled, Data cache writeback
CPU S5PC100 (id 0x43100000)
S3C24XX Clocks, (c) 2004 Simtec Electronics
S5PC100: PLL settings, A=1332000000, M=267000000, E=67500000, H=24000000
S5PC100: ARMCLK=666000000, HCLKD0=166500000, PCLKD0=83250000,
HCLK=133500000, PCLK=66750000
mout_apll: source is fout_apll (1), rate is 1332000000
mout_epll: source is fout_epll (1), rate is 67500000
mout_mpll: source is mpll (1), rate is 267000000
mout_hpll: source is srclk (1), rate is 24000000
mmc_bus: source is dout_mpll (1), rate is 44500000
mmc_bus: source is dout_mpll (1), rate is 66750000
mmc_bus: source is dout_mpll (1), rate is 66750000
usb-host-bus: source is dout_mpll (1), rate is 133500000
uclk1: source is dout_mpll (1), rate is 66750000
sclk_spi: source is dout_mpll2 (1), rate is 66750000
sclk_spi: source is dout_mpll2 (1), rate is 66750000
sclk_spi: source is dout_mpll2 (1), rate is 66750000
sclk_audio: source is mout_epll (0), rate is 67500000
audio-bus: source is mout_epll (0), rate is 67500000
audio-bus: source is mout_epll (0), rate is 67500000
audio-bus: source is fout_epll (0), rate is 67500000
sclk_irda: source is dout_mpll (1), rate is 133500000
sclk_pwi: source is srclk (0), rate is 0
sclk_fimd: source is dout_mpll (1), rate is 133500000
sclk_fimc: source is dout_mpll (1), rate is 133500000
sclk_fimc: source is dout_mpll (1), rate is 133500000
sclk_fimc: source is dout_mpll (1), rate is 133500000
sclk_mixer: source is clk_27m (0), rate is 27000000
s5pc1xx: 12288000 bytes system memory reserved for fimc0 at 0x20776000
s5pc1xx: 12288000 bytes system memory reserved for fimc1 at 0x2132e000
s5pc1xx: 12288000 bytes system memory reserved for fimc2 at 0x21ee6000
s5pc1xx: 16777216 bytes system memory reserved for mfc at 0x22a9e000
s5pc1xx: 16777216 bytes system memory reserved for jpeg at 0x23a9e000
s5pc1xx: 16777216 bytes system memory reserved for pmem at 0x24a9e000
s5pc1xx: 16777216 bytes system memory reserved for pmem_gpu1 at 0x25a9e000
s5pc1xx: 8388608 bytes system memory reserved for pmem_adsp at 0x26a9e000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/mmcblk0p1 rw rootfstype=ext3 mem=256m
init=/init  console=ttySAC1,115200  kgdbwait
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x30
console [ttySAC1] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB = 256MB total
Memory: 144384KB available (4452K code, 843K data, 216K init)
Calibrating delay loop... 665.19 BogoMIPS (lpj=1662976)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 520 bytes
S5PC1XX GPIO Driver Init
NET: Registered protocol family 16
S5PC100: Initialising architecture
S3C PL330-DMA Controller Driver, (c) 2008-2009 Samsung Electronics
Total 24 DMA channels will be initialized.
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Bluetooth: Core ver 2.15
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
cfg80211: Using static regulatory domain info
cfg80211: Regulatory domain: US
        (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
        (2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
        (5170000 KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
        (5190000 KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
        (5210000 KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
        (5230000 KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
        (5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
cfg80211: Calling CRDA for country: US
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
NetWinder Floating Point Emulator V0.97 (double precision)
ashmem: initialized
yaffs Oct 31 2010 19:41:22 Installing.
msgmni has been set to 282
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
s3cfb s3cfb: [fb0] dma: 0x2fa00000, cpu: 0xff000000, size: 0x00177000
Console: switching to colour frame buffer device 100x30
s3cfb s3cfb: registered successfully
S3C64XX ADC driver, (c) 2007 Samsung Electronics
ADC platform data read
S3C64XX ADC driver successfully probed !
s5pc100-uart.0: s3c2410_serial0 at MMIO 0xec000000 (irq = 16) is a S3C6400/10
s5pc100-uart.1: s3c2410_serial1 at MMIO 0xec000400 (irq = 20) is a S3C6400/10
s5pc100-uart.2: s3c2410_serial2 at MMIO 0xec000800 (irq = 24) is a S3C6400/10
s5pc100-uart.3: s3c2410_serial3 at MMIO 0xec000c00 (irq = 28) is a S3C6400/10
brd: module loaded
loop: module loaded
pmem: 1 init
pmem_gpu1: 1 init
pmem_adsp: 1 init
Android kernel panic handler initialized (bind=panic)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
PPPoL2TP kernel driver, V1.0
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Invalid chip endian 0xffffffff
smc911x: not found (-19).
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver plusb
usbcore: registered new interface driver cdc_subset
Linux video capture interface: v2.00
S5PC100 MFC Driver, (c) 2009 Samsung Electronics
S3C G3D Driver, (c) 2007-2009 Samsung Electronics
s3c_g3d version : 0x1020100
G3D_RESERVED_MEM_SIZE : 32 MB
G3D_CHUNK_SIZE : 2 MB
G3D_CHUNK_NUM : 16
g3d is registered successfully!<4>Driver 'sd' needs updating - please
use bus_type methods
S3C NAND Driver, (c) 2008 Samsung Electronics
S3C NAND Driver is using hardware ECC.
NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB
3,3V 8-bit)
Creating 3 MTD partitions on "NAND 128MiB 3,3V 8-bit":
0x000000000000-0x000000080000 : "Bootloader"
0x000000080000-0x000000400000 : "Kernel"
0x000000400000-0x000008000000 : "File System"
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number 1
s3c2410-ohci s3c2410-ohci: irq 87, io mem 0xed400000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
s3c_otghcd s3c_otghcd: S3C OTGHCD
s3c_otghcd s3c_otghcd: new USB bus registered, assigned bus number 2
s3c_otghcd s3c_otghcd: irq 88, io mem 0xed200000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usbcore: registered new interface driver cdc_acm
cdc_acm: v0.26:USB Abstract Control Model driver for USB modems and
ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial Driver core
USB Serial support registered for GSM modem (1-port)
usbcore: registered new interface driver option
option: v0.7.2:USB Driver for GSM modems
android init
mice: could not register psaux device, error: -16
mice: PS/2 mouse device common for all mice
input: s3c-keypad as /class/input/input0
s3c-keypad Initialized
S3C Keypad Driver
S3C Touchscreen driver, (c) 2008 Samsung Electronics
S3C TouchScreen got loaded successfully : 12 bits
input: S3C TouchScreen as /class/input/input1
S3C24XX RTC, (c) 2004,2006 Simtec Electronics
s3c2410-rtc s3c2410-rtc: rtc disabled, re-enabling
s3c2410-rtc s3c2410-rtc: rtc core: registered s3c as rtc0
i2c /dev entries driver
s3c2410-i2c s3c2410-i2c.0: slave address 0x10
s3c2410-i2c s3c2410-i2c.0: bus frequency set to 379 KHz
s3c2410-i2c s3c2410-i2c.0: i2c-0: S3C I2C adapter
s3c2410-i2c s3c2410-i2c.1: slave address 0x10
s3c2410-i2c s3c2410-i2c.1: bus frequency set to 379 KHz
s3c2410-i2c s3c2410-i2c.1: i2c-1: S3C I2C adapter
S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics
s3c2410-wdt s3c2410-wdt: watchdog inactive, reset disabled, irq enabled
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: HCILL protocol initialized
Bluetooth: Broadcom Blutonium firmware driver ver 1.2
usbcore: registered new interface driver bcm203x
Bluetooth: Digianswer Bluetooth USB driver ver 0.10
usbcore: registered new interface driver bpa10x
Bluetooth: BlueFRITZ! USB driver ver 1.2
usbcore: registered new interface driver bfusb
Bluetooth: Generic Bluetooth USB driver ver 0.5
usbcore: registered new interface driver btusb
Bluetooth: Generic Bluetooth SDIO driver ver 0.1
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
s3c-sdhci s3c-sdhci.0: clock source 0: hsmmc (133500000 Hz)
s3c-sdhci s3c-sdhci.0: clock source 1: hsmmc (133500000 Hz)
s3c-sdhci s3c-sdhci.0: clock source 2: mmc_bus (44500000 Hz)
Registered led device: mmc0::
mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.0] using ADMA
s3c-sdhci s3c-sdhci.1: clock source 0: hsmmc (133500000 Hz)
s3c-sdhci s3c-sdhci.1: clock source 1: hsmmc (133500000 Hz)
s3c-sdhci s3c-sdhci.1: clock source 2: mmc_bus (44500000 Hz)
Registered led device: mmc1::
mmc1: SDHCI controller on samsung-hsmmc [s3c-sdhci.1] using ADMA
s3c-sdhci s3c-sdhci.2: clock source 0: hsmmc (133500000 Hz)
s3c-sdhci s3c-sdhci.2: clock source 1: hsmmc (133500000 Hz)
s3c-sdhci s3c-sdhci.2: clock source 2: mmc_bus (44500000 Hz)
Registered led device: mmc2::
mmc2: SDHCI controller on samsung-hsmmc [s3c-sdhci.2] using ADMA
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
logger: created 64K log 'log_main'
logger: created 256K log 'log_events'
logger: created 64K log 'log_radio'
Advanced Linux Sound Architecture Driver Version 1.0.18a.
No device for DAI CS42L52
asoc: CS42L52 <-> s5p-i2s-v5 mapping ok
CS42L52: soc_cs42l52_set_bias_level() off without power
CS42L52: soc_cs42l52_write() 0x2 = 9f (159)
CS42L52: soc_cs42l52_write() 0x3 = 07 (7)
CS42L52: soc_cs42l52_write() 0x0 = 99 (153)
mmc0: new high speed SD card at address 0007
mmcblk0: mmc0:0007 SD02G 1.84 GiB
 mmcblk0: p1
CS42L52: soc_cs42l52_write() 0x3e = ba (186)
CS42L52: soc_cs42l52_write() 0x47 = 80 (128)
CS42L52: soc_cs42l52_write() 0x32 = 80 (128)
CS42L52: soc_cs42l52_write() 0x32 = 00 (0)
CS42L52: soc_cs42l52_write() 0x0 = 00 (0)
CS42L52: Cirrus CS42L52 codec , revision 3
CS42L52: soc_cs42l52_write() 0x22 = f0 (240)
CS42L52: soc_cs42l52_write() 0x23 = f0 (240)
CS42L52: soc_cs42l52_write() 0x24 = f0 (240)
CS42L52: soc_cs42l52_write() 0x25 = f0 (240)
CS42L52: soc_cs42l52_write() 0x4 = 00 (0)
CS42L52: soc_cs42l52_write() 0x5 = 80 (128)
CS42L52: soc_cs42l52_write() 0xd = 80 (128)
CS42L52: soc_cs42l52_write() 0xe = 07 (7)
CS42L52: soc_cs42l52_write() 0x8 = 01 (1)
CS42L52: soc_cs42l52_write() 0x9 = 01 (1)
CS42L52: soc_cs42l52_write() 0x10 = 20 (32)
CS42L52: soc_cs42l52_write() 0x11 = 20 (32)
CS42L52: soc_cs42l52_write() 0xa = 09 (9)
CS42L52: soc_cs42l52_write() 0x12 = 0c (12)
CS42L52: soc_cs42l52_write() 0x13 = 0c (12)
CS42L52: soc_cs42l52_write() 0x16 = 0c (12)
CS42L52: soc_cs42l52_write() 0x17 = 0c (12)
CS42L52: soc_cs42l52_write() 0x2a = c0 (192)
CS42L52: soc_cs42l52_write() 0x2c = 04 (4)
CS42L52: soc_cs42l52_write() 0x2d = 49 (73)
CS42L52: soc_cs42l52_write() 0x1d = 06 (6)
CS42L52: soc_cs42l52_write() 0x18 = 98 (152)
CS42L52: soc_cs42l52_write() 0x19 = 98 (152)
DAPM CS42L52 sync
MIC-L/R: Off  in 1 out 0
 out static MICB
 out static MICA
Front-L/R: Off  in 0 out 1
 in  static SPKB
 in  static SPKA
MICB: Off  in 1 out 0
 in  static MIC-L/R
 out static MICB Switch
MICA: Off  in 1 out 0
 in  static MIC-L/R
 out static MICA Switch
INPUT4B: Off  in 1 out 0
 out static AIN4B Switch
INPUT3B: Off  in 1 out 0
 out static AIN3B Switch
INPUT2B: Off  in 1 out 0
 out static AIN2B Switch
INPUT1B: Off  in 1 out 0
 out static AIN1B Switch
 out AIN1 ADC Mux Right Capture Switch
INPUT4A: Off  in 1 out 0
 out static AIN4A Switch
INPUT3A: Off  in 1 out 0
 out static AIN3A Switch
INPUT2A: Off  in 1 out 0
 out static AIN2A Switch
INPUT1A: Off  in 1 out 0
 out static AIN1A Switch
 out AIN1 ADC Mux Left Capture Switch
MICBIAS: Off  in 0 out 1
SPKB: Off  in 0 out 1
 in  static SPK Pwr Right
 out static Front-L/R
SPKA: Off  in 0 out 1
 in  static SPK Pwr Left
 out static Front-L/R
HPB: Off  in 0 out 1
 in  static HP Amp Right
HPA: Off  in 0 out 1
 in  static HP Amp Left
SPK Pwr Right: Off  in 0 out 1
 in  static DAC Right
 out static SPKB
SPK Pwr Left: Off  in 0 out 1
 in  static DAC Left
 out static SPKA
HP Amp Right: Off  in 0 out 1
 in  static Passthrough Right Playback Switch
 out static HPB
HP Amp Left: Off  in 0 out 1
 in  static Passthrough Left Playback Switch
 out static HPA
DAC Right: Off  in 0 out 2
 out static SPK Pwr Right
 out Off Passthrough Right Playback Switch
DAC Left: Off  in 0 out 2
 out static SPK Pwr Left
 out Off Passthrough Left Playback Switch
Passthrough Right Playback Switch: Off  in 0 out 1
 in  Off DAC Right
 out static HP Amp Right
Passthrough Left Playback Switch: Off  in 0 out 1
 in  Off DAC Left
 out static HP Amp Left
PGA Right: Off  in 5 out 0
 in  static PGA MICB
 in  static AIN4B Switch
 in  static AIN3B Switch
 in  static AIN2B Switch
 in  static AIN1B Switch
PGA Left: Off  in 5 out 0
 in  static PGA MICA
 in  static AIN4A Switch
 in  static AIN3A Switch
 in  static AIN2A Switch
 in  static AIN1A Switch
Mic-Bias: Off  in 0 out 0
 in  static Mic Bias Capture Switch
 in  static Mic Bias Capture Switch
Mic Bias Capture Switch: Off  in 0 out 0
 out static Mic-Bias
 out static Mic-Bias
PGA MICB: Off  in 1 out 0
 in  static MICB Switch
 out static PGA Right
PGA MICA: Off  in 1 out 0
 in  static MICA Switch
 out static PGA Left
MICB Switch: Off  in 1 out 0
 in  static MICB
 out static PGA MICB
AIN4B Switch: Off  in 1 out 0
 in  static INPUT4B
 out static PGA Right
AIN3B Switch: Off  in 1 out 0
 in  static INPUT3B
 out static PGA Right
AIN2B Switch: Off  in 1 out 0
 in  static INPUT2B
 out static PGA Right
AIN1B Switch: Off  in 1 out 0
 in  static INPUT1B
 out static PGA Right
MICA Switch: Off  in 1 out 0
 in  static MICA
 out static PGA MICA
AIN4A Switch: Off  in 1 out 0
 in  static INPUT4A
 out static PGA Left
AIN3A Switch: Off  in 1 out 0
 in  static INPUT3A
 out static PGA Left
AIN2A Switch: Off  in 1 out 0
 in  static INPUT2A
 out static PGA Left
AIN1A Switch: Off  in 1 out 0
 in  static INPUT1A
 out static PGA Left
ADC Mux Right Capture Switch: Off  in 1 out 0
 in  AIN1 INPUT1B
 out static ADC Right
ADC Mux Left Capture Switch: Off  in 1 out 0
 in  AIN1 INPUT1A
 out static ADC Left
MICB Stereo Mux Capture Switch: Off  in 0 out 0
MICA Stereo Mux Capture Switch: Off  in 0 out 0
MICB Mux Capture Switch: Off  in 0 out 0
MICA Mux Capture Switch: Off  in 0 out 0
ADC Right: Off  in 1 out 0
 in  static ADC Mux Right Capture Switch
ADC Left: Off  in 1 out 0
 in  static ADC Mux Left Capture Switch
ALSA device list:
  #0: SMDKC100 (CS42L52)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.13
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.6
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
lib80211: common routines for IEEE802.11 drivers
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
s3c-fimc: fimc_configure_subdev: v4l2 subdev board registering failed
CS42L52: soc_cs42l52_set_bias_level() off with power
CS42L52: soc_cs42l52_write() 0x2 = 1e (30)
s3c-fimc: fimc_configure_subdev: v4l2 subdev board registering failed
s3c2410-rtc s3c2410-rtc: setting system clock to 2009-09-16 13:35:36
UTC (1253108136)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on mmcblk0p1, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) on device 179:1.
Freeing init memory: 216K
Executing mount /dev/mmcblk0p1 to /media/mmcblk0p1, action=add
INIT: Entering runlevel: 5
Starting Dropbear SSH server: dropbear.
Starting system message bus: dbus.
Starting syslogd/klogd: done
Starting Connection Manager
Starting GPE display manager: gpe-dm


S5PC1xx login:

C).  amixer  contents
root@S5PC1xx:~/work# amixer contents
numid=43,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=228,step=0
  : values=204,204
numid=40,iface=MIXER,name='Tone Control Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=31,iface=MIXER,name='PCM Mixer Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=30,iface=MIXER,name='PCM Mixer Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=127,step=0
  : values=103,103
numid=12,iface=MIXER,name='PCM Signal Polarity Playback Switch'
  ; type=ENUMERATED,access=rw------,values=2,items=2
  ; Item #0 'Normal'
  ; Item #1 'Inverted'
  : values=0,0
numid=72,iface=MIXER,name='Mic Bias Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'On'
  ; Item #1 'Off'
  : values=1
numid=20,iface=MIXER,name='Mic Gain Capture Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=31,step=0
  : values=0,0
numid=1,iface=MIXER,name='Mic VA Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=6
  ; Item #0 '0.5VA'
  ; Item #1 '0.6VA'
  ; Item #2 '0.7VA'
  ; Item #3 '0.8VA'
  ; Item #4 '0.83VA'
  ; Item #5 '0.91VA'
  : values=0
numid=29,iface=MIXER,name='ADC Mixer Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=28,iface=MIXER,name='ADC Mixer Capture Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=127,step=0
  : values=127,127
numid=74,iface=MIXER,name='ADC Mux Left Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=5
  ; Item #0 'AIN1'
  ; Item #1 'AIN2'
  ; Item #2 'AIN3'
  ; Item #3 'AIN4'
  ; Item #4 'PGA'
  : values=0
numid=73,iface=MIXER,name='ADC Mux Right Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=5
  ; Item #0 'AIN1'
  ; Item #1 'AIN2'
  ; Item #2 'AIN3'
  ; Item #3 'AIN4'
  ; Item #4 'PGA'
  : values=0
numid=27,iface=MIXER,name='ADC Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=26,iface=MIXER,name='ADC Capture Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=128,step=0
  : values=108,108
numid=11,iface=MIXER,name='Playback B=A Volume Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=69,iface=MIXER,name='Playback Charge Pump Freq'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=5
numid=57,iface=MIXER,name='ALC Attack Rate Capture Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=63,step=0
  : values=0
numid=56,iface=MIXER,name='ALC Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=59,iface=MIXER,name='ALC Max Threshold Capture Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=60,iface=MIXER,name='ALC Min Threshold Capture Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=1
numid=58,iface=MIXER,name='ALC Release Rate Capture Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=63,step=0
  : values=63
numid=21,iface=MIXER,name='ALC SR Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=22,iface=MIXER,name='ALC ZC Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=4,iface=MIXER,name='Analog SR Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,off
numid=5,iface=MIXER,name='Analog ZC Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,on
numid=39,iface=MIXER,name='Bass Corner Freq Playback Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 '50Hz'
  ; Item #1 '100Hz'
  ; Item #2 '200Hz'
  ; Item #3 '250Hz'
  : values=0
numid=42,iface=MIXER,name='Bass Gain Playback Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=7
numid=66,iface=MIXER,name='Batt Compensation Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=67,iface=MIXER,name='Batt VP Monitor Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=68,iface=MIXER,name='Batt VP ref'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=0
numid=32,iface=MIXER,name='Beep Freq'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=0
numid=37,iface=MIXER,name='Beep Mix Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=35,iface=MIXER,name='Beep OffTime'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=33,iface=MIXER,name='Beep OnTime'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=0
numid=36,iface=MIXER,name='Beep Type'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 'Off'
  ; Item #1 'Single'
  ; Item #2 'Multiple'
  ; Item #3 'Continuous'
  : values=0
numid=34,iface=MIXER,name='Beep Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=31,step=0
  : values=66
numid=13,iface=MIXER,name='Digital De-Emphasis Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=14,iface=MIXER,name='Digital SR Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=15,iface=MIXER,name='Digital ZC Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=7,iface=MIXER,name='Ganged Ctl Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=10,iface=MIXER,name='HP Analog Gain Playback Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=4
numid=45,iface=MIXER,name='HP Digital Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=44,iface=MIXER,name='HP Digital Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=255,step=0
  : values=239,239
numid=2,iface=MIXER,name='HPF Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=3,iface=MIXER,name='HPF Freeze Capture Switch'
  ; type=ENUMERATED,access=rw------,values=2,items=2
  ; Item #0 'Continuous DC Subtraction'
  ; Item #1 'Frozen DC Subtraction'
  : values=0,0
numid=6,iface=MIXER,name='HPF corner freq Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 'Normal'
  ; Item #1 '119Hz'
  ; Item #2 '236Hz'
  ; Item #3 '464Hz'
  : values=0
numid=55,iface=MIXER,name='Limiter Attack Rate Playback Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=63,step=0
  : values=0
numid=53,iface=MIXER,name='Limiter Attnenuate Playback Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Apply Specific'
  ; Item #1 'Apply All'
  : values=1
numid=49,iface=MIXER,name='Limiter Cushion Threshold Playback Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=48,iface=MIXER,name='Limiter Max Threshold Playback Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=0
numid=52,iface=MIXER,name='Limiter Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=54,iface=MIXER,name='Limiter Release Rate Playback Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=63,step=0
  : values=63
numid=50,iface=MIXER,name='Limiter SR Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=51,iface=MIXER,name='Limiter ZC Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=78,iface=MIXER,name='MICA Mux Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'MIC1'
  ; Item #1 'MIC2'
  : values=0
numid=76,iface=MIXER,name='MICA Stereo Mux Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Mono'
  ; Item #1 'Stereo'
  : values=1
numid=77,iface=MIXER,name='MICB Mux Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'MIC1'
  ; Item #1 'MIC2'
  : values=0
numid=75,iface=MIXER,name='MICB Stereo Mux Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Mono'
  ; Item #1 'Stereo'
  : values=1
numid=8,iface=MIXER,name='Mix/Swap Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 'Normal'
  ; Item #1 'Sum half'
  ; Item #2 'Sub half'
  ; Item #3 'Inverted'
  : values=0
numid=63,iface=MIXER,name='Noise Gate Boost Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=62,iface=MIXER,name='Noise Gate Capture Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=65,iface=MIXER,name='Noise Gate Delay Time Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 '50ms'
  ; Item #1 '100ms'
  ; Item #2 '150ms'
  ; Item #3 '200ms'
  : values=1
numid=64,iface=MIXER,name='Noise Gate Threshold Capture Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=7,step=0
  : values=2
numid=61,iface=MIXER,name='Noise Gate Type Capture Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Apply Specific'
  ; Item #1 'Apply All'
  : values=0
numid=23,iface=MIXER,name='PGA Capture Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=48,step=0
  : values=52,52
numid=71,iface=MIXER,name='Passthrough Left Playback Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Off'
  ; Item #1 'On'
  : values=0
numid=70,iface=MIXER,name='Passthrough Right Playback Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Off'
  ; Item #1 'On'
  : values=0
numid=25,iface=MIXER,name='Passthru Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=24,iface=MIXER,name='Passthru Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=144,step=0
  : values=120,120
numid=9,iface=MIXER,name='Signal Polarity Capture Switch'
  ; type=ENUMERATED,access=rw------,values=2,items=2
  ; Item #0 'Normal'
  ; Item #1 'Inverted'
  : values=0,0
numid=47,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=46,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw------,values=2,min=0,max=255,step=0
  : values=239,239
numid=19,iface=MIXER,name='Spk Full-Bridge Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=17,iface=MIXER,name='Spk Mute 50/50 Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=18,iface=MIXER,name='Spk Swap Channel Playback Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'ChannelA'
  ; Item #1 'ChannelB'
  : values=0
numid=16,iface=MIXER,name='Spk Volume Equal Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=38,iface=MIXER,name='Treble Corner Freq Playback Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=4
  ; Item #0 '5kHz'
  ; Item #1 '7kHz'
  ; Item #2 '10kHz'
  ; Item #3 '15kHz'
  : values=0
numid=41,iface=MIXER,name='Treble Gain Playback Volume'
  ; type=INTEGER,access=rw------,values=1,min=0,max=15,step=0
  : values=7
root@S5PC1xx:~/work#


D).  aplay  wav  file

root@S5PC1xx:~/work# aplay aaaa
Playing raw data 'aaaa' : Unsigned 8 bit, Rate 8000 HzCS42L52:
soc_cs42l52_set_fmt() Enter soc_cs42l52_set_fmt
CS42L52: soc_cs42l52_set_fmt() codec dai fmt slave
CS42L52: soc_cs42l52_set_fmt() codec dai fmt i2s
CS42L52: soc_cs42l52_set_fmt() codec dai fmt normal sclk
CS42L52: soc_cs42l52_write() 0x6 = 24 (36)
, Mono
CS42L52: soc_cs42l52_write() 0x5 = a0 (160)
CS42L52: soc_cs42l52_write() 0x6 = 24 (36)
CS42L52: soc_cs42l52_set_bias_level() partial on
CS42L52: soc_cs42l52_write() 0x2 = 1e (30)
CS42L52: soc_cs42l52_write() 0x4 = 51 (81)
CS42L52: soc_cs42l52_write() 0x4 = 50 (80)
CS42L52: soc_cs42l52_write() 0x4 = 10 (16)
CS42L52: soc_cs42l52_write() 0x4 = 00 (0)
DAPM CS42L52 snd_soc_dapm_stream_event
MIC-L/R: Off  in 1 out 0
 out static MICB
 out static MICA
Front-L/R: On  in 2 out 1
 in  static SPKB
 in  static SPKA
MICB: Off  in 1 out 0
 in  static MIC-L/R
 out static MICB Switch
MICA: Off  in 1 out 0
 in  static MIC-L/R
 out static MICA Switch
INPUT4B: Off  in 1 out 0
 out static AIN4B Switch
INPUT3B: Off  in 1 out 0
 out static AIN3B Switch
INPUT2B: Off  in 1 out 0
 out static AIN2B Switch
INPUT1B: Off  in 1 out 0
 out static AIN1B Switch
 out AIN1 ADC Mux Right Capture Switch
INPUT4A: Off  in 1 out 0
 out static AIN4A Switch
INPUT3A: Off  in 1 out 0
 out static AIN3A Switch
INPUT2A: Off  in 1 out 0
 out static AIN2A Switch
INPUT1A: Off  in 1 out 0
 out static AIN1A Switch
 out AIN1 ADC Mux Left Capture Switch
MICBIAS: Off  in 0 out 1
SPKB: Off  in 1 out 1
 in  static SPK Pwr Right
 out static Front-L/R
SPKA: Off  in 1 out 1
 in  static SPK Pwr Left
 out static Front-L/R
HPB: Off  in 1 out 1
 in  static HP Amp Right
HPA: Off  in 1 out 1
 in  static HP Amp Left
SPK Pwr Right: On  in 1 out 1
 in  static DAC Right
 out static SPKB
SPK Pwr Left: On  in 1 out 1
 in  static DAC Left
 out static SPKA
HP Amp Right: On  in 1 out 1
 in  static Passthrough Right Playback Switch
 out static HPB
HP Amp Left: On  in 1 out 1
 in  static Passthrough Left Playback Switch
 out static HPA
DAC Right: On  in 1 out 2
 out static SPK Pwr Right
 out Off Passthrough Right Playback Switch
DAC Left: On  in 1 out 2
 out static SPK Pwr Left
 out Off Passthrough Left Playback Switch
Passthrough Right Playback Switch: On  in 1 out 1
 in  Off DAC Right
 out static HP Amp Right
Passthrough Left Playback Switch: On  in 1 out 1
 in  Off DAC Left
 out static HP Amp Left
PGA Right: Off  in 5 out 0
 in  static PGA MICB
 in  static AIN4B Switch
 in  static AIN3B Switch
 in  static AIN2B Switch
 in  static AIN1B Switch
PGA Left: Off  in 5 out 0
 in  static PGA MICA
 in  static AIN4A Switch
 in  static AIN3A Switch
 in  static AIN2A Switch
 in  static AIN1A Switch
Mic-Bias: Off  in 0 out 0
 in  static Mic Bias Capture Switch
 in  static Mic Bias Capture Switch
Mic Bias Capture Switch: Off  in 0 out 0
 out static Mic-Bias
 out static Mic-Bias
PGA MICB: Off  in 1 out 0
 in  static MICB Switch
 out static PGA Right
PGA MICA: Off  in 1 out 0
 in  static MICA Switch
 out static PGA Left
MICB Switch: Off  in 1 out 0
 in  static MICB
 out static PGA MICB
AIN4B Switch: Off  in 1 out 0
 in  static INPUT4B
 out static PGA Right
AIN3B Switch: Off  in 1 out 0
 in  static INPUT3B
 out static PGA Right
AIN2B Switch: Off  in 1 out 0
 in  static INPUT2B
 out static PGA Right
AIN1B Switch: Off  in 1 out 0
 in  static INPUT1B
 out static PGA Right
MICA Switch: Off  in 1 out 0
 in  static MICA
 out static PGA MICA
AIN4A Switch: Off  in 1 out 0
 in  static INPUT4A
 out static PGA Left
AIN3A Switch: Off  in 1 out 0
 in  static INPUT3A
 out static PGA Left
AIN2A Switch: Off  in 1 out 0
 in  static INPUT2A
 out static PGA Left
AIN1A Switch: Off  in 1 out 0
 in  static INPUT1A
 out static PGA Left
ADC Mux Right Capture Switch: Off  in 1 out 0
 in  AIN1 INPUT1B
 out static ADC Right
ADC Mux Left Capture Switch: Off  in 1 out 0
 in  AIN1 INPUT1A
 out static ADC Left
MICB Stereo Mux Capture Switch: Off  in 0 out 0
MICA Stereo Mux Capture Switch: Off  in 0 out 0
MICB Mux Capture Switch: Off  in 0 out 0
MICA Mux Capture Switch: Off  in 0 out 0
ADC Right: Off  in 1 out 0
 in  static ADC Mux Right Capture Switch
ADC Left: Off  in 1 out 0
 in  static ADC Mux Left Capture Switch
CS42L52: soc_cs42l52_set_bias_level() full on
CS42L52: soc_cs42l52_write() 0xd = 80 (128)
CS42L52: soc_cs42l52_write() 0xd = 83 (131)
CS42L52: soc_cs42l52_write() 0xd = 83 (131)
CS42L52: soc_cs42l52_write() 0xd = 83 (131)
root@S5PC1xx:~/work# CS42L52: soc_cs42l52_write() 0x4 = 04 (4)
CS42L52: soc_cs42l52_write() 0x4 = 05 (5)
CS42L52: soc_cs42l52_write() 0x4 = 45 (69)
CS42L52: soc_cs42l52_write() 0x4 = 55 (85)
DAPM CS42L52 snd_soc_dapm_stream_event
MIC-L/R: Off  in 1 out 0
 out static MICB
 out static MICA
Front-L/R: Off  in 0 out 1
 in  static SPKB
 in  static SPKA
MICB: Off  in 1 out 0
 in  static MIC-L/R
 out static MICB Switch
MICA: Off  in 1 out 0
 in  static MIC-L/R
 out static MICA Switch
INPUT4B: Off  in 1 out 0
 out static AIN4B Switch
INPUT3B: Off  in 1 out 0
 out static AIN3B Switch
INPUT2B: Off  in 1 out 0
 out static AIN2B Switch
INPUT1B: Off  in 1 out 0
 out static AIN1B Switch
 out AIN1 ADC Mux Right Capture Switch
INPUT4A: Off  in 1 out 0
 out static AIN4A Switch
INPUT3A: Off  in 1 out 0
 out static AIN3A Switch
INPUT2A: Off  in 1 out 0
 out static AIN2A Switch
INPUT1A: Off  in 1 out 0
 out static AIN1A Switch
 out AIN1 ADC Mux Left Capture Switch
MICBIAS: Off  in 0 out 1
SPKB: Off  in 0 out 1
 in  static SPK Pwr Right
 out static Front-L/R
SPKA: Off  in 0 out 1
 in  static SPK Pwr Left
 out static Front-L/R
HPB: Off  in 0 out 1
 in  static HP Amp Right
HPA: Off  in 0 out 1
 in  static HP Amp Left
SPK Pwr Right: Off  in 0 out 1
 in  static DAC Right
 out static SPKB
SPK Pwr Left: Off  in 0 out 1
 in  static DAC Left
 out static SPKA
HP Amp Right: Off  in 0 out 1
 in  static Passthrough Right Playback Switch
 out static HPB
HP Amp Left: Off  in 0 out 1
 in  static Passthrough Left Playback Switch
 out static HPA
DAC Right: Off  in 0 out 2
 out static SPK Pwr Right
 out Off Passthrough Right Playback Switch
DAC Left: Off  in 0 out 2
 out static SPK Pwr Left
 out Off Passthrough Left Playback Switch
Passthrough Right Playback Switch: Off  in 0 out 1
 in  Off DAC Right
 out static HP Amp Right
Passthrough Left Playback Switch: Off  in 0 out 1
 in  Off DAC Left
 out static HP Amp Left
PGA Right: Off  in 5 out 0
 in  static PGA MICB
 in  static AIN4B Switch
 in  static AIN3B Switch
 in  static AIN2B Switch
 in  static AIN1B Switch
PGA Left: Off  in 5 out 0
 in  static PGA MICA
 in  static AIN4A Switch
 in  static AIN3A Switch
 in  static AIN2A Switch
 in  static AIN1A Switch
Mic-Bias: Off  in 0 out 0
 in  static Mic Bias Capture Switch
 in  static Mic Bias Capture Switch
Mic Bias Capture Switch: Off  in 0 out 0
 out static Mic-Bias
 out static Mic-Bias
PGA MICB: Off  in 1 out 0
 in  static MICB Switch
 out static PGA Right
PGA MICA: Off  in 1 out 0
 in  static MICA Switch
 out static PGA Left
MICB Switch: Off  in 1 out 0
 in  static MICB
 out static PGA MICB
AIN4B Switch: Off  in 1 out 0
 in  static INPUT4B
 out static PGA Right
AIN3B Switch: Off  in 1 out 0
 in  static INPUT3B
 out static PGA Right
AIN2B Switch: Off  in 1 out 0
 in  static INPUT2B
 out static PGA Right
AIN1B Switch: Off  in 1 out 0
 in  static INPUT1B
 out static PGA Right
MICA Switch: Off  in 1 out 0
 in  static MICA
 out static PGA MICA
AIN4A Switch: Off  in 1 out 0
 in  static INPUT4A
 out static PGA Left
AIN3A Switch: Off  in 1 out 0
 in  static INPUT3A
 out static PGA Left
AIN2A Switch: Off  in 1 out 0
 in  static INPUT2A
 out static PGA Left
AIN1A Switch: Off  in 1 out 0
 in  static INPUT1A
 out static PGA Left
ADC Mux Right Capture Switch: Off  in 1 out 0
 in  AIN1 INPUT1B
 out static ADC Right
ADC Mux Left Capture Switch: Off  in 1 out 0
 in  AIN1 INPUT1A
 out static ADC Left
MICB Stereo Mux Capture Switch: Off  in 0 out 0
MICA Stereo Mux Capture Switch: Off  in 0 out 0
MICB Mux Capture Switch: Off  in 0 out 0
MICA Mux Capture Switch: Off  in 0 out 0
ADC Right: Off  in 1 out 0
 in  static ADC Mux Right Capture Switch
ADC Left: Off  in 1 out 0
 in  static ADC Mux Left Capture Switch
