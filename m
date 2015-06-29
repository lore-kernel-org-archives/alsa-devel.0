From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: ASoC: 88pm860x: Question about
 pm860x_set_dai_sysclk implementation
Date: Mon, 29 Jun 2015 10:49:10 +0800
Message-ID: <1435546150.1744.2.camel@linaro.org>
References: <1435503659.6929.1.camel@ingics.com>
 <1435543330.1744.1.camel@linaro.org>
 <CAFRkauDr1p3eeMzMzUJBqHuxgndiHs8kW3uWP9NwtVBd3xZR7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C42E26518B
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 04:49:08 +0200 (CEST)
Received: by pdcu2 with SMTP id u2so107973750pdc.3
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 19:49:06 -0700 (PDT)
In-Reply-To: <CAFRkauDr1p3eeMzMzUJBqHuxgndiHs8kW3uWP9NwtVBd3xZR7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-06-29 at 10:27 +0800, Axel Lin wrote:
> 2015-06-29 10:02 GMT+08:00 Haojian Zhuang <haojian.zhuang@linaro.org>:
> > On Sun, 2015-06-28 at 23:00 +0800, Axel Lin wrote:
> >> Hi Haojian,
> >> In sound/soc/codecs/88pm860x-codec.c (pm860x_set_dai_sysclk):
> >> When dir != PM860X_CLK_DIR_OUT, current code set
> >> pm860x->dir = PM860X_CLK_DIR_IN; and then return -EINVAL.
> >> This looks confusion.
> >> Since there is no comment for that, I'm wondering if the
> >> return -EINVAL is intentional or not.
> >>
> >> Regards,
> >> Axel
> >>
> >
> > Hi Axel,
> >
> > Since we didn't support slave mode in our solution, I just return
> > -EINVAL for PM860X_CLK_DIR_IN. I'm sorry to add the confused code.
> > Could you help to format a patch to add the comments?
> 
> The main confusion part is current code actually *changes* pm860x->dir setting
> when return -EINVAL in pm860x_set_dai_sysclk.
> (And the pm860x->dir is used in pm860x_pcm_set_dai_fmt.)
> so I'm wondering if it make sense to just return -EINVAL without setting
> pm860x->dir = PM860X_CLK_DIR_IN; in pm860x_set_dai_sysclk.

It's fine to return -EINVAL directly without setting pm680x->dir.

Regards
Haojian
