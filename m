From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: ASoC: bug report for ssm2602
Date: Tue, 26 Aug 2014 14:11:20 +0800
Message-ID: <CAHG8p1Cj9s1-WAyKNtFkCFK0Z74-YX0A7O1o0oN0+hPqNCrorg@mail.gmail.com>
References: <CAHG8p1BqrSHagAWor6ZqnnPReBPvYfwpXpbNOSWBjxa5n-raEA@mail.gmail.com>
 <53F71195.5030502@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D1492615F3
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 08:11:21 +0200 (CEST)
Received: by mail-vc0-f181.google.com with SMTP id lf12so16064059vcb.26
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 23:11:20 -0700 (PDT)
In-Reply-To: <53F71195.5030502@metafoo.de>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

2014-08-22 17:47 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 08/22/2014 11:21 AM, Scott Jiang wrote:
>>
>> Hi Mark and Lars,
>>
>> commit 9d863b88ec371491e926e0828dbe3d36ead0f6f9
>> Author: Lars-Peter Clausen <lars@metafoo.de>
>> Date:   Sat Aug 31 18:15:23 2013 +0200
>>
>>      ASoC: ssm2602: Fix cache sync
>>
>>      The ssm2602 uses regmap for caching not soc-cache, so we need to use
>>      regcache_sync() instead of snd_soc_cache_sync().
>>
>> According my test, regcache_sync() can't recover register values when
>> resume. While snd_soc_cache_sync() works fine. I used regmap_read() to
>> read registers in regmap layer and found it's the same as suspend. But
>> regcache_sync() didn't sync these registers correctly to hardware.
>>
>
> That does not make too much sense. snd_soc_cache_sync() is definitely a
> no-op when using regmap. Which kernel version are you on? Are there any
> additional changes to this driver in your tree?

My version is 3.16. I compared with the latest 3.17 rc2 kernel, there
is only one patch.

commit 00a37032a099572302ae89c893bd5c90b924c537
Author: Mark Brown <broonie@linaro.org>
Date:   Thu Jul 31 12:47:13 2014 +0100

    ASoC: ssm2602: Convert to params_width()

    The CODEC doesn't care how data is laid out in memory.

    Signed-off-by: Mark Brown <broonie@linaro.org>
    Acked-by: Lars-Peter Clausen <lars@metafoo.de>

I believe this patch isn't related to the pm bug here.
By the way, have you ever tested your patches on any blackfin board?
Your patches for adau1761, ssm2602 and bf5xx-i2s all failed to run.

Scott
