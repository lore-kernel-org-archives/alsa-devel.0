From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [RFC][ASoC] New device/driver arch
Date: Thu, 14 Jun 2007 18:40:32 +0100
Message-ID: <1181842832.26658.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id C15BD245B3
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2007 19:40:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@freescale.com>, Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

I'd like to gather some feedback on some changes I've been making to
ASoC recently. The changes were made to fit in better with the PPC
device tree and to help with easier porting to new platforms. They were
also introduced to make dealing with device probe errors (e.g. I2C probe
failure) a little easier.

The largest change is the introduction of an ASoC bus device. All
component drivers (that is, codec, codec DAI, CPU DAI, and DMA PCM
drivers) register with this bus. This should simplify device
registration and hopefully better fit in with the PPC model. A component
driver now typically consists of the standard driver ops and a set of
ASoC/ALSA ops to configure audio.

The new soc.h shows this here :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob;f=include/sound/soc.h;h=af7ee8140273028a419b4cc60b5f07b4fe511a64;hb=ppc-dev

Example component drivers are here :-

I2S

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob;f=sound/soc/pxa/pxa2xx-i2s.c;h=e058295fdfe05573a5a892c3a2afc90fcb35472a;hb=ppc-dev

DMA

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob;f=sound/soc/pxa/pxa2xx-pcm.c;h=679aef6c95ad90e45a2ea41bed51c4dc353d0918;hb=ppc-dev


WM8753 Codec

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob;f=sound/soc/codecs/wm8753.c;h=f1d49d9bb2a37c48556e7d9039540d362e65af22;hb=ppc-dev


Another major change is that there is no more snd_dai_link (structure
that connected codec <--> CPU). This has been replaced by an ASoC PCM
device that describes each PCM device in the machine. This new ASoC PCM
device has it's own driver and registers with the bus (like the others).
This allows an ASoC PCM driver to be defined like :-

static struct snd_soc_device_driver hifi_pcm_drv = {
	.type	= SND_SOC_BUS_TYPE_PCM,
	.driver	= {
		.name	= "mainstone-hifi-pcm",
		.owner	= THIS_MODULE,
		.probe	= hifi_pcm_probe,
		.remove = hifi_pcm_remove,
	},
	.components	= {
		.cpu_dai 	= pxa2xx_i2s,
		.codec		= wm8753_codec,
		.codec_dai	= wm8753_hifi_dai,
		.platform	= pxa2xx_pcm,
	},
};

This now shows each component within the driver structure.

The snd_soc_machine driver has changed and can now contain numerous ASoC
PCM devices. It is now a platform driver.

Example machine driver for Mainstone with WM8753 is here :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob;f=sound/soc/pxa/mainstone_wm8753.c;h=a49c1c528063494aeadee26ea3e07405c3a8762e;hb=ppc-dev

The machine driver now also does the I2C/SPI probing (instead of the
codec) and also does any codec IO (to better support multiple
controllers). 

Fwiw, I've not tested any of this code atm. I plan to start this
tomorrow on pxa2xx and i.MX31 and would like to get some feedback before
porting remaining platforms and codecs over.

Liam
