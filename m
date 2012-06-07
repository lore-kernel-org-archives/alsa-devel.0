From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v1 2/5] ASoC: mmp: add audio dma support
Date: Thu, 7 Jun 2012 18:44:20 +0800
Message-ID: <CAMj5BkhtHaF=b=VDMoif_RxWR_Wdxc7qMpjH-SBO=yoA4W9LTA@mail.gmail.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
	<1338791851-21038-3-git-send-email-zhangfei.gao@marvell.com>
	<1339061042.1927.61.camel@vkoul-udesk3>
	<CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
	<1339063547.1927.63.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DBD324354
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 12:44:20 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so282163wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2012 03:44:20 -0700 (PDT)
In-Reply-To: <1339063547.1927.63.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 7, 2012 at 6:05 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Thu, 2012-06-07 at 17:59 +0800, zhangfei gao wrote:
>> On Thu, Jun 7, 2012 at 5:24 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
>> > On Mon, 2012-06-04 at 14:37 +0800, Zhangfei Gao wrote:
>> >> mmp-pcm handle audio dma based on soc-dmaengine
>> >> Support mmp and pxa910
>> > See soc-dmaengine.c. You sneed to use the library to use dmaengine.
>> >
>>
>> Thanks Vinod for kind review.
>>
>> Some confusion, only find sound/soc/soc-dmaengine-pcm.c.
>> So the driver base on the library, snd_dmaengine_pcm_open/close etc.
>> Replacing dma_request_channel etc.
>>
>> Is it right direction?
> Yes your driver should use it. See examples in other soc drivers

This driver already been ported to soc-dmaengine-pcm.c, refer
mxs-pcm.c and imx-pcm-dma-mx2.c.
Using snd_dmaengine_pcm_open, snd_dmaengine_pcm_close, etc.
Only exception is dmaengine_slave_config, since we have some specific config.

>
>
> --
> ~Vinod
>
