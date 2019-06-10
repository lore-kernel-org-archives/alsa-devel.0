From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 08/14] ASoC: Intel: Skylake: Properly cleanup on component
 removal
Date: Mon, 10 Jun 2019 09:17:21 +0200
Message-ID: <36e24c2a-feb4-4c6f-7bc5-76b13ff625a3@intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
 <20190605134556.10322-9-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605134556.10322-9-amadeuszx.slawinski@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019-06-05 15:45, Amadeusz Sławiński wrote:
> When we remove component we need to reverse things which were done on
> init, this consists of topology cleanup, lists cleanup and releasing
> firmware.
> 
> Currently cleanup handlers are put in wrong places or otherwise missing.
> So add proper component cleanup function and perform cleanups in it.
> 
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>   sound/soc/intel/skylake/skl-pcm.c      |  8 ++++++--
>   sound/soc/intel/skylake/skl-topology.c | 15 +++++++++++++++
>   sound/soc/intel/skylake/skl-topology.h |  2 ++
>   sound/soc/intel/skylake/skl.c          |  2 --
>   4 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
> index 44062806fbed..7e8110c15258 100644
> --- a/sound/soc/intel/skylake/skl-pcm.c
> +++ b/sound/soc/intel/skylake/skl-pcm.c
> @@ -1459,8 +1459,12 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
>   
>   static void skl_pcm_remove(struct snd_soc_component *component)
>   {
> -	/* remove topology */
> -	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
> +	struct hdac_bus *bus = dev_get_drvdata(component->dev);
> +	struct skl *skl = bus_to_skl(bus);
> +
> +	skl_tplg_exit(component, bus);
> +
> +	skl_debugfs_exit(skl);
>   }
>   
>   static const struct snd_soc_component_driver skl_component  = {
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 44f3b29a7210..3964262109ac 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3748,3 +3748,18 @@ int skl_tplg_init(struct snd_soc_component *component, struct hdac_bus *bus)
>   
>   	return 0;
>   }
> +
> +void skl_tplg_exit(struct snd_soc_component *component, struct hdac_bus *bus)
> +{
> +	struct skl *skl = bus_to_skl(bus);
> +	struct skl_pipeline *ppl, *tmp;
> +
> +	if (!list_empty(&skl->ppl_list))
> +		list_for_each_entry_safe(ppl, tmp, &skl->ppl_list, node)
> +			list_del(&ppl->node);
> +
> +	/* clean up topology */
> +	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
> +
> +	release_firmware(skl->tplg);
> +}

In debugfs cleanup patch:
[PATCH 07/14] ASoC: Intel: Skylake: Add function to cleanup debugfs 
interface

you define skl_debugfs_exit separately - its usage is split and present 
in this very patch instead. However, for tplg counterpart - 
skl_tplg_exit - you've decided to combine both together. Why not 
separate tplg cleanup too?

> diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
> index 82282cac9751..7d32c61c73e7 100644
> --- a/sound/soc/intel/skylake/skl-topology.h
> +++ b/sound/soc/intel/skylake/skl-topology.h
> @@ -471,6 +471,8 @@ void skl_tplg_set_be_dmic_config(struct snd_soc_dai *dai,
>   	struct skl_pipe_params *params, int stream);
>   int skl_tplg_init(struct snd_soc_component *component,
>   				struct hdac_bus *ebus);
> +void skl_tplg_exit(struct snd_soc_component *component,
> +				struct hdac_bus *bus);
>   struct skl_module_cfg *skl_tplg_fe_get_cpr_module(
>   		struct snd_soc_dai *dai, int stream);
>   int skl_tplg_update_pipe_params(struct device *dev,
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 6d6401410250..e4881ff427ea 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -1119,14 +1119,12 @@ static void skl_remove(struct pci_dev *pci)
>   	struct skl *skl = bus_to_skl(bus);
>   
>   	cancel_work_sync(&skl->probe_work);
> -	release_firmware(skl->tplg);
>   
>   	pm_runtime_get_noresume(&pci->dev);
>   
>   	/* codec removal, invoke bus_device_remove */
>   	snd_hdac_ext_bus_device_remove(bus);
>   
> -	skl->debugfs = NULL;
>   	skl_platform_unregister(&pci->dev);
>   	skl_free_dsp(skl);
>   	skl_machine_device_unregister(skl);
> 
