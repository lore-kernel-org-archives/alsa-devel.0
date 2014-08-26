From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: bug report for ssm2602
Date: Tue, 26 Aug 2014 08:36:37 +0200
Message-ID: <53FC2AF5.40901@metafoo.de>
References: <CAHG8p1BqrSHagAWor6ZqnnPReBPvYfwpXpbNOSWBjxa5n-raEA@mail.gmail.com>	<53F71195.5030502@metafoo.de>
 <CAHG8p1Cj9s1-WAyKNtFkCFK0Z74-YX0A7O1o0oN0+hPqNCrorg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-150.synserver.de
 [212.40.185.150])
 by alsa0.perex.cz (Postfix) with ESMTP id 230CF2615F7
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 08:36:40 +0200 (CEST)
In-Reply-To: <CAHG8p1Cj9s1-WAyKNtFkCFK0Z74-YX0A7O1o0oN0+hPqNCrorg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08/26/2014 08:11 AM, Scott Jiang wrote:
> 2014-08-22 17:47 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 08/22/2014 11:21 AM, Scott Jiang wrote:
>>>
>>> Hi Mark and Lars,
>>>
>>> commit 9d863b88ec371491e926e0828dbe3d36ead0f6f9
>>> Author: Lars-Peter Clausen <lars@metafoo.de>
>>> Date:   Sat Aug 31 18:15:23 2013 +0200
>>>
>>>       ASoC: ssm2602: Fix cache sync
>>>
>>>       The ssm2602 uses regmap for caching not soc-cache, so we need to use
>>>       regcache_sync() instead of snd_soc_cache_sync().
>>>
>>> According my test, regcache_sync() can't recover register values when
>>> resume. While snd_soc_cache_sync() works fine. I used regmap_read() to
>>> read registers in regmap layer and found it's the same as suspend. But
>>> regcache_sync() didn't sync these registers correctly to hardware.
>>>
>>
>> That does not make too much sense. snd_soc_cache_sync() is definitely a
>> no-op when using regmap. Which kernel version are you on? Are there any
>> additional changes to this driver in your tree?
>
> My version is 3.16. I compared with the latest 3.17 rc2 kernel, there
> is only one patch.

And it is vanilla v3.16, no patches to the driver or the ASoC core? 
snd_soc_cache_sync() will definitely do nothing for this driver on v3.16 
since reg_cache_size is 0 for this driver's snd_soc_codec_driver.

[...]
> By the way, have you ever tested your patches on any blackfin board?
> Your patches for adau1761, ssm2602 and bf5xx-i2s all failed to run.

Yes, I've tested them before submitting them upstream on a ezkit board.
What kind of errors are you seeing?

- Lars
