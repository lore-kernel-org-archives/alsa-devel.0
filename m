From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: alc5623: Convert codec->hw_read
	to regmap_read
Date: Fri, 14 Oct 2011 06:39:43 +0800
Message-ID: <CAF+7xWkVLNgToGiEn+xqgnii7QozNu0QAf2U-kXRNRtVK0dkqA@mail.gmail.com>
References: <1318490575.2857.8.camel@phoenix>
	<20111013165129.GO5193@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DA6992432D
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 00:40:03 +0200 (CEST)
Received: by eyz10 with SMTP id 10so547263eyz.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 15:40:03 -0700 (PDT)
In-Reply-To: <20111013165129.GO5193@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2011/10/14 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, Oct 13, 2011 at 03:22:55PM +0800, Axel Lin wrote:
>> codec->hw_read is broken now, let's covert to regmap_read.
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>
> I'd rather not fix these like this because when we convert these drivers
> to use regmap directly it won't be quite so obvious what's going on and
> we'll easily introduce bugs where we start using the cached values from
> a regmap level cache.
>
> Probably the best thing here is to convert all these drivers to use
> cache_bypass to read directly through the cache - the same thing will
> then work with direct regmap usage.
>
I don't complete understand "use cache_bypass to read directly through
the cache".
Can you illustrate it?
The purpose of original implementation is to read h/w then fill the cache.
The cache is zeroed before we call alc5623_fill_cache().

Or do you mean changes like below instead of calling regmap_read directly?

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 557b3af..43006b3 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -51,10 +51,15 @@ static void alc5623_fill_cache(struct snd_soc_codec *codec)
 {
        int i, step = codec->driver->reg_cache_step;
        u16 *cache = codec->reg_cache;
+       unsigned int val;

        /* not really efficient ... */
-       for (i = 0 ; i < codec->driver->reg_cache_size ; i += step)
-               cache[i] = codec->hw_read(codec, i);
+       codec->cache_bypass = 1;
+       for (i = 0 ; i < codec->driver->reg_cache_size ; i += step) {
+               snd_soc_read(codec, i);
+               cache[i] = val;
+       }
+       codec->cache_bypass = 0;
 }

 static inline int alc5623_reset(struct snd_soc_codec *codec)

Thanks,
Axel
