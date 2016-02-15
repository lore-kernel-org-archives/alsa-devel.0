From: Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH] Provide card number / PID via sequencer
 client	info
Date: Mon, 15 Feb 2016 19:32:43 +0100
Message-ID: <20160215183243.GA26482@mail.zuhause>
References: <1455370937-501-1-git-send-email-martin@mail.zuhause>
 <1455370937-501-3-git-send-email-martin@mail.zuhause>
 <s5htwlab70o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe02-1.mx.upcmail.net
 (vie01a-dmta-pe02-1.mx.upcmail.net [62.179.121.157])
 by alsa0.perex.cz (Postfix) with ESMTP id C678C260731
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 19:32:45 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aVNwz-00089i-FK
 for alsa-devel@alsa-project.org; Mon, 15 Feb 2016 19:32:45 +0100
Content-Disposition: inline
In-Reply-To: <s5htwlab70o.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 15, 2016 at 11:30:15AM +0100, Takashi Iwai wrote:
> The idea looks good.  One remaining question is whether only providing
> the card number or pid is sufficient for all cases.

I only care about the kernel client. 
 
> > @@ -357,7 +357,8 @@ struct snd_seq_client_info {
> >  	unsigned char event_filter[32];	/* event filter bitmap */
> >  	int num_ports;			/* RO: number of ports */
> >  	int event_lost;			/* number of lost events */
> > -	char reserved[64];		/* for future use */
> > +	int owner;			/* RO: card number[kernel] / PID[user] */
> > +	char reserved[64 - sizeof(int)]; /* for future use */
> 
> The sizeof(int) is always 4.  So let's make it explicit.
> 
> But, please make sure that this change won't lead to any
> incompatibility.  Some architectures might align with 64bit long,
> although the 32bit int and the rest char[] should be fine on all known
> architectures, AFAIK.

Sorry, I don't have access to the various non x86-architectures, so I can't test.

I will change to 
int card; 
int pid; 
char reserve[56];

More safety would just provide a much more complex (ugly?) structure:

struct _int_snd_seq_client_info_old {
        int client;                     /* client number to inquire */
        snd_seq_client_type_t type;     /* client type */
        char name[64];                  /* client name */
        unsigned int filter;            /* filter flags */
        unsigned char multicast_filter[8]; /* multicast filter bitmap */
        unsigned char event_filter[32]; /* event filter bitmap */
        int num_ports;                  /* RO: number of ports */
        int event_lost;                 /* number of lost events */
        char reserved[64]; /* for future use */
};

struct _int_snd_seq_client_info_new {
        int client;                     /* client number to inquire */
        snd_seq_client_type_t type;     /* client type */
        char name[64];                  /* client name */
        unsigned int filter;            /* filter flags */
        unsigned char multicast_filter[8]; /* multicast filter bitmap */
        unsigned char event_filter[32]; /* event filter bitmap */
        int num_ports;                  /* RO: number of ports */
        int event_lost;                 /* number of lost events */
        int card;
        int pid;
        char reserved[64]; /* for future use */
};

struct snd_seq_client_info {
        int client;                     /* client number to inquire */
        snd_seq_client_type_t type;     /* client type */
        char name[64];                  /* client name */
        unsigned int filter;            /* filter flags */
        unsigned char multicast_filter[8]; /* multicast filter bitmap */
        unsigned char event_filter[32]; /* event filter bitmap */
        int num_ports;                  /* RO: number of ports */
        int event_lost;                 /* number of lost events */
        int card;
        int pid;
        char reserved[64 - sizeof(struct _int_snd_seq_client_info_new) + sizeof(_int_snd_seq_client_info_old)]; /* for future use */
};

This should handle all alignment and type size issues automatically.

If you really want this, I can provide the apropriate patches.

> >  
> > diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
> > index 58e79e0..ac07ab7 100644
> > --- a/sound/core/seq/seq_clientmgr.c
> > +++ b/sound/core/seq/seq_clientmgr.c
> > @@ -364,6 +364,7 @@ static int snd_seq_open(struct inode *inode, struct file *file)
> >  	/* fill client data */
> >  	user->file = file;
> >  	sprintf(client->name, "Client-%d", c);
> > +	client->data.user.owner = get_pid(task_pid(current));
> >  
> >  	/* make others aware this new client */
> >  	snd_seq_system_client_ev_client_start(c);
> > @@ -380,6 +381,7 @@ static int snd_seq_release(struct inode *inode, struct file *file)
> >  		seq_free_client(client);
> >  		if (client->data.user.fifo)
> >  			snd_seq_fifo_delete(&client->data.user.fifo);
> > +		put_pid(client->data.user.owner);
> >  		kfree(client);
> >  	}
> 
> Shouldn't the counterpart (put_pid()) be called anywhere else?

The only way to free a client structure is seq_free_client1 (static).
This is called by snd_seq_open before get_pid [=> irelevant] and 
seq_free_client (static).
seq_free_client is called by snd_seq_release, which calls put_pid and
snd_seq_delete_kernel_client, which destroys a kernel client.

Are I'm missing a code path?

Regards,
Martin
