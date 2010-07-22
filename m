From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC: multi-component updates from RFC
Date: Thu, 22 Jul 2010 09:18:24 +0100
Message-ID: <1279786704.3083.22.camel@odin>
References: <1279715490.3072.51.camel@odin>
	<201007220927.16738.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ABF09103801
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 10:18:28 +0200 (CEST)
Received: by wyb42 with SMTP id 42so330897wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 01:18:28 -0700 (PDT)
In-Reply-To: <201007220927.16738.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-07-22 at 09:27 +0300, Peter Ujfalusi wrote:
> Hello Liam,
> 
> On Wednesday 21 July 2010 15:31:30 ext Liam Girdwood wrote:
> 
> ...
> 
> > The only other change I've made is fixing the twl4030 and DAC33 codec
> > probe and remove (as spotted by Peter).
> 
> I'm in the process of checking the changes.
> For the twl4030 I have spotted the following:
> 1. twl-core registers "twl4030_codec" platform device.
> 2. The driver for this is the drivers/mfd/twl4030-codec.c
> 3. this MFD driver registers the following platform devices:
>    twl4030_codec_audio
>    twl4030_codec_vibra
> 4. the sound/soc/codecs/twl4030.c is the twl4030_codec_audio driver

Ah, I didn't see that part. I'll revert the twl-core name change.

> 5. the drivers/input/misc/twl4030-vibra.c is the twl4030_codec_vibra driver
> Note: the platform data is propagated from board files to mfd/twl4030-codec.c, 
> than this mfd driver passes the appropriate platform data to the soc codec, and 
> vibra driver.
> 
> The codec part of twl40x0, twl50x0 has vibra and audio functionality, and they 
> have interoperability problems (sharing the same resources).
> 

I'm actually looking into the interop problems later as twl6040 + vibra
has the same issues.

> The name for the drivers/mfd/twl4030-codec.c is chosen, because the TRM refers 
> to this block as codec (audio + vibra).
> We could go, and rename however this mfd driver to twl4030-audio (since the TRM 
> randomly refers to audio block instead of codec).
> Than we can have twl4030-codec as device name for the soc codec, and twl4030-
> vibra for the vibra.
> 

Agreed, I'll make that change.

> I'll continue on checking the changes...
> 

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
