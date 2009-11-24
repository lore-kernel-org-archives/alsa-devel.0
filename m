From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Handling two audio codec in the same kernel
Date: Tue, 24 Nov 2009 10:37:41 -0600
Message-ID: <4B0C0BD5.9050407@ridgerun.com>
References: <1253647760-32558-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090922213604.GB4736@sirena.org.uk>
	<4ABA3C52.6010509@ridgerun.com>
	<20090923154916.GA4257@sirena.org.uk>
	<4ABA4855.9080201@ridgerun.com>
	<20090923163914.GB31134@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 1903F1037EA
	for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2009 17:37:42 +0100 (CET)
In-Reply-To: <20090923163914.GB31134@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I have been working on developing the voice codec driver for the davinci 
platforms, in particularly for the DM365 EVM. This board has one AIC codec and 
one voice codec.

Some time ago I sent the initial patch for adding support for the Voice codec. 
You suggested me that I should register in the case of DM365 EVM both codecs in 
the same kernel (AIC and Voice Codec):

>> [MA] But how I can tell the kernel to use one or the other one in 
>> runtime?, and Why do we need to have both compiled at the same time? if 
>> this is really needed What is the best way to that?
> 
> The kernel would just expose both devices to user space so the choice
> would be down to the application layer.  This would give maximum
> flexibility to systems, allowing them to chop and change at runtime if
> they needed to for some reason (eg, using a lower quality but lower
> power voice output for telephony style applications but a higer quality
> higher power output for MP3 playback).  It'd also mean that for the EVM
> the user would be able to use a single kernel image to evaluate both
> outputs which makes life easier for things like distros.
> 

There was another problem because both codecs share the same DMA channels, 
however this it was solved by following your suggestion:

> The implementation I suggested above with returning EBUSY if the DMA is
> already in use would probably work.
> 

At this point the both drivers AIC and Voice Codec are implemented, and also the 
logic to handle the dma channels properly.

I have some questions:

* How is the proper way to register both codecs in the same kernel?
* If I have registered in the same kernel, How I can choose the codec that will 
be used in the alsamixer menu?

At this point I have added the following structures to the 
sound/soc/davinci/davinci-evm.c file:

static struct snd_soc_dai_link dm365_evm_dai[] = {
	{
		.name = "TLV320AIC3X",
		.stream_name = "AIC3X",
		.cpu_dai = &davinci_i2s_dai,
		.codec_dai = &aic3x_dai,
		.init = evm_aic3x_init,
		.ops = &evm_ops,
	},
	{
		.name = "Voice Codec - CQ93VC",
		.stream_name = "CQ93",
		.cpu_dai = &davinci_vcif_dai,
		.codec_dai = &cq93vc_dai,
	},
};

/* davinci dm365 evm audio machine driver external or internal */
static struct snd_soc_card dm365_snd_soc_card_evm = {
	.name = "DaVinci DM365 EVM",
	.platform = &davinci_soc_platform,
	.dai_link = dm365_evm_dai,
	.num_links = ARRAY_SIZE(dm365_evm_dai),
};

/* evm audio subsystem */
static struct snd_soc_device dm365_evm_snd_devdata = {
	.card = &dm365_snd_soc_card_evm,
	.codec_dev = &soc_codec_dev_aic3x,  // Only codec_dev at time?
	.codec_data = &aic3x_setup,
};

This is the output:
...
 > Advanced Linux Sound Architecture Driver Version 1.0.21.
 > No device for DAI tlv320aic3x
 > No device for DAI davinci-i2s
 > asoc: tlv320aic3x <-> davinci-i2s mapping ok
 > asoc: CQ93VC <-> davinci-vcif mapping ok
 > ALSA device list:
 >   #0: DaVinci DM365 EVM (tlv320aic3x)
 > ...


root@dm365-evm:/apps# arecord -D 'plughw:0,0'| aplay -D 'plughw:0,0' &
Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
Playing WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono

root@dm365-evm:/apps# arecord -D 'plughw:0,1'| aplay -D 'plughw:0,1'
davinci_pcm: Failed to get dma channels
asoc: can't open platform davinci-audio
arecord: main:608: audio open error: Device or resource busy
davinci_pcm: Failed to get dma channels
asoc: can't open platform davinci-audio
aplay: main:608: audio open error: Device or resource busy

root@dm365-evm:/apps# arecord -D 'plughw:0,1'| aplay -D 'plughw:0,1' &
Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
Playing WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono

root@dm365-evm:/apps# arecord -D 'plughw:0,0'| aplay -D 'plughw:0,0'
davinci_pcm: Failed to get dma channels
asoc: can't open platform davinci-audio
davinci_pcm: Failed to get dma channels
arecord: main:60asoc: can't open platform davinci-audio
8: audio open error: Device or resource busy
aplay: main:608: audio open error: Device or resource busy

You can do different combinations as well -
root@dm365-evm:/apps# arecord -D 'plughw:0,0'| aplay -D 'plughw:0,1'
Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
Playing WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono

root@dm365-evm:/apps# arecord -D 'plughw:0,1'| aplay -D 'plughw:0,0'
Recording WAVE 'stdin' : Unsigned 8 bit, ate 8000 Hz, Mono
Playing WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono

The DMA logic works fine as you see in the examples above. However, only the AIC 
works recording/playback, the voice codec doesn't work. If I switch the default 
codec to Voice Codec it works.

Thanks,
Miguel Aguilar
