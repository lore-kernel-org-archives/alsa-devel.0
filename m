From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH -next] ASoC: Intel: Skylake: Fix to use
 list_for_each_safe() when delete items
Date: Tue, 25 Apr 2017 09:30:35 +0530
Message-ID: <20170425040035.GY6263@localhost>
References: <20170425032817.21959-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A33DE26664F
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 05:58:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170425032817.21959-1-weiyj.lk@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alsa-devel@alsa-project.org, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, Hardik T Shah <hardik.t.shah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 25, 2017 at 03:28:17AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Since we will remove items off the list using list_del() we need
> to use a safe version of the list_for_each() macro aptly named
> list_for_each_safe().

ah yes, god catch

> This is detected by Coccinelle semantic patch.

It is a good practice to include the script you used, do you mind adding
that in the log?

> 
> Fixes: b8c722ddd548 ("ASoC: Intel: Skylake: Add support for deferred
> DSP module bind")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/intel/skylake/skl-pcm.c | 4 ++--
>  sound/soc/intel/skylake/skl-topology.c | 4 ++--
>  2 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
> index 600faad..d43d197 100644
> --- a/sound/soc/intel/skylake/skl-pcm.c
> +++ b/sound/soc/intel/skylake/skl-pcm.c
> @@ -1323,10 +1323,10 @@ int skl_platform_unregister(struct device *dev)
>  {
>  	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
>  	struct skl *skl = ebus_to_skl(ebus);
> -	struct skl_module_deferred_bind *modules;
> +	struct skl_module_deferred_bind *modules, *tmp;
>  
>  	if (!list_empty(&skl->bind_list)) {
> -		list_for_each_entry(modules, &skl->bind_list, node) {
> +		list_for_each_entry_safe(modules, tmp, &skl->bind_list, node) {
>  			list_del(&modules->node);
>  			kfree(modules);
>  		}
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 74b3acf..aea7917 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -1091,7 +1091,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
>  	struct skl_module_cfg *src_module = NULL, *dst_module;
>  	struct skl_sst *ctx = skl->skl_sst;
>  	struct skl_pipe *s_pipe = mconfig->pipe;
> -	struct skl_module_deferred_bind *modules;
> +	struct skl_module_deferred_bind *modules, *tmp;
>  
>  	if (s_pipe->state == SKL_PIPE_INVALID)
>  		return -EINVAL;
> @@ -1105,7 +1105,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
>  
>  		src_module = w_module->w->priv;
>  
> -		list_for_each_entry(modules, &skl->bind_list, node) {
> +		list_for_each_entry_safe(modules, tmp, &skl->bind_list, node) {
>  			/*
>  			 * When the destination module is deleted, Unbind the
>  			 * modules from deferred bind list.
> 

-- 
~Vinod
