From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] ASoC/multi-component: fix au1x platform
Date: Thu, 19 Aug 2010 17:59:24 +0200
Message-ID: <AANLkTikMknoV5GDOCw1_B8jwXy6S7zZ7OidcXAjS_FBf@mail.gmail.com>
References: <AANLkTikyZKhs6t8RRRd36KjW_Enb-+NGvUCraxEakHO5@mail.gmail.com>
	<20100819140649.GA29395@opensource.wolfsonmicro.com>
	<AANLkTik_VdzUEZ0+079iZciOryRbFNDyjE-jdzJXztcW@mail.gmail.com>
	<20100819143555.GB29453@opensource.wolfsonmicro.com>
	<AANLkTikUN0xDGnDPk7Jxk9YihOD3mPxRzxhv+s+A5Fsz@mail.gmail.com>
	<20100819144841.GC29453@opensource.wolfsonmicro.com>
	<AANLkTimbasVqtJLeg-F+M9Ry9AzLgy8EG213vy_rEbc=@mail.gmail.com>
	<20100819155244.GB9307@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5846924490
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 17:59:25 +0200 (CEST)
Received: by yxp4 with SMTP id 4so838884yxp.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 08:59:24 -0700 (PDT)
In-Reply-To: <20100819155244.GB9307@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 5:52 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Aug 19, 2010 at 04:58:55PM +0200, Manuel Lauss wrote:
>> On Thu, Aug 19, 2010 at 4:48 PM, Mark Brown
>
> Please remember to keep people CCed on Linux mailing list postings.
>
>> > The struct snd_ac97 * passed in to them has a pointer to the struct
>> > snd_card * for the card which should (via some further indirection)
>> > allow you to get back to the ASoC specific structures.
>
>> Are there an in-tree examples I could look at? =A0(and for example on how
>> to pass per-instance platform data around? =A0It's not immediately obvio=
us
>> to me how to get data allocated in a platform_driver.probe() callback to
>> the various dai_ops and pcm_ops).
>
> This is the only embedded device I've ever seen where anyone wanted to
> use multiple AC97 controllers so not directly. =A0If you look at the SoC
> core you can see how the various ALSA structures are converted into ASoC
> specific ones, though.

There are up to four PSCs, each capable of both AC97 and I2S operation,
with separate RX and TX DMA channels. I consider each PSC a separate "card".

I figured out how to access platform data in dai_ops,  however I see absolu=
tely
no way to get at it from the ac97_ops.


Manuel
