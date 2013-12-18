From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH] ASoC: mmp-pcm: config pcm slave via
 generic dmaengine
Date: Wed, 18 Dec 2013 13:55:26 +0800
Message-ID: <52B138CE.3000800@marvell.com>
References: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
 <20131217124954.GY3185@sirena.org.uk> <52B062EC.2050605@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id BBD852610B9
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 06:55:42 +0100 (CET)
In-Reply-To: <52B062EC.2050605@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/17/2013 10:42 PM, Lars-Peter Clausen wrote:
> On 12/17/2013 01:49 PM, Mark Brown wrote:
>> On Tue, Dec 17, 2013 at 04:22:24PM +0800, Qiao Zhou wrote:
>>> use snd_dmaengine_pcm_prepare_slave_config to set slave config,
>>> and remove the max_burst_size = 4 hard code.
>>>
>>> select SND_SOC_GENERIC_DMAENGINE_PCM for mmp-pcm.
>>
>> Applied, thanks.  Can you also convert to use snd_dmaengine_pcm_register()
>> and remove this file completely?
>>
>
> The problem here is that the driver uses sram for its audio memory and the
> platform has a custom function for looking up the sram pool. What we really
> need is a generic version of that which we can use in memalloc.c in the core.
>
> - Lars
>
I'll check the general memalloc implementation. Thanks.

-- 

Best Regards
Qiao
