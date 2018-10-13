From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 03/10] ASoC: sun8i-codec: add support for
 speaker amp GPIO
Date: Fri, 12 Oct 2018 21:21:02 -0700
Message-ID: <CA+E=qVeS4hhwFiu-Q939R6DLcf0aZg2SnMB6KZ0kvsC8kRgMiw@mail.gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
 <20181013033230.6506-4-anarsoul@gmail.com>
 <CAGb2v66sfw6AQFjCjDA5JwYsE4zOaKjxjSLX5J8vq=wZrdHDVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 64B8B2678CA
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 06:21:30 +0200 (CEST)
Received: by mail-oi1-f194.google.com with SMTP id w81-v6so11382103oiw.9
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 21:21:30 -0700 (PDT)
In-Reply-To: <CAGb2v66sfw6AQFjCjDA5JwYsE4zOaKjxjSLX5J8vq=wZrdHDVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 12, 2018 at 9:00 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Sat, Oct 13, 2018 at 11:33 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > Some boards may have external amplifier for speaker that is controlled
> > via GPIO, add support for it in similar way as it's done in sun4i-codec
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> ASoC now has a generic amplifier driver. Please use that instead.
>
> See Documentation/devicetree/bindings/sound/simple-amplifier.txt

Is there any example on how to use it? Documentation doesn't specify
what DAPM routes I have to add to get it working.

>
> ChenYu
