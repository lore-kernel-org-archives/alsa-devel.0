From: Adam Goode <agoode@google.com>
Subject: Re: [PATCH - seq 1/1] ALSA seq: expose the card number
	of ALSA seq clients
Date: Thu, 11 Jun 2015 23:43:53 -0400
Message-ID: <CAOf41NkjzBSAJgpX_OL_5D0u6BqMAj++BSxVA8YVZzqCESBDbw@mail.gmail.com>
References: <1433466290-31244-1-git-send-email-agoode@google.com>
 <s5hvbeyigtz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id C6898266640
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 05:44:14 +0200 (CEST)
Received: by wiwd19 with SMTP id d19so5960044wiw.0
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 20:44:14 -0700 (PDT)
In-Reply-To: <s5hvbeyigtz.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 8, 2015 at 7:23 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu,  4 Jun 2015 21:04:50 -0400,
> Adam Goode wrote:
> >
> > Expose the card number of seq clients. This allows interested userspace
> > programs to discover the hardware device that backs a particular seq
> > client. Before this change, the only way to get information about the
> > hardware for a client was by using brittle heuristics.
> >
> > Signed-off-by: Adam Goode <agoode@google.com>
>
> The patch looks almost good.  (One coding style fix about one-line if
> would be better, though.)
>
> However, if we want to have more changes, I'd prefer the protocol
> version bump after all changes are merged.
> Are you going to submit any further changes?
>
>
> thanks,
>
> Takashi
>

Hi Takashi,

I fixed up the patch in v2. It fixes the style issue and delays updating
protocol for now.

I think there might be another useful field to expose (the hardware midi
device number), but I'm not sure yet. It is complicated since OPL3 does
expose a client but does not use rawmidi. Otherwise, the rawmidi device
number would be the obvious choice. I'm pretty sure I just need the card
number to solve my problems in Chrome, but I will have to think about it.

The only other interesting change to make right now would be a tstamp field
(something like PCM), but it might be too complex for a quick fix. I do
like the PCM timestamp mode selection, and would like to see such a thing
in seq.


Thanks,

Adam



