From: Timur Tabi <timur.tabi@gmail.com>
Subject: asoc multi-component: almost there!
Date: Mon, 26 Jul 2010 17:37:42 -0500
Message-ID: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 32652243A9
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 00:38:15 +0200 (CEST)
Received: by vws20 with SMTP id 20so3375614vws.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 15:38:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Liam,

I almost got it working.  I can generate names that match, so it finds it:

soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
dai_link->cpu_dai_name=e0016000.ssi
soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
dai_link->codec_name=cs4270-codec.0-004f
soc_bind_dai_link:1169 codec_dai->name=e0016000.ssi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1169 codec_dai->name=cs4270-hifi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1194 platform->name=e0021180.dma-channel,
dai_link->platform_name=e0021100.dma-channel
soc_bind_dai_link:1194 platform->name=e0021100.dma-channel,
dai_link->platform_name=e0021100.dma-channel
soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
dai_link->cpu_dai_name=e0016000.ssi
soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
dai_link->codec_name=cs4270-codec.0-004f
soc_bind_dai_link:1169 codec_dai->name=e0016000.ssi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1169 codec_dai->name=cs4270-hifi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1194 platform->name=e0021180.dma-channel,
dai_link->platform_name=e0021180.dma-channel
asoc: cs4270-hifi <-> e0016000.ssi mapping ok

but then I get this:

sysfs: cannot create duplicate filename '/devices/platform/soc-audio/cs4270'

I'm registering two DAIs -- one for playback, one for capture, but I'm
using the same name for the codec DAI.  How do I resolve this?

-- 
Timur Tabi
Linux kernel developer at Freescale
