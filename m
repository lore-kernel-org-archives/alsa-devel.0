From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v3 2/2] topology: Fix the missing
 referenced elem ptr when merging private data
Date: Mon, 25 Jul 2016 14:17:16 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84BA8A003@shsmsx102.ccr.corp.intel.com>
References: <cover.1469163116.git.mengdong.lin@linux.intel.com>
 <49ac654e701ef70abfc525af3cf48fd87d067596.1469163116.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 01EFE265926
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2016 16:17:32 +0200 (CEST)
In-Reply-To: <49ac654e701ef70abfc525af3cf48fd87d067596.1469163116.git.mengdong.lin@linux.intel.com>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Sorry to interrupt you. Does this patch look good now?
This alsa-lib patch is a bug fix without any ABI changes. And it's not part of the other 2 series for BE DAI support.

Thanks
Mengdong

> -----Original Message-----
> From: mengdong.lin@linux.intel.com [mailto:mengdong.lin@linux.intel.com]
> Sent: Friday, July 22, 2016 1:13 PM
> To: alsa-devel@alsa-project.org; broonie@kernel.org
> Cc: tiwai@suse.de; Girdwood, Liam R; Lin, Mengdong; Nc, Shreyas;
> Mengdong Lin
> Subject: [PATCH v3 2/2] topology: Fix the missing referenced elem ptr when
> merging private data
> 
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> tplg_copy_data() should set the valid referenced data element pointer on
> success. The caller will double check this pointer for all kinds of references,
> including controls and data.
> 
> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> diff --git a/src/topology/data.c b/src/topology/data.c index
> 768fc27..4798086 100644
> --- a/src/topology/data.c
> +++ b/src/topology/data.c
> @@ -1053,8 +1053,10 @@ int tplg_copy_data(snd_tplg_t *tplg, struct
> tplg_elem *elem,
> 
>  	tplg_dbg("Data '%s' used by '%s'\n", ref->id, elem->id);
>  	/* overlook empty private data */
> -	if (!ref_elem->data || !ref_elem->data->size)
> +	if (!ref_elem->data || !ref_elem->data->size) {
> +		ref->elem = ref_elem;
>  		return 0;
> +	}
> 
>  	old_priv = get_priv_data(elem);
>  	if (!old_priv)
> @@ -1078,6 +1080,8 @@ int tplg_copy_data(snd_tplg_t *tplg, struct
> tplg_elem *elem,
>  	ref_elem->compound_elem = 1;
>  	memcpy(priv->data + old_priv_data_size,
>  	       ref_elem->data->data, priv_data_size);
> +
> +	ref->elem = ref_elem;
>  	return 0;
>  }
> 
> --
> 2.5.0
