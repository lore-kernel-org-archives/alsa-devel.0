From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] sound: soc: wm8903: Cut gpio_base data
Date: Tue, 18 Sep 2018 16:51:23 -0700
Message-ID: <CACRpkdazTEdc2u1u_Z0f_uVUiufzdkz1jYpSziVTPXKhCXxovg@mail.gmail.com>
References: <20180918191233.17178-1-linus.walleij@linaro.org>
 <20180918195220.GX2471@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id BB11D26761D
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2018 01:51:37 +0200 (CEST)
Received: by mail-it0-f68.google.com with SMTP id h1-v6so5410758itj.4
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 16:51:37 -0700 (PDT)
In-Reply-To: <20180918195220.GX2471@sirena.org.uk>
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
Cc: patches@opensource.cirrus.com, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 18, 2018 at 12:52 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 18, 2018 at 12:12:33PM -0700, Linus Walleij wrote:
> > This variable is only used inside the file, and we should
> > never hard-code the GPIO base, so delete this.
>
> Adding the Cirrus people again...

Sorry about all beginners mistakes :/

> hard coding the GPIO base is needed
> for board file based systems if they're using GPIO numbers isn't it?

It is needed if there are board files hardcoding GPIOs referencing
the global number range on this specific gpiochip.

Since there are no boards defining platform data (hence patch 1)
I assume all users are using device tree and thus dynamic
GPIO number assignment, so this can go.

Even if new board files are added they should use machine
descriptor tables for referencing the individual GPIO chip and
offset. In this case by the label "wm8903" and local offset.

Yours,
Linus Walleij
