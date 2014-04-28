From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: core: Fix component_list corruption
 when unloading modules
Date: Mon, 28 Apr 2014 15:26:59 +0200
Message-ID: <535E5723.4070200@metafoo.de>
References: <1398688251-11374-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-059.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AA40261A1B
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 15:27:09 +0200 (CEST)
In-Reply-To: <1398688251-11374-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 04/28/2014 02:30 PM, Jarkko Nikula wrote:
> This fixes module unload regressions introduced by commits 98e639fb8a3e
> ("ASoC: Track which components have been registered with
> snd_soc_register_component()") and b37f1d123c69 ("ASoC: Let snd_soc_platform
> subclass snd_soc_component").
>
> First commit causes component_list to be corrupted when removing codec and
> second when removing platform. Reason for both is that components associated
> with platform or codec are never removed from the list because for them
> registered_as_component field in struct snd_soc_component is always false.
>
> Now list becomes corrupted when snd_soc_unregister_platform() or
> snd_soc_unregister_codec() frees the platform or codec structure and where
> the associated struct snd_soc_component is embedded.
>
> Fix these by moving component unregistration and cleanup to a new local
> function __snd_soc_unregister_component() that takes component as its
> argument.
>
> Since component is known for platforms and codecs the
> __snd_soc_unregister_component() can be called directly and
> snd_soc_unregister_component() takes care to find and unregister only
> components that were registered using snd_soc_register_component().
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   sound/soc/soc-core.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index f18112a32541..62c3980fad5b 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -4061,6 +4061,18 @@ int snd_soc_register_component(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(snd_soc_register_component);
>
> +static void __snd_soc_unregister_component(struct snd_soc_component *cmpnt)
> +{
> +	snd_soc_unregister_dais(cmpnt);
> +
> +	mutex_lock(&client_mutex);
> +	list_del(&cmpnt->list);
> +	mutex_unlock(&client_mutex);
> +
> +	dev_dbg(cmpnt->dev, "ASoC: Unregistered component '%s'\n", cmpnt->name);
> +	kfree(cmpnt->name);
> +}
> +
>   /**
>    * snd_soc_unregister_component - Unregister a component from the ASoC core
>    *
> @@ -4076,14 +4088,7 @@ void snd_soc_unregister_component(struct device *dev)
>   	return;
>
>   found:
> -	snd_soc_unregister_dais(cmpnt);
> -
> -	mutex_lock(&client_mutex);
> -	list_del(&cmpnt->list);
> -	mutex_unlock(&client_mutex);
> -
> -	dev_dbg(dev, "ASoC: Unregistered component '%s'\n", cmpnt->name);
> -	kfree(cmpnt->name);
> +	__snd_soc_unregister_component(cmpnt);
>   }
>   EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
>
> @@ -4183,7 +4188,7 @@ EXPORT_SYMBOL_GPL(snd_soc_register_platform);
>    */
>   void snd_soc_remove_platform(struct snd_soc_platform *platform)
>   {
> -	snd_soc_unregister_component(platform->dev);
> +	__snd_soc_unregister_component(&platform->component);
>
>   	mutex_lock(&client_mutex);
>   	list_del(&platform->list);
> @@ -4388,7 +4393,7 @@ void snd_soc_unregister_codec(struct device *dev)
>   	return;
>
>   found:
> -	snd_soc_unregister_component(dev);
> +	__snd_soc_unregister_component(&codec->component);
>
>   	mutex_lock(&client_mutex);
>   	list_del(&codec->list);
>
