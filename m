From: Vishal Thanki <vishalthanki@gmail.com>
Subject: Re: [PATCH] ASoC: simple-card: Add a NULL pointer
	check in asoc_simple_card_dai_link_of
Date: Thu, 5 Mar 2015 16:15:16 +0530
Message-ID: <CAC3a_SDWqGLsgUu8_mRYkW=Y+KHvWvAWjUYr4Ba3BrDBiP6nNA@mail.gmail.com>
References: <20150303132900.GA22246@vishal> <54F76B43.3030602@bfs.de>
Reply-To: vishal.thanki@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E47D265677
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 11:45:37 +0100 (CET)
Received: by iecat20 with SMTP id at20so21822211iec.6
 for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2015 02:45:37 -0800 (PST)
In-Reply-To: <54F76B43.3030602@bfs.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: wharms@bfs.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

I am new to kasprintf. I think we need to make sure of freeing memory
allocated using kasprintf.

On Thu, Mar 5, 2015 at 1:59 AM, walter harms <wharms@bfs.de> wrote:

>
>
> Am 03.03.2015 14:29, schrieb Vishal Thanki:
> > Make sure devm_kzalloc() succeeds.
> >
> > Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>
> > ---
> >  sound/soc/generic/simple-card.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/sound/soc/generic/simple-card.c
> b/sound/soc/generic/simple-card.c
> > index f7c6734..fb550b5 100644
> > --- a/sound/soc/generic/simple-card.c
> > +++ b/sound/soc/generic/simple-card.c
> > @@ -372,6 +372,11 @@ static int asoc_simple_card_dai_link_of(struct
> device_node *node,
> >                           strlen(dai_link->cpu_dai_name)   +
> >                           strlen(dai_link->codec_dai_name) + 2,
> >                           GFP_KERNEL);
> > +     if (!name) {
> > +             ret = -ENOMEM;
> > +             goto dai_link_of_err;
> > +     }
> > +
> >       sprintf(name, "%s-%s", dai_link->cpu_dai_name,
> >                               dai_link->codec_dai_name);
> >       dai_link->name = dai_link->stream_name = name;
>
>
> maybe it is more simple to use kasprintf here ?
>
> just my 2 cents,
> wh
>
>
