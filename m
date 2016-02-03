From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: deadlock between snd_rawmidi_kernel_open/snd_seq_port_connect
Date: Wed, 3 Feb 2016 14:22:18 +0100
Message-ID: <CACT4Y+adjCo6gTn2FBAsKnYkHoJMAkL99=YFFkHXTizvK7oJxg@mail.gmail.com>
References: <CACT4Y+aKQXV7xkBW9hpQbzaDO7LrUvohxWh-UwMxXjDy-yBD=A@mail.gmail.com>
 <s5hwpqy9brq.wl-tiwai@suse.de> <CACT4Y+Z0KA9bD5Q6K=+zBuxVbToEVYQng-uXOV+z=0_y9RYyfQ@mail.gmail.com>
 <s5hfuxa44m0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hfuxa44m0.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 3, 2016 at 8:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > This looks like a false-positive report to me.  Of course, we should
>> > annotate the mutex there for nested locks, though.
>>
>>
>> Takashi, can you please annotate it for lockdep? I hit it on every run.
>
> The lock had an annotation but alas it didn't seem enough.
> In anyway, it's not good to have double locks if it's avoidable.  So I
> worked on it now, and below is the current result of the hack.
>
> The change became a bit more intrusive than wished, but it should be
> still simple enough.  I put this on top of topic/core-fixes branch.


I don't see the deadlock reports now. Thanks!


> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: seq: Fix lockdep warnings due to double mutex locks
>
> The port subscription code uses double mutex locks for source and
> destination ports, and this may become racy once when wrongly set up.
> It leads to lockdep warning splat, typically triggered by fuzzer like
> syzkaller, although the actual deadlock hasn't been seen, so far.
>
> This patch simplifies the handling by reducing to two single locks, so
> that no lockdep warning will be trigger any longer.
>
> By splitting to two actions, a still-in-progress element shall be
> added in one list while handling another.  For ignoring this element,
> a new check is added in deliver_to_subscribers().
>
> Along with it, the code to add/remove the subscribers list element was
> cleaned up and refactored.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/seq/seq_clientmgr.c |   3 +
>  sound/core/seq/seq_ports.c     | 233 +++++++++++++++++++++++------------------
>  2 files changed, 133 insertions(+), 103 deletions(-)
>
> diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
> index 13cfa815732d..58e79e02f217 100644
> --- a/sound/core/seq/seq_clientmgr.c
> +++ b/sound/core/seq/seq_clientmgr.c
> @@ -678,6 +678,9 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
>         else
>                 down_read(&grp->list_mutex);
>         list_for_each_entry(subs, &grp->list_head, src_list) {
> +               /* both ports ready? */
> +               if (atomic_read(&subs->ref_count) != 2)
> +                       continue;
>                 event->dest = subs->info.dest;
>                 if (subs->info.flags & SNDRV_SEQ_PORT_SUBS_TIMESTAMP)
>                         /* convert time according to flag with subscription */
> diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
> index 55170a20ae72..921fb2bd8fad 100644
> --- a/sound/core/seq/seq_ports.c
> +++ b/sound/core/seq/seq_ports.c
> @@ -173,10 +173,6 @@ struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
>  }
>
>  /* */
> -enum group_type {
> -       SRC_LIST, DEST_LIST
> -};
> -
>  static int subscribe_port(struct snd_seq_client *client,
>                           struct snd_seq_client_port *port,
>                           struct snd_seq_port_subs_info *grp,
> @@ -203,6 +199,20 @@ static struct snd_seq_client_port *get_client_port(struct snd_seq_addr *addr,
>         return NULL;
>  }
>
> +static void delete_and_unsubscribe_port(struct snd_seq_client *client,
> +                                       struct snd_seq_client_port *port,
> +                                       struct snd_seq_subscribers *subs,
> +                                       bool is_src, bool ack);
> +
> +static inline struct snd_seq_subscribers *
> +get_subscriber(struct list_head *p, bool is_src)
> +{
> +       if (is_src)
> +               return list_entry(p, struct snd_seq_subscribers, src_list);
> +       else
> +               return list_entry(p, struct snd_seq_subscribers, dest_list);
> +}
> +
>  /*
>   * remove all subscribers on the list
>   * this is called from port_delete, for each src and dest list.
> @@ -210,7 +220,7 @@ static struct snd_seq_client_port *get_client_port(struct snd_seq_addr *addr,
>  static void clear_subscriber_list(struct snd_seq_client *client,
>                                   struct snd_seq_client_port *port,
>                                   struct snd_seq_port_subs_info *grp,
> -                                 int grptype)
> +                                 int is_src)
>  {
>         struct list_head *p, *n;
>
> @@ -219,15 +229,13 @@ static void clear_subscriber_list(struct snd_seq_client *client,
>                 struct snd_seq_client *c;
>                 struct snd_seq_client_port *aport;
>
> -               if (grptype == SRC_LIST) {
> -                       subs = list_entry(p, struct snd_seq_subscribers, src_list);
> +               subs = get_subscriber(p, is_src);
> +               if (is_src)
>                         aport = get_client_port(&subs->info.dest, &c);
> -               } else {
> -                       subs = list_entry(p, struct snd_seq_subscribers, dest_list);
> +               else
>                         aport = get_client_port(&subs->info.sender, &c);
> -               }
> -               list_del(p);
> -               unsubscribe_port(client, port, grp, &subs->info, 0);
> +               delete_and_unsubscribe_port(client, port, subs, is_src, false);
> +
>                 if (!aport) {
>                         /* looks like the connected port is being deleted.
>                          * we decrease the counter, and when both ports are deleted
> @@ -235,21 +243,14 @@ static void clear_subscriber_list(struct snd_seq_client *client,
>                          */
>                         if (atomic_dec_and_test(&subs->ref_count))
>                                 kfree(subs);
> -               } else {
> -                       /* ok we got the connected port */
> -                       struct snd_seq_port_subs_info *agrp;
> -                       agrp = (grptype == SRC_LIST) ? &aport->c_dest : &aport->c_src;
> -                       down_write(&agrp->list_mutex);
> -                       if (grptype == SRC_LIST)
> -                               list_del(&subs->dest_list);
> -                       else
> -                               list_del(&subs->src_list);
> -                       up_write(&agrp->list_mutex);
> -                       unsubscribe_port(c, aport, agrp, &subs->info, 1);
> -                       kfree(subs);
> -                       snd_seq_port_unlock(aport);
> -                       snd_seq_client_unlock(c);
> +                       continue;
>                 }
> +
> +               /* ok we got the connected port */
> +               delete_and_unsubscribe_port(c, aport, subs, !is_src, true);
> +               kfree(subs);
> +               snd_seq_port_unlock(aport);
> +               snd_seq_client_unlock(c);
>         }
>  }
>
> @@ -262,8 +263,8 @@ static int port_delete(struct snd_seq_client *client,
>         snd_use_lock_sync(&port->use_lock);
>
>         /* clear subscribers info */
> -       clear_subscriber_list(client, port, &port->c_src, SRC_LIST);
> -       clear_subscriber_list(client, port, &port->c_dest, DEST_LIST);
> +       clear_subscriber_list(client, port, &port->c_src, true);
> +       clear_subscriber_list(client, port, &port->c_dest, false);
>
>         if (port->private_free)
>                 port->private_free(port->private_data);
> @@ -479,85 +480,120 @@ static int match_subs_info(struct snd_seq_port_subscribe *r,
>         return 0;
>  }
>
> -
> -/* connect two ports */
> -int snd_seq_port_connect(struct snd_seq_client *connector,
> -                        struct snd_seq_client *src_client,
> -                        struct snd_seq_client_port *src_port,
> -                        struct snd_seq_client *dest_client,
> -                        struct snd_seq_client_port *dest_port,
> -                        struct snd_seq_port_subscribe *info)
> +static int check_and_subscribe_port(struct snd_seq_client *client,
> +                                   struct snd_seq_client_port *port,
> +                                   struct snd_seq_subscribers *subs,
> +                                   bool is_src, bool exclusive, bool ack)
>  {
> -       struct snd_seq_port_subs_info *src = &src_port->c_src;
> -       struct snd_seq_port_subs_info *dest = &dest_port->c_dest;
> -       struct snd_seq_subscribers *subs, *s;
> -       int err, src_called = 0;
> -       unsigned long flags;
> -       int exclusive;
> +       struct snd_seq_port_subs_info *grp;
> +       struct list_head *p;
> +       struct snd_seq_subscribers *s;
> +       int err;
>
> -       subs = kzalloc(sizeof(*subs), GFP_KERNEL);
> -       if (! subs)
> -               return -ENOMEM;
> -
> -       subs->info = *info;
> -       atomic_set(&subs->ref_count, 2);
> -
> -       down_write(&src->list_mutex);
> -       down_write_nested(&dest->list_mutex, SINGLE_DEPTH_NESTING);
> -
> -       exclusive = info->flags & SNDRV_SEQ_PORT_SUBS_EXCLUSIVE ? 1 : 0;
> +       grp = is_src ? &port->c_src : &port->c_dest;
>         err = -EBUSY;
> +       down_write(&grp->list_mutex);
>         if (exclusive) {
> -               if (! list_empty(&src->list_head) || ! list_empty(&dest->list_head))
> +               if (!list_empty(&grp->list_head))
>                         goto __error;
>         } else {
> -               if (src->exclusive || dest->exclusive)
> +               if (grp->exclusive)
>                         goto __error;
>                 /* check whether already exists */
> -               list_for_each_entry(s, &src->list_head, src_list) {
> -                       if (match_subs_info(info, &s->info))
> -                               goto __error;
> -               }
> -               list_for_each_entry(s, &dest->list_head, dest_list) {
> -                       if (match_subs_info(info, &s->info))
> +               list_for_each(p, &grp->list_head) {
> +                       s = get_subscriber(p, is_src);
> +                       if (match_subs_info(&subs->info, &s->info))
>                                 goto __error;
>                 }
>         }
>
> -       if ((err = subscribe_port(src_client, src_port, src, info,
> -                                 connector->number != src_client->number)) < 0)
> -               goto __error;
> -       src_called = 1;
> -
> -       if ((err = subscribe_port(dest_client, dest_port, dest, info,
> -                                 connector->number != dest_client->number)) < 0)
> +       err = subscribe_port(client, port, grp, &subs->info, ack);
> +       if (err < 0) {
> +               grp->exclusive = 0;
>                 goto __error;
> +       }
>
>         /* add to list */
> -       write_lock_irqsave(&src->list_lock, flags);
> -       // write_lock(&dest->list_lock); // no other lock yet
> -       list_add_tail(&subs->src_list, &src->list_head);
> -       list_add_tail(&subs->dest_list, &dest->list_head);
> -       // write_unlock(&dest->list_lock); // no other lock yet
> -       write_unlock_irqrestore(&src->list_lock, flags);
> +       write_lock_irq(&grp->list_lock);
> +       if (is_src)
> +               list_add_tail(&subs->src_list, &grp->list_head);
> +       else
> +               list_add_tail(&subs->dest_list, &grp->list_head);
> +       grp->exclusive = exclusive;
> +       atomic_inc(&subs->ref_count);
> +       write_unlock_irq(&grp->list_lock);
> +       err = 0;
> +
> + __error:
> +       up_write(&grp->list_mutex);
> +       return err;
> +}
>
> -       src->exclusive = dest->exclusive = exclusive;
> +static void delete_and_unsubscribe_port(struct snd_seq_client *client,
> +                                       struct snd_seq_client_port *port,
> +                                       struct snd_seq_subscribers *subs,
> +                                       bool is_src, bool ack)
> +{
> +       struct snd_seq_port_subs_info *grp;
> +
> +       grp = is_src ? &port->c_src : &port->c_dest;
> +       down_write(&grp->list_mutex);
> +       write_lock_irq(&grp->list_lock);
> +       if (is_src)
> +               list_del(&subs->src_list);
> +       else
> +               list_del(&subs->dest_list);
> +       grp->exclusive = 0;
> +       write_unlock_irq(&grp->list_lock);
> +       up_write(&grp->list_mutex);
> +
> +       unsubscribe_port(client, port, grp, &subs->info, ack);
> +}
> +
> +/* connect two ports */
> +int snd_seq_port_connect(struct snd_seq_client *connector,
> +                        struct snd_seq_client *src_client,
> +                        struct snd_seq_client_port *src_port,
> +                        struct snd_seq_client *dest_client,
> +                        struct snd_seq_client_port *dest_port,
> +                        struct snd_seq_port_subscribe *info)
> +{
> +       struct snd_seq_subscribers *subs;
> +       bool exclusive;
> +       int err;
> +
> +       subs = kzalloc(sizeof(*subs), GFP_KERNEL);
> +       if (!subs)
> +               return -ENOMEM;
> +
> +       subs->info = *info;
> +       atomic_set(&subs->ref_count, 0);
> +       INIT_LIST_HEAD(&subs->src_list);
> +       INIT_LIST_HEAD(&subs->dest_list);
> +
> +       exclusive = !!(info->flags & SNDRV_SEQ_PORT_SUBS_EXCLUSIVE);
> +
> +       err = check_and_subscribe_port(src_client, src_port, subs, true,
> +                                      exclusive,
> +                                      connector->number != src_client->number);
> +       if (err < 0)
> +               goto error;
> +       err = check_and_subscribe_port(dest_client, dest_port, subs, false,
> +                                      exclusive,
> +                                      connector->number != dest_client->number);
> +       if (err < 0)
> +               goto error_dest;
>
> -       up_write(&dest->list_mutex);
> -       up_write(&src->list_mutex);
>         return 0;
>
> - __error:
> -       if (src_called)
> -               unsubscribe_port(src_client, src_port, src, info,
> -                                connector->number != src_client->number);
> + error_dest:
> +       delete_and_unsubscribe_port(src_client, src_port, subs, true,
> +                                   connector->number != src_client->number);
> + error:
>         kfree(subs);
> -       up_write(&dest->list_mutex);
> -       up_write(&src->list_mutex);
>         return err;
>  }
>
> -
>  /* remove the connection */
>  int snd_seq_port_disconnect(struct snd_seq_client *connector,
>                             struct snd_seq_client *src_client,
> @@ -567,37 +603,28 @@ int snd_seq_port_disconnect(struct snd_seq_client *connector,
>                             struct snd_seq_port_subscribe *info)
>  {
>         struct snd_seq_port_subs_info *src = &src_port->c_src;
> -       struct snd_seq_port_subs_info *dest = &dest_port->c_dest;
>         struct snd_seq_subscribers *subs;
>         int err = -ENOENT;
> -       unsigned long flags;
>
>         down_write(&src->list_mutex);
> -       down_write_nested(&dest->list_mutex, SINGLE_DEPTH_NESTING);
> -
>         /* look for the connection */
>         list_for_each_entry(subs, &src->list_head, src_list) {
>                 if (match_subs_info(info, &subs->info)) {
> -                       write_lock_irqsave(&src->list_lock, flags);
> -                       // write_lock(&dest->list_lock);  // no lock yet
> -                       list_del(&subs->src_list);
> -                       list_del(&subs->dest_list);
> -                       // write_unlock(&dest->list_lock);
> -                       write_unlock_irqrestore(&src->list_lock, flags);
> -                       src->exclusive = dest->exclusive = 0;
> -                       unsubscribe_port(src_client, src_port, src, info,
> -                                        connector->number != src_client->number);
> -                       unsubscribe_port(dest_client, dest_port, dest, info,
> -                                        connector->number != dest_client->number);
> -                       kfree(subs);
> +                       atomic_dec(&subs->ref_count); /* mark as not ready */
>                         err = 0;
>                         break;
>                 }
>         }
> -
> -       up_write(&dest->list_mutex);
>         up_write(&src->list_mutex);
> -       return err;
> +       if (err < 0)
> +               return err;
> +
> +       delete_and_unsubscribe_port(src_client, src_port, subs, true,
> +                                   connector->number != src_client->number);
> +       delete_and_unsubscribe_port(dest_client, dest_port, subs, false,
> +                                   connector->number != dest_client->number);
> +       kfree(subs);
> +       return 0;
>  }
>
>
> --
> 2.7.0
>
