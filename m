From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: sof-rt5682: add MCLK
 support for BYT platform
Date: Tue, 18 Jun 2019 19:49:48 +0200
Message-ID: <8ee10576-6c07-c532-4142-abded850010f@linux.intel.com>
References: <20190618002336.5734-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 602A0F8075C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 19:49:49 +0200 (CEST)
In-Reply-To: <20190618002336.5734-1-yung-chuan.liao@linux.intel.com>
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
To: Bard liao <yung-chuan.liao@linux.intel.com>, broonie@kernel.org, tiwai@suse.de
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

On 6/18/19 2:23 AM, Bard liao wrote:
> From: Xun Zhang <xun2.zhang@intel.com>
> 
> The sof-rt5682 machine driver currently uses BCLK on BYT/Minnowboard
> platform. The MCLK signal is available since the Turbot revision, so
> enable MCLK on BYT/Minnowboard Turbot platform.

The commit message is not wrong but for more context the MCLK is enabled 
on all known BYT/CHT platforms except early MinnowBoards and Up where 
the MCLK is not available on the low-speed/HAT connector.

> 
> Signed-off-by: Xun Zhang <xun2.zhang@intel.com>
> Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>


>   	if (sof_rt5682_quirk & SOF_RT5682_MCLK_EN) {
> +		if (sof_rt5682_quirk & SOF_RT5682_MCLK_BYTCHT_EN) {
> +			ret = clk_prepare_enable(ctx->mclk);
> +			if (ret < 0) {
> +				dev_err(rtd->dev,
> +					"could not configure MCLK state");
> +				return ret;
> +			}
> +		}

Note that we could technically fallback to using the BCLK only in the 
error case but it's an unlikely scenario which we've never seen, so

Patch 1 and 2

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
