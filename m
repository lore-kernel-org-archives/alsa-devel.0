From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: topology: create tlv before
 soc_tplg_init_kcontrol
Date: Thu, 14 Mar 2019 06:12:04 +0100
Message-ID: <4941dc4c-eb52-3b10-bc1d-381fb7817e9a@linux.intel.com>
References: <20190313134943.29994-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB972F8961E
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2019 06:12:17 +0100 (CET)
In-Reply-To: <20190313134943.29994-1-yung-chuan.liao@linux.intel.com>
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
To: Bard liao <yung-chuan.liao@linux.intel.com>, broonie@kernel.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

On 3/13/19 8:49 AM, Bard liao wrote:
> Component driver may want to use tlv data. Create tlv before
> soc_tplg_init_kcontrol so component driver can use the tlv data
> in the control_load ops.
> 
> Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/soc-topology.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 25fca7055464..fbee4720b834 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -894,19 +894,20 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, unsigned int count,
>   			continue;
>   		}
>   
> +		/* create any TLV data */
> +		soc_tplg_create_tlv(tplg, &kc, &mc->hdr);
> +
>   		/* pass control to driver for optional further init */
>   		err = soc_tplg_init_kcontrol(tplg, &kc,
>   			(struct snd_soc_tplg_ctl_hdr *) mc);
>   		if (err < 0) {
>   			dev_err(tplg->dev, "ASoC: failed to init %s\n",
>   				mc->hdr.name);
> +			soc_tplg_free_tlv(tplg, &kc);
>   			kfree(sm);
>   			continue;
>   		}
>   
> -		/* create any TLV data */
> -		soc_tplg_create_tlv(tplg, &kc, &mc->hdr);
> -
>   		/* register control here */
>   		err = soc_tplg_add_kcontrol(tplg, &kc,
>   			&sm->dobj.control.kcontrol);
> @@ -1324,18 +1325,19 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
>   			continue;
>   		}
>   
> +		/* create any TLV data */
> +		soc_tplg_create_tlv(tplg, &kc[i], &mc->hdr);
> +
>   		/* pass control to driver for optional further init */
>   		err = soc_tplg_init_kcontrol(tplg, &kc[i],
>   			(struct snd_soc_tplg_ctl_hdr *)mc);
>   		if (err < 0) {
>   			dev_err(tplg->dev, "ASoC: failed to init %s\n",
>   				mc->hdr.name);
> +			soc_tplg_free_tlv(tplg, &kc[i]);
>   			kfree(sm);
>   			continue;
>   		}
> -
> -		/* create any TLV data */
> -		soc_tplg_create_tlv(tplg, &kc[i], &mc->hdr);
>   	}
>   	return kc;
>   
> 
