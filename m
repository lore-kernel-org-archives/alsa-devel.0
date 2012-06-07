From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v1 2/5] ASoC: mmp: add audio dma support
Date: Thu, 7 Jun 2012 17:59:43 +0800
Message-ID: <CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
	<1338791851-21038-3-git-send-email-zhangfei.gao@marvell.com>
	<1339061042.1927.61.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D275103D27
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 11:59:43 +0200 (CEST)
Received: by wgbds1 with SMTP id ds1so847940wgb.2
	for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2012 02:59:43 -0700 (PDT)
In-Reply-To: <1339061042.1927.61.camel@vkoul-udesk3>
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

On Thu, Jun 7, 2012 at 5:24 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Mon, 2012-06-04 at 14:37 +0800, Zhangfei Gao wrote:
>> mmp-pcm handle audio dma based on soc-dmaengine
>> Support mmp and pxa910
> See soc-dmaengine.c. You sneed to use the library to use dmaengine.
>

Thanks Vinod for kind review.

Some confusion, only find sound/soc/soc-dmaengine-pcm.c.
So the driver base on the library, snd_dmaengine_pcm_open/close etc.
Replacing dma_request_channel etc.

Is it right direction?
