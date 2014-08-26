From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: bug report for ssm2602
Date: Tue, 26 Aug 2014 08:43:14 +0200
Message-ID: <53FC2C82.1060802@metafoo.de>
References: <CAHG8p1BqrSHagAWor6ZqnnPReBPvYfwpXpbNOSWBjxa5n-raEA@mail.gmail.com>
 <53F71195.5030502@metafoo.de>
 <CAHG8p1Cj9s1-WAyKNtFkCFK0Z74-YX0A7O1o0oN0+hPqNCrorg@mail.gmail.com>
 <20140826062846.GS17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-147.synserver.de (smtp-out-151.synserver.de
 [212.40.185.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D60C2615F7
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 08:43:13 +0200 (CEST)
In-Reply-To: <20140826062846.GS17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Scott Jiang <scott.jiang.linux@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08/26/2014 08:28 AM, Mark Brown wrote:
> On Tue, Aug 26, 2014 at 02:11:20PM +0800, Scott Jiang wrote:
>> 2014-08-22 17:47 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
>
>>>>       ASoC: ssm2602: Fix cache sync
>
>>>>       The ssm2602 uses regmap for caching not soc-cache, so we need to use
>>>>       regcache_sync() instead of snd_soc_cache_sync().
>
>>>> According my test, regcache_sync() can't recover register values when
>>>> resume. While snd_soc_cache_sync() works fine. I used regmap_read() to
>>>> read registers in regmap layer and found it's the same as suspend. But
>>>> regcache_sync() didn't sync these registers correctly to hardware.
>
>>> That does not make too much sense. snd_soc_cache_sync() is definitely a
>>> no-op when using regmap. Which kernel version are you on? Are there any
>>> additional changes to this driver in your tree?
>
> If it is the above patch is the problem perhaps that the register map
> isn't getting marked as dirty so the cache sync is being suppressed?

The core should mark it as dirty after calling the suspend callback. But 
there might be bugs preventing this. Try to make sure that 
regmap_mark_dirty() gets called for this device and also try to check what 
goes wrong in regcache_sync() and why it does not sync the registers.

- Lars
