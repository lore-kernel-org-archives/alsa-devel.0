From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Wed, 8 May 2013 14:14:12 -0300
Message-ID: <CAOMZO5CzDGJ+UD6L4UAmzAg5evN5cru26HdnSiUJUSNqSiEHJA@mail.gmail.com>
References: <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
 <20130505101515.GT4945@sirena.org.uk>
 <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
 <20130506220650.GJ7478@sirena.org.uk>
 <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
 <20130508103150.GW7478@sirena.org.uk>
 <518A608E.8030802@boundarydevices.com>
 <20130508145919.GU7478@sirena.org.uk>
 <20130508151128.GW7478@sirena.org.uk>
 <CAOMZO5DYBONvbEQQd1_CUB7VhVn7pyxB=ms7u-uiJpWS4OSMAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f180.google.com (mail-ve0-f180.google.com
 [209.85.128.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C5352616FF
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 19:14:13 +0200 (CEST)
Received: by mail-ve0-f180.google.com with SMTP id pa12so1996551veb.39
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 10:14:12 -0700 (PDT)
In-Reply-To: <CAOMZO5DYBONvbEQQd1_CUB7VhVn7pyxB=ms7u-uiJpWS4OSMAw@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Matt Sealey <matt@genesi-usa.com>, Eric Nelson <eric.nelson@boundarydevices.com>, "troy.kisky" <troy.kisky@boundarydevices.com>, "zengzm.kernel" <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 8, 2013 at 1:02 PM, Fabio Estevam <festevam@gmail.com> wrote:

> When using regmap, the 'defaults_raw' variants must be used, as these are the
> ones checked inside drivers/base/regmap/regcache.c

Please ignore this comment. I fixed it in the patch I have just submitted.
