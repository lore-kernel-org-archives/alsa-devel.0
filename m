From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] ALSA: seq: Fix OOB-reads from strlcpy
Date: Thu, 4 Apr 2019 14:52:51 -0700
Message-ID: <CABXOdTeM-9m+ezp5NZpvc6gKutd=1qwwCzkpxAXQ1+ZeqdyNeg@mail.gmail.com>
References: <20190404213355.76452-1-zsm@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 037D7F80714
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 23:53:04 +0200 (CEST)
Received: by mail-yw1-xc44.google.com with SMTP id v127so1552921ywe.13
 for <alsa-devel@alsa-project.org>; Thu, 04 Apr 2019 14:53:04 -0700 (PDT)
In-Reply-To: <20190404213355.76452-1-zsm@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Zubin Mithra <zsm@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 4, 2019 at 2:34 PM Zubin Mithra <zsm@chromium.org> wrote:
>
> When ioctl calls are made with non-null-terminated userspace strings,
> strlcpy causes an OOB-read from within strlen. Fix by changing to use
> strscpy instead.
>
> Signed-off-by: Zubin Mithra <zsm@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  sound/core/seq/seq_clientmgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
> index 7d4640d1fe9fb..38e7deab63847 100644
> --- a/sound/core/seq/seq_clientmgr.c
> +++ b/sound/core/seq/seq_clientmgr.c
> @@ -1252,7 +1252,7 @@ static int snd_seq_ioctl_set_client_info(struct snd_seq_client *client,
>
>         /* fill the info fields */
>         if (client_info->name[0])
> -               strlcpy(client->name, client_info->name, sizeof(client->name));
> +               strscpy(client->name, client_info->name, sizeof(client->name));
>
>         client->filter = client_info->filter;
>         client->event_lost = client_info->event_lost;
> @@ -1530,7 +1530,7 @@ static int snd_seq_ioctl_create_queue(struct snd_seq_client *client, void *arg)
>         /* set queue name */
>         if (!info->name[0])
>                 snprintf(info->name, sizeof(info->name), "Queue-%d", q->queue);
> -       strlcpy(q->name, info->name, sizeof(q->name));
> +       strscpy(q->name, info->name, sizeof(q->name));
>         snd_use_lock_free(&q->use_lock);
>
>         return 0;
> @@ -1592,7 +1592,7 @@ static int snd_seq_ioctl_set_queue_info(struct snd_seq_client *client,
>                 queuefree(q);
>                 return -EPERM;
>         }
> -       strlcpy(q->name, info->name, sizeof(q->name));
> +       strscpy(q->name, info->name, sizeof(q->name));
>         queuefree(q);
>
>         return 0;
> --
> 2.21.0.392.gf8f6787159e-goog
>
