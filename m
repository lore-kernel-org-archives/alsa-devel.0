From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: add codec driver for TI TAS5086
Date: Wed, 22 May 2013 13:50:21 -0400
Message-ID: <CAKON4OyqoUTsYHqv3kW3jN9Za=-Z866rcjPiANL8t5uyraK=6w@mail.gmail.com>
References: <1362740833-15704-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
 [209.85.217.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 513E2260899
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:50:22 +0200 (CEST)
Received: by mail-lb0-f177.google.com with SMTP id o10so2377881lbi.8
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 10:50:21 -0700 (PDT)
In-Reply-To: <1362740833-15704-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 8, 2013 at 6:07 AM, Daniel Mack <zonque@gmail.com> wrote:
> This patch adds a driver for TI's TA5086 6-channel PWM processor.
>
> This chip has a very unusual register layout, specifically because the
> registers are of unequal size, and multi-byte registers require bulk
> writes to take effect. Regmap does not support these kind of mappings.
>
> Currently, the driver does not touch any of the registers >= 0x20, so
> it doesn't matter, because the register map is mapped to an 8-bit array.
> In case more features will be added in the future that require access
> to higher registers, the entire regmap H/W I/O routines have to be
> open-coded.

Check out my tas5504 driver from a long time ago. It dealt with those registers.

https://github.com/jonsmirl/mpc5200/blob/master/sound/soc/codecs/tas5504.c
https://github.com/jonsmirl/mpc5200/blob/master/sound/soc/codecs/tas5504.h

--
Jon Smirl
jonsmirl@gmail.com
