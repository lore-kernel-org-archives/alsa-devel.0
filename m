From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/3] ASoC: Intel: Skylake: Add api to
 retrieve dmic array info from nhlt
Date: Thu, 26 May 2016 10:53:00 +0530
Message-ID: <20160526052259.GP2735@localhost>
References: <ac23a9ba3795ed50bea2d88dc90b419238ef1542.1463673471.git.yong.zhi@intel.com>
 <1464182357-1305-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C63D26054D
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 07:16:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1464182357-1305-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, yang.a.fang@intel.com, broonie@kernel.org, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 25, 2016 at 06:19:17AM -0700, Yong Zhi wrote:
> skylake can be configured with either both 2 and 4 channel DMIC

Skylake

> array, or 2 channel DMIC array only, this patch provides an API to
> retrieve the DMIC info from nhlt.
> 
>   *
>   */
>  #include "skl.h"
> +#include <linux/pci.h>

Typical convention is to have standard includes before local ones

> +int skl_get_dmic_geo(struct skl *skl)
> +{
> +	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
> +	struct nhlt_endpoint *epnt;
> +	struct nhlt_dmic_array_config *cfg;
> +	struct device *dev = &(skl->pci->dev);

i dont think braces are required..

> +	unsigned int dmic_geo = 0;
> +	u8 j;
> +
> +	epnt = (struct nhlt_endpoint *)nhlt->desc;
> +
> +	for (j = 0; j < nhlt->endpoint_count; j++) {
> +		if (epnt->linktype == NHLT_LINK_DMIC) {
> +			cfg = (struct nhlt_dmic_array_config  *)
> +					(epnt->config.caps);
> +			switch (cfg->array_type) {
> +			case NHLT_MIC_ARRAY_2CH_SMALL:
> +			case NHLT_MIC_ARRAY_2CH_BIG:
> +				dmic_geo |= MIC_ARRAY_2CH;
> +				break;

empty line here please

> +			case NHLT_MIC_ARRAY_4CH_1ST_GEOM:
> +			case NHLT_MIC_ARRAY_4CH_L_SHAPED:
> +			case NHLT_MIC_ARRAY_4CH_2ND_GEOM:
> +				dmic_geo |= MIC_ARRAY_4CH;
> +				break;

here too

-- 
~Vinod
