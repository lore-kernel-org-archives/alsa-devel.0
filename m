From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v1 2/5] ASoC: mmp: add audio dma support
Date: Thu, 07 Jun 2012 16:50:25 +0530
Message-ID: <1339068025.1927.66.camel@vkoul-udesk3>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
	<1338791851-21038-3-git-send-email-zhangfei.gao@marvell.com>
	<1339061042.1927.61.camel@vkoul-udesk3>
	<CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
	<1339063547.1927.63.camel@vkoul-udesk3>
	<CAMj5BkhtHaF=b=VDMoif_RxWR_Wdxc7qMpjH-SBO=yoA4W9LTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 990642415B
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 13:27:19 +0200 (CEST)
In-Reply-To: <CAMj5BkhtHaF=b=VDMoif_RxWR_Wdxc7qMpjH-SBO=yoA4W9LTA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-06-07 at 18:44 +0800, zhangfei gao wrote:
> Only exception is dmaengine_slave_config, since we have some specific config.
And why?

> +static bool filter(struct dma_chan *chan, void *param)
> +{
> +	struct mmp_dma_data *dma_data = param;
> +	bool found = false;
> +	char *devname;
> +
> +	devname = kasprintf(GFP_KERNEL, "%s.%d", dma_data->dma_res->name,
> +		dma_data->ssp_id);
> +	if ((strcmp(dev_name(chan->device->dev), devname) == 0) &&
> +		(chan->chan_id == dma_data->dma_res->start)) {
> +		chan->private = &dma_data->tdma_data;
chan->private is deprecated and should not be used 
> +		found = true;
> +	}
> +
> +	kfree(devname);
> +	return found;
> +}


-- 
~Vinod
