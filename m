From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH] ASoC: blackfin: add bf6xx audio dma driver
Date: Thu, 25 Sep 2014 15:24:45 +0800
Message-ID: <CAHG8p1Ad0RbLjdXpjAor8pZXs_9OfUbp142vQ_pc2KReTy9u8w@mail.gmail.com>
References: <1411552520-26090-1-git-send-email-scott.jiang.linux@gmail.com>
 <20140924082622.GW4015@sirena.org.uk>
 <CAHG8p1BxYz1ZunaGRo0ruJPSU17uF5XRttqn--QeWEExMWWNtw@mail.gmail.com>
 <20140924114232.GI16977@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D35ED2608C7
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 09:24:49 +0200 (CEST)
Received: by mail-vc0-f181.google.com with SMTP id hq12so1205350vcb.12
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 00:24:47 -0700 (PDT)
In-Reply-To: <20140924114232.GI16977@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, adi-buildroot-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

2014-09-24 19:42 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Wed, Sep 24, 2014 at 06:02:40PM +0800, Scott Jiang wrote:
>> 2014-09-24 16:26 GMT+08:00 Mark Brown <broonie@kernel.org>:
>
>> > Can you go into a bit more detail on the differences - clearly there's
>> > some similarlities since the drivers got merged, can we really not share
>> > any code?
>
>> First, sport2 only supports i2s and left justified mode, while sport3
>> adds i2s packed
>> and right justified mode. Second, in tdm mode for sport2, tx and rx
>> are dependent and have
>> a window granularity of 8 channel. While sport3 doesn't have these
>> limits. What's more,
>> sport3 is not only used on blackfin. That means many patches can only
>> apply to this driver.
>
> These sound more like extended functionality and tweaks rather than
> massive updates which need a completely separate driver - new modes and
> so on.

Yes, it looks similar in i2s mode. But in tdm mode, because we don't need to
copy 2 channels user buffer to 8 channels dma buffer, it might looks
very different.
If you think this patch is not good, I'd send a new one after I merged
tdm driver.
By the way, if the channel order of hardware is different from what is
expected by alsa,
the copy work is left to plugin or driver?

Scott
