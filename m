From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 5/9] ASoC: Intel: Skylake: Add topology
 core init and handlers
Date: Fri, 18 Sep 2015 10:55:57 +0100
Message-ID: <1442570157.7634.36.camel@loki>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E0A12659F2
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 11:56:03 +0200 (CEST)
In-Reply-To: <1439832404-12424-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S.
 Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-08-17 at 22:56 +0530, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> The SKL driver does not code DSP topology in driver. It uses the
> newly added ASoC topology core to parse the topology information
> (controls, widgets and map) from topology binary.
> Each topology element passed private data which contains
> information that driver used to identify the module instance
> within firmware and send IPCs for that module to DSP firmware
> along with parameters.
> This patch adds init routine to invoke topology load and callback
> for topology creation.
> 
> Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---

> +
> +/*
> + * SKL topology init routine
> + */
> +int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
> +{
> +	int ret;
> +	const struct firmware *fw;
> +	struct hdac_bus *bus = ebus_to_hbus(ebus);
> +	struct skl *skl = ebus_to_skl(ebus);
> +
> +	ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "config firmware request failed with %d\n", ret);

It would be good to say what file name we are failing with here. 

> +		return ret;
> +	}
> +
> +	/*
> +	 * The complete tplg for SKL is loaded as index 0, we don't use
> +	 * any other index
> +	 */
> +	ret = snd_soc_tplg_component_load(&platform->component, &skl_tplg_ops, fw, 0);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "tplg component load failed%d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	skl->resource.max_mcps = SKL_MAX_MCPS;
> +	skl->resource.max_mem = SKL_FW_MAX_MEM;
> +
> +	return 0;
> +}
> diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
> index a50689825bca..b258c90d89f1 100644
> --- a/sound/soc/intel/skylake/skl-tplg-interface.h
> +++ b/sound/soc/intel/skylake/skl-tplg-interface.h
> @@ -19,6 +19,27 @@
>  #ifndef __HDA_TPLG_INTERFACE_H__
>  #define __HDA_TPLG_INTERFACE_H__
>  
> +/* Default types range from 0~12. type can range from 0 to 0xff
> + * SST types start at higher to avoid any overlapping in future */
> +#define SOC_CONTROL_TYPE_HDA_SST_ALGO_PARAMS	200
> +#define SOC_CONTROL_TYPE_HDA_SST_MUX		201
> +#define SOC_CONTROL_TYPE_HDA_SST_MIX		201
> +#define SOC_CONTROL_TYPE_HDA_SST_BYTE		203

These are lower than 0xff

Liam
