From: Alexander <subaparts@yandex.ru>
Subject: New SoC layer codec registration problem
Date: Thu, 28 Oct 2010 13:12:20 +0400
Message-ID: <1288257140.2098.41.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward1.mail.yandex.net (forward1.mail.yandex.net [77.88.46.6])
	by alsa0.perex.cz (Postfix) with ESMTP id B02DC2432C
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 11:12:30 +0200 (CEST)
Received: from smtp2.mail.yandex.net (smtp2.mail.yandex.net [77.88.46.102])
	by forward1.mail.yandex.net (Yandex) with ESMTP id 22EF369E9803
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2010 13:12:30 +0400 (MSD)
Received: from [192.168.1.202] (ppp85-141-164-146.pppoe.mtu-net.ru
	[85.141.164.146])
	by smtp2.mail.yandex.net (Yandex) with ESMTPA id B37DC52809D
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2010 13:12:29 +0400 (MSD)
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

I'm trying to implement new SoC codec in linux-next-20101025 kernel.

Part of the code:
---
#if defined(CONFIG_SPI_MASTER)
static int __devinit cs4271_spi_probe(struct spi_device *spi)
{
	struct cs4271_private *cs4271;
	int ret;

	cs4271 = kzalloc(sizeof *cs4271, GFP_KERNEL);
	if (!cs4271)
		return -ENOMEM;

	spi_set_drvdata(spi, cs4271);
	cs4271->control_data = spi;
	cs4271->bus_type = SND_SOC_SPI;

	ret = snd_soc_register_codec(&spi->dev, &soc_codec_dev_cs4271,
				     &cs4271_dai, 1);
	if (ret < 0)
		kfree(cs4271);
	return ret;
}

static int __devexit cs4271_spi_remove(struct spi_device *spi)
{
	snd_soc_unregister_codec(&spi->dev);
	kfree(spi_get_drvdata(spi));
	return 0;
}

static struct spi_driver cs4271_spi_driver = {
	.driver = {
		.name	= "cs4271-codec",
		.owner	= THIS_MODULE,
	},
	.probe		= cs4271_spi_probe,
	.remove		= __devexit_p(cs4271_spi_remove),
};
#endif /* defined(CONFIG_SPI_MASTER) */
---

So, codec name I expect is "cs4271-codec", but codec registered with
name "spi0.0"

Here is boot log:
---
Jan  1 00:00:04 miniCio user.debug kernel: cs4271-codec spi0.0: codec
register spi0.0
Jan  1 00:00:04 miniCio user.debug kernel: cs4271-codec spi0.0: dai
register spi0.0 #1
Jan  1 00:00:04 miniCio user.debug kernel: Registered DAI 'cs4271-hifi'
Jan  1 00:00:04 miniCio user.debug kernel: Registered codec 'spi0.0'
Jan  1 00:00:04 miniCio user.info kernel: Codec driver for CS4271
registered
Jan  1 00:00:04 miniCio user.debug kernel: ep93xx-pcm-audio
ep93xx-pcm-audio: platform register ep93xx-pcm-audio
Jan  1 00:00:04 miniCio user.debug kernel: Registered platform
'ep93xx-pcm-audio'
Jan  1 00:00:04 miniCio user.debug kernel: ep93xx-i2s ep93xx-i2s: dai
register ep93xx-i2s
Jan  1 00:00:04 miniCio user.debug kernel: Registered DAI 'ep93xx-i2s'
Jan  1 00:00:04 miniCio user.debug kernel: soc-audio soc-audio: binding
CS4271 at idx 0
Jan  1 00:00:04 miniCio user.debug kernel: soc-audio soc-audio: CODEC
cs4271-codec not registered
Jan  1 00:00:04 miniCio user.debug kernel: soc-audio soc-audio:
Registered card 'EDB93XX'
Jan  1 00:00:04 miniCio user.info kernel: EDB93xx Machine ALSA Driver
Jan  1 00:00:04 miniCio user.info kernel: ALSA device list:
Jan  1 00:00:04 miniCio user.info kernel:   No soundcards found.
---

What am I doing wrong?

Alexander.
