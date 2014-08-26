From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: ASoC: bug report for ssm2602
Date: Tue, 26 Aug 2014 15:14:01 +0800
Message-ID: <CAHG8p1CNN8y010uOxJdUz9FHdBMd-OEiTO=wToWQ4hCYgM-Aww@mail.gmail.com>
References: <CAHG8p1BqrSHagAWor6ZqnnPReBPvYfwpXpbNOSWBjxa5n-raEA@mail.gmail.com>
 <53F71195.5030502@metafoo.de>
 <CAHG8p1Cj9s1-WAyKNtFkCFK0Z74-YX0A7O1o0oN0+hPqNCrorg@mail.gmail.com>
 <20140826062846.GS17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 by alsa0.perex.cz (Postfix) with ESMTP id C11B52617A4
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 09:14:02 +0200 (CEST)
Received: by mail-vc0-f171.google.com with SMTP id hq11so16409032vcb.16
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 00:14:01 -0700 (PDT)
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
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark and Lars,

>
> If it is the above patch is the problem perhaps that the register map
> isn't getting marked as dirty so the cache sync is being suppressed?
>

I print some info in regcache_sync_block_single() and found some registers
are skipped because the regmap thinks it's the same as default. I guess it's
a bug here. When I use regmap_read(), these values are not equal to default.

>> I believe this patch isn't related to the pm bug here.
>> By the way, have you ever tested your patches on any blackfin board?
>> Your patches for adau1761, ssm2602 and bf5xx-i2s all failed to run.
>
> I guess this is addressed to Lars-Peter but could you be more specific
> about the problems you are seeing?

bf5xx-i2s-pcm, I have sent a patch to Mark for this.

commit 30443408fd7201fd1911b09daccf92fae3cc700d
Author: Scott Jiang <scott.jiang.linux@gmail.com>
Date:   Fri Jul 18 16:14:57 2014 +0800

    ASoC: blackfin: use samples to set silence

    The third parameter for snd_pcm_format_set_silence needs the number
    of samples instead of sample bytes.

In fact, test cases still report bugs for this driver after I fix this
bug. There are
many Xrun for TDM codecs. I guess you change the parameters in
bf5xx_pcm_hardware
for TDM to I2S.

ssm2602, can't recover registers after resume.
adau1761, I'm not sure what the problem is. I'll take a look later.

Thanks,
Scott
