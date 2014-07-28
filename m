From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 08:54:13 -0400
Message-ID: <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
 <53D5ECA7.5090106@metafoo.de>
 <20140728112055.GM17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C6662619FE
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 14:54:14 +0200 (CEST)
Received: by mail-la0-f42.google.com with SMTP id pv20so5507106lab.29
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 05:54:13 -0700 (PDT)
In-Reply-To: <20140728112055.GM17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 28, 2014 at 7:20 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 28, 2014 at 08:24:39AM +0200, Lars-Peter Clausen wrote:
>> Cc ASoC maintainers.
>
> Jon, you should really know to CC maintainers.

Are the all CC'd now? I thought the ALSA list was sufficient.

So how do I set this hardware up?

on-chip codec - it is ADC/DAC with FIFIO directly attached. There is
no separate bus. on-chip codec supports things like mic1, mic2, line
in, line out, hp out. Most boards populate only a subset of the jacks.
Right now the device driver makes a dummy codec and internally creates
a card and links everything together.
http://git.elopez.com.ar/linux/src/abc050fbbaa5302b76ac585954cd207961fc9159/sound/soc/sunxi/sunxi-codec.c?at=sunxi-codec

Then someone came along and wanted to add a MAX9768. We're stuck
because the way the driver is built it doesn't support the external
MAX9768 codec driver.  MAX9768 is just an amp with I2C control of
volume.

So how should the device tree look for no external amp? Right now
there is just a device node and the driver makes a card/dummy-codec
internally.

How should the device tree look when there is an external amp?  Maybe
this amp should just be a chip of the device node?

How should the various jack populations be handled in the device tree?

-- 
Jon Smirl
jonsmirl@gmail.com
