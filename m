From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH][RFC][alsa-utils 5/9] alsactl: use link
 list to maintain source of events
Date: Fri, 5 Oct 2018 19:14:41 +0200
Message-ID: <ebd92686-31d6-1c2b-42bc-5e9dd9679cf6@perex.cz>
References: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
 <20181005144729.21388-6-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id BB7AF267845
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 19:14:46 +0200 (CEST)
In-Reply-To: <20181005144729.21388-6-o-takashi@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de, thomas@coldfix.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 5.10.2018 v 16:47 Takashi Sakamoto napsal(a):
> At present, handlers for control nodes are maintained by one-dimensional
> array. This is not necessarily useful to maintain handlers with
> associated information.
> 
> This commit adds link-list for the maintenance.

Thanks for the improved code.

Please, use macros in list.h to manage linked list which are inherited
from the kernel here.

					Jaroslav

> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  alsactl/monitor.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/alsactl/monitor.c b/alsactl/monitor.c
> index cf5c50a..8b16307 100644
> --- a/alsactl/monitor.c
> +++ b/alsactl/monitor.c
> @@ -29,6 +29,16 @@
>  static int signal_type;
>  static bool interrupted;
>  
> +struct src_entry {
> +	snd_ctl_t *handle;
> +	char *name;
> +	unsigned int pfd_count;
> +	struct {
> +		struct src_entry *prev;
> +		struct src_entry *next;
> +	} list;
> +};
> +
>  #define MAX_CARDS	256
>  
>  struct snd_card_iterator {
> @@ -59,6 +69,72 @@ static const char *snd_card_iterator_next(struct snd_card_iterator *iter)
>          return (const char *)iter->name;
>  }
>  
> +static inline void remove_source_entry(struct src_entry *src)
> +{
> +	struct src_entry *prev = src->list.prev;
> +	struct src_entry *next = src->list.next;
> +
> +	if (prev)
> +		prev->list.next = src->list.next;
> +	if (next)
> +		next->list.prev = src->list.prev;
> +	free(src->name);
> +	free(src);
> +}
> +
> +static void clear_source_list(struct src_entry **srcs)
> +{
> +	while (*srcs) {
> +		struct src_entry *src = *srcs;
> +		*srcs = src->list.next;
> +
> +		remove_source_entry(src);
> +	}
> +}
> +
> +static int insert_source_entry(struct src_entry **head, snd_ctl_t *handle,
> +			       const char *name)
> +{
> +	struct src_entry *src;
> +	int count;
> +	int err;
> +
> +	src = calloc(1, sizeof(*src));
> +	if (!src)
> +		return -ENOMEM;
> +	src->handle = handle;
> +
> +	src->name = strdup(name);
> +	if (!src->name) {
> +		err = -ENOMEM;
> +		goto error;
> +	}
> +
> +	count = snd_ctl_poll_descriptors_count(handle);
> +	if (count < 0) {
> +		err = count;
> +		goto error;
> +	}
> +	if (count == 0) {
> +		err = -ENXIO;
> +		goto error;
> +	}
> +	src->pfd_count = count;
> +
> +	if (*head) {
> +		src->list.next = (*head)->list.next;
> +		src->list.prev = *head;
> +		(*head)->list.next = src;
> +	} else {
> +		*head = src;
> +	}
> +
> +	return 0;
> +error:
> +	free(src);
> +	return err;
> +}
> +
>  static int open_ctl(const char *name, snd_ctl_t **ctlp)
>  {
>  	snd_ctl_t *ctl;
> @@ -259,6 +335,7 @@ static int prepare_signal_handler(void)
>  
>  int monitor(const char *name)
>  {
> +	struct src_entry *srcs = NULL;
>  	snd_ctl_t *ctls[MAX_CARDS] = {0};
>  	int ncards = 0;
>  	int show_cards;
> @@ -281,6 +358,9 @@ int monitor(const char *name)
>  		snd_card_iterator_init(&iter);
>  		while ((cardname = snd_card_iterator_next(&iter))) {
>  			err = open_ctl(cardname, &ctls[ncards]);
> +			if (err < 0)
> +				goto error;
> +			err = insert_source_entry(&srcs, ctls[ncards], cardname);
>  			if (err < 0)
>  				goto error;
>  			++ncards;
> @@ -288,6 +368,9 @@ int monitor(const char *name)
>  		show_cards = 1;
>  	} else {
>  		err = open_ctl(name, &ctls[0]);
> +		if (err < 0)
> +			goto error;
> +		err = insert_source_entry(&srcs, ctls[ncards], name);
>  		if (err < 0)
>  			goto error;
>  		ncards++;
> @@ -300,6 +383,7 @@ int monitor(const char *name)
>  	clear_dispatcher(epfd, ctls, ncards);
>  
>  error:
> +	clear_source_list(&srcs);
>  	for (i = 0; i < ncards; i++) {
>  		if (ctls[i])
>  			snd_ctl_close(ctls[i]);
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
