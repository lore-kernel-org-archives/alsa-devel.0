From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/4] ALSA: info: Minor optimization
Date: Tue, 5 Feb 2019 18:55:50 +0100
Message-ID: <b0a4b682-f676-2fc7-0e4f-3fae00b41aac@perex.cz>
References: <20190205160758.9172-1-tiwai@suse.de>
 <20190205160758.9172-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 20CF82666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 18:55:53 +0100 (CET)
In-Reply-To: <20190205160758.9172-3-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 5.2.2019 v 17:07 Takashi Iwai napsal(a):
> Just a minor code optimization to reduce the source code size
> slightly.  No functional changes.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/info.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/core/info.c b/sound/core/info.c
> index 76800326ac56..12b80e6d9ee4 100644
> --- a/sound/core/info.c
> +++ b/sound/core/info.c
> @@ -463,11 +463,12 @@ static struct snd_info_entry *create_subdir(struct module *mod,
>  }
>  
>  static struct snd_info_entry *
> -snd_info_create_entry(const char *name, struct snd_info_entry *parent);
> +snd_info_create_entry(const char *name, struct snd_info_entry *parent,
> +		      struct module *module);
>  
>  int __init snd_info_init(void)
>  {
> -	snd_proc_root = snd_info_create_entry("asound", NULL);
> +	snd_proc_root = snd_info_create_entry("asound", NULL, THIS_MODULE);
>  	if (!snd_proc_root)
>  		return -ENOMEM;
>  	snd_proc_root->mode = S_IFDIR | 0555;
> @@ -684,7 +685,8 @@ EXPORT_SYMBOL(snd_info_get_str);
>   * Return: The pointer of the new instance, or %NULL on failure.
>   */
>  static struct snd_info_entry *
> -snd_info_create_entry(const char *name, struct snd_info_entry *parent)
> +snd_info_create_entry(const char *name, struct snd_info_entry *parent,
> +		      struct module *module)
>  {
>  	struct snd_info_entry *entry;
>  	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> @@ -701,6 +703,7 @@ snd_info_create_entry(const char *name, struct snd_info_entry *parent)
>  	INIT_LIST_HEAD(&entry->children);
>  	INIT_LIST_HEAD(&entry->list);
>  	entry->parent = parent;
> +	entry->module = module;
>  	if (parent)
>  		list_add_tail(&entry->list, &parent->children);
>  	return entry;
> @@ -720,14 +723,9 @@ struct snd_info_entry *snd_info_create_module_entry(struct module * module,
>  					       const char *name,
>  					       struct snd_info_entry *parent)
>  {
> -	struct snd_info_entry *entry;
> -
>  	if (!parent)
>  		parent = snd_proc_root;
> -	entry = snd_info_create_entry(name, parent);
> -	if (entry)
> -		entry->module = module;
> -	return entry;
> +	return snd_info_create_entry(name, parent, module);
>  }
>  EXPORT_SYMBOL(snd_info_create_module_entry);
>  
> @@ -745,14 +743,9 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
>  					     const char *name,
>  					     struct snd_info_entry * parent)
>  {
> -	struct snd_info_entry *entry;
> -
>  	if (!parent)
>  		parent = card->proc_root;
> -	entry = snd_info_create_entry(name, parent);
> -	if (entry)
> -		entry->module = card->module;
> -	return entry;
> +	return snd_info_create_entry(name, parent, card->module);
>  }
>  EXPORT_SYMBOL(snd_info_create_card_entry);

Won't be better to define those two above functions as inline now?

For rest: Reviewed-by: Jaroslav Kysela <perex@perex.cz>

Thanks,
	Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
