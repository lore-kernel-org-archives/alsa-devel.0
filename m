From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG:
 Fix	compile error when registering a DAI
Date: Thu, 22 Jul 2010 16:45:39 +0900
Message-ID: <4C47F723.4090506@samsung.com>
References: <4C47D3A3.9000102@samsung.com>
	<AANLkTiluZwni88uY6WtwKkB9Qpm2ECz_37z5_bUY1jII@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 05B71103807
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 09:51:18 +0200 (CEST)
Received: from epmmp1. (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5Y00F698838WC0@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 22 Jul 2010 16:45:39 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net
	(unknown [165.213.149.150])
	by mmp1.samsung.com (Sun Java(tm) System Messaging Server 7u3-15.01
	64bit
	(built Feb 12 2010)) with ESMTPA id <0L5Y0081V883FA70@mmp1.samsung.com>
	for
	alsa-devel@alsa-project.org; Thu, 22 Jul 2010 16:45:39 +0900 (KST)
In-reply-to: <AANLkTiluZwni88uY6WtwKkB9Qpm2ECz_37z5_bUY1jII@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Seungwhan Youn wrote:
> Hi,
> 
> On Thu, Jul 22, 2010 at 2:14 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch modify some code which register a DAI with ASoC core
>> according to modified registration API of DAI.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  sound/soc/s3c24xx/aquila_wm8994.c |    3 +--
>>  sound/soc/s3c24xx/s3c-i2s-v2.c    |    2 +-
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/s3c24xx/aquila_wm8994.c b/sound/soc/s3c24xx/aquila_wm8994.c
>> index 69c41eb..007ed3a 100644
>> --- a/sound/soc/s3c24xx/aquila_wm8994.c
>> +++ b/sound/soc/s3c24xx/aquila_wm8994.c
>> @@ -268,8 +268,7 @@ static int __init aquila_init(void)
>>                return -ENOMEM;
>>
>>        /* register voice DAI here */
>> -       ret = snd_soc_register_dai(&aquila_snd_device->dev,
>> -                       0, &voice_dai);
>> +       ret = snd_soc_register_dai(&aquila_snd_device->dev, &voice_dai);
>>        if (ret)
>>                return ret;
>>
>> diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
>> index f4fbc0e..b3866d5 100644
>> --- a/sound/soc/s3c24xx/s3c-i2s-v2.c
>> +++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
>> @@ -750,7 +750,7 @@ int s3c_i2sv2_register_dai(struct device *dev, int id,
>>        drv->suspend = s3c2412_i2s_suspend;
>>        drv->resume = s3c2412_i2s_resume;
>>
>> -       return snd_soc_register_dai(dev, id, drv);
>> +       return snd_soc_register_dai(dev, drv);
> 
> How about s3c64xx-i2s? I think, if this patch fixes all errors in
Sorry, I confused your comment.
What do you mean "How about s3c64xx-i2s" ?

> 'sound/soc/s3c24xx',
> It'll be more nice than this.
