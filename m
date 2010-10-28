From: Alexander <subaparts@yandex.ru>
Subject: Re: New SoC layer codec registration problem
Date: Fri, 29 Oct 2010 02:24:43 +0400
Message-ID: <1288304683.2098.54.camel@r60e>
References: <1288257140.2098.41.camel@r60e>
	<AANLkTi=wCBkw7v7xMwbcf7F_qQSyD6zb=HTnqeD+EGHM@mail.gmail.com>
	<1288281110.2098.47.camel@r60e> <20101028183302.GA14076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward3.mail.yandex.net (forward3.mail.yandex.net [77.88.46.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E59D24403
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 00:24:49 +0200 (CEST)
In-Reply-To: <20101028183302.GA14076@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Victor Rodriguez <vm.rod25@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello!

On Thu, 2010-10-28 at 19:33 +0100, Mark Brown wrote:
> > The question is why fmt_single_name() picks up "spi0.0" instead of
> > "cs4271-codec", I've added some debug output. And this function relies
> 
> We identify devices based on something unique per device so that if you
> have more than one device of the same type in a system the stack can
> tell them apart.
> 

My machine driver contains the following structures:

---
static struct snd_soc_dai_link edb93xx_dai = {
	.name		= "CS4271",
	.stream_name	= "CS4271 HiFi",
	.platform_name	= "ep93xx-pcm-audio",
	.cpu_dai_name	= "ep93xx-i2s",
	.codec_name	= "cs4271-codec",
	.codec_dai_name	= "cs4271-hifi",
	.ops		= &edb93xx_ops,
};

static struct snd_soc_card snd_soc_edb93xx = {
	.name		= "EDB93XX",
	.dai_link	= &edb93xx_dai,
	.num_links	= 1,
};
---

And all other machine SoC drivers contain similar...
If instead I'll write 
.codec_name = "spi0.0",

it will be strange... However it can work...

Alexander.
