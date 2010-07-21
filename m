From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: ASoC: multi-component updates from RFC
Date: Wed, 21 Jul 2010 13:31:30 +0100
Message-ID: <1279715490.3072.51.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EA5AC103924
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 14:31:32 +0200 (CEST)
Received: by wwd20 with SMTP id 20so293389wwd.2
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 05:31:32 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

I've just pushed some updates to multi-component that came out of the
RFC discussion.

The main update is the use of dev_name (or DAI name for devices with
multiple DAIs) to identify ASoC components. This replaces the current
method of using a struct codec|dai|platform pointer and ID to define a
DAI link. e.g. we can now define a DAI link as follows :-

static struct snd_soc_dai_link sdp3430_dai[] = {
	{
		.name = "TWL4030 I2S",
		.stream_name = "TWL4030 Audio",
		.cpu_dai_name = "omap-mcbsp-dai.1",
		.codec_dai_name = "twl4030-hifi",
		.platform_name = "omap-pcm-audio",
		.codec_name = "twl4030-codec",
		.init = sdp3430_twl4030_init,
		.ops = &sdp3430_ops,
	},
	{
		.name = "TWL4030 PCM",
		.stream_name = "TWL4030 Voice",
		.cpu_dai_name = "omap-mcbsp-dai.2",
		.codec_dai_name = "twl4030-voice",
		.platform_name = "omap-pcm-audio",
		.codec_name = "twl4030-codec",
		.init = sdp3430_twl4030_voice_init,
		.ops = &sdp3430_voice_ops,
	},
};

This now means we now no longer have to export all the CODEC | DAI |
platform structure symbols around and can keep them static. We also
manage to delete a few headers as a result of this change.

Since we are now using dev_name or DAI name (for single devices with
multiple DAIs) I've taken the opportunity to standardise the ASoC
component naming. It's currently very ad-hoc and platform specific, so
I've now added some useful prefixes to help. e.g. So we now have :-

"-codec" prefix for codecs, e.g. "wm8731-codec"
"-dai" prefix for CPU DAI's e.g. "pxa-i2s-dai"
"-hifi", -"voice", etc for CODEC DAIs e.g. "wm8731-hifi"
"-pcm-audio" for platform DMA, e.g. "pxa-pcm-audio" for PXA DMA
(although most platform DMA controllers used this anyway).

This naming standard will also come in handy for device tree too.

The only other change I've made is fixing the twl4030 and DAC33 codec
probe and remove (as spotted by Peter).

I've also received and applied numerous patches from Jarkko, Timur,
Ryan, Chanwoo, Joonyoug, Kyungmin, Jassi and Seungwhan.

The multi-component code can be found here :-

git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git topic/multi-component

As usual, please give this some testing (especially ASoC platform
maintainers) and if all is OK we can upstream some time next week (or
the week after).

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
