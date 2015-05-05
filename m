From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Tue, 05 May 2015 15:45:58 +0100
Message-ID: <1430837158.8043.61.camel@loki>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EA91F261736
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 16:46:04 +0200 (CEST)
In-Reply-To: <1430833322-13531-3-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-05-05 at 21:42 +0800, Bard Liao wrote:
> Modify the RT5645 driver to parse platform data from device tree.
> Write a DT binding document to describe those properties.
> 
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> ---
>  Documentation/devicetree/bindings/sound/rt5645.txt | 72 ++++++++++++++++++++++
>  sound/soc/codecs/rt5645.c                          | 35 +++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rt5645.txt
> 

> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index e435680..36e22b6 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3134,6 +3134,37 @@ static struct dmi_system_id dmi_platform_intel_braswell[] = {
>  	{ }
>  };
>  
> +static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device_node *np)
> +{
> +	rt5645->pdata.in2_diff = of_property_read_bool(np,
> +		"realtek,in2-differential");
> +	of_property_read_u32(np,
> +		"realtek,dmic1-data-pin", &rt5645->pdata.dmic1_data_pin);

We should really be using device_property_() instead of of_property_()
APIs since we will have to support both DT and ACPI properties.

Liam
