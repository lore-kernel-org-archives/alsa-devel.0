From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: asoc multi-component: almost there!
Date: Tue, 27 Jul 2010 18:26:30 +0100
Message-ID: <1280251590.3085.112.camel@odin>
References: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
	<1280238546.3085.89.camel@odin>
	<AANLkTikGhu8EVLozlBWmC6Tuu_gHZX_mkTRImsMo91TE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 789D9245CF
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 19:26:33 +0200 (CEST)
Received: by wwe15 with SMTP id 15so1630wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2010 10:26:33 -0700 (PDT)
In-Reply-To: <AANLkTikGhu8EVLozlBWmC6Tuu_gHZX_mkTRImsMo91TE@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur.tabi@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-07-27 at 10:20 -0500, Timur Tabi wrote:
> On Tue, Jul 27, 2010 at 8:49 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> 
> > Each machine DAI link now has a sysfs entry so we can inspect its
> > configuration/status now.
> 
> I have a suspicion that this will totally break my code.

I think you are probably a special case here since you are the only
person who is dynamically building a DAI link array atm. Everyone else
has a static table. To further complicate matters, you are having to
read from a device tree that has not been optimised for creating ASoC
DAI link tables (hence the meeting at UDS this year to come up with some
device tree ASoC format).

Fwiw, I've just again tested another multiple DAI mapping to single
CODEC DAI :-

 	{
		.name = "DAI test1",
		.stream_name = "Multimedia",

		.cpu_dai_name = "omap-mcbsp-dai.1",
		.platform_name = "omap-pcm-audio",

		.codec_dai_name =  "twl6040-dl1",
		.codec_name = "twl6040-codec",
	},
	{
		.name = "DAI test2",
		.stream_name = "Multimedia",

		.cpu_dai_name = "omap-mcbsp-dai.3",
		.platform_name = "omap-pcm-audio",

		.codec_dai_name =  "twl6040-dl1",
		.codec_name = "twl6040-codec",
	}


Works fine for me.

> 
> > Hence each machine DAI link must be named
> > differently. You could have a "cs4270 playback" and "cs4270 capture" DAI
> > links now.
> 
> That won't work either.  For one thing, the CS4270 driver registers
> only one DAI, and it's called "cs4270-hifi".  So I have to call it
> "cs4270-hifi".  So I can't call it anything else.

I was meaning the DAI _link_ name (above as "DAI test1" and "DAI test
2") and not the CODEC DAI name ("twl6040-dl1" above).

I think you should be creating two DAI links like this:-

	{
		.name = "cs4270-playback",
		.stream_name = "Playback",

		.cpu_dai_name = "fsl-ssi-blah.0",
		.platform_name = "fsl-blah-pcm-audio",

		.codec_dai_name =  "cs4270-hifi",
		.codec_name = "cs4270-codec-addr",
	},
	{
		.name = "cs4270-capture",
		.stream_name = "Capture",

		.cpu_dai_name = "fsl-ssi-blah.1",
		.platform_name = "fsl-blah-pcm-audio",

		.codec_dai_name =  "cs4270-hifi",
		.codec_name = "cs4270-codec-addr",
	},

The only differences between both DAI links is the name, stream_name and
cpu_dai_name (iirc your DMA has to be different too?)

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
