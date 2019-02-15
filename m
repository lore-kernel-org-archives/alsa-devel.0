From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] ASoC: simple-card: fixup refcount_t
	underflow
Date: Fri, 15 Feb 2019 18:48:26 +0200
Message-ID: <CAEnQRZC+jDPRLhNEY5xP9AFxvqFvjBVRDxVfNbgfURudXuO1FQ@mail.gmail.com>
References: <878syh8svy.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZD3CRzHDd-eGbVWqBUmNuqGaXJwTboQ3v1TnZAN3B_4bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 98301265523
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 13:13:12 +0100 (CET)
Received: by mail-ed1-f67.google.com with SMTP id j89so4228691edb.9
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 04:13:12 -0800 (PST)
In-Reply-To: <CAEnQRZD3CRzHDd-eGbVWqBUmNuqGaXJwTboQ3v1TnZAN3B_4bw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Vicente Bergas <vicencb@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Ok, I think you are using an older code base.

Here is the patch that works for me:

--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -445,7 +445,7 @@ static int simple_for_each_link(struct simple_priv *priv,
        /* Check if it has dai-link */
        node = of_get_child_by_name(top, PREFIX "dai-link");
        if (!node) {
-               node = top;
+               node = of_node_get(top);
                is_top = 1;
        }

Not sure if is correct, though.

On Fri, Feb 15, 2019 at 3:57 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> Hi,
>
> This patch doesn't seem to apply on Mark's sound/for-next branch.
>
> What is the tree you based this on?
>
> thanks,
> Daniel.
> On Fri, Feb 15, 2019 at 8:43 AM Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >
> >
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > commit da215354eb55c ("ASoC: simple-card: merge simple-scu-card")
> > merged simple-card and simple-scu-card. Then it had refcount
> > underflow bug. This patch fixup it.
> > We will get below error without this patch.
> >
> >         OF: ERROR: Bad of_node_put() on /sound
> >         CPU: 3 PID: 237 Comm: kworker/3:1 Not tainted 5.0.0-rc6+ #1514
> >         Hardware name: Renesas H3ULCB Kingfisher board based on r8a7795 ES2.0+ (DT)
> >         Workqueue: events deferred_probe_work_func
> >         Call trace:
> >          dump_backtrace+0x0/0x150
> >          show_stack+0x24/0x30
> >          dump_stack+0xb0/0xec
> >          of_node_release+0xd0/0xd8
> >          kobject_put+0x74/0xe8
> >          of_node_put+0x24/0x30
> >          __of_get_next_child+0x50/0x70
> >          of_get_next_child+0x40/0x68
> >          asoc_simple_card_probe+0x604/0x730
> >          platform_drv_probe+0x58/0xa8
> >          ...
> > Reported-by: Vicente Bergas <vicencb@gmail.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > Vicente, can you please test this patch ?
> >
> >  sound/soc/generic/simple-card.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> > index 37e001c..3fe3441 100644
> > --- a/sound/soc/generic/simple-card.c
> > +++ b/sound/soc/generic/simple-card.c
> > @@ -462,7 +462,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
> >         conf_idx        = 0;
> >         node = of_get_child_by_name(top, PREFIX "dai-link");
> >         if (!node) {
> > -               node = dev->of_node;
> > +               node = of_node_get(top);
> >                 loop = 0;
> >         }
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
