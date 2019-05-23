From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: core: lock client_mutex while
 removing link components
Date: Thu, 23 May 2019 12:20:34 -0500
Message-ID: <8ab92ac1-2952-fe0c-f8a8-d75d41aa70b1@linux.intel.com>
References: <20190523171201.31104-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55132F89625
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 19:20:36 +0200 (CEST)
In-Reply-To: <20190523171201.31104-1-ranjani.sridharan@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 5/23/19 12:12 PM, Ranjani Sridharan wrote:
> Removing link components results in topology unloading. So,
> acquire the client_mutex before removing components in
> soc_remove_link_components. This will prevent the lockdep warning
> seen when dai links are removed during topology removal.
> 
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

GitHub issue: https://github.com/thesofproject/linux/issues/967 for more 
details.

> ---
>   sound/soc/soc-core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index ce8c057bcd5b..bbb52fbd195e 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1010,12 +1010,14 @@ static void soc_remove_link_components(struct snd_soc_card *card,
>   	struct snd_soc_component *component;
>   	struct snd_soc_rtdcom_list *rtdcom;
>   
> +	mutex_lock(&client_mutex);
>   	for_each_rtdcom(rtd, rtdcom) {
>   		component = rtdcom->component;
>   
>   		if (component->driver->remove_order == order)
>   			soc_remove_component(component);
>   	}
> +	mutex_unlock(&client_mutex);
>   }
>   
>   static void soc_remove_dai_links(struct snd_soc_card *card)
> 
