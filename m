From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: asoc multi-component: almost there!
Date: Tue, 27 Jul 2010 11:42:15 +0100
Message-ID: <1280227335.3085.29.camel@odin>
References: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 798EB244CD
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 12:42:19 +0200 (CEST)
Received: by wyb42 with SMTP id 42so2815813wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2010 03:42:18 -0700 (PDT)
In-Reply-To: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
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

On Mon, 2010-07-26 at 17:37 -0500, Timur Tabi wrote:
> Liam,
> 
> I almost got it working.  I can generate names that match, so it finds it:
> 
> soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
> dai_link->cpu_dai_name=e0016000.ssi
> soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
> dai_link->codec_name=cs4270-codec.0-004f
> soc_bind_dai_link:1169 codec_dai->name=e0016000.ssi,
> dai_link->codec_dai_name=cs4270-hifi
> soc_bind_dai_link:1169 codec_dai->name=cs4270-hifi,
> dai_link->codec_dai_name=cs4270-hifi
> soc_bind_dai_link:1194 platform->name=e0021180.dma-channel,
> dai_link->platform_name=e0021100.dma-channel
> soc_bind_dai_link:1194 platform->name=e0021100.dma-channel,
> dai_link->platform_name=e0021100.dma-channel
> soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
> dai_link->cpu_dai_name=e0016000.ssi
> soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
> dai_link->codec_name=cs4270-codec.0-004f
> soc_bind_dai_link:1169 codec_dai->name=e0016000.ssi,
> dai_link->codec_dai_name=cs4270-hifi
> soc_bind_dai_link:1169 codec_dai->name=cs4270-hifi,
> dai_link->codec_dai_name=cs4270-hifi
> soc_bind_dai_link:1194 platform->name=e0021180.dma-channel,
> dai_link->platform_name=e0021180.dma-channel
> asoc: cs4270-hifi <-> e0016000.ssi mapping ok
> 
> but then I get this:
> 
> sysfs: cannot create duplicate filename '/devices/platform/soc-audio/cs4270'
> 
> I'm registering two DAIs -- one for playback, one for capture, but I'm
> using the same name for the codec DAI.  How do I resolve this?

You don't need to register two CODEC DAIs here. One will do, since we
only have the one CODEC.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
