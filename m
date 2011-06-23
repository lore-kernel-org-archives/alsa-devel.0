From: Marco Sinigaglia <marco.sinigaglia@csr.com>
Subject: ALSA SoC on Android problems
Date: Thu, 23 Jun 2011 16:37:46 +0100
Message-ID: <4E035DCA.9010409@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-d.mailcontrol.com (cluster-d.mailcontrol.com
	[85.115.60.190]) by alsa0.perex.cz (Postfix) with ESMTP id 00D78244A9
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 17:38:23 +0200 (CEST)
Received: from CAMEUREXB02.EUROPE.ROOT.PRI ([193.128.72.68])
	by rly05d.srv.mailcontrol.com (MailControl) with ESMTP id
	p5NFcFTA028498
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 16:38:17 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to enable the WM9714 attached to a S3C6410 through the AC97 Bus.
I am using the Android Gingerbread running the kernel linux-2.6.35.

I am not sure if this is the right mailing list, please redirect me if 
it is not.

I can see, on the kernel source,  that there is the WM9713 codec but not 
the WM9714. Is this a problem?

I am quite sure that the  kernel does not find/setup the WM9714. 
Assuming that is the kernel that has to configure it, do I have to setup 
something?
I can see that, on linux-2.6.35/sound/soc/codecs/wm9713.c, the 
wm9713_soc_probe function is not call. Nevertheless, the smdk_wm9713.c 
does run the smdk_init without errors.

The kernel log is following:

No device for DAI AD73311
Asahi Kasei AK4104 ALSA SoC Codec Driver
No device for DAI AK4535
Cirrus Logic CS4270 ALSA SoC Codec Driver
No device for DAI PCM3008 HiFi
No device for DAI SSM2602
No device for DAI tlv320aic23
No device for DAI UDA134X
No device for DAI WM8510 HiFi
No device for DAI WM8728
No device for DAI WM8971
No device for DAI WM8990 ADC/DAC Primary
ALSA device list:
   No soundcards found.

Indeed, the user space is complaining:

E/ALSALib (   53): 
external/alsa-lib/src/control/control.c:902:(snd_ctl_open_noupdate) 
Invalid CTL AndroidOut
W/AudioHardwareALSA(   53): Unable to attach mixer to device AndroidOut: 
No such file or directory
E/AudioHardwareALSA(   53): Unable to attach mixer to device default: No 
such file or directory
E/ALSALib (   53): 
external/alsa-lib/src/control/control.c:902:(snd_ctl_open_noupdate) 
Invalid CTL AndroidIn


Kernel config :

# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_JACK=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
# CONFIG_SND_RAWMIDI_SEQ is not set
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_ARM=y
# CONFIG_SND_SPI is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_S3C24XX_SOC=y
CONFIG_SND_S3C_I2SV2_SOC=y
CONFIG_SND_S3C64XX_SOC_I2S_V4=y
CONFIG_SND_S3C_SOC_AC97=y
CONFIG_SND_S3C64XX_SOC_WM8580=y
CONFIG_SND_SOC_SMDK_WM9713=y
CONFIG_SND_SOC_I2C_AND_SPI=y
CONFIG_SND_SOC_ALL_CODECS=y
CONFIG_SND_SOC_WM_HUBS=y
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_AD1836=y
CONFIG_SND_SOC_AD193X=y
CONFIG_SND_SOC_AD1980=y
CONFIG_SND_SOC_AD73311=y
CONFIG_SND_SOC_ADS117X=y
CONFIG_SND_SOC_AK4104=y
CONFIG_SND_SOC_AK4535=y
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK4671=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_DA7210=y
CONFIG_SND_SOC_L3=y
CONFIG_SND_SOC_PCM3008=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_STAC9766=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC26=y
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320DAC33=y
CONFIG_SND_SOC_UDA134X=y
CONFIG_SND_SOC_UDA1380=y
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8727=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8900=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8940=y
CONFIG_SND_SOC_WM8955=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8961=y
CONFIG_SND_SOC_WM8971=y
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8988=y
CONFIG_SND_SOC_WM8990=y
CONFIG_SND_SOC_WM8993=y
CONFIG_SND_SOC_WM9081=y
CONFIG_SND_SOC_WM9705=y
CONFIG_SND_SOC_WM9712=y
CONFIG_SND_SOC_WM9713=y
CONFIG_SND_SOC_MAX9877=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SOC_WM2000=y
CONFIG_SND_SOC_WM9090=y
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=y
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HIDRAW is not set
# CONFIG_HID_PID is not set


Cheers
Marco



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
