From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v2 1/9] ASoC: sun4i-i2s: Add compatibility
	with A64 codec I2S
Date: Fri, 19 Oct 2018 09:16:56 -0700
Message-ID: <CA+E=qVfRzWYELnvkV+5sq8mDOCMF49Ng0eU57qRQyZadHGQ3Wg@mail.gmail.com>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-2-anarsoul@gmail.com>
 <20181015081836.onjczcsg5qwp6rbt@flea> <2698773.RERkv2aHyz@anarsoul-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D388726751A
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 18:17:24 +0200 (CEST)
Received: by mail-ot1-f67.google.com with SMTP id w67so33698697ota.7
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 09:17:24 -0700 (PDT)
In-Reply-To: <2698773.RERkv2aHyz@anarsoul-thinkpad>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, arm-linux <linux-arm-kernel@lists.infradead.org>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 19, 2018 at 9:14 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Monday, October 15, 2018 1:18:36 AM PDT Maxime Ripard wrote:
> > On Sat, Oct 13, 2018 at 09:53:21AM -0700, Vasily Khoruzhick wrote:
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > The I2S block used for the audio codec in the A64 differs from other 3
> > > I2S modules in A64 and isn't compatible with H3. But it is very similar
> > > to what is found in A10(sun4i). However, its TX FIFO is
> > > located at a different address.
> > >
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Mark, can you pick this patch up please?

Ooops, wrong patch, please ignore this message.

>
> Thanks!
>
> Regards,
> Vasily
>
> >
> > Maxime
>
>
>
>
