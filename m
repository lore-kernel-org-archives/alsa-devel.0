From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: bug report for ssm2602
Date: Fri, 22 Aug 2014 11:47:01 +0200
Message-ID: <53F71195.5030502@metafoo.de>
References: <CAHG8p1BqrSHagAWor6ZqnnPReBPvYfwpXpbNOSWBjxa5n-raEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 55D4C265904
 for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2014 11:47:12 +0200 (CEST)
In-Reply-To: <CAHG8p1BqrSHagAWor6ZqnnPReBPvYfwpXpbNOSWBjxa5n-raEA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08/22/2014 11:21 AM, Scott Jiang wrote:
> Hi Mark and Lars,
>
> commit 9d863b88ec371491e926e0828dbe3d36ead0f6f9
> Author: Lars-Peter Clausen <lars@metafoo.de>
> Date:   Sat Aug 31 18:15:23 2013 +0200
>
>      ASoC: ssm2602: Fix cache sync
>
>      The ssm2602 uses regmap for caching not soc-cache, so we need to use
>      regcache_sync() instead of snd_soc_cache_sync().
>
> According my test, regcache_sync() can't recover register values when
> resume. While snd_soc_cache_sync() works fine. I used regmap_read() to
> read registers in regmap layer and found it's the same as suspend. But
> regcache_sync() didn't sync these registers correctly to hardware.
>

That does not make too much sense. snd_soc_cache_sync() is definitely a 
no-op when using regmap. Which kernel version are you on? Are there any 
additional changes to this driver in your tree?

- Lars
