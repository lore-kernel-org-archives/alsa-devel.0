From: Alexander <subaparts@yandex.ru>
Subject: Re: New SoC layer codec registration problem
Date: Thu, 28 Oct 2010 19:51:50 +0400
Message-ID: <1288281110.2098.47.camel@r60e>
References: <1288257140.2098.41.camel@r60e>
	<AANLkTi=wCBkw7v7xMwbcf7F_qQSyD6zb=HTnqeD+EGHM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward19.mail.yandex.net (forward19.mail.yandex.net
	[95.108.253.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DF982451D
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 17:52:00 +0200 (CEST)
In-Reply-To: <AANLkTi=wCBkw7v7xMwbcf7F_qQSyD6zb=HTnqeD+EGHM@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Victor Rodriguez <vm.rod25@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Thu, 2010-10-28 at 09:07 -0500, Victor Rodriguez wrote:
> O        ret = snd_soc_register_codec(&spi->dev, &soc_codec_dev_cs4271,
> >                                     &cs4271_dai, 1);
> 
> Sorry for this maybe I am wrong but shouldn't this bee with {}
> >        if (ret < 0) {
> >                kfree(cs4271);
> >                return ret;
>           }
> Thanks
> 
> Victor Rodriguez

Oh, no, this part is correct, I'm sure.
The question is why fmt_single_name() picks up "spi0.0" instead of
"cs4271-codec", I've added some debug output. And this function relies
on dev_name() instead of dev->driver->name, this works in 2 of 3 cases
(where one string equals another):
---
Jan  1 00:00:04 miniCio user.debug kernel: cs4271-codec spi0.0: codec
register spi0.0
Jan  1 00:00:04 miniCio user.info kernel: dev_name=spi0.0
Jan  1 00:00:04 miniCio user.info kernel: dev->driver->name=cs4271-codec
Jan  1 00:00:04 miniCio user.debug kernel: cs4271-codec spi0.0: dai
register spi0.0 #1
Jan  1 00:00:04 miniCio user.debug kernel: Registered DAI 'cs4271-hifi'
Jan  1 00:00:04 miniCio user.debug kernel: Registered codec 'spi0.0'
Jan  1 00:00:04 miniCio user.info kernel: Codec driver for CS4271
registered
Jan  1 00:00:04 miniCio user.debug kernel: ep93xx-pcm-audio
ep93xx-pcm-audio: platform register ep93xx-pcm-audio
Jan  1 00:00:04 miniCio user.info kernel: dev_name=ep93xx-pcm-audio
Jan  1 00:00:04 miniCio user.info kernel:
dev->driver->name=ep93xx-pcm-audio
Jan  1 00:00:04 miniCio user.debug kernel: Registered platform
'ep93xx-pcm-audio'
Jan  1 00:00:04 miniCio user.debug kernel: ep93xx-i2s ep93xx-i2s: dai
register ep93xx-i2s
Jan  1 00:00:04 miniCio user.info kernel: dev_name=ep93xx-i2s
Jan  1 00:00:04 miniCio user.info kernel: dev->driver->name=ep93xx-i2s
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
