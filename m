From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] sound: soc: wm8903: Cut gpio_base data
Date: Tue, 18 Sep 2018 19:07:54 -0700
Message-ID: <CACRpkdZziWXhTpL_MUcsFJ7ZzR6Patq5mhfcxnj5BRu506erQQ@mail.gmail.com>
References: <20180918191233.17178-1-linus.walleij@linaro.org>
 <20180918195220.GX2471@sirena.org.uk>
 <CACRpkdazTEdc2u1u_Z0f_uVUiufzdkz1jYpSziVTPXKhCXxovg@mail.gmail.com>
 <20180919000950.GA2471@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D0F726761D
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2018 04:08:08 +0200 (CEST)
Received: by mail-io1-f65.google.com with SMTP id q4-v6so3221755iob.8
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 19:08:08 -0700 (PDT)
In-Reply-To: <20180919000950.GA2471@sirena.org.uk>
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

On Tue, Sep 18, 2018 at 5:09 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 18, 2018 at 04:51:23PM -0700, Linus Walleij wrote:
>
> > Since there are no boards defining platform data (hence patch 1)
> > I assume all users are using device tree and thus dynamic
> > GPIO number assignment, so this can go.
>
> > Even if new board files are added they should use machine
> > descriptor tables for referencing the individual GPIO chip and
> > offset. In this case by the label "wm8903" and local offset.
>
> I tend to worry about breaking out of tree users unless there's an
> active reason to do it, is there something coming along - this looked
> more like just a cleanup?

This is to get rid of the global GPIO numberspace, little by little.
As long as we hardcode the base of the GPIO chip anywhere,
that numberspace prevails.

Yours,
Linus Walleij