>
> >
> > diff --git a/include/uapi/sound/asequencer.h
> b/include/uapi/sound/asequencer.h
> > index 5a5fa49..c2a659be 100644
> > --- a/include/uapi/sound/asequencer.h
> > +++ b/include/uapi/sound/asequencer.h
> > @@ -25,7 +25,7 @@
> >  #include <sound/asound.h>
> >
> >  /** version of the sequencer */
> > -#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 1)
> > +#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 2)
> >
> >  /**
> >   * definition of sequencer event types
> > @@ -357,7 +357,8 @@ struct snd_seq_client_info {
> >       unsigned char event_filter[32]; /* event filter bitmap */
> >       int num_ports;                  /* RO: number of ports */
> >       int event_lost;                 /* number of lost events */
> > -     char reserved[64];              /* for future use */
> > +     int card_number;                /* RO: card number, or -1 if no
> card. Added in protocol version 1.0.2 */
> > +     char reserved[60];              /* for future use */
> >  };
> >
> >
> > diff --git a/sound/core/seq/seq_clientmgr.c
> b/sound/core/seq/seq_clientmgr.c
> > index edbdab8..fcae784 100644
> > --- a/sound/core/seq/seq_clientmgr.c
> > +++ b/sound/core/seq/seq_clientmgr.c
> > @@ -216,7 +216,7 @@ int __init client_init_data(void)
> >  }
> >
> >
> > -static struct snd_seq_client *seq_create_client1(int client_index, int
> poolsize)
> > +static struct snd_seq_client *seq_create_client1(int client_index, int
> poolsize, int card_number)
> >  {
> >       unsigned long flags;
> >       int c;
> > @@ -232,6 +232,7 @@ static struct snd_seq_client *seq_create_client1(int
> client_index, int poolsize)
> >               return NULL;
> >       }
> >       client->type = NO_CLIENT;
> > +     client->card_number = card_number;
> >       snd_use_lock_init(&client->use_lock);
> >       rwlock_init(&client->ports_lock);
> >       mutex_init(&client->ports_mutex);
> > @@ -327,7 +328,7 @@ static int snd_seq_open(struct inode *inode, struct
> file *file)
> >
> >       if (mutex_lock_interruptible(&register_mutex))
> >               return -ERESTARTSYS;
> > -     client = seq_create_client1(-1, SNDRV_SEQ_DEFAULT_EVENTS);
> > +     client = seq_create_client1(-1, SNDRV_SEQ_DEFAULT_EVENTS, -1);
> >       if (client == NULL) {
> >               mutex_unlock(&register_mutex);
> >               return -ENOMEM; /* failure code */
> > @@ -1194,6 +1195,7 @@ static void get_client_info(struct snd_seq_client
> *cptr,
> >       info->event_lost = cptr->event_lost;
> >       memcpy(info->event_filter, cptr->event_filter, 32);
> >       info->num_ports = cptr->num_ports;
> > +     info->card_number = cptr->card_number;
> >       memset(info->reserved, 0, sizeof(info->reserved));
> >  }
> >
> > @@ -2239,6 +2241,7 @@ int snd_seq_create_kernel_client(struct snd_card
> *card, int client_index,
> >  {
> >       struct snd_seq_client *client;
> >       va_list args;
> > +     int card_number = -1;
> >
> >       if (snd_BUG_ON(in_interrupt()))
> >               return -EBUSY;
> > @@ -2252,6 +2255,7 @@ int snd_seq_create_kernel_client(struct snd_card
> *card, int client_index,
> >               return -ERESTARTSYS;
> >
> >       if (card) {
> > +             card_number = card->number;
> >               client_index += SNDRV_SEQ_GLOBAL_CLIENTS
> >                       + card->number * SNDRV_SEQ_CLIENTS_PER_CARD;
> >               if (client_index >= SNDRV_SEQ_DYNAMIC_CLIENTS_BEGIN)
> > @@ -2259,7 +2263,7 @@ int snd_seq_create_kernel_client(struct snd_card
> *card, int client_index,
> >       }
> >
> >       /* empty write queue as default */
> > -     client = seq_create_client1(client_index, 0);
> > +     client = seq_create_client1(client_index, 0, card_number);
> >       if (client == NULL) {
> >               mutex_unlock(&register_mutex);
> >               return -EBUSY;  /* failure code */
> > @@ -2533,9 +2537,13 @@ void snd_seq_info_clients_read(struct
> snd_info_entry *entry,
> >                       continue;
> >               }
> >
> > -             snd_iprintf(buffer, "Client %3d : \"%s\" [%s]\n",
> > +             snd_iprintf(buffer, "Client %3d : \"%s\" [%s]",
> >                           c, client->name,
> >                           client->type == USER_CLIENT ? "User" :
> "Kernel");
> > +             if (client->card_number != -1) {
> > +                     snd_iprintf(buffer, ", card %d",
> client->card_number);
> > +             }
> > +             snd_iprintf(buffer, "\n");
> >               snd_seq_info_dump_ports(buffer, client);
> >               if (snd_seq_write_pool_allocated(client)) {
> >                       snd_iprintf(buffer, "  Output pool :\n");
> > diff --git a/sound/core/seq/seq_clientmgr.h
> b/sound/core/seq/seq_clientmgr.h
> > index 20f0a72..627be9d 100644
> > --- a/sound/core/seq/seq_clientmgr.h
> > +++ b/sound/core/seq/seq_clientmgr.h
> > @@ -50,6 +50,7 @@ struct snd_seq_client {
> >               accept_output: 1;
> >       char name[64];          /* client name */
> >       int number;             /* client number */
> > +     int card_number;        /* card number, or -1 if no card */
> >       unsigned int filter;    /* filter flags */
> >       DECLARE_BITMAP(event_filter, 256);
> >       snd_use_lock_t use_lock;
> > --
> > 2.2.0.rc0.207.ga3a616c
> >
>
